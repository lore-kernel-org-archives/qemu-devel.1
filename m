Received: from eggs.gnu.org ([2001:4830:134:3::10]:58348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV42E-0001PR-L4
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 19:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV42D-00037o-NY
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 19:58:10 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:50989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fV42C-00036v-Sj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 19:58:09 -0400
Date: Tue, 19 Jun 2018 09:56:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618235654.GC25461@umbus.fritz.box>
References: <20180618213816.5966-1-mail@sebastianbauer.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HwnjeXAdSoek43pS"
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


--HwnjeXAdSoek43pS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 11:38:16PM +0200, Sebastian Bauer wrote:
> According to the sm501 specs the hardware cursor colors are to be given in
> the rgb565 format, but the code currently interprets them as bgr565.

Can those specs be found online somewhere?

>=20
> Therefore, the colors of the hardware cursors are wrong in the QEMU
> display, e.g., the standard mouse pointer of AmigaOS appears blue instead
> of red. This change fixes this issue by replacing the existing naive
> bgr565 =3D> rgb888 conversion with a standard rgb565 =3D> rgb888 one that=
 also
> scales the color component values properly.
>=20
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
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

--HwnjeXAdSoek43pS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoRsQACgkQbDjKyiDZ
s5IzHQ/+MYQHknM68BWHaj1Ba3wr96pleFErD1ttauPbGme1aj3j0XwIpOgtZTRS
d0e062S4JfBQrh0RDVSdW08vUxpwrWVwwsulx72ybQV5t5hIgcHl4VCqEoAei9By
eVBCa92d9xkPvkYTCZZy4iEpGLa8Ik6+L4wNYEJmsJ5/XNXHh+Ug00Awldg6Oacv
4Iz4n0W3Qwd3+j2FebnlchqV2e5dgO1jv63jgnHY1lQD5UWb3byYbQYRCXrU5PvV
njHOhrYfssDwpj+964wxajH1H2sihau+EFB7lvG83PAksSvHqdDS1lBl0wvTfG55
bKRurUoIJvfRpLwpxFuYCKrJIqPTZ/zHIdjvVMNOcOpfURmy2wCuc3X8kSEuMI+h
SOwFW5iAvHNrggkMKVb1vNzu+f8rFvE87pjGo1KkaIeIiSu9YhHkXcYsLEwe31C8
GsWKt/dpfu2vBtU4dLW+aRNJBVxCmOsYSbYlMp7NH6VRDXM+xUpAlPoXxUSGHu8u
bMCxAF2lPQyBL+mY6um056I1bfOkKrtbNBcfaLaVZtx3r4IA8pVrhTt1S1pbIfg4
gMy+N3PSvVqSlNkAF7Nm0cBQmrQvL3ewPmuLLiS7VQ/gAbxnjkdJAAGlNT1WihbT
2fLqlkYvBPeg9z0jo+ogev8R9FlPOrEq7MHKlY2GhpZcXJm8Ic4=
=s4In
-----END PGP SIGNATURE-----

--HwnjeXAdSoek43pS--
