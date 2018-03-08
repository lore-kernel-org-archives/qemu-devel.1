Received: from eggs.gnu.org ([2001:4830:134:3::10]:45448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ettuR-00023d-Tp
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:40:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ettuO-00047F-RM
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:40:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55380 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ettuO-000479-Mg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:40:28 -0500
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-2-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5962657b-3609-b361-03be-30f474722de1@redhat.com>
Date: Thu, 8 Mar 2018 12:40:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180307155746.18526-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 1/8] SecurityPkg: also clear
 HashInterfaceHob.SupportedHashMask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com, Star Zeng <star.zeng@intel.com>, Chao Zhang <chao.b.zhang@intel.com>

On 03/07/18 16:57, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Commit 4cc2b63bd829426b05bad0d8952f1855a10d6ed7 fixed an out of bounds
> ZeroMem() call. However, as Laszlo Ersek pointed out, the intent was
> to clear all but the Identifier (to revert the effect of
> RegisterHashInterfaceLib()). For that, it should clear the
> SupportedHashMask too.
>=20
> Cc: Jiewen Yao <jiewen.yao@intel.com>
> Cc: Chao Zhang <chao.b.zhang@intel.com>
> Cc: Star Zeng <star.zeng@intel.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Contributed-under: TianoCore Contribution Agreement 1.1
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  .../Library/HashLibBaseCryptoRouter/HashLibBaseCryptoRouterPei.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCry=
ptoRouterPei.c b/SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseC=
ryptoRouterPei.c
> index 361a4f6508a0..bf6e1336ee76 100644
> --- a/SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCryptoRout=
erPei.c
> +++ b/SecurityPkg/Library/HashLibBaseCryptoRouter/HashLibBaseCryptoRout=
erPei.c
> @@ -426,6 +426,7 @@ HashLibBaseCryptoRouterPeiConstructor (
>      //
>      ZeroMem (&HashInterfaceHob->HashInterface, sizeof (HashInterfaceHo=
b->HashInterface));
>      HashInterfaceHob->HashInterfaceCount =3D 0;
> +    HashInterfaceHob->SupportedHashMask =3D 0;
>    }
> =20
>    //
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks,
Laszlo
