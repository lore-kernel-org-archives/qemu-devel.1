Received: from eggs.gnu.org ([209.51.188.92]:60692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gp3IY-0005A2-Fc
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:45:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gp3IX-0003uO-Eu
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 22:45:54 -0500
Date: Thu, 31 Jan 2019 14:12:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190131031209.GI1771@umbus.fritz.box>
References: <20190128065552.31514-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline
In-Reply-To: <20190128065552.31514-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc: remove the interrupt presenters from
 under PowerPCCPU
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


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 07:55:52AM +0100, C=E9dric Le Goater wrote:
> These fields have now been replaced by equivalents under the machine
> data.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-4.0, thanks.

> ---
>  target/ppc/cpu.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a62ff60414f4..2c22292e7f41 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1178,9 +1178,6 @@ do {                                            \
>  typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
>  typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
> =20
> -struct XiveTCTX;
> -struct ICPState;
> -
>  /**
>   * PowerPCCPU:
>   * @env: #CPUPPCState
> @@ -1198,8 +1195,6 @@ struct PowerPCCPU {
>      int vcpu_id;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> -    struct ICPState *icp;
> -    struct XiveTCTX *tctx;
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxSZ4gACgkQbDjKyiDZ
s5JnCxAAwAA/CRoBA5gv6zxAB5B79sasACMT09y0JTq7Gs6MIcxj8jbNG3vjt+2h
uFMeSDhFzZQbjdJ9w1Wb6wyCjLbtw0euNTi5G2171/uoGw5nOhTDfxh6qme6WP6+
/XjGAL6KHKsUs7LgrkdjQAJL5PEiPoz+sEzIUMfLQ+4K8SomicBgl7+s7JLBb91s
+OkvzKMN23IATQyqqh13GBL6GpEVENYdgYagg/Nc9/dPeUFLYkhwCvlzLq4ZxQf7
fTKD6VVOqKDIvQoe66cWTATp42veswNrQ4jUKrE+x8Zn3Cr4GVVcEKAG6TU6Oz8H
VcrBZfW5ZsOzsjaCG/BaVs96Y/ivzJtRWO5CSQhsLqPQVPDaNnbWyheOLoQEnyg/
a88gUcl1OuX5itZg8RwO79WmtOnheWxJwGWkhjBdJK8xOTHyHXNTkwUnyl7XB9Jg
Sa4+SDrnhT1PNBTEDpz9Iib2h8bf8IkCwvmJevSwaEKxFSTNjSC79PbmrqxguJLS
C+j8DMdNB/vgrZ4UeoIo3FvalGjWrhrR1UVcVNd8/lP8nMNpJItOJ6XWmuWMlLLo
7yUaklWGw2NuKLo9BD2hxobmysUhEwx35s0oBhGNwRBRsQ2xEeSN55vlPbL0y5wK
TIv9k9a3Qb9X9dfKUkZ2UxKBe96iaVD1630f9hPde7buDAhT5qQ=
=Jr9p
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--
