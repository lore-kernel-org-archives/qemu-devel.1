Received: from eggs.gnu.org ([2001:4830:134:3::10]:58877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eqFR7-0005oP-85
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eqFR4-0005DN-60
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:51:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42676 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eqFR4-0005D5-0e
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:51:06 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-6-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <53a8a301-0719-aca9-7b4c-90df90ccfda0@redhat.com>
Date: Mon, 26 Feb 2018 10:50:49 +0100
MIME-Version: 1.0
In-Reply-To: <20180223132311.26555-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 5/7] ovmf: link with Tcg2Dxe module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> This module measures and log the boot environment. It also produces
> the Tcg2 protocol, which allows for example to read the log from OS:
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
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgX64.dsc | 15 +++++++++++++++
>  OvmfPkg/OvmfPkgX64.fdf |  4 ++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index 34a7c2778e..9bd0709f98 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -213,6 +213,8 @@
>  !if $(TPM2_ENABLE) =3D=3D TRUE
>    Tpm12CommandLib|SecurityPkg/Library/Tpm12CommandLib/Tpm12CommandLib.=
inf
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> +  Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
> +  Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
>  !endif
> =20
>  [LibraryClasses.common]

I'd prefer to review this part in v2, once the @@ hunk headers are set
up at your end ("xfuncname").

> @@ -364,6 +366,11 @@
>    PciLib|OvmfPkg/Library/DxePciLibI440FxQ35/DxePciLibI440FxQ35.inf
>    MpInitLib|UefiCpuPkg/Library/MpInitLib/DxeMpInitLib.inf
>    QemuFwCfgS3Lib|OvmfPkg/Library/QemuFwCfgS3Lib/DxeQemuFwCfgS3LibFwCfg=
.inf
> +!if $(TPM2_ENABLE)
> +  HashLib|SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCrypt=
oRouterDxe.inf
> +  Tpm12DeviceLib|SecurityPkg/Library/Tpm12DeviceLibTcg/Tpm12DeviceLibT=
cg.inf

Can we drop TPM12? "Tcg2Dxe.inf" does not seem to depend on this lib clas=
s.

> +  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibTcg2/Tpm2DeviceLibTcg=
2.inf
> +!endif
> =20
>  [LibraryClasses.common.UEFI_APPLICATION]
>    PcdLib|MdePkg/Library/DxePcdLib/DxePcdLib.inf
> @@ -654,6 +661,14 @@
>        NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1=
.inf
>        NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSh=
a256.inf
>    }
> +
> +  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf {
> +    <LibraryClasses>
> +      Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibRouter/Tpm2Device=
LibRouterDxe.inf

Can you please explain why Tpm2DeviceLib has to be resolved differently
for DXE_DRIVER modules in general (see above) and for "Tcg2Dxe.inf"
specifically?

Hmmm... Looks like "Tpm2DeviceLibTcg2.inf" implements the APIs via the
TPM2 protocol. Whereas "Tcg2Dxe.inf" itself provides that protocol, so
obviously it cannot rely on the protocol; it has to access the device,
which is done with the help of "Tpm2DeviceLibRouterDxe.inf" and the
"Tpm2InstanceLibDTpm.inf" that is plugged in via NULL resolution below.
Is that about correct?

If so, can you please document it in the commit message?

> +      NULL|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2InstanceLibDTpm.i=
nf
> +      NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1=
.inf

Again -- is SHA1 required?

> +      NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSh=
a256.inf
> +  }
>  !endif
> =20
>  !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
> index 9558142a42..b8dd7ecae4 100644
> --- a/OvmfPkg/OvmfPkgX64.fdf
> +++ b/OvmfPkg/OvmfPkgX64.fdf
> @@ -397,6 +397,10 @@ INF  MdeModulePkg/Universal/FaultTolerantWriteDxe/=
FaultTolerantWriteDxe.inf
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

Thanks!
Laszlo
