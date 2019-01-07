Received: from eggs.gnu.org ([209.51.188.92]:53144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggN4C-0002q3-SC
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 00:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ggN4B-0006f3-R8
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 00:03:12 -0500
Date: Mon, 7 Jan 2019 15:48:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190107044815.GF13339@umbus.fritz.box>
References: <20190102055743.5052-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
In-Reply-To: <20190102055743.5052-1-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 00/10] spapr: introduce the 'dual'
 interrupt mode XICS/XIVE
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


--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 06:57:33AM +0100, C=E9dric Le Goater wrote:
> Hello,
>=20
> This series adds a new sPAPR IRQ backend called 'dual' which supports
> both interrupt mode, the XIVE native exploitation mode and the legacy
> compatibility mode (XICS).
>=20
> The machine operates with the legacy mode by default and lets CAS
> negotiate a new interrupt mode. If a new mode is selected, it is
> activated after a machine reset to take into account the required
> changes. These impact the device tree layout, the interrupt presenter
> object and the exposed MMIO regions in the case of XIVE.
>=20
> The preliminary changes for this new IRQ backend are the introduction
> of a second interrupt presenter object under the PowerPCCPU to support
> XIVE. The qemu_irq array of each interrupt controller model is also
> made common and moved under the machine.

Ok, I've now applied all of this series to ppc-for-4.0.

>=20
>=20
> GitHub trees available here :
> =20
> QEMU sPAPR:
>=20
>   https://github.com/legoater/qemu/commits/xive-next
>  =20
> QEMU PowerNV:
>=20
>   https://github.com/legoater/qemu/commits/powernv-3.1
>=20
> Linux/KVM:
>=20
>   https://github.com/legoater/linux/commits/xive-4.20
>=20
> OPAL:
>=20
>   https://github.com/legoater/skiboot/commits/xive
>=20
> Best wishes for 2019 !=20
>=20
> C.
>=20
>=20
>=20
> C=E9dric Le Goater (10):
>   spapr: modify the prototype of the cpu_intc_create() method
>   ppc/xive: introduce a XiveTCTX pointer under PowerPCCPU
>   ppc: replace the 'Object *intc' by a 'ICPState *icp' pointer under the
>     CPU
>   spapr/xive: simplify the sPAPR IRQ qirq method for XIVE
>   ppc: export the XICS and XIVE set_irq handlers
>   pnv/psi: move the ICSState qemu_irq array under the PSI device model
>   spapr: move the ICSState qemu_irq array under the machine
>   ppc/xics: allow ICSState to have an offset 0
>   spapr: introduce a new sPAPR IRQ backend supporting XIVE and XICS
>   spapr: enable XIVE MMIOs at reset
>=20
>  include/hw/ppc/pnv.h        |   2 +-
>  include/hw/ppc/pnv_psi.h    |   1 +
>  include/hw/ppc/spapr.h      |   1 +
>  include/hw/ppc/spapr_irq.h  |   6 +-
>  include/hw/ppc/spapr_xive.h |   2 +-
>  include/hw/ppc/xics.h       |   6 +-
>  include/hw/ppc/xive.h       |   9 +-
>  target/ppc/cpu.h            |   5 +-
>  hw/intc/spapr_xive.c        |  23 ++-
>  hw/intc/xics.c              |   4 +-
>  hw/intc/xics_kvm.c          |   3 +-
>  hw/intc/xics_spapr.c        |  10 +-
>  hw/intc/xive.c              |  11 +-
>  hw/ppc/pnv.c                |  27 ++--
>  hw/ppc/pnv_core.c           |   4 +-
>  hw/ppc/pnv_psi.c            |   7 +-
>  hw/ppc/spapr.c              |  12 +-
>  hw/ppc/spapr_cpu_core.c     |   9 +-
>  hw/ppc/spapr_hcall.c        |  11 ++
>  hw/ppc/spapr_irq.c          | 270 ++++++++++++++++++++++++++++++++++--
>  20 files changed, 342 insertions(+), 81 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwy2g8ACgkQbDjKyiDZ
s5JS+A//SuATKbEfUhrDFIL9tPG35E/DonclRQ8TqZfffyELIyW24IrdyxfYe6/J
+roU5zNe5Y2f2Hw0nz3+JwH6Gt6kieL+eNA3DvA8WALfejE0KZA7VWWr6ExhhOhN
JJkZ0C6xJcLYxnFdYjUIUvMZnU4fSwawzRdfk7GlDSRinWibbBvxl7WrrJTpkv/d
Xaj6Cx7pgKGP2mCnub2ejOI7KmJ3HYpomTtxUVPijELTgjPcVjpmYh+Ll3lm/4Gr
qgzYU125vCtgf1Krlp7mkl5zLClO+hNRjXv/CQt4qulGKjVcO/eBEc7a7ZWnYrO5
iMkwj88QQQE4IPQZkMzkV1YFhN4pD9E/zSpVBl2Y6E2ukyVmSOwV/O/GtiA9/57X
px83twhvZmhKlyFiQOgaHGkui01Cq3Kyx1IRZFCqN+SZXfuVMJ7tomJncVsrghUm
FSxZGsBo4z+KkT77R3aueDPNo98VRdQUZNzaXFKORNYCakaouwNfieZvaa/A45Ca
XHwlh9rL7ZDlMa4ZSysLyGpBhRz1hyXPkd7ygWM95g8mHL4OuH/QcHR9GnUqUmte
w5veVcUEquE036b/uBinSK+MOozffDvMZbrS5/lP8pHX4FyumZT0cOnz9/hv2bji
T7ztSGxB6MR7WxRHkPRpxMTbMdkcavIzqeOHfLczKXPZcGrtGis=
=k+1R
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--
