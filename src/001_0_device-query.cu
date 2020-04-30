// #CUDA Training
//
// #Example 1 - retrieve device info
//
// #Author Ugo Varetto
//

#include <iostream>
//#include <cuda_runtime.h> // automatically added by nvcc

int main(int argc, const char** argv) {
    int deviceCount = 0;
    if (cudaGetDeviceCount(&deviceCount) != cudaSuccess) {
        std::cout << "cudaGetDeviceCount FAILED CUDA Driver and Runtime "
                     "version may be mismatched.\n";
        std::cout << "\nFAILED\n";
        return 1;
    }

    // This function call returns 0 if there are no CUDA capable devices.
    if (deviceCount == 0) {
        std::cout << "There is no device supporting CUDA\n";
        return 1;
    }

    int dev = 0;
    int driverVersion = 0, runtimeVersion = 0;
    for (dev = 0; dev != deviceCount; ++dev) {
        cudaDeviceProp deviceProp;
        cudaGetDeviceProperties(&deviceProp, dev);
        if (dev == 0) {
            // This function call returns 9999 for both major & minor fields, if
            // no CUDA capable devices are present
            if (deviceProp.major == 9999 && deviceProp.minor == 9999)
                std::cout << "There is no device supporting CUDA.\n";
            else if (deviceCount == 1)
                std::cout << "There is 1 device supporting CUDA\n";
            else
                std::cout << "There are " << deviceCount
                          << " devices supporting CUDA\n";
        }
        std::cout << "\nDevice" << dev << ": " << deviceProp.name << '\n';

#ifndef MINIMAL
        cudaDriverGetVersion(&driverVersion);
        std::cout << "  CUDA Driver Version:                           "
                  << driverVersion / 1000 << '.' << driverVersion % 100 << '\n';
        cudaRuntimeGetVersion(&runtimeVersion);
        std::cout << "  CUDA Runtime Version:                          "
                  << runtimeVersion / 1000 << '.' << runtimeVersion % 100
                  << '\n';

        std::cout << "  CUDA Capability Major/Minor version number:    "
                  << deviceProp.major << '.' << deviceProp.minor << '\n';

        std::cout << "  Total amount of global memory:                 "
                  << deviceProp.totalGlobalMem << " bytes\n";

        std::cout << "  Number of multiprocessors:                     "
                  << deviceProp.multiProcessorCount << '\n';

        std::cout << "  Total amount of constant memory:               "
                  << deviceProp.totalConstMem << " bytes\n";
        std::cout << "  Total amount of shared memory per block:       "
                  << deviceProp.sharedMemPerBlock << " bytes\n";
        std::cout << "  Total number of registers available per block: "
                  << deviceProp.regsPerBlock << '\n';
        std::cout << "  Warp size:                                     "
                  << deviceProp.warpSize << '\n';
#endif
        std::cout << "  Maximum number of threads per block:           "
                  << deviceProp.maxThreadsPerBlock << '\n';
        std::cout << "  Maximum sizes of each dimension of a block:    "
                  << deviceProp.maxThreadsDim[0] << " x "
                  << deviceProp.maxThreadsDim[1] << " x "
                  << deviceProp.maxThreadsDim[2] << '\n';
        std::cout << "  Maximum sizes of each dimension of a grid:     "
                  << deviceProp.maxGridSize[0] << " x "
                  << deviceProp.maxGridSize[1] << " x "
                  << deviceProp.maxGridSize[2] << '\n';
#ifndef MINIMAL
        std::cout << "  Maximum memory pitch:                          "
                  << deviceProp.memPitch << " bytes\n";
        std::cout << "  Texture alignment:                             "
                  << deviceProp.textureAlignment << " bytes\n";
        std::cout << "  Clock rate:                                    "
                  << deviceProp.clockRate * 1e-6f << " GHz\n";
        std::cout << "  Concurrent copy and execution:                 "
                  << (deviceProp.deviceOverlap ? "Yes" : "No") << '\n';
        std::cout << "  # of Asynchronous Copy Engines:                "
                  << deviceProp.asyncEngineCount << '\n';
        std::cout << "  Run time limit on kernels:                     "
                  << (deviceProp.kernelExecTimeoutEnabled ? "Yes\n" : "No\n");
        std::cout << "  Integrated:                                    "
                  << (deviceProp.integrated ? "Yes\n" : "No\n");
        std::cout << "  Support host page-locked memory mapping:       "
                  << (deviceProp.canMapHostMemory ? "Yes\n" : "No\n");
        std::cout << "  Compute mode:                                  "
                  << (deviceProp.computeMode == cudaComputeModeDefault
                          ? "Default (multiple host threads can use this "
                            "device simultaneously)\n"
                          : deviceProp.computeMode == cudaComputeModeExclusive
                                ? "Exclusive (only one host thread at a time "
                                  "can use this device)\n"
                                : deviceProp.computeMode ==
                                          cudaComputeModeProhibited
                                      ? "Prohibited (no host thread can use "
                                        "this device)\n"
                                      : "Unknown\n");
        std::cout << "  Memory bus width:                              "
                  << deviceProp.memoryBusWidth << " bytes\n";
        std::cout << "  Memory clock:                                  "
                  << deviceProp.memoryClockRate * 1e-6f << " GHz\n";
#endif
        std::cout << "  Concurrent kernel execution:                   "
                  << (deviceProp.concurrentKernels ? "Yes\n" : "No\n");
        std::cout << "  Device has ECC support enabled:                "
                  << (deviceProp.ECCEnabled ? "Yes\n" : "No\n");
        std::cout << "  Device is using TCC driver mode:               "
                  << (deviceProp.tccDriver ? "Yes\n" : "No\n");
        std::cout << "  Unified addressing:                            "
                  << (deviceProp.unifiedAddressing ? "Yes\n" : "No\n");
        std::cout << "  PCI bus id:                                    "
                  << deviceProp.pciBusID << '\n';
        std::cout << "  PCI device id:                                 "
                  << deviceProp.pciDeviceID << '\n';
    }

    return 0;
}
