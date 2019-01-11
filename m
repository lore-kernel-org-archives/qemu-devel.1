Received: from eggs.gnu.org ([209.51.188.92]:58435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpb-0005ZR-DE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ghkpZ-0003SH-6e
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 19:37:50 -0500
Date: Fri, 11 Jan 2019 11:21:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190111002155.GL6682@umbus.fritz.box>
References: <20190109224919.2082F7456A2@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xb8pJpF45Qg/t7GZ"
Content-Disposition: inline
In-Reply-To: <20190109224919.2082F7456A2@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] ppc440: Avoid reporting error when reading
 non-existent RAM slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--Xb8pJpF45Qg/t7GZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 11:37:33PM +0100, BALATON Zoltan wrote:
> When reading base register of RAM slot with no RAM we should not try
> to calculate register value because that will result printing an error
> due to invalid RAM size. Just return 0 without the error in this case.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied, thanks.

> ---
>  hw/ppc/ppc440_uc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
> index c489368905..9130eb314c 100644
> --- a/hw/ppc/ppc440_uc.c
> +++ b/hw/ppc/ppc440_uc.c
> @@ -613,8 +613,10 @@ static uint32_t dcr_read_sdram(void *opaque, int dcr=
n)
>      case SDRAM_R1BAS:
>      case SDRAM_R2BAS:
>      case SDRAM_R3BAS:
> -        ret =3D sdram_bcr(sdram->ram_bases[dcrn - SDRAM_R0BAS],
> -                        sdram->ram_sizes[dcrn - SDRAM_R0BAS]);
> +        if (sdram->ram_sizes[dcrn - SDRAM_R0BAS]) {
> +            ret =3D sdram_bcr(sdram->ram_bases[dcrn - SDRAM_R0BAS],
> +                            sdram->ram_sizes[dcrn - SDRAM_R0BAS]);
> +        }
>          break;
>      case SDRAM_CONF1HB:
>      case SDRAM_CONF1LL:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xb8pJpF45Qg/t7GZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw34aMACgkQbDjKyiDZ
s5JrIhAAuxMnK+XaEYJCJ3phM0lhDeNWmOL3Fs+b1XGLyz4Smv6pY1vv5c3cBNDn
eWhlwake93iG7tBHSDs+gsb2IvyoULxUuRne75tV0azmd+IDJVscxITGCVIkRK/P
q4dWV8e2OnCBvaaL/Dotm7pVSsTZMAAxtLcCxmYvTZtUZ+Pz0gjdRsnjZDxIbznq
2PIj+7kXU7HySETDepNNDeOg4OS92BKz4CZ40ejrMMO7q4+m4Ex5OFn4QZLfY8Ic
uy3d6zn4Ch3AUCvTKlrrn1otnpwdNOKV+0xwiuaIuqKBKd9kVKV+QRe0Qq4UX36k
G26Nj9o7Ub1MVUiHXd/xbjv0r7/R29T5+KoeT+H0AvJS2fBpOAOwIM8ZcyiNsKvt
3vvemvF6d8ZykzZphVK4z1eW2tR2mSrBrjtZwKOSvUitRYIxN+Z2SeYPpjadBaC1
0Vlxy0ira4V6/7zu0erinlJNSZ+vv7f1vrSS0mzjnrUP45CcfFSVCeik3hDnTdr5
2bUyodRGt7ttVnz8tChCRPilHYIQ4nwd7uBRHtprWbz+XklI7jCAxhZsy/a+LqS5
i0jKINgmWQUDynzt3pXPpRbBWne+SjrU26XbaH961AiavKmZLZ0HBPXyZTJtEmjr
7gvTu5dOQ6vZXewba4ttitM7Z2Bu7MyDFgT2QcX2IYKlAyCAUqg=
=IIDN
-----END PGP SIGNATURE-----

--Xb8pJpF45Qg/t7GZ--
