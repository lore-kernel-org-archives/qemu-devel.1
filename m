Received: from eggs.gnu.org ([2001:4830:134:3::10]:42292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1etyVx-0003S5-8A
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1etyVu-0007Ec-2p
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:35:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1etyVt-0007E6-Sg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:35:29 -0500
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-5-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6bae8e57-2ba5-d870-9220-38c30c350978@redhat.com>
Date: Thu, 8 Mar 2018 17:35:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180307155746.18526-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 4/8] ovmf: simplify
 SecurityStubDxe.inf inclusion
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

On 03/07/18 16:57, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> SecurityStubDxe.inf should be included unconditionally.
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Contributed-under: TianoCore Contribution Agreement 1.1
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgIa32.dsc    | 6 ++----
>  OvmfPkg/OvmfPkgIa32X64.dsc | 6 ++----
>  OvmfPkg/OvmfPkgX64.dsc     | 6 ++----
>  3 files changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
> index fbe0f790e431..5bd3f4f977df 100644
> --- a/OvmfPkg/OvmfPkgIa32.dsc
> +++ b/OvmfPkg/OvmfPkgIa32.dsc
> @@ -611,14 +611,12 @@ [Components]
> =20
>    MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
> =20
> -!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>    MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
>      <LibraryClasses>
> +!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>        NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerific=
ationLib.inf
> -	}
> -!else
> -  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
>  !endif
> +  }
> =20
>    MdeModulePkg/Universal/EbcDxe/EbcDxe.inf
>    PcAtChipsetPkg/8259InterruptControllerDxe/8259.inf
> diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
> index fb10e0b0f2e4..7dded86c4940 100644
> --- a/OvmfPkg/OvmfPkgIa32X64.dsc
> +++ b/OvmfPkg/OvmfPkgIa32X64.dsc
> @@ -620,14 +620,12 @@ [Components.X64]
> =20
>    MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
> =20
> -!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>    MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
>      <LibraryClasses>
> +!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>        NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerific=
ationLib.inf
> -	}
> -!else
> -  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
>  !endif
> +  }
> =20
>    MdeModulePkg/Universal/EbcDxe/EbcDxe.inf
>    PcAtChipsetPkg/8259InterruptControllerDxe/8259.inf
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index a31551f5ae24..a8e89276c0b2 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -618,14 +618,12 @@ [Components]
> =20
>    MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
> =20
> -!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>    MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
>      <LibraryClasses>
> +!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>        NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerific=
ationLib.inf
> -	}
> -!else
> -  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
>  !endif
> +  }
> =20
>    MdeModulePkg/Universal/EbcDxe/EbcDxe.inf
>    PcAtChipsetPkg/8259InterruptControllerDxe/8259.inf
>=20

Please change the subject as follows:

OvmfPkg: simplify SecurityStubDxe.inf inclusion

With that update:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
