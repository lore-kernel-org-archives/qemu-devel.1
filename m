Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	DRUGS_ERECTILE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MORE_SEX,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEA4C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D3B2086A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 10:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A32hhi7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D3B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iadsC-0004Fk-CM
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 05:51:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iadmI-00015c-RJ
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:45:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iadm8-00048V-1F
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:45:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iadm7-0003v4-Pn
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 05:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575024320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8RarnBY5Eb/LffxFC1I5rMsw6O0jQDcX3jFrklXV6A=;
 b=A32hhi7Z/GV9v9YbVOSfPzVF0CfRCBjiSTdT7y7sUouKTo5xW43mizGKm/GA840XmwOzBt
 BXeUgBuT6+KKe5MSzH8iXS8m8ZgJM1fBjboLOBE6f7FzcJ72jmG7o63K9dgiVPzeM2Dblm
 r79DnwOQbHJtAgf217Y4nt1X+Yqy0fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-v8B6loFWO6iBLIQ2Qp7Vcg-1; Fri, 29 Nov 2019 05:45:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B789184CAA2;
 Fri, 29 Nov 2019 10:45:17 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-255.brq.redhat.com [10.40.204.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 42FF85D9E2;
 Fri, 29 Nov 2019 10:45:10 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-4.2? 1/1] roms/edk2: update submodule from
 edk2-stable201905 to edk2-stable201911
Date: Fri, 29 Nov 2019 11:44:57 +0100
Message-Id: <20191129104457.1991-2-philmd@redhat.com>
In-Reply-To: <20191129104457.1991-1-philmd@redhat.com>
References: <20191129104457.1991-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: v8B6loFWO6iBLIQ2Qp7Vcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Prasad J Pandit <pjp@fedoraproject.org>, Laszlo Ersek <lersek@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org,
 Bruce Rogers <brogers@suse.com>, Cole Robinson <crobinso@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the edk2 submodule from release edk2-stable201905 to
edk2-stable201911.

In this release, the EDK2 project its OpenSSL submodule from 1.1.1b
to 1.1.1d to fix the following CVEs (marked as 'low severity'):

- https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2019-1543
- https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2019-1552
- https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2019-1563

Below is a list of commits in the new release:

    1 bd85bf54c2 MdeModulePkg/Variable: Initialize local variable "RtPtrTra=
ck"
    2 bbb5b0d648 MdeModulePkg/Variable: Initialize local variable "Variable=
"
    3 290a485d60 StandaloneMmPkg: Fix build failure - Bug 2253
    4 e0f8261ad0 BaseTools:fix regression issue for platform .map file
    5 54a07f8fe0 MdePkg: Update the comments of IsLanguageSupported
    6 bf1ea933ec BaseTools:Add a c section in dsc file
    7 7607174192 MdeModulePkg/NvmExpressDxe: Fix wrong queue size for async=
 IO queues
    8 0b9ad0bc03 EmulatorPkg DSC and WinHost.inf: Update tool chain name to=
 CLANGPDB
    9 0769224ac7 OvmfPkg DSC: Update tool chain name to CLANGPDB
   10 8ecd8c49e4 CryptoPkg CryptoLib: Update tool chain name to CLANGPDB
   11 6321ec4eaf MdeModulePkg RegularExpressionDxe: Update tool chain name =
to CLANGPDB
   12 14672c34bd BaseTools: Rename tool chain CLANG9 to CLANGPDB
   13 9639c1f3e7 MdeModulePkg: Unify the definitions of size_t
   14 6fe77f347e MdeModulePkg/Variable: Fix volatile variable RT cache upda=
te logic
   15 da178f5c5c ShellPkg/SmbiosView: SMBIOS 3.3.0 Update "Intel persistent=
 memory"
   16 77ad48a263 ShellPkg/SmbiosView: SMBIOS 3.3.0 Add value HBM and Die fo=
r type 17
   17 16efcbbd3c ShellPkg/SmbiosView: SMBIOS 3.3.0 add support for CXL Flex=
bus
   18 2a9ff5f33f ShellPkg/SmbiosView: SMBIOS 3.3.0 add PCI gen4 values for =
type 9
   19 4b7edd78a0 MdePkg/SmBios.h: SMBIOS 3.3.0 Update Intel Persistent Memo=
ry string
   20 8019eb589a MdePkg/SmBios.h: SMBIOS 3.3.0 Add value HBM and Die for ty=
pe 17
   21 9e50ef63e8 MdePkg/SmBios.h: SMBIOS 3.3.0 add support for CXL Flexbus
   22 70c50f1920 MdePkg/SmBios.h: SMBIOS 3.3.0 add PCI gen4 values for type=
 9
   23 c9af866cdd MdePkg: add null version of RngLib
   24 c801f33d81 UefiCpuPkg/RegisterCpuFeature: Remove CPU_FEATURE_XD macro
   25 6d17c9c24a UefiCpuPkg/CpuCommonFeaturesLib: Remove XD enable/disable =
logic
   26 49fb9f7e06 BaseTools: Fix build failure when using python38
   27 d847ac1f27 BaseTools: Enable MACRO for DSC Components section tag
   28 bfcf262488 EmulatorPkg/PlatformSmbiosDxe: fix a spell error of platfo=
rm.
   29 e92b155740 Readme.md: Update EDK II CI build branch name
   30 3b0631e57e Readme.md: Update EDK II CI build status badge and links
   31 f8dd7c7018 Readme.md: Add CI build status badges
   32 4baa783d5e .mergify: Add Mergify YML pull request rules configuration=
 file
   33 106c7a991c .azurepipelines: Add Azure Pipelines YML configuration fil=
es
   34 4eb2baba93 .pytool: Add CISettings.py and Readme.md
   35 3137900fc9 SignedCapsulePkg: Use BaseCryptLibNull to reduce package C=
I time
   36 30c00d7f19 UefiCpuPkg: Add YAML file for CI builds
   37 e3b8a0081b ShellPkg: Add YAML file for CI builds
   38 566c45a533 SecurityPkg: Add YAML files for CI builds
   39 d495762a97 PcAtChipsetPkg: Add YAML files for CI builds
   40 420c859831 NetworkPkg: Add YAML file for CI builds
   41 3059a38d5f MdePkg: Add YAML file for CI builds
   42 e4612477b9 MdeModulePkg: Add YAML file for CI builds
   43 8bc648fe6c FmpDevicePkg: Add YAML file for CI builds
   44 6d807aef57 FatPkg: Add YAML file for CI builds
   45 f98a44541f CryptoPkg: Add YAML file for CI builds
   46 9da7846c88 .pytool/Plugin: Add CI plugins
   47 de4ce46d6e BaseTools: Add BaseTools plugins to support CI
   48 f7978bb258 BaseTools: Add YAML files with path env and tool extdeps
   49 7569e35bc9 BaseTools: Add RC_PATH define for VS2017/2019
   50 ab5892f260 pip-requirements.txt: Add python pip requirements file
   51 48760409cc .gitignore: Ignore python compiled files, extdeps, and vsc=
ode
   52 021eb1820e Maintainers.txt: Add continuous integration(CI) directorie=
s
   53 cc6854506c Readme.md: remove positional references from submodule des=
cription
   54 995d8b8568 MdeModulePkg/Pci: Add DeviceSecurity support.
   55 985e0a6de7 MdeModulePkg/dec: Add EdkiiDeviceSecurityProtocolGuid.
   56 aa4db5b15e MdeModulePkg/Include: Add DeviceSecurity.h
   57 05ca7ec3cf MdePkg/Include: Add DMTF SPDM definition.
   58 fb92fe9e18 MdeModulePkg/Core/Dxe: free page 0 after disabling NULL po=
inter detection
   59 f9d0e5daa0 MdeModulePkg/DxeIplPeim: reserve page 0 for NULL pointer d=
etection
   60 f55c76b301 BaseTools/GenFw AARCH64: disregard ADRP instructions that =
are patched already
   61 9e9f0be353 ShellPkg/CommandLib: Use first found UC for unsupported Pl=
atformLang
   62 0cecb1f99e BaseTools: Add support for parseing map files generated by=
 CLANG9 in GenFv
   63 5cef92771f BaseTools: Add map file parsing support for CLANG9
   64 601a18bf08 EmbeddedPkg/DtPlatformDxe: Add DT/ACPI Default Flexibility
   65 3a63c17ebc SecurityPkg: Fix TPM2 ACPI measurement.
   66 1a04951309 SecurityPkg/OpalPassword: Remove dependency on EFI_BLOCK_I=
O_PROTOCOL
   67 78413dd4bc Maintainers.txt: Adding new NetworkPkg reviewer.
   68 e07b7d024a MdeModulePkg: Enable variable runtime cache by default
   69 d511d6e0e7 OvmfPkg: Disable variable runtime cache
   70 6f9838f32f MdeModulePkg/Variable: Add RT GetNextVariableName() cache =
support
   71 aab3b9b9a1 MdeModulePkg/Variable: Add RT GetVariable() cache support
   72 1747ab6c1c MdeModulePkg VariableInfo: Always consider RT DXE and SMM =
stats
   73 6b0d7b013e MdeModulePkg/Variable: Add a file for NV variable function=
s
   74 044010234e MdeModulePkg/Variable: Parameterize auth status in Variabl=
eParsing
   75 8d53adbee9 MdeModulePkg/Variable: Parameterize VARIABLE_INFO_ENTRY bu=
ffer
   76 f8ff4cca7c MdeModulePkg/Variable: Parameterize GetNextVariableInterna=
l () stores
   77 20a27a641b MdeModulePkg/Variable: Consolidate common parsing function=
s
   78 a7d69b6aaf MdeModulePkg/EbcDebugger: Add check for Entry and RetEntry
   79 0c1541d457 MdeModulePkg/SetupBrowserDxe: ASSERT GetBufferForValue(&Va=
lue)
   80 3fb7e094ef MdeModulePkg/EsrtDxe: Add check for EsrtRepository
   81 e34022dcbe MdeModulePkg/HiiDatabaseDxe: ASSERT StringPtr
   82 dd6d07bda9 ShellPkg/Shell/FileHandleWrappers.c: Add check for MemFile=
->Buffer
   83 1bcc65b9a1 CryptoPkg: Upgrade OpenSSL to 1.1.1d
   84 fe3ca5fd25 UefiCpuPkg/MpInitLib: Remove global variable X2ApicEnable
   85 54d1e76f4e UefiCpuPkg/MpInitLib: Set X2ApicEnable flag from BSP
   86 8d3f428109 ShellPkg/Ls: Return empty content for all empty folders
   87 106369fe26 ShellPkg/Ls: Consider UEFI timezone may not be set
   88 17efd446c0 MdeModulePkg/Mem: Initialize the variable MapMemory
   89 a857ea4199 MdeModulePkg/UhciPei: Initialize the variable RequestMap
   90 7a2505bb0f MdeModulePkg/EhciPei: Initialize the variable Map
   91 d3eac77eeb MdeModulePkg/SdBlockIoPei: Add check for DeviceIndex
   92 df50c2fcd8 MdeModulePkg/HiiDatabaseDxe: ASSERT "Private->Attribute >>=
 4"
   93 121955fd4f MdeModulePkg/Variable/Pei: Update the condition in if stat=
ement
   94 2b23beb043 MdeModulePkg/Oniguruma: Remove redundant IF statement
   95 c18708d2f0 MdePkg-UefiSpec.h: Add UEFI 2.8 new memory attributes
   96 b10ef8a4e7 MdePkg: Add AML OpCode definition for ExternalOp
   97 6407186db9 MdePkg/UefiFileHandleLib: Tolerate more Root handle FileNa=
mes
   98 1009b59b65 MdePkg/UefiFileHandleLib: Fix potential NULL dereference
   99 787c4baace MdePkg/UefiDebugLibStdErr: Pass the correct buffer size
  100 5ae6c993ab MdePkg/UefiDebugLibConOut: Pass the correct buffer size
  101 e2fc508128 NetworkPkg/HttpDxe: Set the HostName for the verification =
(CVE-2019-14553)
  102 703e7ab21f NetworkPkg/TlsDxe: Add the support of host validation to T=
lsDxe driver (CVE-2019-14553)
  103 1e72b1fb2e CryptoPkg/TlsLib: TlsSetVerifyHost: parse IP address liter=
als as such (CVE-2019-14553)
  104 8d16ef8269 CryptoPkg/Crt: import "inet_pton.c" (CVE-2019-14553)
  105 2ac41c12c0 CryptoPkg/Crt: satisfy "inet_pton.c" dependencies (CVE-201=
9-14553)
  106 eb520d94db CryptoPkg/Crt: turn strchr() into a function (CVE-2019-145=
53)
  107 2ca74e1a17 CryptoPkg/TlsLib: Add the new API "TlsSetVerifyHost" (CVE-=
2019-14553)
  108 31efec8279 MdePkg/Include/Protocol/Tls.h: Add the data type of EfiTls=
VerifyHost (CVE-2019-14553)
  109 b15646484e MdeModulePkg/BdsDxe: Fix PlatformRecovery issue
  110 9f4fbd56d4 CryptoPkg/OpensslLib: Update process_files.pl to generate =
.h files
  111 dc254af6a4 MdeModulePkg/NvmExpressPei: Fix Opal S3 unlock issue
  112 6f3ac73cd3 NetworkPkg/SnpDxe: Use PcdGetBool() instead of FixedPcdGet=
Bool in Snp.c
  113 d4269c8e7c Maintainers.txt: Update my e-mail address
  114 4976a776b2 Maintainers.txt: Change NetworkPkg maintainer role.
  115 9e639c1cb6 IntelFsp2Pkg/SplitFspBin.py: Command crashed when FV almos=
t full.
  116 6996ec88a2 NetworkPkg: Add missing components to DSC file
  117 703232b8e8 OvmfPkg: Enable CLANG9 tool chain
  118 2737037a41 EmulatorPkg: Enable CLANG9 tool chain
  119 933681b208 CryptoPkg IntrinsicLib: Make _fltused always be used
  120 3d61650f95 CryptoPkg: Append options to make CLANG9 tool chain pass b=
uild
  121 55863be1fc MdeModulePkg RegularExpressionDxe: Disable warning for CLA=
NG9 tool chain
  122 7d9ba361cc MdeModulePkg LzmaCustomDecompressLib: Update macro to be s=
ame in CLANG tool
  123 0f59f44805 MdePkg BaseIoLibIntrinsic: Remove __inline__ attribute for=
 IO functions
  124 70bebafd1b MdePkg Base.h: Add definition for CLANG9 tool chain
  125 3d312a1fec BaseTools GenFw: Fix the issue to update the wrong size as=
 SectionSize
  126 15330934dc BaseTools tools_def: Add CLANG9 tool chain to directly gen=
erate PE image
  127 7ab180bb91 BaseTools tools_def.template: Remove unnecessary $(DEST_DI=
R_DEBUG) path
  128 d95de082da CryptoPkg: Add Null instance of the BaseCryptLib class
  129 20c082e8d7 UefiCpuPkg: Add missing components to UefiCpuPkg.dsc
  130 79cd636f3e CryptoPkg: Add Null instance of the TlsLib class
  131 412c963842 CryptoPkg: Add missing components to CryptoPkg.dsc
  132 d6b926e76e SecurityPkg: Fix spelling errors
  133 6e7e9b9578 SecurityPkg: Change EFI_D_INFO to DEBUG_INFO
  134 95d2883647 FmpDevicePkg: Fix spelling errors
  135 5c7006c9de BaseTools: Do not call sys.setdefaultencoding with python =
3
  136 53b1dd1036 PcAtChipsetPkg: Fix spelling errors
  137 44c9618a3f FatPkg: Fix spelling errors
  138 8d89159245 MdePkg: Add UefiFileHandleLib to DSC file
  139 46bb812007 OvmfPkg: Make SOURCE_DEBUG_ENABLE actually need to be set =
to TRUE
  140 f413d9bee3 DynamicTablesPkg: Arm SRAT Table Generator
  141 91f98c9086 DynamicTablesPkg: include ARM intrinsics library to fix 32=
-bit build
  142 61bb6eeb4d NetworkPkg/SnpDxe: Add PCD to remove ExitBootServices even=
t from SNP driver.
  143 109197ee11 WinHost: Add SimplePointer support
  144 2bbbdeeea2 MdeModulePkg/XhciPei: Fix Aligned Page Allocation
  145 3b889f6fab MdeModulePkg/XhciDxe: Fix Aligned Page Allocation
  146 0f28c513d3 SignedCapsulePkg: fix AARCH64 build
  147 e026bb4c39 SecurityPkg Tcg2Dxe: Add Variable Arch protocol dependency
  148 b1c6e9f55e BaseTools: Fix an incremental build issue caused by macro =
in #include
  149 e797a806a8 ShellPkg/UefiShellDebug1CommandsLib: Update to support SmB=
ios 3.3.0
  150 f06c92a656 MdePkg/Include: Update to support SmBios 3.3.0
  151 7288142a39 MdeModulePkg: Update to support SmBios 3.3.0
  152 b8fc5c03e5 NetworkPkg/Ip6Dxe: Fix typo in comment
  153 81e9eca7a4 StandaloneMmPkg/Core: Fix typo in function name
  154 d4fa02a89e MdeModulePkg/PiSmmCore: Fix typo in function name
  155 b0570b48f3 MdeModulePkg DxeCore: Fix typo in function name
  156 23ab8df01a ArmVirtPkg/PlatformBootManagerLib: Don't update progress i=
f Pcd is 0
  157 c3c90d8aa7 OvmfPkg/PlatformBootManagerLib: Don't update progress if P=
cd is 0
  158 cd70b1a71d MdeModulePkg/Ufs: Fix UFS flag read from Query Resp UPIU
  159 4d05a4b709 MdeModulePkg/BdsDxe: Fix calling PlatformBootManagerWaitCa=
llback on 0
  160 a1f94045ff BaseTools: Fix a bug of genffs command generation
  161 778832bcad UefiCpuPkg/MpInitLib: honor the platform's boot CPU count =
in AP detection
  162 30459ddde6 UefiCpuPkg/MpInitLib: expand comment on initial AP enumera=
tion
  163 a7e2d20193 SecurityPkg/Tcg2: Add Support Laml, Lasa for TPM2 ACPI.
  164 1fca55285b SecurityPkg/dsc: Add PCD for Laml, Lasa for TPM2.
  165 5970cb23b7 MdePkg/Include: correct Lasa in Tpm2Acpi.
  166 976d0353a6 UefiPayloadPkg/BlSupportDxe: fix ReserveResourceInGcd() ca=
lls
  167 04a0c3e8e1 UefiPayloadPkg/BlSupportPei: fix MMCONFIG assignment from =
XSDT
  168 7f72ec0b15 StandaloneMmPkg/Core: stop abusing EFI_HANDLE for FwVolHea=
der tracking
  169 7eb6160d4f ShellPkg/UefiShellLib: clarify workaround for unfixable Ed=
kShell bug
  170 d5e35fddec ShellPkg/UefiShellDebug1CommandsLib: fix ShellCloseFile() =
call
  171 1b3115baad ShellPkg: stop taking EFI_HANDLE in place of SHELL_FILE_HA=
NDLE
  172 c44501b313 ShellPkg: stop using EFI_HANDLE in place of EFI_HII_HANDLE
  173 61d505dfc1 ShellPkg/UefiShellDriver1CommandsLib: fix parameter list t=
ypo
  174 fcf8bdcd53 SecurityPkg: stop abusing EFI_EVENT for protocol notify re=
gistration
  175 a629d5b9ef SecurityPkg: fix UninstallMultipleProtocolInterfaces() cal=
ls
  176 35dd574a24 OvmfPkg/PlatformDxe: fix EFI_HII_HANDLE parameters of inte=
rnal functions
  177 19c2a92805 OvmfPkg/VirtioNetDxe: fix SignalEvent() call
  178 2ef0c27cb8 OvmfPkg/XenBusDxe: fix UninstallMultipleProtocolInterfaces=
() call
  179 30af652ee1 NetworkPkg/TcpDxe: fix SockFreeFoo() parameter list
  180 2c9abfd5bb NetworkPkg/Ip4Dxe: fix NetLibDestroyServiceChild() call
  181 bf7249df9c NetworkPkg: fix CloseProtocol & UninstallMultipleProtocolI=
nterfaces calls
  182 c486a33049 NetworkPkg/DxeNetLib: fix type typo in NetLibGetMacAddress=
()
  183 b1a6a0676a MdePkg/DxeServicesLib: remove bogus cast
  184 812e3bade6 MdeModulePkg/S3SaveState: cast Position for S3BootScriptLi=
b explicitly
  185 f662f91cb2 MdeModulePkg/PiSmmCore: make type punning consistent
  186 9388c6b1c1 MdeModulePkg: fix UninstallMultipleProtocolInterfaces() ca=
lls
  187 9ee135501b MdeModulePkg: PEI Core: clean up "AprioriFile" handling in=
 FindFileEx()
  188 f931984015 MdeModulePkg: stop abusing EFI_HANDLE for keystroke notify=
 registration
  189 d342d318e9 MdeModulePkg: document workaround for EFI_RUNTIME_EVENT_EN=
TRY PI spec bug
  190 0bee7dbd2b MdeModulePkg/PlatformVarCleanupLib: fix HiiConstructConfig=
Hdr() call
  191 10eec5aa92 MdeModulePkg: stop abusing EFI_EVENT for protocol notify r=
egistration
  192 abf8f69ebf MdeModulePkg/UefiHiiLib: stop using EFI_HANDLE in place of=
 EFI_HII_HANDLE
  193 3522ea73f9 MdeModulePkg: fix cast in GetModuleInfoFromHandle() calls
  194 02ee79fa6a EmulatorPkg: stop abusing EFI_HANDLE for keystroke notify =
registration
  195 60d222748a EmulatorPkg/DxeTimerLib: drop superfluous cast
  196 e1b59e085a EmbeddedPkg/Universal/MmcDxe: "fix" CloseProtocol() call i=
n BindingStop()
  197 7b6ceb4d3b EmbeddedPkg/AndroidFastbootTransportTcpDxe: fix DestroyChi=
ld() call
  198 7609c04728 EmbeddedPkg: add missing EFIAPI calling convention specifi=
ers
  199 2de1f611be MdeModulePkg/BdsDxe: Also call PlatformBootManagerWaitCall=
back on 0
  200 410c4d00d9 Maintainers.txt: Move ShellBin maintainers to EDK II Relea=
ses section
  201 0b73027eb1 NetworkPkg: Remove unnecessary MdeModulePkg/MdeModulePkg.d=
ec dependency in INF
  202 6fcdbde51f MdeModulePkg: Remove PCD gEfiMdeModulePkgTokenSpaceGuid.Pc=
dTftpBlockSize
  203 047ede3199 NetworkPkg UefiPxeBcDxe: Consume PcdTftpBlockSize defined =
in NetworkPkg.dec
  204 c7471e2a01 NetworkPkg: Add PcdTftpBlockSize in NetworkPkg.dec
  205 1aebb09519 MdeModulePkg: Remove network related guid definitions from=
 MdeModulePkg.dec
  206 281161f109 NetworkPkg: Move network related header files from MdeModu=
lePkg to NetworkPkg
  207 d19040804a UefiCpuPkg: strip trailing whitespace
  208 4040754daf OvmfPkg: strip trailing whitespace
  209 ba39402f34 MdeModulePkg: strip trailing whitespace
  210 89c2e2b1d3 EmulatorPkg: strip trailing whitespace
  211 0deca401f0 BaseTools: strip trailing whitespace
  212 df8f8688b8 ArmPlatformPkg: strip trailing whitespace
  213 92c8588f93 ArmPkg: strip trailing whitespace
  214 432418662c EmbeddedPkg: convert Lauterbach README.txt to 7-bit safe R=
eadme.md
  215 d79b63c64f BaseTools: correct line endings for ConvertFce Python scri=
pt
  216 3afcba4a8f ArmPkg: ArmScmiDxe - convert .h to from 8859-x to 7-bit
  217 fe3b33e8aa DynamicTablesPkg: fix .dsc line ending
  218 7ecf6717cf BaseTools: fix line endings in SetupGit.py Conf files
  219 c63012886c EmbeddedPkg: delete outdated FdtLib README.txt
  220 3ebd880173 NetworkPkg: add missing newline at end of file
  221 280432c2fe EmbeddedPkg: add missing newline at end of TemplateResetSy=
stemLib.inf
  222 c1bcb2258c BaseTools: add missing newlines at end of files
  223 61af5f2494 BaseTools: Fix GenMake multi-workspace failure
  224 5be5439a5a BaseTools: use stdint.h for GCC ProcessorBind.h typedefs
  225 ed9db1b91c MdeModulePkg: Enable/Disable S3BootScript dynamically.
  226 f835e1d4c1 BaseTools/LzmaCompress: Fix the option "d" dictionary size
  227 ac81789c3b MdeModulePkg/ScsiDiskDxe: Support Storage Security Command=
 Protocol
  228 1ff7ed2cfa MdeModulePkg/ScsiBusDxe: Clean up Peripheral Type check
  229 43bb4e379b MdeModulePkg/UfsPassThruDxe: Check for RPMB W-LUN (Securit=
yLun)
  230 9b14509b16 MdePkg: Implement SCSI commands for Security Protocol In/O=
ut
  231 1f5e4d9128 BaseTools: Fix the lib order in static_library_files.lst
  232 76e1e5631f MdeModulePkg/SdMmcPciHcDxe: Fix SdMmcMmcLegacy bus timing =
handling
  233 a8c1fc70db MdeModulePkg/SdMmcPciHcDxe: Fix bus timing switch sequence
  234 206783aa7f MdeModulePkg/SdMmcPciHcDxe: Remove clock stop from HS200 s=
witch
  235 e86664d2b0 MdeModulePkg/TerminalDxe: Enhance the arrow keys support
  236 6da405ebf6 BaseTools:"--exclude" don't apply if parameter ends with s=
eparator
  237 c70fef962e UefiCpuPkg/CpuDxe: clean up PAGE_TABLE_LIB_PAGING_CONTEXT =
usage.
  238 a3596a040b MdePkg Base.h: Define STATIC_ASSERT macro as empty for EBC=
 arch
  239 96301aadc1 MdeModulePkg: Add missing sourceX for Blt
  240 c671c9106c ShellPkg: Unload image on EFI_SECURITY_VIOLATION
  241 2184ededd3 MdeModulePkg/PlatformDriOverride: Unload image on EFI_SECU=
RITY_VIOLATION
  242 f7fdd620e8 MdeModulePkg/UefiBootManager: Unload image on EFI_SECURITY=
_VIOLATION
  243 51a3985cbb MdeModulePkg/DxeCapsuleLibFmp: Unload image on EFI_SECURIT=
Y_VIOLATION
  244 82e0c422b2 EmbeddedPkg: Unload image on EFI_SECURITY_VIOLATION
  245 590c9d5828 MdeModulePkg/BM_UI: Add the new terminal types to related =
menu
  246 8a53ea9d9f MdeModulePkg/TerminalDxe: Extend the terminal console supp=
ort types
  247 da63ba5174 MdeModulePkg: Extend the support keyboard type of Terminal=
 console
  248 4747b92cab BaseTools: init DependencyHeaderFileSet for each MakeFile =
class
  249 670c903a68 Add VS2019 Support on ToolSetup Batches
  250 7a25b3da78 Add VS2019 Toolchain def
  251 6b80310f34 BaseTools/LzmaCompress: Add two switches
  252 fcdedafd97 Revert "BaseTools: Improve GetDependencyList function"
  253 f4c898f2b2 UefiCpuPkg/CpuExceptionHandlerLib: Fix split lock
  254 832c4c7ad6 UefiCpuPkg: Fix potential spinLock issue in SmmStartupThis=
Ap
  255 d7bf973e43 Maintainers.txt update for ShellPkg
  256 13bfe3e452 Maintainers.txt: Unify one maintainer name
  257 85ccbee2ab BaseTools:Fix the issue that build report failed
  258 d652b458f5 EmulatorPkg/TimerLib: Add missing GetTimeInNanoSecond func=
tion
  259 136dad0956 UefiCpuPkg: Remove PcdCpuSmmStaticPageTable
  260 b0c15fb128 BaseTools: Add more parameter checking for CopyFileOnChang=
e()
  261 82c1a21208 StandaloneMmPkg: make package .DSC file build again
  262 9790f62be1 MdeModulePkg SerialDxe.inf: Fix wrong FILE_GUID format
  263 22e75231ae BaseTools:Remove the unnecessary operation of renaming a f=
ile.
  264 0075ab2cec BaseTools: remove unnecessary calls of os.exist
  265 bc9e4194cf BaseTools: Improve GetDependencyList function
  266 e32f7bc96d BaseTools:change some incorrect parameter defaults
  267 b67735a7e8 BaseTools:Replace PlatformInfo with PlatformAutoGen for Mo=
udle
  268 ea331a5c21 MdePkg: UefiLib: Add a function to check if a language is =
supported
  269 26fc074a5f SecurityPkg Tcg2Config: Move common definitions to new Tcg=
2Internal.h
  270 d8c4b87ec4 MdePkg: Drop VERIFY_SIZE_OF in favour of STATIC_ASSERT
  271 b03fb410b2 MdePkg: Use STATIC_ASSERT macro
  272 a9521a6bf4 MdeModulePkg/ResetUtilityLib: Use STATIC_ASSERT macro
  273 0d85e67714 MdeModulePkg/SerialDxe: Update the file Guid in SerialDxe.=
inf
  274 e0e388a427 EmulatorPkg/PeiEmuSerialPortLib: Update the INF file Guid
  275 49a2f8ceee SecurityPkg/SecurityPkg.dec: Update TcgPpVendorLib.h to Tc=
g2PpVendorLib.h
  276 0d4f7b4b38 MdePkg/MdePkg.dec: Update PciSegmentLib.h to S3PciSegmentL=
ib.h
  277 18be724e30 Change package reviewer of CryptoPkg.
  278 9b5a1c789d ArmPlatformPkg: Add missing header files in INF file
  279 7551529ce1 ArmVirtPkg: increase FD/FV size for NOOPT builds
  280 86ad762fa7 UefiCpuPkg/PiSmmCpu: Enable 5L paging only when phy addr l=
ine > 48
  281 5a9db85880 BaseTools: Fixed a bug of IgnoreAutoGen
  282 204ae9da23 MdePkg: Add STATIC_ASSERT macro
  283 5e5abfcab4 BaseTools: Robustness for multiple build environments
  284 7809492c10 BaseTools: Enable --genfds-multi-thread to default build
  285 f23da86415 BaseTools: Fixed the build fail on Linux with --genfds-mul=
ti-thread
  286 e3c8311f8a BaseTools: Fixed the bug of multi-thread genffs for overri=
de inf
  287 000ab98574 BaseTools: Sort Pcd settings to make PcdTokenNumber be fix=
ed
  288 373298ca0d BaseTools: Fixed issue for IgnoreAutoGen
  289 53e2eaba7a BaseTools: Fixed build clean regression issue
  290 cbe7543ebb BaseTools: Fix a bug for Hii Pcd override
  291 f49421a47d MdePkg/BluetoothLeConfig.h: Add type EfiBluetoothSmpPeerAd=
dressList
  292 d6f5a5050b BaseTools:ECC need to handle lower case 'static'
  293 03ad3d889c BaseTools:Ecc handle another copyright format
  294 59b754c9f6 OvmfPkg/EnrollDefaultKeys: clean up Base64Decode() retval =
handling
  295 ae9f12058d ArmVirtPkg/PlatformBootManagerLib: unload image on EFI_SEC=
URITY_VIOLATION
  296 23908d0f5c ShellPkg/ShellPkg.dsc AARCH64: enable stack protector
  297 04d9d89b7d ArmVirtPkg/ArmVirtPrePiUniCoreRelocatable: revert to PIE l=
inking
  298 8a1305a11f UefiCpuPkg: support single EFI_PEI_CORE_FV_LOCATION_PPI in=
 PpiList
  299 7bf5255997 IntelFsp2WrapperPkg: Remove unneeded MdeModulePkg dependen=
cy
  300 d1da2ab93a IntelFsp2Pkg/FspSecCore: Remove unneeded MdeModulePkg depe=
ndency
  301 d2687f23c9 BaseTools/GenFw AARCH64: fix up GOT based relative relocat=
ions
  302 adb59b633c ShellPkg/Pci.c: Update supported link speed to PCI5.0
  303 fa5e184327 BaseTools: Update GenFw tool to support -e -z option toget=
her
  304 48d49ea507 MdeModulePkg: Remove PcdRealTimeClockUpdateTimeout
  305 6b9dd13dd9 PcAtChipsetPkg: add PcdRealTimeClockUpdateTimeout
  306 f64a597d45 UefiCpuPkg: Explain relationship between several SMM PCDs
  307 79186ddcdd UefiCpuPkg/PiSmmCpu: Restrict access per PcdCpuSmmRestrict=
edMemoryAccess
  308 09f7c82b4c UefiCpuPkg/PiSmmCpu: Use new PCD PcdCpuSmmRestrictedMemory=
Access
  309 87184487d2 UefiCpuPkg: Add PcdCpuSmmRestrictedMemoryAccess
  310 8b8e915845 ShellPkg/CommandLib: avoid NULL derefence and memory leak
  311 17f8c9e97d MdePkg/DxeHstiLib: Added checks to improve error handling.
  312 40db176d9d BaseTools: Support more file types in build cache
  313 47f167f47e UefiCpuPkg/SecCore: get AllSecPpiList after SecPlatformMai=
n.
  314 37eef91017 BaseTools: Fixed regression issue for building !x86 builds
  315 df43ea6c08 BaseTools: fix an incremental build issue.
  316 30b4abc6e9 EmulatorPkg/Win/Host: Fix SecPrint() log line endings
  317 10ccc27c95 EmulatorPkg/Win/Host: Fix image unload regression
  318 abc0155b03 BaseTools: Incorrect error message for library instance no=
t found
  319 5f7bb39117 BaseTools: Fix incremental build genmake issue
  320 6dd9aa4019 BaseTools: Support long file path in windows for misc func=
tions
  321 1237517b21 OvmfPkg/OvmfXen: use RealTimeClockRuntimeDxe from Embedded=
Pkg
  322 4870639f55 OvmfPkg: Move XenRealTimeClockLib from ArmVirtPkg
  323 833cd3e0c0 OvmfPkg: Introduce XenIoPvhDxe to initialize Grant Tables
  324 8f39d79d65 OvmfPkg: Introduce PcdXenGrantFrames
  325 05480e2fd4 OvmfPkg/PlatformBootManagerLib: Use a Xen console for ConO=
ut/ConIn
  326 d668c8bc55 OvmfPkg/OvmfXen: Introduce XenTimerDxe
  327 c8395d27f7 OvmfPkg/OvmfXen: Override PcdFSBClock to Xen vLAPIC timer =
frequency
  328 ad256f9540 OvmfPkg/PlatformBootManagerLib: Handle the absence of PCI =
bus on Xen PVH
  329 bc5df19872 OvmfPkg/PlatformBootManagerLib: Use XenDetected from XenPl=
atformLib
  330 054c3fe9b5 OvmfPkg/XenPlatformLib: Cache result for XenDetected
  331 198a8dc9cd OvmfPkg/XenPlatformPei: Ignore missing PCI Host Bridge on =
Xen PVH
  332 77d35f5008 OvmfPkg/XenPlatformPei: Reserve VGA memory region, to boot=
 Linux
  333 24465c380a OvmfPkg/XenPlatformPei: Rework memory detection
  334 a749e1f93b OvmfPkg/XenPlatformPei: no hvmloader: get the E820 table v=
ia hypercall
  335 23f9374203 OvmfPkg: Import XENMEM_memory_map hypercall to Xen/memory.=
h
  336 64eac29576 OvmfPkg/XenPlatformPei: Introduce XenPvhDetected
  337 12998837d5 OvmfPkg/XenPlatformPei: Setup HyperPages earlier
  338 4022f7fa91 OvmfPkg/XenPlatformPei: Introduce XenHvmloaderDetected
  339 80b619d5c4 OvmfPkg/XenPlatformPei: Reinit XenHypercallLib
  340 68f4599dfc OvmfPkg/XenHypercallLib: Enable it in PEIM
  341 2a4a6242b7 OvmfPkg/AcpiPlatformDxe: Use Xen PVH RSDP if it exist
  342 3afa2ed53f OvmfPkg/AcpiPlatformDxe: Use XenPlatformLib
  343 f496443eb3 OvmfPkg/Library/XenPlatformLib: New library
  344 60d265451a OvmfPkg/XenPlatformPei: Grab RSDP from PVH guest start of =
day struct
  345 594b5002a6 OvmfPkg/XenPlatformPei: Use mXenHvmloaderInfo to get E820
  346 8651e1ce71 OvmfPkg/XenPlatformPei: Detect OVMF_INFO from hvmloader
  347 31d4e8b029 OvmfPkg/OvmfXen: use a TimerLib instance that depends only=
 on the CPU
  348 f198e254f7 OvmfPkg/XenResetVector: Allow jumpstart from either hvmloa=
der or PVH
  349 93314ae597 OvmfPkg/XenResetVector: Saving start of day pointer for PV=
H guests
  350 a8c791c15b OvmfPkg/XenResetVector: Add new entry point for Xen PVH
  351 1e9d6b0f98 OvmfPkg/OvmfXen: Creating an ELF header
  352 3b96221f77 OvmfPkg: Introduce XenPlatformPei
  353 c05de360ec OvmfPkg: Introduce XenResetVector
  354 75e85e3382 OvmfPkg: Create platform OvmfXen
  355 aaebea27da OvmfPkg/ResetSystemLib: Add missing dependency on PciLib
  356 30781febe2 UefiCpuPkg: Adding a new TSC library by using CPUID(0x15) =
TSC leaf
  357 9c90d39b60 UefiCpuPkg/CpuCommonFeaturesLib: Use new macros.
  358 95cfe6c247 UefiCpuPkg/RegisterCpuFeaturesLib: Supports test then writ=
e new value logic.
  359 6b3645ade5 UefiCpuPkg/RegisterCpuFeaturesLib: Combine CR read/write a=
ction.
  360 cfbcaad251 UefiCpuPkg/PiSmmCpuDxeSmm: Supports test then write new va=
lue logic.
  361 ef21a304e0 UefiCpuPkg/PiSmmCpuDxeSmm: Combine CR read/write action.
  362 35c2809ba6 UefiCpuPkg/RegisterCpuFeaturesLib: Add "Test Then Write" M=
acros.
  363 4201098e97 UefiCpuPkg/PiSmmCpuDxeSmm: don't free page table pages tha=
t are required to handle current page fault
  364 ada905ab5c MdeModulePkg DxeCore: Fix for missing Memory Attributes Ta=
ble (MAT) update
  365 0970a80583 BaseTools: Update incorrect variable name 'DataPile'
  366 94459080c1 BaseTools: Improve the file saving and copying reliability
  367 d01a998612 BaseTools: Add GenFds multi-thread support in build cache
  368 c340c5bd1b BaseTools: Change the [Arch][Name] module key in Build cac=
he
  369 56c786b0a9 BaseTools: Print first cache missing file for build cachle
  370 0e7e7a264c BaseTools: Improve the cache hit in the edk2 build cache
  371 8113281728 ShellPkg/UefiShellDriver1CommandsLib: Make array big enoug=
h
  372 74c22c59e3 BaseTools/tools_def.template: Add -gdwarf to XCODE5 X64
  373 d47778e522 EmulatorPkg/Sec: Change scope of PpiArray[10]
  374 6ed2c8bed3 EmulatorPkg: Disable TftpDynamicCommand and LogoDxe for XC=
ODE5
  375 26ac9c639a EmulatorPkg/Unix/Host: Remove debug code from BerkeleyPack=
etFilter.c
  376 97a1b9f473 EmulatorPkg/Unix/Host: Initialize field in BerkeleyPacketF=
ilter.c
  377 32e55c9f18 EmulatorPkg: Fix XCODE5 lldb issues
  378 4331b9f5f0 EmulatorPkg/Unix/Host: Disable inline/optimizations for XC=
ODE5
  379 57c320c932 EmulatorPkg: Add support for NOOPT target
  380 9e3ab94dc8 EmulatorPkg: Add -D DISABLE_NEW_DEPRECATED_INTERFACES
  381 50509ec66c EmulatorPkg: Remove UNIX_SEC_BUILD/WIN_SEC_BUILD
  382 868254ace3 EmulatorPkg: Fix VS20xx IA32 boot failure
  383 76e12fa334 BaseTools: Fixed issue of incorrect Module Unique Name
  384 5726bdd9a2 ShellPkg/UefiShellAcpiViewCommandLib: Replace shift logica=
l left
  385 944bd5cf1d CryptoPkg: Fix coding style
  386 501de8146d UefiCpuPkg/Cpuid: Add description for parameter LeafFuncti=
on
  387 0154e02dc7 ShellPkg/UefiShellAcpiViewCommandLib: Initialize local var=
iables
  388 8906f076de CryptoPkg/OpensslLib: Add missing header files in INF file
  389 f516a5144e SecurityPkg/SecurityPkg.uni: Add missing strings for new P=
CDs
  390 0680d08683 MdeModulePkg/DxeIplPeim: Initialize pointer PageMapLevel5E=
ntry
  391 48d8d4d80b BaseTools/Capsule: Tool to generate Windows Firmware Updat=
e Driver
  392 e2aacac580 BaseTools/Capsule: Add WindowsCapsuleSupportHelper
  393 a5944b6a13 FmpDevicePkg/FmpDxe: Remove use of CatSprint()
  394 11d354945c FmpDevicePkg/FmpDxe: Add PcdFmpDeviceStorageAccessEnable
  395 278c3d48a7 FmpDevicePkg/FmpDxe: Add PcdFmpDeviceImageTypeIdGuid
  396 e0961677d1 FmpDevicePkg/FmpDxe: Improve all DEBUG() messages
  397 c40f7cc7fd FmpDevicePkg: Add Capsule Update Policy Protocol
  398 67c1e5ee6e FmpDevicePkg/FmpDxe: Different variable for each FMP Descr=
iptor
  399 4f0544b144 FmpDevicePkg/FmpDxe: Use new FmpDeviceLib APIs
  400 a6ee24fbdd MdeModulePkg/MdeModulePkg.dec: Remove gEfiDpcProtocolGuid
  401 593ecbe300 NetworkPkg: Move Dpc.h from MdeModulePkg to NetworkPkg
  402 492a1db0b8 NetworkPkg: Add Dpc protocol
  403 caa7d3a896 BaseTools/Scripts: Add GetUtcDateTime script.
  404 c0996b76c1 ShellPkg/UefiShellAcpiViewCommandLib: Remove the variable =
"Index"
  405 5ab96088ae CryptoPkg/OpensslLib: remove clone commands
  406 2556350d1b Readme.md: add submodule policy and clone commands
  407 f5892aa8d8 MdeModulePkg/DxeCapsuleLibFmp: Improve comparisons in Caps=
uleOnDisk.c
  408 34651e7d76 MdeModulePkg/CapsuleApp: Improve comparisons in CapsuleOnD=
isk.c
  409 08a54c9e0a BaseTools: Move buildoptions.py to Common folder
  410 1f06aa24c2 FmpDEvicePkg/FmpDeviceLibNull: Implement new APIs
  411 8d01f2f4d6 FmpDevicePkg: Add APIs to FmpDeviceLib
  412 91c230578c FmpDevicePkg: Add UEFI_DRIVER support
  413 82407bd129 BaseTools: Fix checking for Sources section in INF file
  414 2b4c07bc22 BaseTools: Add "-" in a re to parse line in .map file
  415 a000d5d1ca BaseTools: Fix incremental build bug
  416 46f8a68916 MdeModulePkg/DxeIplPeim: Relocate operation of PageMapLeve=
l5Entry++
  417 073f2cede8 UefiCpuPkg/PiSmmCpuDxeSmm: Fix coding style
  418 c3eefcb152 IntelFsp2Pkg/FspSecCore: Add missing header file in INF fi=
le
  419 ed23ab5fc7 ShellPkg/UefiShellAcpiViewCommandLib: Add missing header f=
iles in INF
  420 c0e174bd5b MdePkg/BaseUefiDecompressLib: Add missing description for =
parameter
  421 61ca3b9236 MdeModulePkg: Add missing header files in INF files
  422 6f33f7a262 MdePkg: Add MmAccess and MmControl definition.
  423 9c6180fb3d Readme.md: Remove tag release from Readme
  424 a7b54d1821 MdeModulePkg/RegularExpressionDxe: Add two missing null po=
inter checks
  425 b26691c471 MdeModulePkg RegularExpressionDxe: Update Oniguruma from v=
6.9.0 to v6.9.3
  426 ecc32c90ee MdeModulePkg/UfsPassThruDxe: Implement EDKII_UFS_HC_PLATFO=
RM_PROTOCOL
  427 a71272ed7a MdeModulePkg/UfsPassThruDxe: Refactor private data to use =
UfsHcInfo
  428 90952ad733 MdeModulePkg/UfsPassThruDxe: Refactor UfsExecUicCommand fu=
nction
  429 1bfd58c22e MdeModulePkg: Add definition of the EDKII_UFS_HC_PLATFORM_=
PROTOCOL
  430 12dcad5b1e ShellPkg/UefiShellLevel2CommansLib: Pointer Resonse should=
 be checked
  431 48d5d6d5e0 ShellPkg: acpiview: SRAT: Prevent buffer overruns
  432 5f0661220c ShellPkg: acpiview: PPTT: Prevent buffer overruns
  433 05d402952d ShellPkg: acpiview: MADT: Prevent buffer overruns
  434 62cefaf44e ShellPkg: acpiview: IORT: Prevent buffer overruns
  435 1d12f0e671 ShellPkg: acpiview: GTDT: Prevent buffer overruns
  436 ffb18f7710 ShellPkg: acpiview: DBG2: Prevent buffer overruns
  437 a0792697bc BaseTools: Fixed an issue that build raise exception
  438 4053587347 SourceLevelDebugPkg DebugCommLibUsb3: Address NULL ptr der=
eference case
  439 1a624dd7cf BaseTools: Enable block queue log agent.
  440 4acae2b38e BaseTools: Add the support for python 2
  441 c60fb00f6c BaseTools: Move BuildOption parser out of build.py
  442 636ed13a7f BaseTools: Add LogAgent to support multiple process Autoge=
n
  443 3285fbda88 BaseTools: Add shared data for processes
  444 673d09a2dd BaseTools: Enable Multiple Process AutoGen
  445 e8449e1d8e BaseTools: Decouple AutoGen Objects
  446 197ca7febf BaseTools: Add functions to get platform scope build optio=
ns
  447 2927a6fd99 BaseTools: Split WorkspaceAutoGen._InitWorker into multipl=
e functions
  448 db01c8e3d8 BaseTools: Singleton the object to handle build conf file
  449 4b1b7c1913 CryptoPkg/BaseCryptLib: Wrap OpenSSL HKDF algorithm
  450 466f5e89c3 UefiCpuPkg/PiSmmCpuDxeSmm: Clean up useless ConsoleLogLock=
 spinlock.
  451 800aeeda74 UefiCpuPkg/RegisterCpuFeaturesLib: Clean up useless Consol=
eLogLock spinlock.
  452 01acb06c4f UefiCpuPkg: Update code to include register definitions fr=
om MdePkg
  453 e057908f8d UefiCpuPkg|MdePkg: Move Register/ folder to MdePkg/Include=
/
  454 b3527dedc3 MdeModulePkg/DxeIpl: Create 5-level page table for long mo=
de
  455 236d5c66c4 MdePkg/Cpuid.h: Move Cpuid.h from UefiCpuPkg to MdePkg
  456 1c7b3eb846 MdeModulePkg/DxeIpl: Introduce PCD PcdUse5LevelPageTable
  457 e58aa47432 UefiCpuPkg/CpuDxe: Support parsing 5-level page table
  458 29355b4e1a UefiCpuPkg/CpuDxe: Remove unnecessary macros
  459 09f69a877b UefiCpuPkg/MpInitLib: Enable 5-level paging for AP when BS=
P's enabled
  460 1ab7d72651 OvmfPkg/PlatformPei: Change referenced MSR name.
  461 35ec41803c BaseTools:Add the Judgment Method of "--exclude"
  462 96603b4f02 BaseTools/PatchCheck: Disable text conversion in 'git show=
'
  463 1eeb5ff160 BaseTools/PatchCheck: Add copy from/to keywords
  464 05579e5182 BaseTools/PatchCheck: Ignore blank lines in diff
  465 111bbcf876 MdeModulePkg/DxeCapsuleLibFmp: Add missing description for=
 parameter
  466 e314132fea MdeModulePkg/EsrtFmpDxe: Enhance ESRT to support multiple =
controllers
  467 c30fbac4e2 MdePkg/X64/ProcessorBind.h: Fix EmulatorPkg X64 XCODE5
  468 538d8aaaf3 EmulatorPkg/Unix/Host: Fix XCODE5 IA32/X64 build failure
  469 b98504b514 EmulatorPkg/Unix/Host: Fix NetworkPkg dependencies
  470 113a7d9ec9 EmulatorPkg: Fix VS2015 build when VS2017 also installed
  471 02031cfc92 UefiCpuPkg/PiSmmCpuDxeSmm: Remove debug message.
  472 1821dbed1d UefiCpuPkg/RegisterCpuFeaturesLib: Remove debug message.
  473 5ed4c46f11 UefiCpuPkg/PiSmmCpuDxeSmm: Make code consistent with comme=
nts
  474 76e40d7be2 ShellPkg/UefiShellBcfgCommandLib: Fix '-opt' option
  475 7c662c9e73 ShellPkg: Add shell with all commands integrated
  476 eb2a1ed56f ShellPkg/AcpiView: Fix IA32 link error
  477 aefcf2f78a UefiCpuPkg/PiSmmCpuDxeSmm: Add check for pointer Pml5Entry
  478 4ac8ceb5d6 MdeModulePkg: Remove RecoveryLib.h and PeiRecoveryLibNull
  479 b9c3cbf6ec MdeModulePkg: Remove S3Lib.h and PeiS3LibNull
  480 1702e2ce5a MdeModulePkg/UsbBusDxe: Return error when the device is no=
t present
  481 e18d1c37e8 SecurityPkg/SecurityPkg.dec: Remove trailing white space
  482 afebc51547 MdeModulePkg/PiSmmCore: Use unique structure signatures
  483 89164babec UefiCpuPkg/MpInitLib: don't shadow the microcode patch twi=
ce.
  484 5e4ebd9ea5 IntelFsp2Pkg: Improve FSP Python scripts to support 3.x.
  485 46e34cc956 UefiCpuPkg/PiSmmCpuDxeSmm: Keep function comment and decla=
ration adjacent
  486 f32a49f10b SecurityPkg/FvReportPei: Change HashAlgoId to HashAlgId
  487 93373079b5 MdeModulePkg: Fix typos and add periods
  488 83d6207f99 BaseTools: Fixed a typo in Trim.py
  489 101dc9e257 BaseTools:Added arch output to build report
  490 8ddec24dea BaseTools:Updata the output encoding of the Popen function
  491 307e1650be BaseTools:Add extra debugging message
  492 76912197fa BaseTools:replace the chinese quotation mark with unicode =
"
  493 05f8e85fa7 ShellPkg: acpiview: IORT: Refactor PMCG node mapping count=
 validation
  494 d23bf79734 ShellPkg: acpiview: MADT: Split structure length validatio=
n
  495 748c1efd1e ShellPkg: acpiview: SRAT: Minor code style enhancements
  496 e0cf5ac693 ShellPkg: acpiview: RSDP: Make code consistent with other =
parsers
  497 eefa8f8bf2 ShellPkg: acpiview: XSDT: Remove redundant ParseAcpi() cal=
l
  498 58cc0ffe68 ShellPkg: acpiview: Allow passing buffer length to DumpGas=
Struct()
  499 d21e5dbbbf MdePkg: Add PI 1.5 SmramMemoryReserve HOB file
  500 95fb75883d MdePkg/PciExpress21.h: Fix the PCI industry standard regis=
ter defines
  501 b3d00df69c CryptoPkg/BaseCryptLib: Use cmp-operator for non-Boolean c=
omparisons
  502 3d34b5f326 ArmPkg: DebugPeCoffExtraActionLib: fix trivial comment typ=
os
  503 a6cd7fbac4 ArmPkg: DebugPeCoffExtraActionLib: debugger commands are n=
ot errors
  504 8fed4e47d9 OvmfPkg/build.sh: use newer '-drive if=3Dpflash' syntax wh=
en running qemu
  505 4634fd429e OvmfPkg/build.sh: remove $ADD_QEMU_HDA
  506 28bc699240 MdePkg/UefiDebugLibStdErr: Add destructor to CloseEvent
  507 0f4b77f5b2 MdePkg/UefiDebugLibDebugPortProtocol: Add destructor to Cl=
oseEvent
  508 e92bdcb3ec MdePkg/UefiDebugLibConOut: Add destructor to CloseEvent
  509 87ad6913b4 UefiCpuPkg/RegisterCpuFeaturesLib: Start all processors si=
multaneously.
  510 a430589cb5 UefiCpuPkg/CpuMpPei: Produce EDKII_PEI_MP_SERVICES2_PPI.
  511 ebfbb70129 UefiCpuPkg: Add new EDKII_PEI_MP_SERVICES2_PPI
  512 c06a657f4f UefiCpuPkg/MpInitLibUp: Add MpInitLibStartupAllCPUs API.
  513 ee0c39fa11 UefiCpuPkg/MpInitLib: Add MpInitLibStartupAllCPUs API.
  514 92b5a2eabc UefiCpuPkg/Include/MpInitLib.h: Add MpInitLibStartupAllCPU=
s API.
  515 d47b85a621 Revert "UefiCpuPkg/PiSmmCpu: Allow SMM access-out when sta=
tic paging is OFF"
  516 30f6148546 UefiCpuPkg/PiSmmCpu: Allow SMM access-out when static pagi=
ng is OFF
  517 520a1e60de IntelFsp2Pkg: PeiService pointer not reset to 0 in SecMain
  518 0dd8d7d556 OvmfPkg/build.sh: remove literal carriage return
  519 959791dd6c BaseTools: Sort file list in Makefile
  520 7d0a56c4a1 BaseTools: add GetMaintainer.py script
  521 83e7d5c75e OvmfPkg/build.sh: enable multitheaded build by default
  522 cf2d8d4978 edksetup.sh: remove redundant -?, -h and --help in options=
 parsing
  523 11e5fc6601 edksetup.sh: when executing arithmetic commands, $ isn't n=
eeded
  524 07d80d35ad edksetup.sh: Use $SCRIPTNAME consistently instead of 'edks=
etup.sh'
  525 80d4f9e8f9 edksetup.sh: Use bash variable $PWD instead of executing p=
wd command
  526 f6f1e0b7c2 EmbeddedPkg: list module-internal header files in INF c
  527 9e55ce6b75 CryptoPkg/BaseCryptLib: list module-internal header files =
in INF c
  528 2a0168c7c0 ArmPlatformPkg: list module-internal header files in INF c
  529 4cef711d63 ArmPkg: list module-internal header files in INF c
  530 bb824f685d BaseTools: Fixed the mis-using strip() function issue.
  531 5f89bcc460 BaseTools: Create ".cache" folder when initialize Build ob=
ject
  532 8ff68cd5e4 ShellPkg: acpiview: DBG2: Remove redundant forward declara=
tions
  533 2a219e196d ShellPkg: acpiview: GTDT: Remove redundant forward declara=
tions
  534 795e706f74 ShellPkg: acpiview: IORT: Remove redundant forward declara=
tions
  535 9cb5bcce9a ShellPkg: acpiview: MADT: Remove redundant forward declara=
tions
  536 527a36859d ShellPkg: acpiview: SRAT: Remove redundant forward declara=
tions
  537 cca8826cc0 ShellPkg: acpiview: SPCR: Remove redundant forward declara=
tion
  538 86da432af3 ShellPkg: acpiview: FADT: Remove redundant forward declara=
tions
  539 386fbe1a6b ShellPkg: acpiview: RSDP: Remove redundant forward declara=
tions
  540 ef2360569d ShellPkg/Type.c: Add value check before (LoopVar - 1)
  541 5d3ef15da7 OvmfPkg: link SM3 support into Tcg2Pei and Tcg2Dxe
  542 c027f68030 SecurityPkg: set SM3 bit in TPM 2.0 hash mask by default
  543 7c1126d394 SecurityPkg/HashLibBaseCryptoRouter: recognize the SM3 dig=
est algorithm
  544 edf6ef246d SecurityPkg: introduce the SM3 digest algorithm
  545 296c908c69 Maintainers.txt: Fine-grained review ownership for MdeModu=
lePkg
  546 2474cb0a4d Maintainers.txt: split out section "OvmfPkg: CSM modules"
  547 46b6cae1e5 Maintainers.txt: split out section "OvmfPkg: TCG- and TPM2=
-related modules"
  548 da75ac2169 Maintainers.txt: split out section "OvmfPkg: Xen-related m=
odules"
  549 0c7e86086f Maintainers.txt: split out section "ArmVirtPkg: modules us=
ed on Xen"
  550 f1a74d998d Maintainers.txt: add wildcard path association for Arm/AAr=
ch64
  551 16eb2dc159 Maintainers.txt: update for filesystem area descriptions
  552 3dafa03822 UefiCpuPkg/RegisterCpuFeaturesLib: avoid use dynamic PCD.
  553 bbd357ae57 UefiCpuPkg/RegisterCpuFeaturesLib: Avoid AP calls PeiServi=
ces table.
  554 04dd0cb972 UefiCpuPkg DxeRegisterCpuFeaturesLib: Fix VS2012 build fai=
lure
  555 cce01f538f MdePkg/BaseLib: Base64Decode(): don't declare variables in=
 nested blocks
  556 35e242b698 MdePkg/BaseLib: rewrite Base64Decode()
  557 5d68fc6781 MdePkg/BaseLib: re-specify Base64Decode(), and add tempora=
ry stub impl
  558 84a4594720 UefiCpuPkg CpuCommonFeaturesLib: Enhance Ppin code
  559 51dd408ae1 UefiCpuPkg/PiSmmCpuDxeSmm: Enable MM MP Protocol
  560 18f169a95c MdePkg: Add new MM MP Protocol definition.
  561 eebc135ffb BaseTools: Fix python3.8 SyntaxWarning
  562 70565e6422 EmulatorPkg/Unix: Convert timezone from seconds to minutes
  563 8f5b265500 EmulatorPkg/build.sh: Fix missing usage of -b BUILDTARGET =
parameter
  564 55b9bbf40a EmulatorPkg: update HOST_TOOLS to xcode5
  565 43622317c6 FmpDevicePkg: Fix various typos
  566 a79841a024 BaseTools: Add HOST_APPLICATION module type.
  567 2d100d1d73 BaseTools: Fixed the issue when ToolDefinitionFile is not =
generated
  568 c630f69df0 UefiCpuPkg/PiSmmCpu: ReclaimPages: fix incorrect operator =
binding
  569 4eee0cc7cc UefiCpuPkg/PiSmmCpu: Enable 5 level paging when CPU suppor=
ts
  570 6e5a33d1fb MdePkg/BaseLib.h: Update IA32_CR4 structure for 5-level pa=
ging
  571 deb90ac03a Revert "MdePkg/BaseLib.h: Update IA32_CR4 structure for 5-=
level paging"
  572 4e78c7bebb Revert "UefiCpuPkg/PiSmmCpu: Enable 5 level paging when CP=
U supports"
  573 f044a7d8ff Maintainers.txt: Remove maintainer info for IntelFsp[Wrapp=
er]Pkg
  574 91cc60bafc IntelFsp2Pkg: Fix various typos
  575 efa12a3f02 Revert "FmpDevicePkg: Fix various typos"
  576 7a0df266e5 UefiCpuPkg RegisterCpuFeaturesLib: Fix an ASSERTION issue
  577 28781fd52a Revert "BaseTools/BfmLib: Add a tool BfmLib"
  578 064daac0c6 Revert "BaseTools/FCE: Add a tool FCE"
  579 b9479a7f7b Revert "BaseTools/FMMT: Add a tool FMMT"
  580 60ec54afc3 Revert "BaseTools: fix FCE build when edksetup not execute=
d"
  581 661c5ed2d6 Revert "BaseTools/FMMT: Change FMMT script type in PosixLi=
ke"
  582 e8d4c5f92b Revert "BaseTools/BfmLib: Change BfmLib script type in Pos=
ixLike"
  583 226301051d Revert "BaseTools/FCE: Change FCE script type in PosixLike=
"
  584 8df52631e5 ArmPlatformPkg: Actually disable PL031 interrupts
  585 7365eb2c8c UefiCpuPkg/PiSmmCpu: Enable 5 level paging when CPU suppor=
ts
  586 7c5010c7f8 MdePkg/BaseLib.h: Update IA32_CR4 structure for 5-level pa=
ging
  587 7e56f8928d UefiCpuPkg/PiSmmCpu: Change variable names and comments to=
 follow SDM
  588 034a3b4f55 MdeModulePkg/Setup: Check ConfigAccess protocol in case it=
's destroyed
  589 688ec2d006 BaseTools: Detect the change of env variable used in toold=
ef.txt
  590 1d06b46cf1 BaseTools: Fixed the issue of the CFlag for compile PcdVal=
ueInit.c
  591 f527942e6b FmpDevicePkg: Fix various typos
  592 8a842b31b9 BaseTools/FCE: Change FCE script type in PosixLike
  593 556bf5b357 BaseTools/BfmLib: Change BfmLib script type in PosixLike
  594 2112fc71b1 BaseTools/FMMT: Change FMMT script type in PosixLike
  595 2d53d54a5b BaseTools: Fix various typos
  596 d031fc07eb BaseTools: fix FCE build when edksetup not executed
  597 0a487ef96b Maintainers.txt: Change SecurityPkg Maintainer Role
  598 6a34c1ce70 Revert "MdePkg/Protocol/Hash: introduce GUID for SM3"
  599 a9faafb156 Revert "SecurityPkg: introduce the SM3 digest algorithm"
  600 29a1a6eff7 Revert "SecurityPkg/HashLibBaseCryptoRouter: recognize the=
 SM3 digest algorithm"
  601 0d823bfd8d Revert "SecurityPkg: set SM3 bit in TPM 2.0 hash mask by d=
efault"
  602 ddc020fb0a Revert "OvmfPkg: link SM3 support into Tcg2Pei and Tcg2Dxe=
"
  603 1ec05b81e5 OvmfPkg: use DxeTpmMeasurementLib if and only if TPM2_ENAB=
LE
  604 c6a72cd794 EmbeddedPkg: Fix various typos
  605 16f3544ddd ArmPlatformPkg: Fix various typos
  606 ff5fef1428 ArmPkg: Fix various typos
  607 080981d72d BaseTools/FMMT: Add a tool FMMT
  608 3c59d94637 BaseTools/FCE: Add a tool FCE
  609 dc7b0dc8d6 BaseTools/BfmLib: Add a tool BfmLib
  610 03835a8c73 Maintainers.txt: Drop deprecated SourceForge SVN link
  611 e54ce6d074 Maintainers.txt: add Leif Lindholm as Package Reviewer of =
ArmVirtPkg
  612 a7c7d21ffa OvmfPkg: link SM3 support into Tcg2Pei and Tcg2Dxe
  613 d5af8fc5a9 SecurityPkg: set SM3 bit in TPM 2.0 hash mask by default
  614 542d04e2a4 SecurityPkg/HashLibBaseCryptoRouter: recognize the SM3 dig=
est algorithm
  615 06dd5863b6 SecurityPkg: introduce the SM3 digest algorithm
  616 49c1e683c4 MdePkg/Protocol/Hash: introduce GUID for SM3
  617 896db3a4ce Maintainers.txt: Remove information for IntelFramework[Mod=
ule]Pkg
  618 87fc0601fa Remove IntelFrameworkPkg
  619 aa7fc1c11c Remove IntelFrameworkModulePkg
  620 4286eb22f4 ShellPkg: acpiview: Make '-h' option not require a paramet=
er
  621 5ed3b5624f ShellPkg: acpiview: Remove duplicate indentation in IORT p=
arser
  622 687546ddd5 ShellPkg: acpiview: Remove '-v' flag from allowed command =
line args
  623 f17dad04ed ShellPkg: acpiview: Remove redundant IORT node types enum
  624 f73843d56d ShellPkg: acpiview: Allow disabling consistency checks (-q=
 flag)
  625 3d31443502 ShellPkg: acpiview: Make DBG2 output consistent with other=
 tables
  626 5a119220c1 ShellPkg: acpiview: Fix 'nn' printing in Table Checksum re=
porting
  627 6d9603713c ShellPkg: acpiview: Remove '/?' from valid command line fl=
ags
  628 5a27f7a237 ShellPkg: acpiview: Improve PPTT table field validation
  629 e53303ca05 EmulatorPkg/MiscSubClassPlatformDxe: Remove this unused mo=
dule
  630 21902410ad ShellPkg/UefiShellLib: Set input pointer parameter to null=
 if failure
  631 6a1f06fadb OvmfPkg/XenBusDxe: Don't call DisconnectController in Stop=
()
  632 64ef66ba8b OvmfPkg/XenBusDxe: Close XenIoProtocol openned by children
  633 be0d1c1755 MdeModulePkg SmbiosMeasurementDxe: Add Type4 Voltage field=
 to blacklist
  634 c3f0829b34 IntelFsp2Pkg: FSP Python scripts to support 3.x.
  635 2603fce126 PciBusDxe: duplicate node insertion for every PPB device i=
n the system
  636 0889500ce1 MdeModulePkg/BdsDxe: Use a pcd to control PlatformRecovery
  637 f81b738653 MdeModulePkg: Add a pcd to set the OS indications bit
  638 b7cd36a224 SecurityPkg: Remove DxeDeferImageLoadLib in DSC
  639 3974488393 BaseTools:Linux changes the way the latest version is judg=
ed
  640 aecad6c1cb Fix indentation in edksetup.sh SetupPython3
  641 adec1f5deb MdeModulePkg/SdMmcHcDxe: Implement revision 3 of SdMmcOver=
rideProtocol
  642 f56cc67f62 MdeModulePkg/SdMmcOverride: Add GetOperatingParam notify p=
hase
  643 a37e18f6fc MdeModulePkg/UfsPassThruDxe: Fix unaligned data transfer h=
andling
  644 ffe048a080 ArmVirtPkg: handle NETWORK_TLS_ENABLE in ArmVirtQemu*
  645 48fdf9a6df BaseTools:Remove unused Edk2BuildNotes2.txt
  646 6759212fa6 Edk2Setup: Support different VS tool chain setup
  647 541d6017e2 Edk2: Remove nt32 related flag in bat files
  648 d316662118 SecurityPkg/DxeDeferImageLoadLib: Remove DxeDeferImageLoad=
Lib
  649 fda8482df7 MdeModulePkg/DxeCapsuleLibFmp: Add missing NULL pointer ch=
eck.
  650 104a1aa19b BaseTools/Capsule: Supports multiple payloads and drivers =
in capsule
  651 c54c856218 UefiCpuPkg/MpInitLib: MicrocodeDetect: Ensure checked rang=
e is valid
  652 f426d8744f MdeModulePkg/UfsPassThruDxe: Refactor UFS device presence =
detection
  653 c78008b4b2 PcAtChipsetPkg: Remove framework modules
  654 8b6f0b5cd3 SecurityPkg: add FvReportPei.inf in dsc for build validati=
on
  655 3743e71a06 SecurityPkg/FvReportPei: implement a common FV verifier an=
d reporter
  656 beda3f76af SecurityPkg: add definitions for OBB verification
  657 c7341877f6 OvmfPkg: don't assign PCI BARs above 4GiB when CSM enabled
  658 4b04d9d736 OvmfPkg: Don't build in QemuVideoDxe when we have CSM
  659 16ec209a41 OvmfPkg/LegacyBbs: Add boot entries for VirtIO and NVME de=
vices
  660 0ca6250768 OvmfPkg/LegacyBios: set NumberBbsEntries to the size of Bb=
sTable
  661 2f3435c234 SecurityPkg: Add missing instances for build only
  662 846b1652d9 MdeModulePkg/CapsulePei: Add memory pointer check
  663 c1227348e3 MdeModulePkg: Add CapsuleOnDiskLoadPei PEIM.
  664 28889a7898 MdeModulePkg: Add Capsule On Disk APIs into CapsuleLib.
  665 e761d18f01 MdeModulePkg/DxeIpl: Support Capsule On Disk.
  666 4ef0b0ac8e MdeModulePkg/CapsuleRuntimeDxe: Introduce PCD to control t=
his feature.
  667 43311062a1 MdeModulePkg/BdsDxe: Support Capsule On Disk.
  668 1103ba946a MdeModulePkg: Add Capsule On Disk related definition.
  669 8165570e3e MdeModulePkg/CapsuleApp: Enhance Capsule-On-Disk related f=
unctions.
  670 51f7a3e6c5 CryptoPkg/OpensslLib: Exclude err_all.c in process_files.p=
l
  671 b8ac0b7f28 BaseTools: Move Build Cache related function out of Create=
AsBuiltInf
  672 dc174cd9e5 BaseTools: refine CreateAsBuiltInf function
  673 401507c786 BaseTools:Add DetectNotUsedItem.py to Edk2BaseToolsScripts
  674 48c921a79f Maintainers.txt: update it to remove IntelSiliconPkg maint=
ainers
  675 77ff7d6aa2 Remove IntelSiliconPkg that has been moved to edk2-platfor=
m repo
  676 370f16c548 BaseTools:Add import in FvImageSection
  677 8797683f96 MdeModulePkg/PeiMain: PeiAllocatePool: output NULL if HOB =
creation fails
  678 be5903ad1e MdeMoudlePkg/CapsulePei: No need to remain space for null-=
terminate
  679 d96f83de5e MdeMoudlePkg/CapsulePei: Optimize GetScatterGatherHeadEntr=
ies
  680 f654a18b66 MdeMoudlePkg/CapsulePei: Optimize AreCapsulesStaged
  681 0c52961538 MdeMoudlePkg/CapsulePei: Fix coding style issue
  682 27052c21c4 MdeModulePkg/CapsulePei: Optimize the CapsulePei
  683 ba3aa1c4e7 MdeModulePkg/NvmExpressPei: Produce NVM Express PassThru P=
PI
  684 4128d8a8cb MdeModulePkg: Add definitions for NVM Express Passthru PPI
  685 719a684d7d UefiPayloadPkg: Remove legacy PIC 8259 driver
  686 b86fbe1f98 CryptoPkg/OpensslLib: disable autoload-config for OpenSSL
  687 90e8f13d51 CryptoPkg/OpensslLib: Fix CR/LF issue
  688 57ec204e69 Revert "Capsule-on-Disk entire Patch
  689 425d8d487f MdePkg: Add Generic Initiator Affinity Structure definitio=
ns to SRAT
  690 f17935321a MdeModulePkg: Add CapsuleOnDiskLoadPei PEIM.
  691 8636f70b5a MdeModulePkg: Add Capsule On Disk APIs into CapsuleLib.
  692 6b32af2e10 MdeModulePkg/DxeIpl: Support Capsule On Disk.
  693 7837d12498 MdeModulePkg/CapsuleRuntimeDxe: Introduce PCD to control t=
his feature.
  694 fd72860895 MdeModulePkg/BdsDxe: Support Capsule On Disk.
  695 6470a43160 MdeModulePkg/CapsuleApp: Enhance Capsule-On-Disk related f=
unctions.
  696 0d4aa276d1 MdeModulePkg: Add Capsule On Disk related definition.
  697 4c12dcace9 IntelFsp2Pkg: add TempRamExitPpi.h.
  698 8a08dc5486 ShellPkg: acpiview: ACPI 6.3 update for MADT parser
  699 1d7571166f EmbeddedPkg: improve TimeBaseLib type safety
  700 7c974d6b6e ArmPlatformPkg: use UINT32 epoch second counter
  701 2378ea5515 BaseTools:Introduce CopyFileOnChange() function to copy ca=
che files
  702 17b082ce67 BaseTools: Cannot store library cache of different arch to=
gether
  703 04df18535c BaseTools:Build Cache output notification message
  704 ede54e3588 BaseTools:Build cache cannot store the cache files for lib=
rary package
  705 84f736a73e OvmfPkg: Refer to Shell app via its declared GUID
  706 ae71eae151 OvmfPkg/Csm/CsmSupportLib: Drop IntelFrameworkPkg dependen=
cy
  707 0ec400a540 OvmfPkg/IncompatiblePciDeviceSupportDxe: Drop framework pk=
g dependency
  708 0e0a6a2e64 OvmfPkg/PlatformPei: Remove redundant reference of framewo=
rk pkg DEC
  709 6764fb9cd8 MdeModulePkg: Add missing instances for build only
  710 34857c2ff9 SourceLevelDebugPkg: Add missing instances for build only
  711 a860eb9668 CryptoPkg: Add missing instance for build only
  712 fec63bb922 UefiPayloadPkg/PlatformBootManagerLib: Use EDKII_SERIAL_PO=
RT_LIB_VENDOR_GUID from MdeModulePkg
  713 6631c096ee ArmPkg/PlatformBootManagerLib: Use EDKII_SERIAL_PORT_LIB_V=
ENDOR_GUID from MdeModulePkg
  714 4ff31c083e ArmVirtPkg/PlatformBootManagerLib: Use EDKII_SERIAL_PORT_L=
IB_VENDOR_GUID
  715 cf78c9d18a MdeModulePkg: Introduce EDKII_SERIAL_PORT_LIB_VENDOR_GUID
  716 b0663641c9 OvmfPkg/Csm/LegacyBiosDxe: Fix Legacy16GetTableAddress cal=
l for E820 data
  717 3207a872a4 OvmfPkg: Update DSC/FDF files to consume CSM components in=
 OvmfPkg
  718 f3ddffe9d8 OvmfPkg/Csm/LegacyBootManagerLib: Update to make it build =
for OVMF
  719 62508ba72e OvmfPkg/Csm/LegacyBootMaintUiLib: Update to make it build =
for OVMF
  720 e794eb7ba2 OvmfPkg/Csm/LegacyBiosDxe: Update to make it build for OVM=
F
  721 84e0e1674a OvmfPkg/Csm/VideoDxe: Update to make it build for OVMF
  722 51e55d8162 OvmfPkg/OvmfPkg.dec: Add PCD definitions used by copied CS=
M modules
  723 eb7cad3f4a OvmfPkg/OvmfPkg.dec: Add the new include folder for CSM he=
ader files
  724 17c5832074 OvmfPkg/OvmfPkg.dec: Add definitions for CSM-related Guid =
& Protocol
  725 b522c77bdb OvmfPkg: Copy the required CSM components from framework p=
ackages
  726 bb4485d388 Maintainers.txt: Add maintainer for CSM components in Ovmf=
Pkg
  727 0a35997643 MdeModulePkg/GraphicsConsoleDxe: Initialize the output mod=
e
  728 297495f410 MdeModulePkg/ConSplitterDxe: Optimize the ConSplitterTextO=
utSetMode
  729 e85cfa2fa4 UefiCpuPkg RegisterCpuFeaturesLib.h: Fix typo 'STRICK' to =
'STRIKE'
  730 fc7d997c35 ShellPkg/Debug1CommandsLib: Fix bugs in func DisplaySysEve=
ntLogData
  731 4eb0acb1e2 BaseTools: add script to configure local git options
  732 5b3e695d8a BaseTools: add centralized location for git config files
  733 9e2416ae2e SecurityPkg/HddPassword: Add a PCD to skip Hdd password pr=
ompt
  734 e5b4d825af MdeModulePkg/PciBusDxe: catch unimplemented extended confi=
g space reads
  735 1631bb26ae OvmfPkg/README: Update the network build flags
  736 470626624f DynamicTablesPkg: Disable deprecated APIs
  737 5d86a5fa76 DynamicTablesPkg: Fix line endings in dsc file
  738 1a48fda531 IntelFspPkg&IntelFspWrapperPkg: Remove them
  739 e8015f2fac DynamicTablesPkg: GTDT updates for ACPI 6.3
  740 77db115601 DynamicTablesPkg: Add dynamic PPTT table generation suppor=
t
  741 8349b86836 IntelFsp2Pkg/SplitFspBin.py: Support rebasing 1.x binary.
  742 4266624341 Maintainers.txt: Remove Yonghong from BaseTools Reviewer
  743 5626887071 OvmfPkg: Drop build flag USE_LEGACY_ISA_STACK and legacy I=
SA stack
  744 5506701f79 DynamicTablesPkg: Add ACPI 6.3 SPE support to MADT generat=
or
  745 ccc97f6df4 DynamicTablesPkg: Test for duplicate GT Block frame number=
s
  746 28b824d707 DynamicTablesPkg: Test for duplicate UIDs in MADT generato=
r
  747 c1b53091f6 DynamicTablesPkg: Add code for finding duplicate values in=
 arrays
  748 75bf10a689 DynamicTablesPkg: Add frame number validation to GTDT gene=
rator
  749 98f98eb440 ShellPkg/acpiview: GTDT updates for ACPI 6.3
  750 48b0bf6476 BaseTools: Refactor hash tracking after checking for Sourc=
es section
  751 1fa6699e6c BaseTools: Add a checking for Sources section in INF file
  752 04797875d1 BaseTools:Make BaseTools support new rules to generate RAW=
 FFS FILE
  753 6cbed0e36f SecurityPkg/OpalPassword: Add PCD to skip password prompt
  754 9fc1b85fd1 UefiCpuPkg/MpInitLib: Decrease NumApsExecuting only for Ap=
InitConfig
  755 5b9b0a8da6 UefiCpuPkg/MpInitLib: increase NumApsExecuting only for Ap=
InitConfig
  756 f0718d1d6b CryptoPkg/BaseCryptLib: Wrap OpenSSL SM3 algorithm
  757 fe0c2770a7 UefiCpuPkg CpuCommFeaturesLib: Reduce to set MSR_IA32_CLOC=
K_MODULATION
  758 de2204a9e8 UefiCpuPkg CpuCommFeaturesLib: Fix ASSERT if LMCE is suppo=
rted
  759 49fb605709 UefiCpuPkg CpuCommFeaturesLib: Fix GP fault issue about Pr=
ocTrace
  760 484dc05005 UefiCpuPkg CpuCommFeaturesLib: Disable TraceEn at the begi=
nning
  761 3147da2635 EmbeddedPkg/PrePiLib: remove dead status code reporting co=
de
  762 662bd0da7f OvmfPkg/QemuVideoDxe: Shouldn't assume system in VGA alias=
 mode.

Cc: qemu-stable@nongnu.org
Ref: https://bugs.launchpad.net/qemu/+bug/1852196
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 roms/edk2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/roms/edk2 b/roms/edk2
index 20d2e5a125..bd85bf54c2 160000
--- a/roms/edk2
+++ b/roms/edk2
@@ -1 +1 @@
-Subproject commit 20d2e5a125e34fc8501026613a71549b2a1a3e54
+Subproject commit bd85bf54c268204c7a698a96f3ccd96cd77952cd
--=20
2.21.0


