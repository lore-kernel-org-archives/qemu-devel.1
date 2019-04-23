Received: from eggs.gnu.org ([209.51.188.92]:36923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1e-0005Az-9t
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hIz1Z-0005c4-SI
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hIz1Z-0005an-FJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 13:16:05 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Tue, 23 Apr 2019 19:15:12 +0200
Message-Id: <20190423171520.4511-5-lersek@redhat.com>
In-Reply-To: <20190423171520.4511-1-lersek@redhat.com>
References: <20190423171520.4511-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/12] roms/edk2: advance to tag
 edk2-stable201903
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org

Update the roms/edk2 submodule hash from edk2-stable201811 to
edk2-stable201903. The release notes are available at
<https://github.com/tianocore/edk2/releases/tag/edk2-stable201903>.

$ git shortlog edk2-stable201811..edk2-stable201903

Achin Gupta (9):
      ArmPkg: Add PCDs needed for MM communication driver.
      ArmPkg/Drivers: Add EFI_MM_COMMUNICATION_PROTOCOL DXE driver.
      ArmPkg/Include: Add MM interface SVC return codes.
      ArmPkg/ArmMmuLib: Add MMU Library suitable for use in S-EL0.
      StandaloneMmPkg: Add missing dependency on PL011UartClockLib
      StandaloneMmPkg: Enforce alignment check for AArch64
      StandaloneMmPkg: Zero data structure explicitly
      StandaloneMmPkg: Replace dependency on ArmMmuLib
      StandaloneMmPkg: Update dependency on PeCoffExtraActionLib

Albecki, Mateusz (1):
      MdeModulePkg/SdMmcPciHcDxe Fix eMMC HS400 switch sequence

Alex James (2):
      StdLib/sys/termios: Define cc_t as unsigned
      StdLib/Environs: Avoid infinite recursion in _Exit

Antoine Coeur (5):
      ArmVirtPkg: Fix various typos
      CryptoPkg: Fix various typos
      CorebootPayloadPkg: Fix various typos
      CorebootModulePkg: Fix various typos
      BaseTools: Various typo

Ard Biesheuvel (116):
      MdePkg/BaseIoLibIntrinsicArmVirt ARM: avoid double word loads and s=
tores
      ArmPkg/ArmGicDxe ARM: fix encoding for GICv3 interrupt acknowledge
      ArmPlatformPkg: clear frame pointer in startup code
      ArmVirtPkg/PrePi: clear frame pointer in startup code
      ArmPkg/ArmSmcPsciResetSystemLib: add missing call to ExitBootServic=
es()
      ArmPkg: remove now unused BsdLib.h
      ArmPlatformPkg/NorFlashDxe: prepare for devicepath format change
      ArmPlatformPkg/NorFlashDxe: use one GUID plus index to identify fla=
sh banks
      ArmVirtPkg/FdtClientDxe: take DT node 'status' properties into acco=
unt
      ArmVirtPkg/NorFlashQemuLib: discover NOR flash banks dynamically
      ArmPlatformPkg/NorFlashPlatformLib: remove unused Guid member from =
struct
      ArmPkg/ArmPkg.dsc: move ArmMmuStandaloneMmLib.inf to AARCH64 sectio=
n
      EmbeddedPkg/TemplateSec: remove unused module
      EmbeddedPkg/PrePiHobLib: drop CreateHobList() from library
      ArmVirtPkg/FdtPciHostBridgeLib: map ECAM and I/O spaces in GCD memo=
ry map
      ArmVirtPkg/QemuVirtMemInfoLib: remove 1:1 mapping of top of PA rang=
e
      MdePkg/ProcessorBind.h AARCH64: limit MAX_ADDRESS to 48 bits
      ArmPkg/ArmLib: add support for reading the max physical address spa=
ce size
      ArmVirtPkg/XenVirtMemInfoLib: refactor reading of the PA space size
      ArmPkg/ArmMmuLib: take the CPU supported maximum PA space into acco=
unt
      ArmPkg/CpuPei: base GCD memory space size on CPU's PA range
      ArmPlatformPkg/PrePi: base GCD memory space size on CPU's PA range
      ArmVirtPkg/PrePi: base GCD memory space size on CPU's PA range
      BeagleBoardPkg/PrePi: base GCD memory space size on CPU's PA range
      ArmPlatformPkg/PlatformPei: drop unused PCD references
      EmbeddedPkg/PrePiLib: drop unused PCD reference
      ArmVirtPkg: drop PcdPrePiCpuMemorySize assignments from all platfor=
ms
      EmbeddedPkg/EmbeddedPkg.dec: drop PcdPrePiCpuMemorySize declaration=
s
      ArmPkg/ArmMmuLib ARM: handle unmapped section in GetMemoryRegion()
      ArmPkg/ArmMmuLib ARM: handle unmapped sections when updating permis=
sions
      ArmVirtPkg/NorFlashQemuLib: disregard our primary FV
      ArmVirtPkg/QemuVirtMemInfoLib: trim the MMIO region mapping
      BaseTools/CommonLib: avoid using 'native' word size in IP address h=
andling
      BaseTools/CommonLib: use explicit 64-bit type in Strtoi()
      BaseTools/DevicePath: use explicit 64-bit number parsing routines
      BaseTools/CommonLib: add definition of MAX_UINT32
      BaseTools/DevicePath: use MAX_UINT32 as default device path max siz=
e
      BaseTools/CommonLib: get rid of 'native' type string parsing routin=
es
      BaseTools/CommonLib: drop definition of MAX_UINTN
      BaseTools/CommonLib: drop the use of MAX_ADDRESS
      Revert "MdePkg/ProcessorBind.h AARCH64: limit MAX_ADDRESS to 48 bit=
s"
      MdeModulePkg/FileExplorerLib: avoid packed struct for program data
      BaseTools/tools_def AARCH64 RELEASE: move GCC49/GGC5 to 4 KB alignm=
ent
      ArmVirtPkg/ArmVirtQemuKernel ARM: make some PCD settings apply to A=
RM
      ArmVirtPkg/PrePiUniCoreRelocatable CLANG38: work around build issue=
s
      BaseTools/GenFw ARM: don't permit R_ARM_GOT_PREL relocations
      MdePkg/BaseMemoryLibOptDxe ARM: add missing function annotations
      BaseTools/tools_def ARM CLANG35: work around -mno-movt option name =
change
      ArmVirtPkg/PrePi ARM CLANG35: drop incompatible command line option
      ArmVirtPkg/ArmVirt.dsc.inc: define TcpIoLib resolution unconditiona=
lly
      ArmPkg: remove redundant _ARM_PLATFORM_FLAGS overrides
      EmbeddedPkg: remove GdbDebugAgent library
      BaseTools/tools_def ARM: emit PIC veneers
      ArmPkg/DefaultExceptionHandlerLib ARM: avoid endless loop in RELEAS=
E builds
      MdePkg/Base: introduce MAX_ALLOC_ADDRESS
      MdeModulePkg/Dxe/Gcd: disregard memory above MAX_ALLOC_ADDRESS
      MdeModulePkg/Dxe/Page: take MAX_ALLOC_ADDRESS into account
      ArmPkg/ArmMmuLib: take MAX_ALLOC_ADDRESS into account
      ArmPlatformPkg/MemoryInitPeim: take MAX_ALLOC_ADDRESS into account
      ArmVirtPkg/MemoryInitPeiLib: split memory HOB based on MAX_ALLOC_AD=
DRESS
      MdePkg/Arm/ProcessorBind.h: fix copy/paste error
      ArmPlatformPkg/SP805WatchdogDxe: cosmetic cleanup
      ArmPlatformPkg/SP805WatchdogDxe: switch to interrupt mode
      ArmPkg/GenericWatchdogDxe: clean up the code
      ArmPkg/GenericWatchdogDxe: implement RegisterHandler() method
      ArmPlatformPkg/PL011SerialPortLib: use untyped PCD for register bas=
e
      BaseTools/tools_def ARM: use softfloat target for CLANG3x
      BaseTools/GenFds: permit stripped MM_CORE_STANDALONE binaries
      BaseTools/Conf/tools_def.template: drop ARM/AARCH support from GCC4=
6/GCC47
      ArmPkg/ArmMmuLib ARM: add missing support for non-shareable cached =
mappings
      ArmPkg/ArmMmuLib ARM: fix thinko in second level page table handlin=
g
      MdePkg: implement MmServicesTableLib based on traditional SMM
      BaseTools/tools_def GCC5: disable LTO for ASLC invocations
      ArmPkg/ArmMmuLib ARM: disregard high memory when setting permission=
s
      ArmPkg/ArmMmuLib AARCH64: fix out of bounds access
      MdeModulePkg/MdeModulePkg.dsc: add MmServicesTableLib resolution
      OvmfPkg: add MmServicesTableLib resolution
      QuarkPlatformPkg: add MmServicesTableLib resolution
      Vlv2TbltDevicePkg: add MmServicesTableLib resolution
      MdeModulePkg/FaultTolerantWriteDxe: factor out boot service accesse=
s
      MdeModulePkg/FaultTolerantWriteDxe: implement standalone MM version
      MdeModulePkg/VariableRuntimeDxe: factor out boot service accesses
      MdeModulePkg/VariableRuntimeDxe: implement standalone MM version
      MdePkg: introduce standalone MM entry point library class
      MdePkg: introduce standalone MM entry point library implementation
      MdePkg: add MM_STANDALONE implementation of MmServicesTableLib
      MdeModulePkg: implement NULL instance of HobLib library class
      MdeModulePkg: implement NULL instance of MemoryAllocationLib librar=
y class
      MdeModulePkg/MdeModulePkg/dsc: move DxeDebugSupportDxe to x86 only =
section
      MdeModulePkg/AuthVariableLibNull: add MM_STANDALONE support
      MdeModulePkg/VarCheckLib: add MM_STANDALONE support
      MdeModulePkg/MdeModulePkg.dsc: add MM_STANDALONE FTW and variable m=
odules
      ArmPkg/DebugAgentSymbolsBaseLib: remove exception handling
      ArmPkg/DefaultExceptionHandlerLib: declare the permitted usage cont=
ext
      ArmVirtPkg: drop reference to ArmPkg/DefaultExceptionHandlerLibBase
      ArmPkg/DefaultExceptionHandlerLib: drop BASE variant
      ArmPkg/DefaultExceptionHandlerLib: use console if available
      EmbeddedPkg/NorFlashInfoLib: convert to BASE library
      ArmPkg/DefaultExceptionHandlerLib: add missing UefiLib include
      CryptoPkg/SmmCryptLib: permit use by MM_STANDALONE modules
      SecurityPkg/PlatformSecureLibNull: permit use by MM_STANDALONE modu=
les
      MdeModulePkg/VarCheckUefiLib: permit use by MM_STANDALONE modules
      MdePkg/UefiDevicePathLib: permit use by MM_STANDALONE modules
      StandaloneMmPkg: add HobLib implementation for MM_STANDALONE module=
s
      StandaloneMmPkg: add MM_STANDALONE MemoryAllocationLib implementati=
on
      StandaloneMmPkg/StandaloneMmCoreHobLib: restrict to MM_CORE_STANDAL=
ONE
      StandaloneMmPkg/StandaloneMmCpu: fix typo Standlone -> Standalone
      StandaloneMmPkg/StandaloneMmCoreEntryPoint: use %a modifier for ASC=
II strings
      StandaloneMmPkg/StandaloneMmCoreEntryPoint: remove bogus ASSERT_EFI=
_ERROR()s
      StandaloneMmPkg/StandaloneMmPeCoffExtraActionLib: ignore runtime at=
tribute
      StandaloneMmPkg/Core/Dispatcher: don't copy dispatched image twice
      StandaloneMmPkg/StandaloneMmCoreEntryPoint: permit the use of TE im=
ages
      MdeModulePkg/MdeModulePkg.dsc: ignore standalone MM modules for EBC=
 or XCODE5
      ArmPkg/ArmMmuLib ARM: trim high memory regions instead of rejecting=
 them
      ArmPkg/ArmMmuLib AARCH64: get rid of needless TLB invalidation
      MdePkg/BaseLib: implement SpeculationBarrier() for ARM and AArch64

Ashish Singhal (6):
      MdeModulePkg/SdMmcPciHcDxe: Add SDMMC HC v4 and above Support.
      MdePkg/UefiLib: Abstract driver model protocol uninstallation
      NetworkPkg/IScsiDxe: Use UEFILib APIs to uninstall protocols.
      NetworkPkg: Protocol Uninstallation Cleanup
      DynamicTablesPkg/DynamicTableManagerDxe: Update DEPEX
      DynamicTablesPkg/AcpiSpcrLibArm: Support 16550 UART.

Bret Barkelew (4):
      MdePkg/IndustryStandard: Introduce a correctly spelled macro
      SecurityPkg/Tcg: Fix typos in TcgDxe.c and Tcg2Dxe.c
      MdePkg/IndustryStandard: Remove an incorrectly spelled macro
      MdePkg/UefiLib: Add a new API GetVariable3

Chasel, Chiu (16):
      IntelFsp2WrapperPkg: Support FSP Dispatch mode
      IntelFsp2WrapperPkg: Revert 90c5bc08
      IntelFsp2WrapperPkg: Support FSP Dispatch mode
      IntelFsp2WrapperPkg: Fix line ending format issue
      IntelFsp2WrapperPkg: Fix constant if statements issue
      Maintainers.txt: Change package maintainer of IntelFsp*Pkg
      BaseTools/GenFv: Support SecCore and PeiCore in different FV
      IntelFsp2Pkg: Add FspmArchConfigPpi to support Dispatch mode
      IntelFsp2Pkg: Remove unused keyword in new PPI header
      IntelFsp2Pkg: Add function to get bootloader stack pointer
      IntelFsp2Pkg: FSP can utilize bootloader stack
      MdePkg: Support EFI_PEI_CORE_FV_LOCATION_PPI
      MdeModulePkg/PeiMain: Support EFI_PEI_CORE_FV_LOCATION_PPI
      UefiCpuPkg/SecCore: Support EFI_PEI_CORE_FV_LOCATION_PPI
      UefiCpuPkg/SecCore: Support EFI_PEI_CORE_FV_LOCATION_PPI
      UefiCpuPkg/SecCore: Wrong Debug Information for SecCore

Chen A Chen (18):
      SecurityPkg: Remove dead code and inf redundant definitions.
      SecurityPkg: Remove code under UserIdentification folder.
      FatPkg: Break down Part.c file.
      MdePkg/UefiGpt.h: Add new definition for enable GPT support
      FatPkg: Add GPT check in FatPei to support Capsule-on-Disk feature.
      MdePkg/UefiSpec.h: Add definition to support Capsule-on-Disk featur=
e
      MdeModulePkg/CapsuleApp: Add a function used to get next DevicePath
      MdeModulePkg/CapsuleApp: Add functions to support Capsule-on-Disk
      MdeModulePkg/CapsuleApp: Enhance CapsuleApp to support Capsule-on-D=
isk
      FatPkg/FatPei/Gpt.c: Fix uninitialized variable issue
      MdeModulePkg/CapsuleApp: Fix potential NULL pointer dereference iss=
ue
      MdeModulePkg/CapsuleApp: Fix potential NULL pointer dereference iss=
ue
      MdeModulePkg/CapsuleApp: Fix memory leak issue.
      UefiCpuPkg/Microcode: Fix incorrect checksum issue for extended tab=
le
      IntelSiliconPkg/MicrocodeUpdate: Fix incorrect checksum issue
      MdeModulePkg: Rename confusion function name
      UefiCpuPkg/Microcode: Fix InComplete CheckSum32 issue
      UefiCpuPkg/Microcode.c: Add verification before calculate CheckSum3=
2

Chu, Maggie (2):
      SecurityPkg: Incorrect warning message for Opal admin revert action
      SecurityPkg: Add a PCD to skip Opal password prompt

Dandan Bi (12):
      MdeModulePkg/DisplayEngine: Remove useless NULL ptr check for NewPo=
s
      MdePkg: check Length para before use in DevPathToTextUsbWWID
      MdePkg: Check input Ptrs in GetSectionFromAnyFvByFileType
      BaseTools/VfrCompile: report error for Integer overflow
      MdeModulePkg/NonDiscoverablePciDevice: Remove the redundant check
      MdePkg/BasePeCoffLib: Add more check for relocation data
      MdePkg/BasePeCoffLib: Correct the address of RelocBaseEnd
      ShellPkg/UefiShellAcpiViewCommandLib: Fix VS tool chain build failu=
re
      MdeModulePkg: Fix coding style issues
      MdePkg: Fix coding style issues
      MdePkg/StatusCodeDataTypeId.h: Add new definition per PI1.7 Spec
      MdeModulePkg/BmBoot: Report status when fail to load/start boot opt=
ion

Derek Lin (1):
      BaseTools: Fix GenFds error doesn't break build.

Edgar Handal (1):
      MdeModulePkg/SdMmcPciHcDxe: Use 16/32-bit IO widths

Eric Dong (9):
      UefiCpuPkg/Cpuid.h: Sync CPUID definition to latest SDM.
      UefiCpuPkg/Cpuid: Add code to support new definition.
      UefiCpuPkg/RegisterCpuFeaturesLib: Enhance debug message.
      UefiCpuPkg/RegisterCpuFeaturesLib: Avoid AP calls PeiService.
      UefiCpuPkg/S3Resume2Pei: check 64BIT_WAKE_F in FACS.OSPMFlags.
      MdeModulePkg/BootScriptExecuteorDxe: check 64BIT_WAKE_F in FACS.OSP=
MFlags
      UefiCpuPkg/RegisterCpuFeaturesLib: Replace AcquireSpinLock.
      SecurityPkg/OpalPassword: Update strings on Opal Setup page
      SecurityPkg/OpalPassword: Add NULL pointer check before using it

Felix Polyudov (1):
      BaseTools: Fix incorrect formatting of GenFds command dictionary

Feng, Bob C (52):
      BaseTools: Fix the problem using FILE_GUID override in .dsc
      BaseTools: Enable Pcd Array support.
      BaseTool: Filter out unused structure pcds
      BaseTools: Replace the sqlite database with list
      BaseTools: Optimize string concatenation
      BaseTools: Customize deepcopy function.
      BaseTools: Correct CCFLAG for PcdValueInit
      BaseTools: Fix PcdNvStoreDefaultValueBuffer Value.
      BaseTools: Fixed bugs in CopyDict function
      BaseTools: Fixed the build fail issue for cases
      BaseTools: Fix PcdArray issue
      BaseTools: Fixed metafile parser issues
      BaseTools: Reset FdsGlobalVariable
      BaseTools: Fixed build report issue.
      BaseTools: Correct PcdArray value assigment statement
      BaseTools: Report Error if use SET in Dsc
      BaseTools: Remove unused logic for EDKI
      BaseTools: Remove unused logic for IPF
      BaseTools: Remove unused logic from C tools
      BaseTools: Enable component override functionality
      BaseTools: Remove unused logic for EDKI
      BaseTools: Remove EDK_SOURCE keyword from ECC Tool
      BaseTools: Remove EDK_SOURCE keyword from GenFds tool.
      BaseTools: Remove EDK_SOURCE keyword from Inf Parser.
      BaseTools: Allow empty value for HiiPcd in Dsc
      BaseTools: Fix build report issue.
      BaseTools: use OrderedDict instead of sdict
      BaseTools: Make sure AllPcdList valid.
      BaseTools:File open failed for VPD MapFile
      BaseTools:Fixed Rsa issue and a set define issue.
      BaseTools:ord() don't match in py2 and py3
      BaseTools: the list and iterator translation
      BaseTools: Handle the bytes and str difference
      BaseTools: ECC tool Python3 adaption
      BaseTools: Eot tool Python3 adaption
      BaseTools: Enable CODE format in DEC file
      BaseTools: Fixed incorrect line number in PcdValueInit.c
      BaseTools: Correct the error message for UPT
      BaseTools: Fixed a build report issue.
      BaseTools: Fix the build report issue about Structure PCD
      BaseTools: Fixed an issue about StructurePcd
      BaseTools: Add MaxSizeUserSet to Pcd deepcopy function
      BaseTools: Fix a ParseDevPathValue function issue.
      BaseTools: Fixed a bug in Vpd handling
      BaseTools: Fixed a code bug for Pcd Array.
      BaseTools: replace Sdict with OrderedDict in UPT
      BaseTool: Fixed incremental rebuild issue.
      BaseTools: Fix a bug about Structure PCD
      BaseTools: Add parameter check for the AsciiStringToUint64
      BaseTools: Eot failed when enable python3
      BaseTools: Fix a Eot issue.
      BaseTools: Add python3-distutils Ubuntu package checking

Gary Lin (2):
      MdePkg ACPI: fix the typos in Acpi61.h and Acpi62.h
      MdeModulePkg/UefiBootManagerLib: Match the nested partitions

Gonzalez Del Cueto, Rodrigo (1):
      SecurityPkg/TcgConfigDxe: Allow enabling TPM 1.2 device from disabl=
ed state.

Hao Wu (25):
      MdePkg/BaseLib: Introduce new SpeculationBarrier API
      MdeModulePkg/FaultTolerantWrite: Update to consume SpeculationBarri=
er
      MdeModulePkg/SmmLockBox: Update to consume SpeculationBarrier
      MdeModulePkg/Variable: Update to consume SpeculationBarrier
      UefiCpuPkg/PiSmmCpuDxeSmm: Update to consume SpeculationBarrier
      UefiCpuPkg: Merge StuffRsb.inc files into one in UefiCpuPkg/Include
      MdeModulePkg/SdMmcPciHcDxe: Fix VS2015 IA32 NOOPT build failure
      MdeModulePkg/SdMmcPciHcDxe: Update comment for spec compliance stat=
us
      MdeModulePkg: Add definitions for ATA AHCI host controller PPI
      MdeModulePkg: Add definitions for EDKII PEI ATA PassThru PPI
      MdeModulePkg: Add definitions for Storage Security Command PPI
      MdeModulePkg: Add GUID for LockBox to save storage dev to init in S=
3
      MdeModulePkg/NvmExpressPei: Avoid updating the module-level variabl=
e
      MdeModulePkg/NvmExpressPei: Add logic to produce SSC PPI
      MdeModulePkg/NvmExpressPei: Consume S3StorageDeviceInitList LockBox
      MdeModulePkg/AhciPei: Add AHCI mode ATA device support in PEI
      MdeModulePkg/SmmLockBoxLib: Use 'DEBUG_' prefix instead of 'EFI_D_'
      MdeModulePkg/SmmLockBox(PEI): Remove an ASSERT in RestoreLockBox()
      MdeModulePkg/SmmLockBoxLib: Support LockBox enlarge in UpdateLockBo=
x()
      OvmfPkg/LockBoxLib: Update the comments for API UpdateLockBox()
      SecurityPkg/OpalPassword: Remove HW init codes and consume SSC PPI
      SecurityPkg/HddPassword: Add Security feature set support for ATA d=
ev
      MdeModulePkg/UfsBlockIoPei: Correct use of 'DeviceIndex' in BlkIO P=
PI
      MdeModulePkg/PartitionDxe: Ensure blocksize holds MBR (CVE-2018-121=
80)
      MdeModulePkg/RamDiskDxe: Restrict on RAM disk size (CVE-2018-12180)

Hess Chen (1):
      BaseTools/ECC: Add a new type of exception

Hsueh, Hong-chihX (1):
      MdePkg/BasePeCoffLib: skip runtime relocation if reloc info is inva=
lid

Jaben Carsey (14):
      BaseTools: Move Identification file to Eot
      BaseTools: cleanup LongFilePathSupport usage
      BaseTools: create and use a standard shared variable for '*'
      BaseTools: fix imports
      MdeModulePkg: fix comments in BaseSortLib
      BaseTools/build/build: refactor and move functions
      BaseTools/Workspace/InfBuildData: move functions
      BaseTools/DscBuildData: move function
      BaseTools/AutoGen: move functions
      BaseTools/GenFds/Capsule: move function logic
      BaseTools/Common/Misc: move private functions
      BaseTools/Common/Misc: remove uncalled code
      BaseTools/Common/Misc: Cleanup the imports
      BaseTools/build/build: delete variable

Jagadeesh Ujja (2):
      SecurityPkg/AuthVariableLib: allow MM_STANDALONE drivers to use thi=
s library
      MdePkg/Include: add MmServicesTableLib header file

Jeff Brasen (5):
      MdeModulePkg/SdDxe: Fix potential NULL pointer access
      EmbeddedPkg/PrePiMemoryAllocationLib: Added AllocateZeroPool()
      MdeModulePkg/BaseSortLib: Enable for all module types
      ArmPkg/ArmScmiDxe: Add clock enable function
      EmbeddedPkg/PrePiLib: Correct function name

Jian J Wang (7):
      CryptoPkg/IntrinsicLib: add missing BaseLib declaration
      Upgrade OpenSSL to 1.1.0j
      CryptoPkg/BaseCryptLib: split CryptPkcs7Verify.c on behalf of runti=
me
      MdePkg/UefiDevicePathLib: Add sanity check for FilePath device path
      MdePkg/UefiDevicePathLibDevicePathProtocol: Add sanity check for Fi=
lePath device path
      UefiCpuPkg: restore strict page attributes via #DB in nonstop mode =
only
      Maintainers.txt: remove unexpected unicode BOM

Jiaxin Wu (7):
      MdeModulePkg/Dhcp4Dxe: Remove unnecessary NULL pointer check.
      NetworkPkg/IScsiDxe: Remove unnecessary NULL pointer check.
      NetworkPkg/DnsDxe: Remove unnecessary NULL pointer check.
      MdeModulePkg/Ip4Dxe: Uninstall protocols when error happen in Drive=
r Binding Start.
      NetworkPkg/Ip6Dxe: Uninstall protocols when error happen in Driver =
Binding Start.
      NetworkPkg/Ip6Dxe: Clean the invalid IPv6 configuration during driv=
er start.
      NetworkPkg/DnsDxe: [CVE-2018-12178] Check the received packet size =
before parsing the message.

Jiewen Yao (6):
      MdeModulePkg/LockboxNullLib: clean up INF file.
      BaseTool/GenC: Fix build error when type is BASE or USER_DEFINED.
      MdePkg/Include: Add Nasm.inc
      MdePkg/BaseLib: Add Shadow Stack Support for X86.
      UefiCpuPkg/ExceptionLib: Add CET support.
      UefiCpuPkg/PiSmmCpu: Add Shadow Stack Support for X86 SMM.

Jordan Justen (1):
      OvmfPkg/build.sh: Enable flash for qemu 3 or later

Julien Grall (1):
      Maintainers.txt: Update e-mail address for Julien Grall

Krzysztof Koch (1):
      ShellPkg/UefiShellAcpiViewCommandLib: Add support for PPTT

Laszlo Ersek (47):
      EmulatorPkg: require GCC48 or later
      OvmfPkg: require GCC48 or later
      Vlv2TbltDevicePkg: assume GCC48 or later
      BaseTools/tools_def.template: fix up LF-only line terminator
      BaseTools/tools_def.template: strip trailing whitespace
      BaseTools/tools_def.template: remove GCC48_IA32_X64_DLINK_COMMON de=
ad-end
      BaseTools/tools_def.template: remove GCC47 leaf definitions
      BaseTools/tools_def.template: propagate loss of GCC47 references
      BaseTools/tools_def.template: remove GCC47 documentation
      BaseTools/tools_def.template: remove GCC46 leaf definitions
      BaseTools/tools_def.template: propagate loss of GCC46 references
      BaseTools/tools_def.template: remove GCC46 documentation
      BaseTools/tools_def.template: remove GCC45 leaf definitions
      BaseTools/tools_def.template: propagate loss of GCC45 references
      BaseTools/tools_def.template: remove GCC45 documentation
      BaseTools/tools_def.template: remove GCC44 leaf definitions
      BaseTools/tools_def.template: propagate loss of GCC44 references
      BaseTools/tools_def.template: rename GCC44_ALL_CC_FLAGS to GCC48_AL=
L_CC_FLAGS
      BaseTools/tools_def.template: eliminate GCC44_IA32_X64_DLINK_FLAGS
      BaseTools/tools_def.template: rename GCC44_IA32_X64_DLINK_COMMON to=
 GCC48_IA32_X64_DLINK_COMMON
      BaseTools/tools_def.template: remove comment about GCC44 + LzmaF86C=
ompress
      BaseTools/tools_def.template: remove GCC44 documentation
      ArmPkg/ArmSoftFloatLib: drop build flags specific to GCC46/GCC47
      CryptoPkg/BaseCryptLib: drop build flags specific to GCC44
      Revert "MdePkg: avoid __builtin_unreachable() on GCC v4.4"
      BaseTools/BuildReport: fix report for platforms/arches without stru=
ct PCDs
      ArmVirtPkg/ArmVirtQemuKernel: don't set PcdCPUCoresStackBase
      ArmVirtPkg: don't set PcdRelocateVectorTable
      ArmVirtPkg/{ArmVirtQemu,ArmVirtQemuKernel}: don't set PcdTrustzoneS=
upport
      ArmVirtPkg: don't set PcdPostCodePropertyMask
      ArmVirtPkg: clean up PcdSetNxForStack setting (applies to ArmVirtQe=
mu only)
      ArmVirtPkg/PrePi: drop wrong PcdCoreCount dependency
      ArmVirtPkg: don't set PcdCoreCount
      ArmVirtPkg: don't set PcdDebugClearMemoryValue
      ArmVirtPkg: don't set PcdDebugPrintErrorLevel in RELEASE builds
      ArmVirtPkg/ArmVirtXen: don't set PcdPL031RtcBase
      ArmVirtPkg/ArmVirtXen: don't set PcdTerminalTypeGuidBuffer
      ArmVirtPkg/ArmVirtXen: don't set PcdShellFile
      ArmVirtPkg/ArmVirtXen: don't set PcdTurnOffUsbLegacySupport
      ArmVirtPkg/ArmVirtXen: don't set Pcd*ImageVerificationPolicy
      Maintainers: add TPM2 reviewers for OvmfPkg
      Maintainers: specify the scope for OvmfPkg/ArmVirtPkg Xen module re=
viewers
      MdeModulePkg/UefiBootManagerLib: fix LoadImage/StartImage status co=
de rep.
      OvmfPkg: add library to track boot option loading/starting on the c=
onsole
      OvmfPkg/PlatformBootManagerLib: display boot option loading/startin=
g
      ArmVirtPkg/ArmVirtQemu*: enable minimal Status Code Routing in DXE
      ArmVirtPkg/PlatformBootManagerLib: display boot option loading/star=
ting

Leif Lindholm (8):
      ArmPkg: fix StandaloneMmMmuLib subdirectory case
      ArmPkg: drop ArmBds remnant Pcds from .dec
      ArmPkg: delete unused ArmTrustZoneSmc.h
      AppPkg: fix webserver build for !Ia32/X64
      IntelFrameworkModulePkg: fix build for AARCH64/ARM
      IntelFrameworkPkg: fix build for AARCH64/ARM
      SecurityPkg: fix package build on ARM
      SignedCapsulePkg: enable package build for AARCH64/ARM

Liming Gao (12):
      OvmfPkg: Don't include TftpDynamicCommand in XCODE5 tool chain
      MdeModulePkg PCD: Add DynamicEx PcdVpdBaseAddress64 for non SPI pla=
tform
      Maintainers.txt: Add the rule to hand over the package maintain rol=
e
      BaseTools Script: Update ConvertFceToStructurePcd to report warning=
 messages
      MdeModulePkg: Correct PCD name in MdeModulePkg.uni
      Readme.md: Add edk2 release tag and edk2 release plan
      BaseTools GenFw: Fix XCODE5 build issue
      BaseTools VolInfo: Fix XCODE5 build issue
      BaseTools: Update PYTHON env to PYTHON_COMMAND
      MdeModulePkg DxeCapsuleLibFmp: Update SupportCapsuleImage() for Fak=
e Capsule
      BaseTools: Remove unused txt files
      Revert "BaseTools:BaseTools supports to the driver combination."

Liu Yu (1):
      EmulatorPkg/build.sh: Fix 'run' path to simulator host executable

Marcin Wojtas (2):
      MdeModulePkg/SdMmcPciHcDxe: Add an optional parameter in NotifyPhas=
e
      MdeModulePkg/SdMmcPciHcDxe: Allow overriding base clock frequency

Max Knutsen (1):
      MdeModulePkg/ReportStatusCodeLib: Avoid using AllocatePool if possi=
ble

Meenakshi Aggarwal (1):
      EmbeddedPkg: Fix Command Argument for SD/eMMC R/W operation.

Mike Maslenkin (1):
      UefiCpuPkg/CpuExceptionHandlerLib: Fix spelling issue

Mike Turner (4):
      MdePkg/BaseLib: Introduce CharToUpper and AsciiCharToUpper publicly
      MdePkg/UefiDevicePathLib: Add a checking step
      BaseTools/DevicePath: Add a checking step
      MdePkg/BaseLib: Add Base64Encode() and Base64Decode()

Pete Batard (2):
      EmbeddedPkg/Library: Add VirtualRealTimeClockLib
      EmbeddedPkg/VirtualRealTimeClockLib: Fix correctness issues

Philippe Mathieu-Daude (1):
      BaseTools: Fix build failure when specifying multiple BUILDTARGET

Ray Ni (10):
      MdeModulePkg/PciBus: Shadow option ROM after BARs are programmed
      MdeModulePkg/PciBus: Fix system hang when no PCI Option ROM exists
      Maintainers.txt: Update mail address
      MdeModulePkg/PciBus: Change PCI_IO_DEVICE.RomSize to UINT32 type
      MdeModulePkg/PciBus: Correct typos
      MdeModulePkg/PciBus: Fix a bug PPB MEM32 BAR isn't restored sometim=
es
      UefiCpuPkg/MtrrLib: Fix a bug that may wrongly set memory <1MB to U=
C
      ShellBinPkg: Ia32/X64 Shell binary update.
      MdeModulePkg/HiiDatabase: Fix potential integer overflow (CVE-2018-=
12181)
      MdeModulePkg/HiiImage: Fix stack overflow when corrupted BMP is par=
sed (CVE-2018-12181)

Sami Mujawar (36):
      Maintainers.txt: Change DynamicTablesPkg maintainer
      DynamicTablesPkg: Dynamic Tables Framework
      DynamicTablesPkg: Table Generator definition
      DynamicTablesPkg: Acpi Table Generator
      DynamicTablesPkg: SMBIOS Table Generator
      DynamicTablesPkg: DT Table Generator
      DynamicTablesPkg: Standard NameSpace Objects
      DynamicTablesPkg: Arm NameSpace Objects
      DynamicTablesPkg: Configuration Manager Objects
      DynamicTablesPkg: Configuration Manager Protocol
      DynamicTablesPkg: Configuration Manager Helper
      DynamicTablesPkg: Table Helper Library
      DynamicTablesPkg: Dynamic Table Factory Protocol
      DynamicTablesPkg: Dynamic Table Factory Dxe
      DynamicTablesPkg: Dynamic Table Manager Dxe
      DynamicTablesPkg: Arm Raw/DSDT/SSDT Generator
      DynamicTablesPkg: Arm ACPI FADT Generator
      DynamicTablesPkg: Arm ACPI MADT Generator
      DynamicTablesPkg: Arm ACPI GTDT Generator
      DynamicTablesPkg: Arm SPCR Table Generator
      DynamicTablesPkg: Arm DBG2 Table Generator
      DynamicTablesPkg: Arm PCI MCFG Table Generator
      DynamicTablesPkg: Arm IORT Table Generator
      DynamicTablesPkg: Fix protocol section
      DynamicTablesPkg: Rename enum used for ID Mapping
      DynamicTablesPkg: Add OEM Info
      DynamicTablesPkg: DGB2: Update DBG2_DEBUG_PORT_DDI
      DynamicTablesPkg: Remove GIC Distributor Id field
      DynamicTablesPkg: Minor updates and fix typos
      ArmPkg: Fix writes to GICv3 GICD_IROUTER<n> reg
      Revert "DynamicTablesPkg: Minor updates and fix typos"
      Revert "DynamicTablesPkg: Remove GIC Distributor Id field"
      Revert "DynamicTablesPkg: DGB2: Update DBG2_DEBUG_PORT_DDI"
      Revert "DynamicTablesPkg: Add OEM Info"
      Revert "DynamicTablesPkg: Rename enum used for ID Mapping"
      Revert "DynamicTablesPkg: Fix protocol section"

Sean Brogan (1):
      MdeModulePkg/NvmExpressDxe: Report StatusCode for device init failu=
re

Shenglei Zhang (37):
      EmulatorPkg: Remove EdkShellBinPkg in FDF and DEC
      Nt32Pkg: Remove EdkShellBinPkg in FDF and DEC
      OvmfPkg: Remove EdkShellBinPkg in FDF
      Vlv2TbltDevicePkg: Remove EdkShellBinPkg with ShellPkg
      EdkShellBinPkg: Remove EdkShellBinPkg
      EdkShellPkg: Remove EdkShellPkg
      Maintainers.txt: Remove EdkShellPkg and EkdShellBinPkg
      UnixPkg: Remove UnixPkg and update Maintainers.txt
      MdeModulePkg: Remove PcdIdentifyMappingPageTablePtr
      ShellPkg: Remove ShellPkg wrapper header files
      BaseTools: Remove GenVtf
      DuetPkg: Remove DuetPkg
      BaseTools: Remove tools only used by DuetPkg
      Maintainers.txt: Remove DuetPkg
      ShellPkg/UefiShellDebug1CommandsLib: Remove the unused function Cha=
rToUpper
      MdeModulePkg/EbcDebugger: Change function names
      MdePkg/BaseLib: Remove definitions of two functions
      MdeModulePkg/EbcDebugger: Use AsciiCharToUpper and CharToUpper
      MdeModulePkg/DxeHttpLib: Use BaseLib api AsciiCharToUpper
      ShellPkg/Shell: Use BaseLib api CharToUpper
      ShellPkg/UefiShellLib: Use BaseLib api CharToUpper
      MdePkg: Change function parameter type
      MdeModulePkg/S3SaveStateDxe: Change function parameter types
      MdeModulePkg/SmmS3SaveStateDxe: Change function parameter types
      BaseTools/tools_def.template: Remove CYGGCC
      OptionRomPkg/ReadMe.txt: Remove CYGGCC
      BaseTools: Update MYTOOLS
      BaseTools/tools_def.template: Remove VS2003 and VS2005
      OptionRomPkg/ReadMe.txt: Remove VS2005
      BaseTools/tools_def.template: Remove UNIXGCC
      OvmfPkg/README: Remove UNIXGCC
      BaseTools/tools_def.template: Remove ELFGCC
      BaseTools/tools_def.template: Remove DDK3790
      BaseTools/build_rule.template: Remove GCCLD
      MdePkg/BaseLib: Change a variable type in a bitwise operation
      MdeModulePkg/PropertiesTableAttributesDxe: Remove this driver
      IntelSiliconPkg/MicrocodeUpdateDxe: Error message enhancement

Siyuan Fu (8):
      ArmVirtPkg: Replace obsoleted network drivers from platform DSC/FDF=
.
      ArmVirtPkg: Remove redundant library instances in ArmVirtQemuKernel=
.dsc
      MdeModulePkg: Delete Tcp4Dxe in MdeModulePkg.
      NetworkPkg: Remove some clarification from TcpDxe.inf
      MdeModulePkg: Delete IScsiDxe in MdeModulePkg.
      NetworkPkg: Remove some clarification from IScsiDxe.inf
      MdeModulePkg: Delete UefiPxeBcDxe in MdeModulePkg.
      NetworkPkg: Remove some clarification from UefiPxeBcDxe.inf

Solanki, Digant H (1):
      IntelSiliconPkg\Include\IndustryStandard: Update IGD_OPREGION_MBOX3=
 Structure

Songpeng Li (3):
      ShellPkg/TftpDynamicCommand: Change file writing method in tftp
      NetworkPkg/IScsiDxe: Remove unused global variables.
      NetworkPkg/Dhcp6Dxe: Remove an unused global variable.

Star Zeng (30):
      Maintainers.txt: Update FmpDevicePkg maintainer
      Maintainers.txt: Update MdeModulePkg maintainers
      MdeModulePkg PeiCore: Remove the using of PcdPeiCoreMaxPeimPerFv
      SecurityPkg Tcg(2)Pei: Remove the using of PcdPeiCoreMaxFvSupported
      MdeModulePkg PeiCore: Remove the using of PcdPeiCoreMaxFvSupported
      MdeModulePkg PeiCore: Remove the using of PcdPeiCoreMaxPpiSupported
      OvmfPkg: Remove PcdPeiCoreMaxXXX PCDs' statement
      Vlv2TbltDevicePkg: Remove PcdPeiCoreMaxXXX PCDs' statement
      MdeModulePkg: Remove PcdPeiCoreMaxXXX PCDs
      MdeModulePkg Variable: Add some missing changes for 9b18845
      MdeModulePkg Variable: Abstract InitRealNonVolatileVariableStore
      MdeModulePkg Variable: Move "extern XXX" to Variable.h
      MdeModulePkg Variable: Not get NV PCD in VariableWriteServiceInitia=
lize
      MdeModulePkg Variable: Abstract VariableWriteServiceInitializeDxe/S=
mm
      MdeModulePkg Variable: Remove CacheOffset in UpdateVariable()
      MdeModulePkg Variable: type case VolatileBase to UINTN directly
      MdeModulePkg: Add PcdEmuVariableNvModeEnable in dec
      MdeModulePkg: Refine description a little for PcdEmuVariableNvStore=
Reserved
      MdeModulePkg Variable: Add emulated variable NV mode support
      MdeModulePkg VariablePei: Don't check BOOT_IN_RECOVERY_MODE
      ArmVirtXen: Use merged variable driver for emulated NV mode
      ArmVirtXen: Link VarCheckUefiLib NULL class library instance
      BeagleBoardPkg: Use merged variable driver for emulated NV mode
      QuarkMin: Use merged variable driver for emulated NV mode
      CorebootPayloadPkg: Use merged variable driver for emulated NV mode
      MdeModulePkg VariableStandaloneMm: Add PcdEmuVariableNvModeEnable i=
n inf
      MdeModulePkg: Remove EmuVariableRuntimeDxe
      MdeModulePkg/PeiCore: Ensure FfsFileHeader 8 bytes aligned
      MdeModulePkg/DxeCore: Ensure FfsFileHeader 8 bytes aligned
      IntelFrameworkModulePkg/FwVolDxe: Ensure FfsFileHeader 8 bytes alig=
ned

Stefan Berger (1):
      OvmfPkg: Add TCG2 Configuration menu to the Device Manager menu

Sughosh Ganu (3):
      ArmPkg/Include: Fix the SPM version SVC ID
      StandaloneMM: Include the newly added library class for MMU functio=
ns
      StandaloneMM: Update permissions for Standalone MM drivers memory a=
rea

Sumit Garg (2):
      ArmPkg/OpteeLib: Add dummy RPC handler
      ArmPkg/OpteeLib: Add OPTEE_SUCCESS return code

Sun, Zailiang (1):
      Maintainers.txt: update Vlv2*Pkg maintainers.

Tomasz Michalec (2):
      MdeModulePkg/SdMmcPciHcDxe: Add UhsSignaling to SdMmcOverride proto=
col
      MdeModulePkg/SdMmcPciHcDxe: Add SwitchClockFreqPost to SdMmcOverrid=
e

Vijayenthiran Subramaniam (2):
      MdeModulePkg/Variable: add debug logs in VariableServiceSetVariable
      NetworkPkg/IScsiDxe: add debug logs for failed SetVariable attempts

Vladimir Olovyannikov (1):
      MdeModulePkg/NonDiscoverablePciDeviceDxe: add missing validation

Vladimir Olovyannikov via edk2-devel (1):
      ShellPkg/TftpDynamicCommand: Return proper status

Wang Fan (2):
      NetworkPkg: Add WiFi Connection Manager to NetworkPkg
      NetworkPkg: Fix Duplicate FreePool Error in WCM

Ye Ting (1):
      Maintainers.txt: Change package maintainer and reviewer of CryptoPk=
g.

Yonghong Zhu (1):
      Maintainers.txt: Update BaseTools maintainers

Yunhua Feng (3):
      BaseTools: nametuple not have verbose parameter in python3
      BaseTools: Remove unnecessary super function
      BaseTools: replace long by int

Zhang, Chao B (6):
      SecurityPkg: TCG Add more Event type
      SecurityPkg: Update TCG PFP spec revision.
      SecurityPkg/Tcg: Fix Warnings and Remarks reported by IASL
      SecurityPkg/TCG: Upgrade UEFI supporting TCG spec info
      MdeModulePkg:Tpm2Acpi.h: Upgrade UEFI supporting TCG spec info
      Maintainers.txt: Change package maintainer and reviewer of Security=
Pkg.

Zhao, ZhiqiangX (1):
      BaseTools: AutoGen and GenFds share the parser data.

Zhichao Gao (8):
      ShellPkg: add array index check for shell delay option
      MdeModulePkg: change the function name ResetSystem
      MdeModulePkg: Add the new API ResetSystem in the head file
      MdeModulePkg: Add a new API ResetSystem for DXE ResetSystemLib
      MdeModulePkg: Add a new API ResetSystem for Null version
      MdeModulePkg: Add a new API ResetSystem for PEI ResetSystemLib
      MdeModulePkg: Add a runtime library instance of ResetSystemLib
      MdeModulePkg: Add the runtime ResetSystemLib in MdeModulePkg.dsc

Zhijux Fan (38):
      BaseTools: Update nasm file build rule to support $(INC)
      BaseTools: Add $(INC)-like support when compiling .nasm files
      BaseTools:Build fail when PCD use in the [DEPEX] section of INF fil=
es
      BaseTools:build break if the Path contains SingleFile.Ext
      BaseTools:The BuildOptionPcd value is wrong
      BaseTools: Fix Pcd Array changes build report issue.
      BaseTools:Define Macro in Inf file, the pcdvalue Can't convert
      BaseTool:Rename xrange() to range()
      BaseTools:use iterate list to replace the itertools
      BaseTools: Rename iteritems to items
      BaseTools: replace get_bytes_le() to bytes_le
      BaseTools:Solve the data sorting problem use python3
      BaseTools: Update argparse arguments since it not have version now
      BaseTools:Similar to octal data rectification
      BaseTools/UPT:merge UPT Tool use Python2 and Python3
      BaseTools: update Test scripts support python3
      BaseTools/Scripts: Porting PackageDocumentTools code to use Python3
      Basetools: It went wrong when use os.linesep
      BaseTools:Fv BaseAddress must set If it not set
      BaseTools:TestTools character encoding issue
      BaseTools:Double carriage return inserted from Trim.py on Python3
      BaseTools: change the Division Operator
      BaseTools:There is extra blank line in datalog
      BaseTools: Similar to octal data rectification
      BaseTools: Update windows and linux run scripts file to use Python3
      BaseTools:Update build tool to print python version information
      BaseTools:Linux Python highest version check.
      BaseTools: PCD value incorrect in structure pcd sku case.
      BaseTools:StructurePCD value display incorrect in "Not used" sectio=
n.
      BaseTools:Fix a ECC issue
      BaseTools:BaseTools supports to the driver combination.
      BaseTools:Fixed build failure when specifying multiple BUILDTARGET
      BaseTools:PCD value error in structure pcd sku case.
      BaseTools:Build fail if define [DEPEX] in library inf
      BaseTools:Some build generated files content are not ordered on lin=
ux
      BaseTools:PackageDocumentTools import lib error occurs.
      BaseTools:The BOM character is processed when python reads a file
      BaseTools:Run packagedoc_cli.py to generate doc failed

yuchenlin (5):
      Revert "OvmfPkg/QemuVideoDxe: list "UnalignedIoInternal.h" in the I=
NF file"
      Revert "OvmfPkg/QemuVideoDxe: VMWare SVGA device support"
      Revert "OvmfPkg/QemuVideoDxe: Helper functions for unaligned port I=
/O."
      Revert "OvmfPkg: VMWare SVGA display device register definitions"
      OvmfPkg: simply use the Bochs interface for vmsvga

zwei4 (1):
      Vlv2TbltDevicePkg:Fix build and boot failure of Minnowboard Max pla=
tform.

Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---

Notes:
    pull:
   =20
    - pick up Igor's R-b
   =20
    v4:
   =20
    - no change
   =20
    v3:
   =20
    - pick up Igor's T-b
   =20
    v2:
   =20
    - pick up Phil's R-b
   =20
    - pick up Michal's and Michael's R-b's

 roms/edk2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/edk2 b/roms/edk2
index 85588389222a..89910a39dcfd 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit 85588389222a3636baf0f9ed8227f2434af4c3f9
+Subproject commit 89910a39dcfd788057caa5d88b7e76e112d187b5
--=20
2.19.1.3.g30247aa5d201
