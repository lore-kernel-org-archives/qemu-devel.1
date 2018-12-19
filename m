Received: from eggs.gnu.org ([2001:4830:134:3::10]:41863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbp-0001zP-6V
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbm-0005xv-EX
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:37 -0500
Date: Wed, 19 Dec 2018 17:38:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063838.GX30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-29-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8MA55IEjTDEadc2f"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-29-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 28/34] target/ppc: Remove vscr_nj and
 vscr_sat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


--8MA55IEjTDEadc2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:05PM -0800, Richard Henderson wrote:
> These macros are no longer used.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index c8f449081d..a2fe6058b1 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -700,8 +700,6 @@ enum {
>  /* Vector status and control register */
>  #define VSCR_NJ		16 /* Vector non-java */
>  #define VSCR_SAT	0 /* Vector saturation */
> -#define vscr_nj		(((env->vscr) >> VSCR_NJ)	& 0x1)
> -#define vscr_sat	(((env->vscr) >> VSCR_SAT)	& 0x1)
> =20
>  /***********************************************************************=
******/
>  /* BookE e500 MMU registers */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8MA55IEjTDEadc2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ524ACgkQbDjKyiDZ
s5KmPhAAgcku9sZe33tDr1qO2no4c06T+CYCkbBZvH48LrKF+JIE0CGd8kKndDNQ
LmaOm9cieyPdwbVLINHeAU55ocnEGQhaEj+1wGQtZwi3mpXWo+Qq8wBmRfBjJWJ4
bPCSWj+e1sFF6UekQNTjODe3RDdnVaJ/awLV9tnqwcuf3w6PGofJCXtM7riadg1M
p9ePrXJnn0w0TEFka6Xbyhi5L/dtKg9xoVLGRqXGBbCyhDxQMJ8HGXk0JETtm65I
gTU20gm3zm+DwCVEa05rCFZEpOJZ885Bvq2lMlSTYPxrez9wVjEtd2cUpCbzGMbJ
t5FtPsjYLJUgzNKmITEcryjiirJWysUepu1pG83X/jaIa5W+AKpZW1O277BNAx0D
eaprc2cWHV6UURtFfMnxJU9SDygedAYfVqyUvENEDsTxWcwMdS1NcWzUeAhDUBbM
p6sXJ9OX0ZqsdKgScnc+UboWqY+2hWhKIydcnUPMlV7tehDnyks87bE5Ixq7V/or
TIUmpqAVy1ZkH1RZNAirc0SJXbFZ2qdEtgBIBQ+P96Ub9HklC20G/XgfwswXCT+1
2nebyrYmGQr1rXR+m9VxGz+pnb5JkAGCnCtF189XcykV/XZ1sZ9yTHB8+2Ijc6KD
f8x4VjHXoiwwSrvAqhD4+KVWcp3p+b9t36e24sBG41J8iEfgYJw=
=6pUK
-----END PGP SIGNATURE-----

--8MA55IEjTDEadc2f--
