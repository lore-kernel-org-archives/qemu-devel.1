Received: from eggs.gnu.org ([2001:4830:134:3::10]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3SkX-00016k-Fa
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:37:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3SkW-0006aw-LM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:37:17 -0400
References: <20170424091659.26708-1-berrange@redhat.com>
	<20170424091659.26708-5-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8226e47c-2198-4785-3837-a8db7ad6b753@redhat.com>
Date: Wed, 26 Apr 2017 21:37:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170424091659.26708-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eetFiuFtpRS1xIXrTgu22QIP2lEtMl5IN"
Subject: Re: [Qemu-devel] [PATCH v5 4/4] qemu-img: copy *key-secret opts
 when opening newly created files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eetFiuFtpRS1xIXrTgu22QIP2lEtMl5IN
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <8226e47c-2198-4785-3837-a8db7ad6b753@redhat.com>
Subject: Re: [PATCH v5 4/4] qemu-img: copy *key-secret opts when opening newly
 created files
References: <20170424091659.26708-1-berrange@redhat.com>
 <20170424091659.26708-5-berrange@redhat.com>
In-Reply-To: <20170424091659.26708-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.04.2017 11:16, Daniel P. Berrange wrote:
> The qemu-img dd/convert commands will create a image file and
> then try to open it. Historically it has been possible to open
> new files without passing any options. With encrypted files
> though, the *key-secret options are mandatory, so we need to
> provide those options when opening the newly created file.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index 2344e64..cee28db 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -2303,8 +2332,8 @@ static int img_convert(int argc, char **argv)
>           * That has to wait for bdrv_create to be improved
>           * to allow filenames in option syntax
>           */
> -        out_blk =3D img_open_file(out_filename, out_fmt,
> -                                flags, writethrough, quiet);
> +        out_blk =3D img_open_new_file(out_filename, opts, out_fmt,
> +                                    flags, writethrough, quiet>      }=

>      if (!out_blk) {>          ret =3D -1;
With the spelling fixed as pointed out by Fam, and with
s/out_blk/s.target/ in this hunk:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--eetFiuFtpRS1xIXrTgu22QIP2lEtMl5IN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkA9uISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgxEH/RHNTsewY5u3waLhR1RIIiMMqT0p6czl
f3hA6nHNxih/qiVEGKY+ER2gRsanOsIDkVGkn9GYmz/vfd08CfZIW+xlJS9pU8R3
jh24O/J+VxgXJkHva2P/WRKmJfODz485BPuXR9sKjSQ2EwcLdNZ4874/ePZAUdoG
7hpUF6cnr+b/goyfjqz0rgryjsuqCWlIEQu6yKLP1hG+3Ye+c8MiaJJQYOqeMXKE
12nz4KZR7aqwv7hjEBIFQIKtXciE2Buv2ZQc/OsSojjCfdA7GlEsOEtqQmzerEiW
wa+fZpvyu2xVmTvOwlBQg9+x+XIIV3YocnMRUcM9KTjEbef+sMzehng=
=1Gjn
-----END PGP SIGNATURE-----

--eetFiuFtpRS1xIXrTgu22QIP2lEtMl5IN--
