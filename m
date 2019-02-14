Received: from eggs.gnu.org ([209.51.188.92]:60985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu5Id-0001mO-5x
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gu5IV-0006a3-J7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 19:54:43 -0500
Date: Thu, 14 Feb 2019 11:49:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190214004902.GX1884@umbus.fritz.box>
References: <20190213210756.27032-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="my6/OtttYtn8dhky"
Content-Disposition: inline
In-Reply-To: <20190213210756.27032-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 0/2] spapr/irq: remove the XICS offset
 adjustment for the dual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--my6/OtttYtn8dhky
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 10:07:54PM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> When using the 'dual' interrupt mode, the source numbers of both sPAPR
> IRQ backends are aligned to share a common IRQ number space and to use
> a similar mapping of the machine qemu_irq array which is indexed by
> the source number.
>=20
> The XICS IRQ number range initially being [ 0x1000 - 0x2000 ], this
> requires to change the XICS ICSState offset to 0 and to provision for
> an extra 4K of source numbers and qemu_irqs which will never be used
> by the machine when running under the XICS interrupt mode. This is not
> an optimal solution.
>=20
> Moreover, the KVM support for the 'dual' interrupt mode will require
> some adjustments. The XICS KVM device considers that the IRQ numbers
> start at XICS_IRQ_BASE (0x1000) and we have no way to inform KVM of
> the offset change. We will need to ignore the lower 4K numbers when
> capturing or restoring the source states from the XICS KVM device.
>=20
> The first patch allocates an IRQ number space of the expected size for
> the XICS sPAPR IRQ backend. The overall IRQ number space size and the
> qemu_irq array size is still the one required by the 'dual' sPAPR IRQ
> backend, that is, in sync with XIVE. The second patch removes the
> ICSState offset adjustment. This last change adds some benefits as it
> simplifies greatly the qirq() method of the 'dual' sPAPR IRQ
> backend.

Ah, much nicer.  Applied to ppc-for-4.0, thanks.


>=20
> C.
>=20
> C=E9dric Le Goater (2):
>   spapr/irq: add an 'nr_irq' parameter to initialize the backend.
>   spapr/irq: remove the XICS offset adjustment
>=20
>  include/hw/ppc/spapr_irq.h |  2 +-
>  hw/ppc/spapr_irq.c         | 45 ++++++++++----------------------------
>  2 files changed, 12 insertions(+), 35 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--my6/OtttYtn8dhky
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxkuvwACgkQbDjKyiDZ
s5K5mxAAorcphYrPxfoqGGYLarDs3s2StaQEK0/6qmsn6U7ozJDEll1sca1nn8mr
0PBXg+pfK64UtWRDbZ5TGR2R2mOgkGXf8gd+vKQwnXmDjsbRF4ORSWzk2yeRL6RF
v03MDlG510HsbASN7/CrMBbtA2BJfaQGCXyZuzDpbnRHgv6xENtCm98YNi7qxLYs
95YHZlNZ1mhSQip8XGDP1CxBgnQ1Ltz/5QC+s/YftoqLiCxOwceTrRi0ASo0+wS7
04RDcHCpRLZec/0bjjPTdMCavk4QYyRgRIWi1lKGaP1GsH1QmVHgOkhwET7bHgV8
RjXxhegv8eOXWVlCi7AWWp1KaID9w9TtkyQ5wXZQj7DwN7NOTeWthchvMpYh472x
evKPu90q1vSFHcBTujceml7AYvFn//18VKIlAF8bXBJSmLOohpx7uWOm3o8m1JFG
d8y3hwEG9cTQVheasRcs4m4NvU+hYaDXFyr78qdqukXKYavLyfPEasORgu4ZCola
pdruIGXI44wF8VXrMWLpwgJW5C3Tlf+T63Ydvf8ciWSd08WtnXE3NVQ0oJPWhFWK
x+LhRJr3hshNxdPBcQh5HWrdp4wtdF7NDjjZ1D1LKK10+vaFdC8ZIUVoEhGyYIDo
97Ojzv+lLygdCSZQFEhr6TAPPI0CU8RXXv7Wn5y8/NCvI3K2jtk=
=OK7S
-----END PGP SIGNATURE-----

--my6/OtttYtn8dhky--
