Received: from eggs.gnu.org ([209.51.188.92]:32802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdL-0003rH-AB
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvwdF-0002PT-Mo
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 23:03:49 -0500
Date: Tue, 19 Feb 2019 14:47:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219034718.GR9345@umbus.fritz.box>
References: <20190215170029.15641-1-clg@kaod.org>
	<20190215170029.15641-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PY8tzLeNxmyMVNR3"
Content-Disposition: inline
In-Reply-To: <20190215170029.15641-5-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 04/12] target/ppc: Fix #include guard in
 mmu-book3s-v3.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--PY8tzLeNxmyMVNR3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 06:00:21PM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied, thanks.

> ---
>  target/ppc/mmu-book3s-v3.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index 41b77158622a..12ec0054c207 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -17,8 +17,8 @@
>   * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
>   */
> =20
> -#ifndef MMU_H
> -#define MMU_H
> +#ifndef MMU_BOOOK3S_V3_H
> +#define MMU_BOOOK3S_V3_H
> =20
>  #ifndef CONFIG_USER_ONLY
> =20
> @@ -62,4 +62,4 @@ int ppc64_v3_handle_mmu_fault(PowerPCCPU *cpu, vaddr ea=
ddr, int rwx,
> =20
>  #endif /* CONFIG_USER_ONLY */
> =20
> -#endif /* MMU_H */
> +#endif /* MMU_BOOOK3S_V3_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PY8tzLeNxmyMVNR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrfEYACgkQbDjKyiDZ
s5K0Rg/9Hv7B2UrFLqkR/e4NaAL5GIKVL4YtfW2H2TZGeDyKO7Gz8tmv7O7/4NxK
NX1seUF16acthW4chp+KNjqLEXczbtXTHJmr9cxHjD1/wtLGuusCJ6Q6EiEYo6v/
JjYz/gnx06avdVx8FAMZnux0YAPWQSFecNy8yuRPj+XjD6QfUO5sF3FDJHMORLdu
ZlWNz8R4kIz7cRScledJyToVPUNm10YIorAombyLkcFx07S3MujImQU5ygiUFnFJ
gkGvTopWVCXV0B6GL1YldKfqWgQ9PfabMhIf7I1h+LF4CZCDk0ebcEqlc/qFn0JM
5XWM7z/kXkFdL5zydtLu2zoGHBi8Jq72VGVfVwVlIpdKHwsKnoEbrG16IWGMPum8
INpnX1LqVO5QMhLKAm/Jok2GdsetWgBL/MS7wzXot60AdXbmyLtN9fE1H2QARK3o
CiHD0cQLWd4C7xMFJ/R7yXmgH32eob/Bu+V1MUgyyJHqBSttWIeqNhrmyG8U62qL
Y6AMsg9n6vLVpoMjeNGa3toTjIpxSRlWU2/vwQqvBLP8p4M6vcDYbopf2BcTTc9H
dmDPvGkMKyZyZ4Y2dSLMUHZnon2u1HzviUGQzoQIh0Nn9K8EL5H5rKZkxSl5uiQG
fKcrQSqt52CRbcItZcmRtGvSwBiRNnt0gOzOeqvk1TXsXQPGMW0=
=f46I
-----END PGP SIGNATURE-----

--PY8tzLeNxmyMVNR3--
