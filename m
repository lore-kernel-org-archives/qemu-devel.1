Received: from eggs.gnu.org ([2001:4830:134:3::10]:40513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euL9O-0006jy-MU
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euL9K-0002a7-Mi
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:45:46 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euL9K-0002ZQ-HB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:45:42 -0500
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
	<20180309130918.734-7-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <2e0b75a8-e23b-7807-7765-3323b715244e@redhat.com>
Date: Fri, 9 Mar 2018 17:45:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180309130918.734-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] OvmfPkg: include Tcg2Dxe module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, javierm@redhat.com

On 03/09/18 14:09, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> This module measures and log the boot environment. It also produces
> the Tcg2 protocol, which allows for example to read the log from OS.
>=20
> The linux kernel doesn't yet read the EFI_TCG2_EVENT_LOG_FORMAT_TCG_2,
> which is required for crypto-agile log. In fact, only upcoming 4.16
> adds support EFI_TCG2_EVENT_LOG_FORMAT_TCG_1_2:
>=20
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi:  SMBIOS=3D0x3fa1f000  ACPI=3D0x3fbb6000  ACPI 2.0=3D=
0x3fbb6014  MEMATTR=3D0x3e7d4318  TPMEventLog=3D0x3db21018
>=20
> $ python chipsec_util.py tpm parse_log binary_bios_measurements
>=20
> [CHIPSEC] Version 1.3.5.dev2
> [CHIPSEC] API mode: using OS native API (not using CHIPSEC kernel modul=
e)
> [CHIPSEC] Executing command 'tpm' with args ['parse_log', '/tmp/binary_=
bios_measurements']
>=20
> PCR: 0	type: EV_S_CRTM_VERSION               	size: 0x2	digest: 1489f92=
3c4dca729178b3e3233458550d8dddf29
> 	+ version:
> PCR: 0	type: EV_EFI_PLATFORM_FIRMWARE_BLOB   	size: 0x10	digest: fd39ce=
d7c0d2a61f6830c78c7625f94826b05bcc
> 	+ base: 0x820000	length: 0xe0000
> PCR: 0	type: EV_EFI_PLATFORM_FIRMWARE_BLOB   	size: 0x10	digest: 39ebc6=
783b72bc1e73c7d5bcfeb5f54a3f105d4c
> 	+ base: 0x900000	length: 0xa00000
> PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x35	digest: 57cd4d=
c19442475aa82743484f3b1caa88e142b8
> PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x24	digest: 9b1387=
306ebb7ff8e795e7be77563666bbf4516e
> PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x26	digest: 9afa86=
c507419b8570c62167cb9486d9fc809758
> PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x24	digest: 5bf8fa=
a078d40ffbd03317c93398b01229a0e1e0
> PCR: 7	type: EV_EFI_VARIABLE_DRIVER_CONFIG   	size: 0x26	digest: 734424=
c9fe8fc71716c42096f4b74c88733b175e
> PCR: 7	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca7=
8e7450a285173431b3e52c5c25299e473
> PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x3e	digest: 252f8e=
bb85340290b64f4b06a001742be8e5cab6
> PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x6e	digest: 22a4f6=
ee9af6dba01d3528deb64b74b582fc182b
> PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x80	digest: b7811d=
5bf30a7efd4e385c6179fe10d9290bb9e8
> PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x84	digest: 425e50=
2c24fc924e231e0a62327b6b7d1f704573
> PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x9a	digest: 0b5d2c=
98ac5de6148a4a1490ff9d5df69039f04e
> PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0xbd	digest: 20bd5f=
402271d57a88ea314fe35c1705956b1f74
> PCR: 1	type: EV_EFI_VARIABLE_BOOT            	size: 0x88	digest: df5d66=
05cb8f4366d745a8464cfb26c1efdc305c
> PCR: 4	type: EV_EFI_ACTION                   	size: 0x28	digest: cd0fdb=
4531a6ec41be2753ba042637d6e5f7f256
> PCR: 0	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca7=
8e7450a285173431b3e52c5c25299e473
> PCR: 1	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca7=
8e7450a285173431b3e52c5c25299e473
> PCR: 2	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca7=
8e7450a285173431b3e52c5c25299e473
> PCR: 3	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca7=
8e7450a285173431b3e52c5c25299e473
> PCR: 4	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca7=
8e7450a285173431b3e52c5c25299e473
> PCR: 5	type: EV_SEPARATOR                    	size: 0x4	digest: 9069ca7=
8e7450a285173431b3e52c5c25299e473
>=20
> $ tpm2_pcrlist
> sha1 :
>   0  : 35bd1786b6909daad610d7598b1d620352d33b8a
>   1  : ec0511e860206e0af13c31da2f9e943fb6ca353d
>   2  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
>   3  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
>   4  : 45a323382bd933f08e7f0e256bc8249e4095b1ec
>   5  : d16d7e629fd8d08ca256f9ad3a3a1587c9e6cc1b
>   6  : b2a83b0ebf2f8374299a5b2bdfc31ea955ad7236
>   7  : 518bd167271fbb64589c61e43d8c0165861431d8
>   8  : 0000000000000000000000000000000000000000
>   9  : 0000000000000000000000000000000000000000
>   10 : 0000000000000000000000000000000000000000
>   11 : 0000000000000000000000000000000000000000
>   12 : 0000000000000000000000000000000000000000
>   13 : 0000000000000000000000000000000000000000
>   14 : 0000000000000000000000000000000000000000
>   15 : 0000000000000000000000000000000000000000
>   16 : 0000000000000000000000000000000000000000
>   17 : ffffffffffffffffffffffffffffffffffffffff
>   18 : ffffffffffffffffffffffffffffffffffffffff
>   19 : ffffffffffffffffffffffffffffffffffffffff
>   20 : ffffffffffffffffffffffffffffffffffffffff
>   21 : ffffffffffffffffffffffffffffffffffffffff
>   22 : ffffffffffffffffffffffffffffffffffffffff
>   23 : 0000000000000000000000000000000000000000
> sha256 :
>   0  : 9ae903dbae3357ac00d223660bac19ea5c021499a56201104332ab966631ce2c
>   1  : acc611d90245cf04e77b0ca94901f90e7fa54770f0426f53c3049b532243d1b8
>   2  : 3d458cfe55cc03ea1f443f1562beec8df51c75e14a9fcf9a7234a13f198e7969
>   3  : 3d458cfe55cc03ea1f443f1562beec8df51c75e14a9fcf9a7234a13f198e7969
>   4  : 7a94ffe8a7729a566d3d3c577fcb4b6b1e671f31540375f80eae6382ab785e35
>   5  : a5ceb755d043f32431d63e39f5161464620a3437280494b5850dc1b47cc074e0
>   6  : 3d458cfe55cc03ea1f443f1562beec8df51c75e14a9fcf9a7234a13f198e7969
>   7  : 65caf8dd1e0ea7a6347b635d2b379c93b9a1351edc2afc3ecda700e534eb3068
>   8  : 0000000000000000000000000000000000000000000000000000000000000000
>   9  : 0000000000000000000000000000000000000000000000000000000000000000
>   10 : 0000000000000000000000000000000000000000000000000000000000000000
>   11 : 0000000000000000000000000000000000000000000000000000000000000000
>   12 : 0000000000000000000000000000000000000000000000000000000000000000
>   13 : 0000000000000000000000000000000000000000000000000000000000000000
>   14 : 0000000000000000000000000000000000000000000000000000000000000000
>   15 : 0000000000000000000000000000000000000000000000000000000000000000
>   16 : 0000000000000000000000000000000000000000000000000000000000000000
>   17 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
>   18 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
>   19 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
>   20 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
>   21 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
>   22 : ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
>   23 : 0000000000000000000000000000000000000000000000000000000000000000
> sha384 :
>=20
> The PhysicalPresenceLib is required, it sets some variables, but the
> firmware doesn't act on it yet.
>=20
> Laszlo Ersek explained on the list why Tpm2DeviceLib has to be
> resolved differently for DXE_DRIVER modules in general and for
> "Tcg2Dxe.inf" specifically:
>=20
>   * We have a library class called Tpm2DeviceLib -- this is basically t=
he
>   set of APIs declared in "SecurityPkg/Include/Library/Tpm2DeviceLib.h"=
.
>   Its leading comment says "This library abstract how to access TPM2
>   hardware device".
>=20
>   There are two *sets* of APIs in "Tpm2DeviceLib.h":
>=20
>   (a) functions that deal with the TPM2 device:
>       - Tpm2RequestUseTpm(),
>       - Tpm2SubmitCommand()
>=20
>       This set of APIs is supposed to be used by clients that *consume*
>       the TPM2 device abstraction.
>=20
>   (b) the function Tpm2RegisterTpm2DeviceLib(), which is supposed to be
>       used by *providers* of various TPM2 device abstractions.
>=20
>   * Then, we have two implementations (instances) of the Tpm2DeviceLib =
class:
>   (1) SecurityPkg/Library/Tpm2DeviceLibTcg2/Tpm2DeviceLibTcg2.inf
>   (2) SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2DeviceLibRouterDxe.in=
f
>=20
>   (1) The first library instance ("Tpm2DeviceLibTcg2.inf") implements t=
he
>   APIs listed under (a), and it does not implement (b) -- see
>   EFI_UNSUPPORTED. In other words, this lib instance is strictly meant =
for
>   drivers that *consume* the TPM2 device abstraction. And, the (a) grou=
p
>   of APIs is implemented by forwarding the requests to the TCG2 protoco=
l.
>=20
>   The idea here is that all the drivers that consume the TPM2 abstracti=
on
>   do not have to be statically linked with a large TPM2 device library
>   instance; instead they are only linked (statically) with this "thin"
>   library instance, and all the actual work is delegated to whichever
>   driver that provides the singleton TCG2 protocol.
>=20
>   (2) The second library instance ("Tpm2DeviceLibRouterDxe.inf") is mea=
nt
>   for the driver that offers (produces) the TCG2 protocol. This lib
>   instance implements both (a) and (b) API groups.
>=20
>   * Here's how things fit together:
>=20
>   (i) The "SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm.in=
f"
>   library instance (which has no lib class) is linked into "Tcg2Dxe.inf=
"
>   via NULL class resolution. This simply means that before the
>   "Tcg2Dxe.inf" entry point function is entered, the constructor functi=
on
>   of "Tpm2InstanceLibDTpm.inf" will be called.
>=20
>   (ii) This Tpm2InstanceLibDTpmConstructor() function calls API (b), an=
d
>   registers its own actual TPM2 command implementation with the
>   "Tpm2DeviceLibRouter" library instance (also linked into the Tcg2Dxe
>   driver). This provides the back-end for the API set (a).
>=20
>          TCG2 protocol provider (Tcg2Dxe.inf driver) launches
>                       |
>                       v
>     NULL class: Tpm2InstanceLibDTpm instance construction
>                       |
>                       v
>     Tpm2DeviceLib class: Tpm2DeviceLibRouter instance
>            backend registration for API set (a)
>=20
>   (iii) The Tcg2Dxe driver exposes the TCG2 protocol.
>=20
>   (iv) A TPM2 consumer calls API set (a) via lib instance (1). Such cal=
ls
>   land in Tcg2Dxe, via the protocol.
>=20
>   (v) Tcg2Dxe serves the protocol request by forwarding it to API set (=
a)
>   from lib instance (2).
>=20
>   (vi) Those functions call the "backend" functions registered by
>   Tpm2DeviceLibDTpm in step (ii).
>=20
>        TPM 2 consumer driver
>                 |
>                 v
>   Tpm2DeviceLib class: Tpm2DeviceLibTcg2 instance
>                 |
>                 v
>          TCG2 protocol interface
>                 |
>                 v
>   TCG2 protocol provider: Tcg2Dxe.inf driver
>                 |
>                 v
>   Tpm2DeviceLib class: Tpm2DeviceLibRouter instance
>                 |
>                 v
>      NULL class: Tpm2InstanceLibDTpm instance
>         (via earlier registration)
>                 |
>                 v
>        TPM2 chip (actual hardware)
>=20
>   * So that is the "router" pattern in edk2. Namely,
>=20
>   - Consumers of an abstraction use a thin library instance.
>=20
>   - The thin library instance calls a firmware-global (singleton) servi=
ce,
>     i.e. a PPI (in the PEI phase) or protocol (in the DXE phase).
>=20
>   - The PEIM providing the PPI, or the DXE driver providing the protoco=
l,
>     don't themselves implement the actual service either. Instead they
>     offer a "registration" service too, and they only connect the incom=
ing
>     "consumer" calls to the earlier registered back-end(s).
>=20
>   - The "registration service", for back-ends to use, may take various
>     forms.
>=20
>     It can be exposed globally to the rest of the firmware, as
>     another member function of the PPI / protocol structure. Then backe=
nds
>     can be provided by separate PEIMs / DXE drivers.
>=20
>     Or else, the registration service can be exposed as just another
>     library API. In this case, the backends are provided as NULL class
>     library instances, and a platform  DSC file links them into the PEI=
M /
>     DXE driver via NULL class resolutions. The backend lib instances ca=
ll
>     the registration service in their own respective constructor
>     functions.
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgIa32.dsc    | 16 ++++++++++++++++
>  OvmfPkg/OvmfPkgIa32.fdf    |  4 ++++
>  OvmfPkg/OvmfPkgIa32X64.dsc | 16 ++++++++++++++++
>  OvmfPkg/OvmfPkgIa32X64.fdf |  4 ++++
>  OvmfPkg/OvmfPkgX64.dsc     | 16 ++++++++++++++++
>  OvmfPkg/OvmfPkgX64.fdf     |  4 ++++
>  6 files changed, 60 insertions(+)
>=20
> diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
> index 05ad5cf3754e..f80fb50d4a38 100644
> --- a/OvmfPkg/OvmfPkgIa32.dsc
> +++ b/OvmfPkg/OvmfPkgIa32.dsc
> @@ -206,6 +206,8 @@ [LibraryClasses]
> =20
>  !if $(TPM2_ENABLE) =3D=3D TRUE
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> +  Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
> +  Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
>  !endif
> =20
>  [LibraryClasses.common]
> @@ -356,6 +358,9 @@ [LibraryClasses.common.DXE_DRIVER]
>    PciLib|OvmfPkg/Library/DxePciLibI440FxQ35/DxePciLibI440FxQ35.inf
>    MpInitLib|UefiCpuPkg/Library/MpInitLib/DxeMpInitLib.inf
>    QemuFwCfgS3Lib|OvmfPkg/Library/QemuFwCfgS3Lib/DxeQemuFwCfgS3LibFwCfg=
.inf
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibTcg2/Tpm2DeviceLibTcg=
2.inf
> +!endif
> =20
>  [LibraryClasses.common.UEFI_APPLICATION]
>    PcdLib|MdePkg/Library/DxePcdLib/DxePcdLib.inf
> @@ -901,3 +906,14 @@ [Components]
>        NULL|MdeModulePkg/Library/VarCheckUefiLib/VarCheckUefiLib.inf
>    }
>  !endif
> +
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf {
> +    <LibraryClasses>
> +      Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2Device=
LibRouterDxe.inf
> +      NULL|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm.i=
nf
> +      HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseC=
ryptoRouterDxe.inf
> +      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1=
.inf
> +      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSh=
a256.inf
> +  }
> +!endif
> diff --git a/OvmfPkg/OvmfPkgIa32.fdf b/OvmfPkg/OvmfPkgIa32.fdf
> index e9e8611d4cd9..938bf7195ec4 100644
> --- a/OvmfPkg/OvmfPkgIa32.fdf
> +++ b/OvmfPkg/OvmfPkgIa32.fdf
> @@ -385,6 +385,10 @@ [FV.DXEFV]
>  INF  MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf
>  !endif
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +INF  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
> +!endif
> +
>  ######################################################################=
##########
> =20
>  [FV.FVMAIN_COMPACT]
> diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
> index 9a095c3ed88d..bc48b5b63c7a 100644
> --- a/OvmfPkg/OvmfPkgIa32X64.dsc
> +++ b/OvmfPkg/OvmfPkgIa32X64.dsc
> @@ -211,6 +211,8 @@ [LibraryClasses]
> =20
>  !if $(TPM2_ENABLE) =3D=3D TRUE
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> +  Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
> +  Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
>  !endif
> =20
>  [LibraryClasses.common]
> @@ -361,6 +363,9 @@ [LibraryClasses.common.DXE_DRIVER]
>    PciLib|OvmfPkg/Library/DxePciLibI440FxQ35/DxePciLibI440FxQ35.inf
>    MpInitLib|UefiCpuPkg/Library/MpInitLib/DxeMpInitLib.inf
>    QemuFwCfgS3Lib|OvmfPkg/Library/QemuFwCfgS3Lib/DxeQemuFwCfgS3LibFwCfg=
.inf
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibTcg2/Tpm2DeviceLibTcg=
2.inf
> +!endif
> =20
>  [LibraryClasses.common.UEFI_APPLICATION]
>    PcdLib|MdePkg/Library/DxePcdLib/DxePcdLib.inf
> @@ -911,3 +916,14 @@ [Components.X64]
>        NULL|MdeModulePkg/Library/VarCheckUefiLib/VarCheckUefiLib.inf
>    }
>  !endif
> +
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf {
> +    <LibraryClasses>
> +      Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2Device=
LibRouterDxe.inf
> +      NULL|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm.i=
nf
> +      HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseC=
ryptoRouterDxe.inf
> +      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1=
.inf
> +      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSh=
a256.inf
> +  }
> +!endif
> diff --git a/OvmfPkg/OvmfPkgIa32X64.fdf b/OvmfPkg/OvmfPkgIa32X64.fdf
> index e2a370ce22c5..246e1dc8278a 100644
> --- a/OvmfPkg/OvmfPkgIa32X64.fdf
> +++ b/OvmfPkg/OvmfPkgIa32X64.fdf
> @@ -392,6 +392,10 @@ [FV.DXEFV]
>  INF  MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf
>  !endif
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +INF  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
> +!endif
> +
>  ######################################################################=
##########
> =20
>  [FV.FVMAIN_COMPACT]
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index 861320e9c1f4..e89de093d6a2 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -211,6 +211,8 @@ [LibraryClasses]
> =20
>  !if $(TPM2_ENABLE) =3D=3D TRUE
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> +  Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
> +  Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
>  !endif
> =20
>  [LibraryClasses.common]
> @@ -361,6 +363,9 @@ [LibraryClasses.common.DXE_DRIVER]
>    PciLib|OvmfPkg/Library/DxePciLibI440FxQ35/DxePciLibI440FxQ35.inf
>    MpInitLib|UefiCpuPkg/Library/MpInitLib/DxeMpInitLib.inf
>    QemuFwCfgS3Lib|OvmfPkg/Library/QemuFwCfgS3Lib/DxeQemuFwCfgS3LibFwCfg=
.inf
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibTcg2/Tpm2DeviceLibTcg=
2.inf
> +!endif
> =20
>  [LibraryClasses.common.UEFI_APPLICATION]
>    PcdLib|MdePkg/Library/DxePcdLib/DxePcdLib.inf
> @@ -909,3 +914,14 @@ [Components]
>        NULL|MdeModulePkg/Library/VarCheckUefiLib/VarCheckUefiLib.inf
>    }
>  !endif
> +
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf {
> +    <LibraryClasses>
> +      Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2Device=
LibRouterDxe.inf
> +      NULL|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm.i=
nf
> +      HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseC=
ryptoRouterDxe.inf
> +      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1=
.inf
> +      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSh=
a256.inf
> +  }
> +!endif
> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
> index c0173e7adf5f..1a46104fc63d 100644
> --- a/OvmfPkg/OvmfPkgX64.fdf
> +++ b/OvmfPkg/OvmfPkgX64.fdf
> @@ -392,6 +392,10 @@ [FV.DXEFV]
>  INF  MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf
>  !endif
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +INF  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
> +!endif
> +
>  ######################################################################=
##########
> =20
>  [FV.FVMAIN_COMPACT]
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
