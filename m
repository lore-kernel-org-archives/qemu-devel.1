Received: from eggs.gnu.org ([2001:4830:134:3::10]:58226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOi0q-0002uq-C9
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cOi0m-0005SF-Ft
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:37:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cOi0m-0005Rz-A2
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 04:37:36 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5868E61BA9
	for <qemu-devel@nongnu.org>; Wed,  4 Jan 2017 09:37:35 +0000 (UTC)
Message-ID: <1483520489.5670.49.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Jan 2017 10:01:29 +0100
In-Reply-To: <20161207105511.25173-1-marcandre.lureau@redhat.com>
References: <20161207105511.25173-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] gtk: avoid oob array access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Mi, 2016-12-07 at 13:55 +0300, Marc-Andr=C3=A9 Lureau wrote:
> When too many consoles are created, vcs[] may be write out-of-bounds.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/gtk.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e81642876a..67c52179ee 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1696,6 +1696,11 @@ static CharDriverState *gd_vc_handler(ChardevVC *v=
c, Error **errp)
>      ChardevCommon *common =3D qapi_ChardevVC_base(vc);
>      CharDriverState *chr;
> =20
> +    if (nb_vcs =3D=3D MAX_VCS) {
> +        error_setg(errp, "Maximum number of consoles reached");
> +        return NULL;
> +    }
> +
>      chr =3D qemu_chr_alloc(common, errp);
>      if (!chr) {
>          return NULL;

added to ui queue.

thanks,
  Gerd
