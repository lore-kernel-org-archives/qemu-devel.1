Received: from eggs.gnu.org ([2001:4830:134:3::10]:55876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJbz-0007gS-Rn
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebJbw-0008DN-MI
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 00:16:39 -0500
Date: Tue, 16 Jan 2018 15:55:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180116045501.GE30352@umbus.fritz.box>
References: <20180115122417.15871-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline
In-Reply-To: <20180115122417.15871-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial-test: fix powernv support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 01:24:17PM +0100, C=E9dric Le Goater wrote:
> Recent commit introduced the firmware image skiboot 5.9 which
> has a different first line ouput.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.12.

> ---
>  tests/boot-serial-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index dd3828c49b38..0a848a1eeb6f 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -41,7 +41,7 @@ static testdef_t tests[] =3D {
>      { "ppc64", "ppce500", "", "U-Boot" },
>      { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
>      { "ppc64", "pseries", "", "Open Firmware" },
> -    { "ppc64", "powernv", "-cpu POWER8", "SkiBoot" },
> +    { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
>      { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
>      { "i386", "pc", "-device sga", "SGABIOS" },
>      { "i386", "q35", "-device sga", "SGABIOS" },

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpdhaQACgkQbDjKyiDZ
s5IFKRAAh9VvaCTPKwSOAFGdTp9zg/5zR1WiXVCVKgTsKY+A4aVTLbsQCt3vcGIO
59s7l7muo4WKSvKj/ofSHbN00ZFlLgNLrYRJBww2O4/0jj1vD/UM9chv2Kk3N5va
EjVTk8h/g6Y/7126Yxu3lLqoRI7jQIMUmsP/RnVseo9FPVgekBbJ0ECyofHrU3wv
VCxJV8hiH0Dg67f2Yvikrp1Qx5RgQKuVsPD7+1k7IPyiZ7mofwXN940IKd1ieEvb
1si63SuAbVEZNfxl1Guh4+XOgh54Ig+4UEw9YRA8CZrDg1YEONZ17y0DjRYGhGKo
jQLMmR2354XA5MOJHrRv2t4l/BAGFSrJtZI7BUmdChBAfahsOThp+nFxCxTgGazt
n2ebzJilZQcJrofNVBbYpB2hYV5pm48K9Sh0JapLYq7GVYmhDelKcnunzG3a6N9k
wFWg8KjcY2yfeN0Z5m2TYYL5e+c/PMNX6+0BpqoFATndmNE5XlxLGd8lraDzt4tg
A1Cx9JogdyicuHbQRBZCOgUdQ4VsWBdIc4M9wylZu007DGP6rpGhnVUKqWWxKyLy
PCVjC/j0PwhuVxrquHi5LUc5xc1lzZUWg0e+QmYPQN3Qdq3B+HCY1g2tZchwd/FE
QKcmpKyg1IUICkhM6F/FA9TElgjbHRewwm9YyCF9cDcqKtAnphw=
=cdbB
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--
