Received: from eggs.gnu.org ([2001:4830:134:3::10]:45540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ettv9-0002Tv-PY
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:41:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ettv6-0004f5-N0
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:41:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ettv6-0004eY-IP
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:41:12 -0500
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-3-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9468288b-2d80-76a2-e00b-f4ed8d18a5e2@redhat.com>
Date: Thu, 8 Mar 2018 12:41:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180307155746.18526-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 2/8] SecurityPkg/Tcg2Pei: drop
 PeiReadOnlyVariable from Depex
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
> The module doesn't use read-only variable.
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Contributed-under: TianoCore Contribution Agreement 1.1
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf b/SecurityPkg/Tcg/Tcg2=
Pei/Tcg2Pei.inf
> index bc910c3baf97..a4aae1488ff8 100644
> --- a/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
> +++ b/SecurityPkg/Tcg/Tcg2Pei/Tcg2Pei.inf
> @@ -91,7 +91,6 @@ [Pcd]
> =20
>  [Depex]
>    gEfiPeiMasterBootModePpiGuid AND
> -  gEfiPeiReadOnlyVariable2PpiGuid AND
>    gEfiTpmDeviceSelectedGuid
> =20
>  [UserExtensions.TianoCore."ExtraFiles"]
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
