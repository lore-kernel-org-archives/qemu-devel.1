Received: from eggs.gnu.org ([2001:4830:134:3::10]:57016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euKVd-0007sG-1R
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euKVY-0006sz-Pc
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:04:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42652 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euKVY-0006ss-Kv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:04:36 -0500
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
	<20180309130918.734-2-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ace0ce4f-03fa-32a8-5d85-6d8722bce452@redhat.com>
Date: Fri, 9 Mar 2018 17:04:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180309130918.734-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/7] SecurityPkg/Tcg2Pei: drop
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
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, javierm@redhat.com

On 03/09/18 14:09, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> The module doesn't use read-only variable.
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Contributed-under: TianoCore Contribution Agreement 1.1
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
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

Any reason you didn't pick up the following R-b from v2?

http://mid.mail-archive.com/74D8A39837DF1E4DA445A8C0B3885C503AAE197C@shsm=
sx102.ccr.corp.intel.com

Reviewed-by: jiewen.yao@intel.com

Anyway, this patch is identical, so I'll carry Jiewen's R-b forward.
(That's important because this is a SecurityPkg patch, and I can only
push it if we have an R-b from one of the SecurityPkg maintainers, Chao
Zhang or Jiewen.)

Thanks
Laszlo
