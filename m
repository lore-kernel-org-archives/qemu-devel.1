Received: from eggs.gnu.org ([2001:4830:134:3::10]:52951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLmHi-00066J-2e
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLmHe-0000Yb-2y
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 03:39:30 -0500
Date: Mon, 4 Dec 2017 18:52:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204075250.GU2130@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-23-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="msgLTjjeumHWYklJ"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-23-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 22/25] spapr: add XIVE support to
 spapr_irq_get_qirq()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--msgLTjjeumHWYklJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:52PM +0100, C=E9dric Le Goater wrote:
> The XIVE object has its own set of qirqs which is to be used when the
> XIVE interrupt mode is activated.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/ppc/spapr.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 734706c18cb3..a91ec1c0751a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3746,8 +3746,12 @@ qemu_irq spapr_irq_get_qirq(sPAPRMachineState *spa=
pr, int irq)
>  {
>      ICSState *ics =3D spapr->ics;
> =20
> -    if (ics_valid_irq(ics, irq)) {
> -        return ics->qirqs[irq - ics->offset];
> +    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
> +        return spapr->xive->qirqs[irq];

You should have a xive helper function for this - spapr code shouldn't
be reaching into the internal XIVE structure.

> +    } else {
> +        if (ics_valid_irq(ics, irq)) {
> +            return ics->qirqs[irq - ics->offset];
> +        }
>      }
> =20
>      return NULL;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--msgLTjjeumHWYklJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlok/tIACgkQbDjKyiDZ
s5LRQQ/+OLZ/RGx75ABRd8Px0p4dZkeEpH6Wtow1hbdXXxADi9PPWmzEiO/UhwF6
ria0EUUUxekX1KknPAhkABR0GHLOd0aghfialoC/ffC0msSBJYcR5fy7iYBFPxaK
6ei/sHuRP1846M7166qM9tSneCcf3VwIKsbAg3C6MLVy6BDfgLKg3IOVi54vECor
CeHyqHAvLrYxwLEVcPbzqa+GGn8tqTyifT7yUPyHnyWSHuK+MRRjEd9TYAGET/tY
Jy7OcUjpjqT70mNjHybc/U2zEwZZ8ztTPp6gP7XiZ74Kp0L1dzypvzK0yOG3ZRPF
SYbAf7o8X5AUvW/jlYKwgqx9G76121ft72NL1IqfOuoYXASafjsAJD1FyhkW1tv9
7ycntTJF/nFe6BZFyJ0HyJpeSTWD6GKS4FGFJD3/DP1jITZ0Cbj1l4bxIpVXC8mI
u5Ep+F8UyRtLRi+h4QYCUdJw/HNMNj235z5PU00kmo16VtPc8ZRsPpW5EMSF3wFr
ddy4duHLOBFvm+dHWbYhWHai7mFeVjIAKs/vDBeq1mytEmLEPIbBG+ktLZW687Jq
m/Xer1jtcHoccGv6tpWZwRWm6XgpGACxYLLhQzC5+eXoMNA7e8X5K51R1z5rZeP5
P5CqRor44Lxki+8BMyI57JmBtlGrAfuJaV/N6H6NpMtwXYP2dBA=
=qmQC
-----END PGP SIGNATURE-----

--msgLTjjeumHWYklJ--
