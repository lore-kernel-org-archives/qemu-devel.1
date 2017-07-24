Received: from eggs.gnu.org ([2001:4830:134:3::10]:53025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiK1-00047m-R1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:43:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dZiK0-0004uB-QT
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:43:13 -0400
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-7-f4bug@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <35e2489f-9cd6-ae5e-39b6-297b6cf5d2ea@redhat.com>
Date: Mon, 24 Jul 2017 13:42:57 -0500
MIME-Version: 1.0
In-Reply-To: <20170724182751.18261-7-f4bug@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g9xG711AHTVvGapTMPBLr7qWm4S3Pkg5K"
Subject: Re: [Qemu-devel] [PATCH for 2.10 06/35] qcow2: remove inconsistent
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g9xG711AHTVvGapTMPBLr7qWm4S3Pkg5K
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org
Message-ID: <35e2489f-9cd6-ae5e-39b6-297b6cf5d2ea@redhat.com>
Subject: Re: [PATCH for 2.10 06/35] qcow2: remove inconsistent check
References: <20170724182751.18261-1-f4bug@amsat.org>
 <20170724182751.18261-7-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/24/2017 01:27 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This is equivalent to assert(russian roulette) so better remove it.
>=20
> block/qcow2-bitmap.c:259:29: warning: The left operand of '=3D=3D' is a=
 garbage value
>         assert(bitmap_table =3D=3D NULL);
>                ~~~~~~~~~~~~ ^
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  block/qcow2-bitmap.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 3e8735a20d..fe72df5057 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -254,7 +254,6 @@ static int free_bitmap_clusters(BlockDriverState *b=
s, Qcow2BitmapTable *tb)
> =20
>      ret =3D bitmap_table_load(bs, tb, &bitmap_table);
>      if (ret < 0) {
> -        assert(bitmap_table =3D=3D NULL);

Rather, we should fix bitmap_table_load() to ensure that bitmap_table is
always assigned, even on error.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--g9xG711AHTVvGapTMPBLr7qWm4S3Pkg5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll2P7EACgkQp6FrSiUn
Q2r1SAf/VqA4NbLXcKvUiH/rGqtgxVrCqyqpsE6dTzaNGFJ+gvUC723uXZesFju2
2YntV/Dp3HEl3ua+clHeMphK5ihiUpIW+6zlmGYmDmA8HDAJZKV2AW/EeLA8bR4Y
H4k0Qd1LQzzN9T/1X7v3+yYE8maxb49qblAGiddw6YjzKHAAnYUBy2SbAhmf3Ytc
NA1qfBjOjgRoAduvTgJBbcbAfQ9iQJsCM6vALmt0HHjYqnKOiJ5jJfNAiRxGrFOm
EbPsYnbXzasnN1mtYnSKNiMjlVHnVUpAEB/B2WifhzpIVSVKMAybqXshHdtbHBql
uwSUrhhaTYDc6IZgVKqPhIbag/4bBw==
=2dx2
-----END PGP SIGNATURE-----

--g9xG711AHTVvGapTMPBLr7qWm4S3Pkg5K--
