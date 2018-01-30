Received: from eggs.gnu.org ([2001:4830:134:3::10]:43331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eh3Y5-00061l-Le
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 20:20:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eh3Y2-0006ko-EM
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 20:20:21 -0500
Date: Wed, 31 Jan 2018 06:49:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180130194935.GL12900@umbus>
References: <20180130131716.5899D7456D5@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q6mBvMCt6oafMx9a"
Content-Disposition: inline
In-Reply-To: <20180130131716.5899D7456D5@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] sii3112: Change angle brackets to quotes
 in #include lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org


--q6mBvMCt6oafMx9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2018 at 02:10:10PM +0100, BALATON Zoltan wrote:
> This matches what other files do for qemu includes
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied, thanks.

> ---
>  hw/ide/sii3112.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
> index 17aa930..e3896c6 100644
> --- a/hw/ide/sii3112.c
> +++ b/hw/ide/sii3112.c
> @@ -12,8 +12,8 @@
>   * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
>   */
> =20
> -#include <qemu/osdep.h>
> -#include <hw/ide/pci.h>
> +#include "qemu/osdep.h"
> +#include "hw/ide/pci.h"
>  #include "trace.h"
> =20
>  #define TYPE_SII3112_PCI "sii3112"

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q6mBvMCt6oafMx9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpwzEwACgkQbDjKyiDZ
s5I3Jw/+Lqjx2XjqZARB/sUxhIi2JLstx0+GbDv/rVc6cni7k4qYIVdFFXjs4lGJ
4dzzBjXlgC2wnL18ljEy2+QlqeEbC4WORplwTzWi/IUDiLxYm39qGTUazFSGgzFw
DRkhdeiMnKUXSxLGmbyQpVR+oSYYdQn/aVvs9G9jPBdPYJm9RFBiu4N8hqIzTjdL
jwsC8YIWJnzlCdY77YKpbqCdgiR3GgoDqaaGk+Z8jcalhdGO2qau6MQo37XQohfF
OYhaqaXAkNvFiGf5wX6IujDMUN7D72KDNjHh4w2a1cLoBiFRLb0d01iJ5p9rQOgM
lXbvSiPQ/vFVYukNr1CNQ0pTKd6Rle86h1hG6l0eYhrBu6l+LRD1mdKd9CspohDb
CZbqkhORWA4hNlESP4jeO9joJCP/qcWrMRFIN1IrJ31abaPrRon2qSur9ej0LyJZ
Cj5WSlzV++jCWOuqxlhKssvT25KY/2vN8aHmA23qJi912T3nPt9LsuTUeVESJrLm
aBewaxfTGC2Awv2tUJ2Q1b+ny27LrITr9zSpJ9pcIJbtElNO+kT7Dffvk664xKPW
Zw54Vo9eIRVWWJsX/dwwwY9WQFGS9MlmzbOaUMp5Q9uVvTt79gcCyZhd3DD0Psj+
IVvtg+fG+0401KWqTj1LE/zkFHysdj+jG0McY014+xV2b6Iuk4k=
=WhmF
-----END PGP SIGNATURE-----

--q6mBvMCt6oafMx9a--
