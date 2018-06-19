Received: from eggs.gnu.org ([2001:4830:134:3::10]:57396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV9Am-0003wI-GJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV9Aj-00007x-CB
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:27:20 -0400
Received: from ozlabs.org ([203.11.71.1]:37379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fV9Ai-00006x-Sh
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 01:27:17 -0400
Date: Tue, 19 Jun 2018 15:26:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619052658.GD11674@umbus.fritz.box>
References: <20180618213816.5966-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20180618213816.5966-1-mail@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] sm501: Fix hardware cursor color conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Bauer <mail@sebastianbauer.info>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 11:38:16PM +0200, Sebastian Bauer wrote:
> According to the sm501 specs the hardware cursor colors are to be given in
> the rgb565 format, but the code currently interprets them as bgr565.
>=20
> Therefore, the colors of the hardware cursors are wrong in the QEMU
> display, e.g., the standard mouse pointer of AmigaOS appears blue instead
> of red. This change fixes this issue by replacing the existing naive
> bgr565 =3D> rgb888 conversion with a standard rgb565 =3D> rgb888 one that=
 also
> scales the color component values properly.
>=20
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>

Applied to ppc-for-3.0, thanks.

> ---
>  hw/display/sm501.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 0488ab69d3..6c7f8483f3 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -668,9 +668,9 @@ static inline void get_hwc_palette(SM501State *state,=
 int crt, uint8_t *palette)
>          } else {
>              rgb565 =3D color_reg & 0xFFFF;
>          }
> -        palette[i * 3 + 0] =3D (rgb565 << 3) & 0xf8; /* red */
> -        palette[i * 3 + 1] =3D (rgb565 >> 3) & 0xfc; /* green */
> -        palette[i * 3 + 2] =3D (rgb565 >> 8) & 0xf8; /* blue */
> +        palette[i * 3 + 0] =3D ((rgb565 >> 11) * 527 + 23) >> 6; /* r */
> +        palette[i * 3 + 1] =3D (((rgb565 >> 5) & 0x3f) * 259 + 33) >> 6;=
 /* g */
> +        palette[i * 3 + 2] =3D ((rgb565 & 0x1f) * 527 + 23) >> 6; /* b */
>      }
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsolCAACgkQbDjKyiDZ
s5I5jRAAhS6Wk+GSQ4fKwrae5waCcNLyAs2hv+aNSyOCyiOZofsgnCe2OaoY3EGE
nrCKUZC6Zwf+03xTeEQzMgYuzVryVe9QjHcfUOouRh60kAV2lziU+D/HFOILm+nS
WOPYOA/1rUmsKmfv1eoo39zqGkrwNQs8TKNFpSMq74Z9fAfecjTrmCElOVySruK0
Nv6QnBV6J4K4mV06elrko7qmTOc6CRDg1OZMSH+Z+f7kJETex257u2wqMbgV9MBj
OiNLt8F8+qPN1E+vHIWQArFQvzoS6G1JpM94yv8fl8dZcEmt9sUVRt63OdkOXRZ1
/AXwJEjwZNF8KmoPKKqkyDGWCn/1083oNONSjhHaFn0jKWRfV6HeVY3kMp8P9p64
6WkQZOrcVfzgbQ5/r0pNeorz4NnNwA16Rhn87iJyYJFZ7uVe1uTsOhTqVDJlMbW/
fW6kOt5tGQH17EEdaByrKRSG6eG/ctu6RDTVdCZYOonHy5Bl5dx7XBmqrMdEhVBE
9RIc8YJmSl1MTYrM/dWc9HVTJ9dZqMr2mJDK9q57AJ0U+UZcvfu3ipA1YwhNAaOv
RlL5tI4ifzmcSQttMq6vUBfjc5OKrHiYZ6lxJ99ZUT8kcbUkUJHoQUTOpq7AF1xA
fXt83G1QgzaojWaBeXnRvxAoiM4fQSUXen2GSxdPHeLUuwkwuaI=
=UREN
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
