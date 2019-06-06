Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A0EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807DA20673
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 13:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807DA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYsYy-0001HX-O8
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 09:36:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYsUh-0006d2-1L
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hYsUO-0000Xl-MG
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hYsUO-0000Sz-Ax
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 09:31:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 650CE3082131
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 13:31:26 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-196.ams2.redhat.com
	[10.36.116.196])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E0E4168424;
	Thu,  6 Jun 2019 13:31:23 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Date: Thu,  6 Jun 2019 15:31:06 +0200
Message-Id: <20190606133110.13754-3-lersek@redhat.com>
In-Reply-To: <20190606133110.13754-1-lersek@redhat.com>
References: <20190606133110.13754-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 06 Jun 2019 13:31:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/6] roms/edk2: update submodule from
 edk2-stable201903 to edk2-stable201905
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the edk2 submodule from release edk2-stable201903 to
edk2-stable201905. The release notes can be read at

  https://github.com/tianocore/edk2/releases/tag/edk2-stable201905

Below is a list of commits in the new release:

    1 c9e1e28b6195 Maintainers.txt: clarify Reviewer requirements and res=
ponsibilities
    2 a24a37dba42c StdLib: Update resolv.conf to use Google's DNS servers
    3 690d60c0ada5 MdeModulePkg/SdMmcPciHcDxe: Add V3 64b DMA Support
    4 326598e9b759 StandaloneMmPkg/Library: Install Variable Arch Protoco=
l
    5 56edfb174ad6 StandaloneMmPkg: drop redundant definition of gEfiMmCo=
nfigurationProtocolGuid
    6 8edde27a3835 StandaloneMmPkg: switch to NULL DebugLib resolution
    7 4b771927c801 StandaloneMmPkg/StandaloneMmCoreEntryPoint: drop expli=
cit SerialPortLib call
    8 d65e0e4881b7 StandaloneMmPkg/Core: permit encapsulated firmware vol=
umes
    9 84249babd703 StandaloneMmPkg/Core: dispatch all drivers at init tim=
e
   10 094c0bc7d7a5 StandaloneMmPkg/Core: drop support for dispatching FVs=
 into MM
   11 b2877855c7ec StandaloneMmPkg/Core: remove legacy boot support
   12 4d275961d8d6 StandaloneMmPkg: drop unused PCD PcdStandaloneMmEnable
   13 d6253d2f9a33 StandaloneMmPkg: remove redundant StandaloneMmDriverEn=
tryPoint driver
   14 fb94f83131f0 BaseTools: Enable compiler cache support in edk2 build
   15 c8eada5ca07b SecurityPkg: Remove duplicated BSD license
   16 5835c054f4ce Vlv2TbltDevicePkg: Remove duplicated BSD license
   17 b2a0a4ffd4d6 ShellPkg/UefiShellAcpiViewCommandLib: Change the note =
in uni
   18 d868846a4ecc BaseTool/Build: Add --disable-include-path-check.
   19 dbe05cb1c038 BaseTools: Fixed the issue of BaseTools Make cleanall =
failed.
   20 b0189eac00a5 BaseTools: Explicitly close files after readlines
   21 c49f298d28cb EmbeddedPkg/MmcDxe: Enable 4-bit mode even if SD_HIGH_=
SPEED is not supported
   22 34b162d078aa UefiCpuPkg/CpuCommonFeaturesLib: Aesni.c uses BIT0 and=
 BIT1 reversedly
   23 d0abf8bb3e09 MdePkg/MdePkg.uni: Add the prompt and help information
   24 6ef95e4da714 SecurityPkg/SecurityPkg.uni: Add the prompt and help i=
nformation
   25 792396bec919 UefiCpuPkg/UefiCpuPkg.uni: Add the prompt and help inf=
ormation
   26 43b1be74a8f6 ShellPkg: Correct a parameter's name
   27 2ac896a67b8e MdePkg/PciSegmentLibSegmentInfo: Change parameters typ=
e
   28 7681a891cec6 BaseTools: Add missing license and copyright info
   29 432a2ba1a0d7 DynamicTablesPkg: correct LibraryClass dependencies fo=
r Arm/DBG2
   30 fbdfef35cb82 DynamicTablesPkg: add package .dsc file
   31 a4712bea79a7 Vlv2TbltDevicePkg: ECP Cleanup.
   32 46002a4a379b Vlv2TbltDevicePkg: Fix build failure issue after ECP c=
leanup
   33 2cb2b6d6fa9c Vlv2TbltDevicePkg: Fix 32bit BIOS build failure issue
   34 4f93ff22b983 DynamicTablesPkg: Fix protocol section
   35 98a4a7a99bf5 DynamicTablesPkg: Rename enum used for ID Mapping
   36 e12bdeb1c2ad DynamicTablesPkg: Add OEM Info
   37 1018bd4c79a6 DynamicTablesPkg: DGB2: Update DBG2_DEBUG_PORT_DDI
   38 24534823b281 DynamicTablesPkg: Remove GIC Distributor Id field
   39 c606f47291e4 DynamicTablesPkg: Minor updates and fix typos
   40 6c27a4d337d0 MdeModulePkg/UefiBootManangerLib: Fix exception issue
   41 bb2c9ccb3388 MdeModulePkg/PiSmmCore: Control S3 related functionali=
ty through flag.
   42 f4c5200926df SecurityPkg/OpalPassword: Fix incorrect line ending is=
sue.
   43 210bd16aff81 Document: Remove obsolete user manuals
   44 f293841f9335 BaseTools: Remove EDKI related logic from Trim tool
   45 2f2c51acfb70 BaseTools: Remove the logic SourceOverridePath
   46 b669adebd01d Fix links in Maintainers.txt and remove slow outdated =
sourceforge git mirror
   47 cf85ba23d58c OvmfPkg: retire "create-release.py"
   48 4da419e2deb9 IntelSiliconPkg/IntelSiliconPkg.dsc: Add a driver to b=
uild
   49 fa888c7ee9ba PcAtChipsetPkg/PcatChipsetPkg.dsc: Add a driver to bui=
ld
   50 4a1f6b85c184 MdeModulePkg: add LockBoxNullLib for !IA32/X64 in .dsc
   51 a004d17d01a9 BaseTool: Fixed an issue of Structure PCD
   52 fdebdc961bfd Nt32Pkg/Nt32Pkg.dsc: Remove EdkCompatibilityPkg inform=
ation
   53 5bca07268aca Maintainers.txt: Remove EdkCompatibilityPkg informatio=
n
   54 c455bc8c8d78 EdkCompatibilityPkg: Remove EdkCompatibilityPkg
   55 e259ad9b6452 OvmfPkg: Drop the ISA Floppy device support
   56 a5cc178aeb1a OvmfPkg: Add an Super IO bus driver
   57 a06810229618 OvmfPkg: Add a build flag to select ISA driver stack
   58 f67786e38171 BaseTools/TianoCompress: Improve performance of bounda=
ry validation
   59 55756c88aec9 BaseTools/C/Common: Improve performance of boundary va=
lidation
   60 8028f0303218 MdePkg/BaseUefiDecompressLib: Improve performance of b=
oundary validation
   61 58742d79457e BaseTools:Trim will trig exception when input asl UTF8=
 format file
   62 1c27ec423635 BaseTools:Coding problems caused by special characters
   63 b02873340b2d Vlv2TbltDevicePkg: Remove PACKAGES_PATH
   64 a89fd3a359b8 MdeModulePkg/CapsuleRuntimeDxe: Add cache flush for IA=
32 and X64
   65 9338e2301785 MdeModulePkg/ResetSystemRuntimeDxe: Remove DoS3 in war=
m reset
   66 b87a9a76ebc3 MdePkg/DebugLib.h: Add new APIs for DebugLib
   67 b04bdd154add MdePkg/BaseDebugLibNull: Add new APIs for DebugLib
   68 f13202874c9c MdePkg/BaseDebugLibSerialPort: Add new APIs
   69 ec81dba51f0b MdePkg/UefidebugLibConOut: Add new APIs
   70 8055c3d5ee3f MdePkg/UefiDebugLibStdErr: Add new APIs
   71 b22b4f5aeed9 MdePkg/DxeRuntimeDebugLibSerialPort: Add new APIs
   72 27d86bc12b1d MdePkg/UefiDebuglibDebugPortProtocol: Add new APIs
   73 92c0bbd18b8b ArmPkg/SemiHostingDebugLib: Add new APIs
   74 2fe5f2f52918 OvmfPkg/PlatformDebugLibIoPort: Add new APIs
   75 446be24d0bd2 IntelFsp2Pkg/BaseFspDebugLibSerialPort: Add new APIs
   76 0bb4eff6a0bb IntelFspPkg/BaseFspDebugLibSerialPort: Add new APIs
   77 9fb1f7efc90a IntelFramworkModulePkg/PeiDxeDebugLibReportStatusCode:=
 Add new APIs
   78 bd68cddc6b5f MdeModulePkg/PeiDxeDebugLibReportStatusCode: Add new A=
PIs
   79 52e22c60eab7 MdeModulePkg: Add definitions for EDKII DEBUG PPI
   80 2bc82244638a MdeModulePkg: Add a PEIM to install Debug PPI
   81 66f50a4b0d49 MdeModulePkg/PeiDebugLibDebugPpi: Add PEI debug lib
   82 a8ac75b8eeb8 MdeModulePkg: Add PEIM and lib to dsc file
   83 475a4317c037 UefiCpuPkg/SmmCpuFeaturesLib: Remove .S files for IA32=
 and X64 arch
   84 b2d13be506fb UefiCpuPkg/BaseUefiCpuLib: Remove .S files for IA32 an=
d X64 arch
   85 df6c5f01e182 UefiCpuPkg/CpuExceptionHandlerLib:Remove.S files for I=
A32 and X64 arch
   86 4eea7627ef0d MdePkg/BaseCpuLib: Remove .S files for IA32 and X64 ar=
ch
   87 1ee58b7103f3 MdePkg/BaseLib: Remove .S files for IA32 and X64 arch
   88 f578386cc49d MdePkg/BaseMemoryLibMmx: Remove .S files for IA32 and =
X64 arch
   89 fbce3e064cdd MdePkg/BaseMemoryLibOptDxe: Remove .S files for IA32 a=
nd X64 arch
   90 ef008cd706b8 MdePkg/BaseMemoryLibOptPei: Remove .S files for IA32 a=
nd X64 arch
   91 42b7b15d2798 MdePkg/BaseMemoryLibRepStr: Remove .S files for IA32 a=
nd X64 arch
   92 94cf7d235a48 MdePkg/BaseMemoryLibSse2: Remove .S files for IA32 and=
 X64 arch
   93 fcc61ca4b122 CryptoPkg/IntrinsicLib: Remove .S files for IA32 arch
   94 c7d22535f7dc SourceLevelDebugPkg/DebugAgentCommon: Remove .S files
   95 fb5c9ed8439b SourceLevelDebugPkg/PeCoffExtraActionLibDebug: Remove =
.S files
   96 57b6844503e7 CorebootModulePkg/SecCore: Remove .S files for IA32 ar=
ch
   97 7ed72121b753 SourceLevelDebugPkg/DebugAgent: Remove AsmFuncs.S in I=
NF
   98 e4ff6349bf9e UefiCpuPkg/MpInitLib: Fix MemTest86 failure.
   99 37f9fea5b88d UefiCpuPkg\CpuSmm: Save & restore CR2 on-demand paging=
 in SMM
  100 79be3d27517c UefiCpuPkg/RegisterCpuFeaturesLib: Remove useless func=
tions.
  101 6214ffb41079 UefiCpuPkg/RegisterCpuFeaturesLib: Optimize PCD PcdCpu=
FeaturesUserConfiguration.
  102 001c2c80333f UefiCpuPkg/RegisterCpuFeaturesLib: Simplify PcdCpuFeat=
uresSupport.
  103 f664032e063b UefiCpuPkg/RegisterCpuFeaturesLib: Correct comments.
  104 516e33972f0a UefiCpuPkg/Cpuid.h: Remove duplicated struct definitio=
n for leaf 1FH
  105 079141ebe7f1 UefiCpuPkg/Cpuid: Dump leaf 1FH information correctly
  106 7f33d4f22836 UefiCpuPkg/LocalApicLib: Add GetProcessorLocation2ByAp=
icId() API
  107 f8113e25001e UefiCpuPkg/Cpuid.h: Update CPUID.7H.ECX structure for =
5-level paging
  108 f53de8aecb12 edk2: Add License-History.txt
  109 304bff7223a8 edk2: Change License.txt from 2-Clause BSD to BSD+Pate=
nt
  110 9ca2b9b9abef edk2: Replace BSD License with BSD+Patent License
  111 2e351cbe8e19 BaseTools: Replace BSD License with BSD+Patent License
  112 4059386c7080 ArmPkg: Replace BSD License with BSD+Patent License
  113 f4dfad05dda2 ArmPlatformPkg: Replace BSD License with BSD+Patent Li=
cense
  114 9792fb0e65ff ArmVirtPkg: Replace BSD License with BSD+Patent Licens=
e
  115 a1594be9c788 BeagleBoardPkg: Replace BSD License with BSD+Patent Li=
cense
  116 f3342b7a69bd CorebootModulePkg: Replace BSD License with BSD+Patent=
 License
  117 d2e8b7e1462f CorebootPayloadPkg: Replace BSD License with BSD+Paten=
t License
  118 2009f6b4c5cb CryptoPkg: Replace BSD License with BSD+Patent License
  119 9cd9bdc620b4 DynamicTablesPkg: Replace BSD License with BSD+Patent =
License
  120 878b807a435e EmbeddedPkg: Replace BSD License with BSD+Patent Licen=
se
  121 e3ba31da1cd1 EmulatorPkg: Replace BSD License with BSD+Patent Licen=
se
  122 eb6cb4ce755f FatPkg: Replace BSD License with BSD+Patent License
  123 bcef758cbac5 FmpDevicePkg: Replace BSD License with BSD+Patent Lice=
nse
  124 c0a00b143853 IntelFrameworkModulePkg: Replace BSD License with BSD+=
Patent License
  125 22a69a5efe1d IntelFrameworkPkg: Replace BSD License with BSD+Patent=
 License
  126 9672cd30563b IntelFsp2Pkg: Replace BSD License with BSD+Patent Lice=
nse
  127 512e23a3339d IntelFsp2WrapperPkg: Replace BSD License with BSD+Pate=
nt License
  128 16a16ea6e39a IntelFspPkg: Replace BSD License with BSD+Patent Licen=
se
  129 194863604898 IntelFspWrapperPkg: Replace BSD License with BSD+Paten=
t License
  130 8f7a05e13966 IntelSiliconPkg: Replace BSD License with BSD+Patent L=
icense
  131 9d510e61fcee MdeModulePkg: Replace BSD License with BSD+Patent Lice=
nse
  132 9344f0921518 MdePkg: Replace BSD License with BSD+Patent License
  133 ecf98fbcf858 NetworkPkg: Replace BSD License with BSD+Patent Licens=
e
  134 9d2eedba985b Nt32Pkg: Replace BSD License with BSD+Patent License
  135 538311f7d3f6 Omap35xxPkg: Replace BSD License with BSD+Patent Licen=
se
  136 96ae5934cfc3 OptionRomPkg: Replace BSD License with BSD+Patent Lice=
nse
  137 b26f0cf9ee09 OvmfPkg: Replace BSD License with BSD+Patent License
  138 e1d302e55472 PcAtChipsetPkg: Replace BSD License with BSD+Patent Li=
cense
  139 0eb3de2edc2a QuarkPlatformPkg: Replace BSD License with BSD+Patent =
License
  140 c9f231d08bdb QuarkSocPkg: Replace BSD License with BSD+Patent Licen=
se
  141 289b714b7700 SecurityPkg: Replace BSD License with BSD+Patent Licen=
se
  142 616bb7577171 ShellBinPkg: Replace BSD License with BSD+Patent Licen=
se
  143 56ba37463a5f ShellPkg: Replace BSD License with BSD+Patent License
  144 fbf06957b9fd SignedCapsulePkg: Replace BSD License with BSD+Patent =
License
  145 85f7e11021b3 SourceLevelDebugPkg: Replace BSD License with BSD+Pate=
nt License
  146 86094561f674 StandaloneMmPkg: Replace BSD License with BSD+Patent L=
icense
  147 0acd869796de UefiCpuPkg: Replace BSD License with BSD+Patent Licens=
e
  148 7ede80607b3f Vlv2DeviceRefCodePkg: Replace BSD License with BSD+Pat=
ent License
  149 9dc8036ddf6f Vlv2TbltDevicePkg: Replace BSD License with BSD+Patent=
 License
  150 bcb966958adc AppPkg: Replace BSD License with BSD+Patent License
  151 0a2530ea7f53 StdLib: Replace BSD License with BSD+Patent License
  152 be41238497e9 StdLibPrivateInternalFiles: Replace BSD License with B=
SD+Patent License
  153 75fae505b735 OvmfPkg: Change License.txt from 2-Clause BSD to BSD+P=
atent
  154 3806e1fd1397 edk2: Remove Contributions.txt and update Readme.md
  155 a281361014de BaseTools/PatchCheck: Generate error if Contributed-un=
der found
  156 ae2fb9ead47b CorebootPayloadPkg/FbGop: Locate correct framebuffer d=
evice
  157 b1e27d175abb BaseTools: Fixed issue in MultiThread Genfds function
  158 2914e8153dd3 BaseTools: Fix corner-cases of --hash feature
  159 1b8caf0d87ea BaseTools: Fix corner-cases of --hash feature
  160 f2b5e04acad2 BaseTools: Fix corner-cases of --hash feature
  161 db4d47fd3ae9 BaseTools: Fix corner-cases of --hash feature
  162 746c5b6238f1 ArmVirtPkg: Update UefiDecompressLib instance
  163 4ffc5aa1d14f BeagleBoardPkg: Update UefiDecompressLib instance
  164 0108a91c5526 EmulatorPkg: Update UefiDecompressLib instance
  165 58e8a1d8044f MdeModulePkg: Move BaseUefiTianoCustomDecompressLib to
  166 9c0f90ffe163 Nt32Pkg: Update to use UefiDecompressLib in MdeModuleP=
kg
  167 8c3677c33f59 Quark: Update to use UefiDecompressLib in MdeModulePkg
  168 f9f757fd098a Vlv2TbltDevicePkg: Update to use UefiDecompressLib in =
MdeModulePkg
  169 ddb8cedce7e0 IntelFrameworkModulePkg: Fix comments and improve E820=
 debug output
  170 9a86fd33e941 OvmfPkg: Copy 8259InterruptControllerDxe driver from P=
cAtChipsetPkg
  171 10fa47e53829 OvmfPkg: Copy Legacy8259 protocol definitions from Int=
elFrameworkPkg
  172 460ffed242af OvmfPkg/OvmfPkg.dec: Add 8259-related PCDs in OVMF DEC=
 file
  173 c01852433f37 OvmfPkg/8259InterruptControllerDxe: Update to make it =
build for OVMF
  174 682888a6d236 OvmfPkg/AcpiPlatformDxe: Consume the 8259 PCD defined =
in OvmfPkg
  175 1a3ffdff82e6 OvmfPkg: Copy 8254TimerDxe driver from PcAtChipsetPkg
  176 e3c787af8c04 OvmfPkg/8254TimerDxe: Update to make it build for OVMF
  177 6d70ade90cab OvmfPkg: Update DSC/FDF files to consume 8259/8254 dri=
vers in OvmfPkg
  178 e0fd9ece26c9 ShellPkg: Clarify the description of acpiview option '=
-s'
  179 cff96d43730c OvmfPkg/License.txt: remove XenPvBlkDxe from the MIT l=
icensed dir list
  180 07a0f27b0e00 OvmfPkg/License.txt: refresh the MIT license text and =
include the SPDX ID
  181 6f21d772aa6b OvmfPkg/IndustryStandard/Xen: replace MIT license text=
 with SPDX ID
  182 34131e1b5c09 OvmfPkg/XenBusDxe: replace MIT license text with SPDX =
ID
  183 174232fa9a90 MdePkg/BaseLib: Remove LongJump.c and SetJump.c
  184 f72f81777b39 MdeModulePkg: introduce PE/COFF image emulator protoco=
l
  185 57df17fe26cd MdeModulePkg/DxeCore: invoke the emulator protocol for=
 foreign images
  186 615a72400bca MdeModulePkg/PciBusDxe: dispatch option ROMs for forei=
gn architectures
  187 26d60374b87d MdeModulePkg/UefiBootManagerLib: allow foreign Driver#=
### images
  188 095fcfc606bd MdeModulePkg/EbcDxe: implement the PE/COFF emulator pr=
otocol
  189 431390dc1f7d MdePkg/UefiBaseType.h: treat EBC as a non-native machi=
ne type
  190 2e21e8c4b896 MdeModulePkg/DxeCore: remove explicit EBC handling
  191 87fcc6e8634e CorebootPayloadPkg: Remove the dependency of ShellBinP=
kg
  192 04af8bf262f1 UefiPayloadPkg: Enhance UEFI payload for coreboot and =
Slim Bootloader
  193 eb33b3994d06 EmulatorPkg/Unix: Rename GdbRun to GdbRun.sh
  194 68d47eea422d IntelFsp2WrapperPkg: Perform post FSP-S process.
  195 85b01932765d MdeModulePkg/CapsulePei: Change debug MACRO
  196 42d8be0eaac5 MdeModulePkg/CapsulePei: Update the debug code to prin=
t 64bit data
  197 05217d210e8d BaseTools:Enable the /MP option of MSVC compiler
  198 87bfb9bcb744 BaseTools:Coding problems cause can not encode FMP Aut=
h Header
  199 0eccea3fbe2f BaseTools: Hash false success with back to back builds
  200 cfb29d2bda57 BaseTools:update ConvertFceToStructurePcd.py with the =
char order PCD name.
  201 d43056888790 MdeModulePkg/UefiBootManagerLib: fix crash on uninitia=
lized ExitData
  202 2980988575c9 Vlv2TbltDevicePkg: Remove ResetSystem declaration
  203 07accfe398a2 Vlv2TbltDevicePkg: Retire 8254 timer and 8259 module
  204 e2a673b85336 CryptoPkg/BaseCryptLib.h: Add new API to get organizat=
ion name
  205 912e1e1ee27e CryptoPkg/BaseCryptLib: Add new API to get organizatio=
n name
  206 1796a39493b2 CryptoPkg/BaseCryptLib.h: Add new API VerifyEKUsInPkcs=
7Signature
  207 23c3178c4d45 CryptoPkg/BaseCryptLib: Add new API VerifyEKUsInPkcs7S=
ignature
  208 aed90beee510 CryptoPkg/BaseCryptLib.h: Add PKCS1v2 (RSAES-OAEP) sup=
port.
  209 933f1990f583 CryptoPkg/BaseCryptLib: Add PKCS1v2 (RSAES-OAEP) suppo=
rt.
  210 52d229238b2d OvmfPkg/QemuVideoDxe: avoid arithmetic on null pointer
  211 dc5bbf10741c OvmfPkg/AcpiPlatformDxe: suppress invalid "deref of un=
def pointer" warning
  212 e30991740d18 OvmfPkg/AcpiPlatformDxe: catch theoretical nullptr der=
ef in Xen code
  213 c2f643479eb3 OvmfPkg/BasePciCapLib: suppress invalid "nullptr deref=
" warning
  214 b29e6365c37f NetworkPkg/UefiPxeBcDxe:Add two PCD to control PXE.
  215 1dc1da58306f MdeModulePkg: Change the SMM debug lib instance
  216 c0b2816d69a2 SignedCapsulePkg: Change the SMM debug lib instance
  217 2b5778c68b63 MdePkg/UefiDebugLibDebugPortProtocol: Make it runtime =
safe
  218 452702d0bc51 MdePkg/UefidebugLibConOut: Make it runtime safe
  219 e72920ec617b MdePkg/UefiDebugLibStdErr: Make it runtime safe
  220 0b836855fb4d BaseTools: Sometime write file not immediate to disk
  221 452b5ad61ddd BaseTools: Enhance Bin Cache database to support save =
the cache
  222 35c2af00d8c3 BaseTools:fixed the incorrect autogen makefile which c=
ause build failure.
  223 56008eb7f68c BaseTools: Hash false success.. minor change in hash i=
nvalidation
  224 00e3e4801467 IntelFsp2WrapperPkg/FspsWrapperPeim: Fix coding style.
  225 40ffb6dc635d Change package maintainer and reviewer of CryptoPkg.
  226 2c0d39ac4704 MdeModulePkg/DxeCapsuleLibFmp: clone ESRT for runtime =
access
  227 ab7e02a4f86a MdeModulePkg/HiiDatabaseDxe: Release lock on all error=
 return path
  228 81a8a52a6bb2 ShellBinPkg: Remove ShellBinPkg
  229 e7ee4e0da153 MdePkg/BaseIoLibIntrinsic: Remove IoLibIcc.c
  230 5b7255e3d909 MdePkg/BaseLib: Remove support of INTEL tool chain
  231 36082dffd48d BaseTools: Remove ICC tool chain in tools_def.template
  232 04c7a5febd82 MdeModulePkg/AhciPei: Limit max transfer blocknum for =
48-bit address
  233 b2b8e872fd1b MdeModulePkg/AhciPei: Add PEI BlockIO support
  234 1a734ed85fda CryptoPkg: add issetugid declaration to fix openssl bu=
ild on FreeBSD
  235 d976f09d99b7 MdePkg/PiFirmwareFile: express IS_SECTION2 in terms of=
 SECTION_SIZE
  236 fc76bbd94df7 MdePkg/PiFirmwareFile: fix undefined behavior in SECTI=
ON_SIZE
  237 d3b3ee09a675 BaseTools/PiFirmwareFile: fix undefined behavior in SE=
CTION_SIZE
  238 1fd227dd2607 MdePkg/PiFirmwareFile: fix undefined behavior in FFS_F=
ILE_SIZE
  239 b9d4847ec258 OvmfPkg/Sec: fix out-of-bounds reads
  240 20029ca22baa EmbeddedPkg: Allow DXE_DRIVER to depend on NvVarStoreF=
ormattedLib
  241 dfaa565559ba MdeModulePkg/DxeCore: Please static checker for false =
report
  242 c9b3fe1586eb BaseTools: Support customized compiling command
  243 00d2aef80c9a MdeModulePkg/BMMUiLib: Set Handle to NULL after uninst=
all protocol
  244 5a4f3a3453e7 MdeModulePkg/FileExplorer: Set Handle to NULL after un=
install protocol
  245 60a86abf95aa MdeModulePkg/HiiDB: Minimize memory allocation times a=
fter ReadyToBoot
  246 ec4e1af5b94f BaseTools/tools_def.template: Remove tools chain with =
ASL tool
  247 228a9c2999bd MdePkg/UefiSpec.h: Change comments of EFI_RESET_SYSTEM
  248 efaed0ab678a MdePkg/PiPeiCis.h: Change comments of EFI_PEI_RESET2_S=
YSTEM
  249 1abe0959f0ea MdePkg/PeiServicesLib.h: Change comments of PeiService=
sResetSystem2
  250 d821151e814f MdePkg/PeiServicesLib.c: Change comments of PeiService=
sResetSystem2
  251 930fcd9f3acf SecurityPkg/Tcg2Dxe: Change comments of ShutdownTpmOnR=
eset
  252 173cd4723444 MdeModulePkg/ResetSystemLib.h: Change comments of Rese=
tSystem
  253 2662528d9695 MdeModulePkg/DxeResetSystemLib.c: Change comments of R=
esetSystem
  254 1cff74bb0f2e MdeModulePkg/BaseResetSystemLibNull.c: Change comments=
 of ResetSystem
  255 32f555385fc8 MdeModulePkg/RuntimeResetSystemLib.c: Change comments
  256 99d7570a7a7f MdeModulePkg/PeiResetSystemlib.c: Change comments of R=
esetSystem
  257 f69cb1082831 MdeModulePkg/ResetSystemRuntimeDxe: Change comments
  258 3bb9b1fad3c6 MdeModulePkg/ResetSystemPei: Change comments of ResetS=
ystem2
  259 eac49c837b32 MdeModulePkg/PeiMain: Change comments of PeiResetSyste=
m2
  260 c676cf740256 MdeModulePkg/NvmExpressHci.c: Change comments
  261 7701cd048712 BeagleBoardPkg/ResetSystemLib: Add new API ResetSystem
  262 446bb6516e94 CorebootPayloadPkg/ResetSystemLib: Add new API ResetSy=
stem
  263 96ed5b28f9ab Nt32Pkg/ResetSystemLib: Add new API ResetSystem
  264 84c0b80de716 OvmfPkg/ResetSystemLib: Add new API ResetSystem
  265 b700a8271912 PcAtChipsetPkg/ResetSystemLib: Add new API ResetSystem
  266 c35bbeebbed2 QuarkSocPkg/ResetSystemLib: Add new API ResetSystem
  267 b5fddfaf477a Vlv2TbltdevicePkg/ResetSystemLib: Add new API ResetSys=
tem
  268 bda4d5be7c97 ArmPkg/ArmSmcPsciResetSystemLib: Add a new API ResetSy=
stem
  269 d943e5ad3b2b ArmVirtPkg/ArmVirtPsciResetSystemLib: Add a new API Re=
setSystem
  270 06aaf2f82cd1 MdeModulePkg/ResetUtilityLib: Add a new API ResetSyste=
mWithSubtype
  271 0851d7a53a1d MdeModulePkg/ResetUtilityLib: Add a new API ResetSyste=
mWithSubtype
  272 a8a8b408b7de OvmfPkg/PlatformBootManagerLib: Remove dependency on M=
ps.h
  273 f4c874c45dbc ShellPkg/UefiShellDebug1CommandsLib
  274 5a1ca93a1fa1 ShellPkg/UefiHandleParsingLib: Remove some unused Guid=
s
  275 4e1daa60f537 MdePkg: Removed IPF related code
  276 c17e4a2f5371 MdePkg/UefiDebugLibConOut: make global variable static
  277 7eef381378b7 MdePkg/UefiDebugLibDebugPortProtocol: make global vari=
able static
  278 ffe48f4b6c65 MdePkg/UefiDebugLibStdErr: make global variable static
  279 ea305ce3f8b5 IntelFrameworkModulePkg: make global variable static
  280 2410ac023016 MdeModulePkg/FirmwarePerformanceDxe: make global varia=
ble static
  281 9ed8c3a8068a IntelFsp2WrapperPkg/FspWrapperNotifyDxe: make global v=
ariable static
  282 4e4b23040786 IntelFrameworkModulePkg: make global variable static
  283 af51cb48a22d MdeModulePkg/StatusCodeHandlerRuntimeDxe: make global =
variable static
  284 d55d9d066436 NetworkPkg: Remove IpSec driver and application
  285 679906d9bd41 NetworkPkg: Add missing string token in NetworkPkg.uni
  286 8a472b1915fb MdeModulePkg: BaseSerialPortLib16550: Add Mmio32 suppo=
rt
  287 038f929c921c CryptoPkg/BaseCryptLib: Remove the blank line in the c=
omments
  288 e2d3a25f1a31 EmbeddedPkg: Extend NvVarStoreFormattedLib LIBRARY_CLA=
SS
  289 964f432b9b0a edk2: Remove AppPkg, StdLib, StdLibPrivateInternalFile=
s
  290 5c5d8d0b2086 edk2: Update ReadMe.md and Maintainer.txt for edk2-lib=
c repo
  291 137cbff041fc QuarkPlatformPkg/AcpiTables: Resolve iASL warnings
  292 b11636239f84 OvmfPkg: introduce EnrollDefaultKeys application
  293 3defea06b2b7 OvmfPkg/EnrollDefaultKeys: update @file comment blocks
  294 05d7f3c3fce5 OvmfPkg/EnrollDefaultKeys: refresh INF file
  295 034dec6ca19d ArmVirtPkg: build EnrollDefaultKeys.efi
  296 85d96998a470 OvmfPkg/EnrollDefaultKeys: clean up minor whitespace w=
art
  297 32d1440aaddd OvmfPkg/EnrollDefaultKeys: clean up global variable na=
me prefixes
  298 e0d612356e84 OvmfPkg/EnrollDefaultKeys: clean up acronym capitaliza=
tion in identifiers
  299 a2491a6c82e4 OvmfPkg/EnrollDefaultKeys: remove unneeded EFIAPI call=
. conv. specifiers
  300 1c9418fcafe3 OvmfPkg/EnrollDefaultKeys: extract typedefs to a heade=
r file
  301 a79b115adeab OvmfPkg/EnrollDefaultKeys: split out certificate and s=
ignature constants
  302 7eeaa7585a98 OvmfPkg/EnrollDefaultKeys: extract MICROSOFT_VENDOR_GU=
ID
  303 86bf2672a35a OvmfPkg/EnrollDefaultKeys: describe functions with lea=
ding comment blocks
  304 c9727ff1df0d OvmfPkg/EnrollDefaultKeys: document the steps of the e=
ntry point function
  305 392404167fb1 OvmfPkg: introduce OVMF_PK_KEK1_APP_PREFIX_GUID
  306 be9470b3c91f OvmfPkg/EnrollDefaultKeys: enroll PK/KEK1 from the Typ=
e 11 SMBIOS table
  307 9fb2ce2f465d OvmfPkg/EnrollDefaultKeys: remove Red Hat's hard-coded=
 PK/KEK1
  308 27e4d6ae25a0 OvmfPkg/XenSupport: remove usage of prefetchable PCI h=
ost bridge aperture
  309 d63610df60f7 OvmfPkg/XenSupport: use a correct PCI host bridge aper=
ture for BAR64
  310 0c40c9c925ca OvmfPkg/XenSupport: turn off address decoding before B=
AR sizing
  311 a41b12574ee1 MdePkg: Add PcdSpeculationBarrierType
  312 aec74656893a MdePkg/BaseLib: Use PcdSpeculationBarrierType
  313 24f4547c5c12 QuarkPlatformPkg: Set PcdSpeculationBarrierType to CPU=
ID
  314 6dd88437b1d9 UefiCpuPkg/MpInitLibUp: Add uniprocessor MpInitLib
  315 ba1362d882e9 UefiCpuPkg/CpuMpPei: Add missing CpuLib class
  316 c793d24b0103 QuarkPlatformPkg: Use uniprocessor MpInitLibUp
  317 0edaa8c16204 QuarkSocPkg/SmmAccessDxe: Set region to UC on SMRAM cl=
ose
  318 80d28ddeb2ce QuarkPlatformPkg/PlatformInit: Resolve ResetSystemLib =
name collision
  319 0d6de095a5ae BaseTools: split long line into multiple short lines.
  320 c4c8c340ef01 BaseTools: Add GCC flags to Basetool build.
  321 273190e18975 BaseTools:Fixed an issue where the order of GuidS chan=
ged in guid.xref
  322 727d7ebaa9f3 OvmfPkg/EnrollDefaultKeys: suppress incorrect compiler=
 warning
  323 d02741225887 Vlv2TbltDevicePkg: Remove NetworkPkg/IpSecDxe module
  324 fbb0ec7ea4c0 BaseTools: support arm64 as a platform name in additio=
n to aarch64
  325 f5245a1db144 SecurityPkg/OpalPassword: Add warning message for Secu=
re Erase
  326 8b4b2fb9a183 BaseTools:corrected error message for the DatumType er=
ror
  327 0cb3f77153b7 BaseTools:ECC report errors on account of analyze spec=
ial characters
  328 26e2b295ec7a BaseTools:Remove unused BaseTools\Source\Python\UPT\Dl=
l
  329 df7c81b5b219 BaseTools:The code used to test python module is moved=
 to edksetup
  330 a642e2b42ed5 MdeModulePkg/DumpDynPcd: Add application to dump dynam=
ic PCD settings
  331 da815cf390cc NetworkPkg DSC: Add the required ARM library to pass A=
RM build
  332 1e948802e755 NetworkPkg: Add DSC/FDF include segment files to Netwo=
rkPkg.
  333 23ea5bfea2a2 NetworkPkg: Add package level include DSC file
  334 792f0d4f12ad EmulatorPkg: Support a second GOP window
  335 1b72fd5121b5 BaseTools/VfrCompile: Remove framework VFR support
  336 8dc1f4ec0f54 FatPkg/FatPei: Remove PcdFrameworkCompatibilitySupport=
 usage
  337 9feffce9c6b5 IntelFrameworkModulePkg: Remove PcdFrameworkCompatibil=
itySupport usage
  338 728c7ffac317 MdeModulePkg/Core: Remove PcdFrameworkCompatibilitySup=
port usage
  339 2e217e402215 MdeModulePkg/CdExpress: Remove PcdFrameworkCompatibili=
tySupport usage
  340 059cf575eb6c MdeModulePkg/Setup: Remove PcdFrameworkCompatibilitySu=
pport usage
  341 1df91bb772a1 QuarkPlatformPkg: Remove PcdFrameworkCompatibilitySupp=
ort usage
  342 868f139b086a SignedCapsulePkg: Remove PcdFrameworkCompatibilitySupp=
ort usage
  343 3e2ec1891f98 UefiCpuPkg: Remove PcdFrameworkCompatibilitySupport us=
age
  344 2c835dee82a4 Vlv2TbltDevicePkg: Remove PcdFrameworkCompatibilitySup=
port usage
  345 4acc5750f055 MdeModulePkg: Remove PcdFrameworkCompatibilitySupport
  346 e0972cfc7df1 SecurityPkg/SecurityPkg.dec: Change BlockSID default p=
olicy
  347 539a6c931884 SecurityPkg/OpalPassword: Change send BlockSID policy
  348 46e696088a0a SecurityPkg/OpalPassword: Fix "Enable Feature" Menu di=
sappear issue
  349 7d83e9e84793 BaseTools:Delete FrameworkDatabase from BaseTools/Conf
  350 c648e9058717 BaseTools: Fix the issue that build report missing Mod=
ule Size
  351 51e9be0cc3d1 Vlv2TbltDevicePkg:Delete FrameworkDatabase from Vlv2Tb=
ltDevicePkg
  352 49693202ec9c Revert "BaseTools:code of test python module is moved =
to edksetup"
  353 20af3a7a3ec4 FatPkg/FatPei: Remove BootInRecoveryMode PPI DEPEX.
  354 0a506fc7ab8b MdeModulePkg: Remove BootInRecoveryMode PPI
  355 30a888b5a0a0 IntelSiliconPkg/IntelVTdDxe: Do global invalidation be=
fore boot
  356 8522ce2c9f88 Maintainers.txt: Update the name of 'Hao Wu' to 'Hao A=
 Wu'
  357 ad9df9377028 EmulatorPkg: Change the cpu frequency to a non-zero va=
lue
  358 0e92957eaa50 EmulatorPkg: Make the shell be the first boot option
  359 68cafc7bf057 EmulatorPkg: Save the modified order after rebooting
  360 21d5bf86b223 EmulatorPkg: Remove framework pkgs dependency from Emu=
latorPkg
  361 3eac7496bef1 Vlv2TbltDevicePkg/PlatformFlashAccessLib: Add error re=
turn
  362 f635a42e14f4 Vlv2TbltDevicePkg/AcpiPlatform: Change Size type to UI=
NTN
  363 24990e84d323 Vlv2TbltDevicePkg/AcpiPlatform: Add variable protocols=
 to depex
  364 e5a0cf912531 Vlv2TbltDevicePkg/PpmPolicy: Fix call to MP Services P=
rotocol
  365 f4aa56e7cc38 Vlv2TbltDevicePkg/SmBiosMiscDxe: Fix GCC build issue
  366 927926f45485 Vlv2TbltDevicePkg: Find UEFI Shell using gUefiShellFil=
eGuid
  367 5cf0cb1582af Vlv2TbltDevicePkg: Build full UEFI Shell from sources
  368 86be1a2eaa8a Vlv2TbltDevicePkg: Use CpuDxe from UefiCpuPkg
  369 76386f4292c3 Vlv2TbltDevicePkg: Add PchInitSmm module
  370 a4390a28b8ac Vlv2TbltDevicePkg: Always enable QuietBoot to produce =
BGRT
  371 ef81f9f12af4 Vlv2TbltDevicePkg/Stitch/Gcc: Update default setting b=
inary
  372 9d87197edadc Vlv2TbltDevicePkg: Remove directory assumptions from b=
uild scripts
  373 447597f123c0 Vlv2TbltDevicePkg/Capsule: Do not clear UEFI varstore
  374 f2197f0d0c3d Vlv2TbltDevicePkg/Capsule: Remove path to openssl tool=
s
  375 1bb262ea0440 Vlv2TbltDevicePkg/Capsule: Add Linux/LVFS generation s=
cripts
  376 62fdb9bbc505 Vlv2TbltDevicePkg: Update Readme.md
  377 cd5147734cbe OvmfPkg/QemuVideoDxe: Remove dependency on OptionRomPk=
g
  378 70023bab7efe MdeModulePkg: BaseSerialPortLib16550: Add missing Pcd =
to UNI
  379 afe8c4110c07 BaseTools: Correct the value assignment for StructureP=
cd
  380 6b74ccf0f8b5 BaseTools:Enables FFS to support the GUID value format
  381 ae3c247dbc94 BaseTools: Check the fread function and avoid dead loo=
p
  382 f684c3f5eef4 Coreboot*Pkg: Retire CorebootPayloadPkg and CorebootMo=
dulePkg
  383 e2aaec4b080c UefiCpuPkg: Remove double \r
  384 4ff689d98277 BaseTools/VfrCompile: clean Framework Vfr support
  385 c4521157bf57 ArmPkg/CompilerIntrinsicsLib: Remove unused sources an=
d clean up .inf
  386 482704df27cc ArmPkg/CompilerIntrinsicsLib: Add memcmp, memmove intr=
insics for MSFT
  387 d039044be43d ArmPkg/CompilerIntrinsicsLib: Add lasr ARM assembly so=
urce for GCC
  388 96ef5a8e30a8 ArmPkg/CompilerIntrinsicsLib: Add uread, uwrite GCC as=
sembly sources
  389 5347c48016f2 edk2: Remove packages moved to edk2-platforms
  390 83f997e58dca edk2: Update Maintainers.txt for packages moved to edk=
2-platforms
  391 cf574f0a1838 UefiCpuPkg PiSmmCpuDxeSmm: Only support IN/OUT IO save=
 state read (CVE-2018-12182)
  392 4000f249ba5c SecurityPkg: Remove double \r
  393 e90ea9470a88 SecurityPkg/AuthSeriableLib: Always delete variable in=
 certdb
  394 f0b8166505d2 EmbeddedPkg DSC: Use ReportStatusCodeLib (DXE) in MdeM=
odulePkg
  395 32f345eba719 EmbeddedPkg/PrePiLib: Drop dependency on IntelFramewor=
k[Module]Pkg
  396 a11d371ef660 OvmfPkg: Remove duplicated library classes in dxe driv=
ers section in DSC
  397 a40f30398ab0 MdePkg: Add ACPI 6.3 header file
  398 3f0055c8de8a MdePkg: Merge TianoCustomDecompress algorithm into
  399 805313dbac3a Nt32Pkg: Update UefiDecompressLib instance path
  400 bf502ae44919 MdeModulePkg/Library: Remove BaseUefiTianoCustomDecomp=
ressLib
  401 89d7c543cf71 OvmfPkg/EnrollDefaultKeys: import the non-default key =
into db
  402 631195044ff0 OvmfPkg: Update DSC/FDF to use NetworkPkg's include fr=
agment file.
  403 bc01f4971d63 Nt32Pkg: Update DSC/FDF to use NetworkPkg's include fr=
agment file.
  404 157a3b1aa50f ArmVirtPkg: Update DSC/FDF to use NetworkPkg's include=
 fragment file.
  405 3b7a897cd8e3 EmulatorPkg: Update DSC/FDF to use NetworkPkg's includ=
e fragment file.
  406 60e95bf5094f OvmfPkg/PlatformPei: assign PciSize on both i440fx/q35=
 branches explicitly
  407 9a2e8d7c65ef OvmfPkg/PlatformPei: hoist PciBase assignment above th=
e i440fx/q35 branching
  408 75136b29541b OvmfPkg/PlatformPei: reorder the 32-bit PCI window vs.=
 the PCIEXBAR on q35
  409 39b9a5ffe661 OvmfPkg/PlatformPei: fix MTRR for low-RAM sizes that h=
ave many bits clear
  410 4d5d7812786d UefiCpuPkg: Remove double \r
  411 7afa0cea8f2c Nt32Pkg: Remove it
  412 147e6e70f2be Maintainers.txt: Remove Nt32Pkg reference after Nt32Pk=
g is removed
  413 c2eab535c679 CryptoPkg/BaseCryptLib: remove unused code for IPF
  414 fb5573b83007 Maintainers.txt: Add 'Zhichao Gao' for ShellPkg review
  415 8da8daafc905 ShellPkg: acpiview: Add GT Frame Number validation to =
GTDT parser
  416 1887b995a359 ShellPkg/UefiShellAcpiViewCommandLib: Fix PPTT cache a=
ttributes validation
  417 41ac2076a7c6 UefiCpuPkg CpuCommonFeaturesLib: Remove CPU generation=
 check
  418 59f20e8d7100 ShellPkg: Update DSC to use NetworkPkg's include fragm=
ent file
  419 48f43c2c56ee EmbeddedPkg: Update DSC to use NetworkPkg's include fr=
agment file
  420 7b84de939489 ShellPkg: Display VENDOR_ID in ASCII when parsing PPTT
  421 911efe279ec3 ShellPkg: Add NetworkPkg/NetworkPkg.dec as the package=
 dependency
  422 110d4729b58e EmulatorPkg: Add NetworkPkg/NetworkPkg.dec as the pack=
age dependency
  423 cc99ea9422be Maintainers.txt: remove UTF-8 BOM wrongly added in com=
mit 147e6e70
  424 66b845ae06f1 BaseTools: Fix private includes for FILE_GUID override
  425 a7ef158b0752 BaseTools: Library hashing fix and optimization for --=
hash feature
  426 c1387446edbb BaseTools:Update mailing list address in BaseTools err=
or messages
  427 9ca1f1446a5a BaseTools: Remove './SecMain' from 'run' target
  428 3604174718e2 IntelFrameworkModulePkg/DebugLib: Fix string copy issu=
e
  429 4718129bf94e BaseTools: Update Conf/target.template with the defaul=
t EmulatorPkg.dsc
  430 01e074bfbcf0 MdeModulePkg: Update MdeModulePkg.dsc to remove Networ=
k related modules
  431 e812a812c1a0 BaseTools: Remove './SecMain' from 'run' target
  432 c0fd7f734e2d BaseTools:Change the path of the file that Binary Cach=
e
  433 4542f8b8135f NetworkPkg: Move Network library and drivers from MdeM=
odulePkg to NetworkPkg
  434 07135c122058 NetworkPkg: Move Network library header file from MdeM=
odulePkg to NetworkPkg
  435 ec56fa278428 MdeModulePkg: Remove network library header file from =
package DEC file
  436 005a5f2dea5c UefiPayloadPkg: Update Package DSC files to refer to N=
etworkLibs.dsc.inc
  437 da82eb1c93b4 ArmPkg: Update Package DSC to remove unused NetLib
  438 21d9dc21f818 SignedCapsulePkg: Update Package DSC to remove unused =
network libs
  439 5a9e23ceb991 Maintainers.txt: update mailing list information
  440 4abfc66db088 Maintainers.txt: update UEFI payload information
  441 591b8cb7f3d0 IntelFsp2Pkg/SplitFspBin.py: Support rebasing 1.x bina=
ry.
  442 9d73c5608d22 IntelFsp2Pkg/SplitFspBin.py: Revert FSP 1.x support.
  443 e2afc8ab59c3 MdeModulePkg/AhciPei: Fix device cannot be found in no=
n-S3 path
  444 3a0b998bf3b5 BaseTools:Extend the binary cache to support library c=
ache
  445 b6cfa686e42d BaseTools:Update binary cache restore time to current =
time
  446 85af0b8116f3 ArmPkg: import Berkeley Softfloat library as git submo=
dule
  447 3cc57695df5a ArmPkg/ArmSoftFloatLib: switch to new version of softf=
loat library
  448 99243102b467 ArmPkg/ArmSoftFloatLib: remove source files that are n=
o longer used
  449 8594c2073cdb ArmPkg/ArmLib ARM: set .fpu to let Clang 7 assemble Ar=
mV7Support.S
  450 371e7001e8d5 ArmPkg/ArmSoftFloatLib GCC4x: fix build failure
  451 6fcc3d68eb02 CryptoPkg/OpensslLib: Modify process_files.pl for upgr=
ading OpenSSL
  452 7eee0488944f CryptoPkg/OpensslLib: Exclude unnecessary files in pro=
cess_files.pl
  453 96dbfad9b00b CryptoPkg/IntrinsicLib: Fix possible unresolved extern=
al symbol issue
  454 5db2fbff23ae CryptoPkg/OpensslLib: Prepare for upgrading OpenSSL
  455 9c3c5c91ce6d CryptoPkg/OpensslLib: Fix cross-build problem for AARC=
H64
  456 c51f8bae7cab CryptoPkg: Fix possible build problem with Clang
  457 b73967891824 CryptoPkg/OpensslLib: Add functions for upgrading Open=
SSL1_1_1b
  458 456dd8b99f00 CryptoPkg: Upgrade OpenSSL to 1.1.1b
  459 acfb90911840 CryptoPkg/BaseCryptLib: Make HMAC_CTX size backward co=
mpatible
  460 f03859ea6c8f CryptoPkg CLANG35: add -std=3Dc99 to dodge OpenSSL C a=
tomics issue
  461 305cd4f783fe Revert "OvmfPkg/PlatformPei: fix MTRR for low-RAM size=
s that have many bits clear"
  462 eb4d62b0779c Revert "OvmfPkg/PlatformPei: reorder the 32-bit PCI wi=
ndow vs. the PCIEXBAR on q35"
  463 753d3d6f43b2 Revert "OvmfPkg/PlatformPei: hoist PciBase assignment =
above the i440fx/q35 branching"
  464 d45349841113 Revert "OvmfPkg/PlatformPei: assign PciSize on both i4=
40fx/q35 branches explicitly"
  465 b07de0974b65 OvmfPkg: raise the PCIEXBAR base to 2816 MB on Q35
  466 49edde15230a OvmfPkg/PlatformPei: set 32-bit UC area at PciBase / P=
ciExBarBase (pc/q35)
  467 466c66341a99 CryptoPkg: Fix build problem with XCODE
  468 4ff8b6b1d8b7 FmpDevicePkg: Add TimerLib to DSC file
  469 7cea4d71a8a8 EmulatorPkg: don't display the cpu current speed
  470 a1539c46958f UefiPayloadPkg: Remove legacy PIC 8259 driver
  471 be689ecc93e5 Revert "EmulatorPkg: don't display the cpu current spe=
ed"
  472 cbfdc1b2df65 Maintainers.txt: Remove Network maintainers for MdeMod=
ulePkg/Universal/Network
  473 0a1b13fd4d22 CryptoPkg/OpensslLib: fix VS2017 build failure
  474 b8993a34ae00 edk2: Update additional licenses in Readme.md
  475 98d8f194e5a6 CryptoPkg/IntrinsicLib: Fix CLANG38 IA32 build problem
  476 b66c4c4ff918 Revert "UefiPayloadPkg: Remove legacy PIC 8259 driver"
  477 20d2e5a125e3 CryptoPkg/OpensslLib: fix build break caused by missin=
g library

Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Ref: https://bugs.launchpad.net/qemu/+bug/1831477
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 roms/edk2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/edk2 b/roms/edk2
index 89910a39dcfd..20d2e5a125e3 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit 89910a39dcfd788057caa5d88b7e76e112d187b5
+Subproject commit 20d2e5a125e34fc8501026613a71549b2a1a3e54
--=20
2.19.1.3.g30247aa5d201



