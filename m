Received: from eggs.gnu.org ([2001:4830:134:3::10]:38482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafFa-0003id-HE
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cafFX-0000bV-C5
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:06:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cafFX-0000ak-6u
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 04:06:15 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B0B788E60
	for <qemu-devel@nongnu.org>; Mon,  6 Feb 2017 09:06:15 +0000 (UTC)
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-12-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f70df007-1597-6fb6-fa92-1f03fc7b0056@redhat.com>
Date: Mon, 6 Feb 2017 10:06:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170202145141.17138-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/22] qcow2: remove useless NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org



On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
> g_strdup() already handles the case where the argument is NULL.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  block/qcow2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8f16..9114218030 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2016,8 +2016,8 @@ static int qcow2_change_backing_file(BlockDriverS=
tate *bs,
>      g_free(s->image_backing_file);
>      g_free(s->image_backing_format);
> =20
> -    s->image_backing_file =3D backing_file ? g_strdup(bs->backing_file=
) : NULL;
> -    s->image_backing_format =3D backing_fmt ? g_strdup(bs->backing_for=
mat) : NULL;
> +    s->image_backing_file =3D g_strdup(bs->backing_file);
> +    s->image_backing_format =3D g_strdup(bs->backing_format);
> =20
>      return qcow2_update_header(bs);
>  }
>=20

Please send this separately with Cc to qemu-trivial.

Paolo
