Received: from eggs.gnu.org ([208.118.235.92]:57814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK4-0001kI-Sj
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK3-0007r1-SP
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:04 -0500
Date: Wed, 2 Jan 2019 15:27:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102042730.GQ27457@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<7cb0f9796d26f5d47d55710c32e0ecaf4f139aa9.1546394798.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WZLuFERxa6Y0cbOt"
Content-Disposition: inline
In-Reply-To: <7cb0f9796d26f5d47d55710c32e0ecaf4f139aa9.1546394798.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 3/8] ppc4xx: Disable debug logging by
 default
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


--WZLuFERxa6Y0cbOt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> Debug logs were left enabled in ppc4xx_devs.c whereas in other files
> these are normally not enabled. Disable it here as well.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied, thanks.

> ---
>  hw/ppc/ppc4xx_devs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index 8c6f3c9577..9b6e4c60fa 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -32,8 +32,7 @@
>  #include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
> =20
> -#define DEBUG_UIC
> -
> +/*#define DEBUG_UIC*/
> =20
>  #ifdef DEBUG_UIC
>  #  define LOG_UIC(...) qemu_log_mask(CPU_LOG_INT, ## __VA_ARGS__)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WZLuFERxa6Y0cbOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsPbIACgkQbDjKyiDZ
s5LcwBAAoIzC3YXMEHOfTHka7TLjvFG0mWmvmD37VpVxWy13KGWTGBbjKb8vo6SO
ZF9+TzhkBvlqDVtc+fPRlBtIPBU9eEyyTdZz/vR4L1J6sC81MJcUJLbfvlgppwQr
IIfqLSY6/5+wc0TvSVbGOkullQlUaDFvErJFlCplyVaUCteWRVBFdEvuIMJC5+dj
OwMBp6AkFIMRkNeUwjfjzs7QXRxgMPDw6XMR0VGeJa18NQdArwzU5QhGeMQSGsXt
Z/XSFpUI/dcCdVNU7H9Pj0Cs9KZzGkoAirypciJx8ZhlmJBVdn6iWPK5ZhauRMal
31rIwL1K3TeVbYO0flNou2DhGJNZoA+A6nZkSAz7qhAGmpX/RcBsNnwCSByTrn1l
mrN9tCcip6jt29vqqd6RgdKNPLYjljiQ5ldKlOVLqzAqXmGEBAEF67DGDrZdevnq
9zYN+T49z0T1qv+/tBk+j1Frvwxlmq2R522h38NLy1euWI9EvRcIqmdm2AjLw4io
wcQcGYq9GrL3hHFoyRg+joHN1d5OLgQuv/A8WX5v/wpgwr8CHJhCNUs8QbQo7RyK
5UYzt78iM9VTmraVaP+jzLy6ugNnrqhQRPUsxouNU7vNC7bqZ6L5zDgc8bQzSOKs
q0eC2BRWykRLNJykhbGNPzH/a/HisD9p0yMgSxvmIFqJnMxN+0g=
=8NI1
-----END PGP SIGNATURE-----

--WZLuFERxa6Y0cbOt--
