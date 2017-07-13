Received: from eggs.gnu.org ([2001:4830:134:3::10]:42884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVfuH-0000jD-BQ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVfuF-0007f5-Ve
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:19:57 -0400
Date: Thu, 13 Jul 2017 21:56:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170713115646.GA17539@umbus.fritz.box>
References: <20170713062128.38954-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20170713062128.38954-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] ppc/pnv: Remove unused XICSState
 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 13, 2017 at 04:21:28PM +1000, Alexey Kardashevskiy wrote:
> e6f7e110ee70 "ppc/xics: remove the XICSState classes" got rid of
> XICSState, this is just an leftover.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to ppc-for-2.10, thanks.

> ---
>  include/hw/ppc/pnv_psi.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
> index 11d83e43f8..f6af5eae1f 100644
> --- a/include/hw/ppc/pnv_psi.h
> +++ b/include/hw/ppc/pnv_psi.h
> @@ -28,8 +28,6 @@
> =20
>  #define PSIHB_XSCOM_MAX         0x20
> =20
> -typedef struct XICSState XICSState;
> -
>  typedef struct PnvPsi {
>      SysBusDevice parent;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllnX/wACgkQbDjKyiDZ
s5I6Lg//QBuwokZD9H42fvTTsjWsNz7DhrBS+nVVlug7Gxj3ew6xq2eYcoOXrRt2
+qEPuwUNpY/pTqlnJFuCFtJi7yw+1Y3KAXBNFS1ZhW7RgMyUbSR+AFDSYfRL2FHO
35YLY9meMvEjj7FSapDahTDbRMkBaD0IFuqs4KAk9gdrJqEJ193NBJdhZAWrZTMd
1Gm3CIBr41CVs8SLcBPqcNlv7THgGDJE1LRx279ztcQYldsB75NpYzOEAt5M8yxu
miqyxjOnxExcrS07yB/i5K7xXfFgWl99xCRAkku+l8FngdlRjRRY1y4Db7hCGGXv
noqYE21g+dXFEmgTOnZrduFHY3u4f1taJwr8liy6V2weCajCxMOAP+SMWqeIkZBi
K9lGBkweZyREh6J92Se+L3cNm33WVQggXPXnj/sew7lNOY+O5/VLIBhc1lQs681w
Pk1iUrHtsfwAI70b+xny8EYq7yLvTJ8RPIPJ8QwsWevzPiZvzz9ppLgSqUtvPQ1p
3vdWoQGka4V7RXqolnNZ1DVT2OrqYxSt2xFqVTyGYg3E9qqS9Vr5KZwGtMAXs5+h
LgOBlBNep4TOPXPAOFAuUW4lKxL+cmweHRZkkokeoBYLhb37XBHLvLv+2ESh4FyZ
Srqo0KqhpQQ9I2H4AWPsPNjdEa37+lJpuyYp4RYdN2p8Y7VMk4Q=
=BjiM
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
