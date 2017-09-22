Received: from eggs.gnu.org ([2001:4830:134:3::10]:37847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLzr-0004iA-Dz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvLzo-0007DY-64
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:19:51 -0400
Date: Fri, 22 Sep 2017 21:00:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922110040.GP4998@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-2-clg@kaod.org>
	<20170919022719.GH27153@umbus>
	<d3ee87a7-208e-a172-094b-6aeedf8c5840@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gQt10JDuGyDb0HQ5"
Content-Disposition: inline
In-Reply-To: <d3ee87a7-208e-a172-094b-6aeedf8c5840@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 01/21] ppc/xive: introduce a
 skeleton for the sPAPR XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--gQt10JDuGyDb0HQ5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2017 at 03:15:44PM +0200, C=E9dric Le Goater wrote:
> On 09/19/2017 04:27 AM, David Gibson wrote:
> > On Mon, Sep 11, 2017 at 07:12:15PM +0200, C=E9dric Le Goater wrote:
> >> Start with a couple of attributes for the XIVE sPAPR controller
> >> model. The number of provisionned IRQ is necessary to size the
> >> different internal XIVE tables, the number of CPUs is also.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > [snip]
> >=20
> >> +static void spapr_xive_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    sPAPRXive *xive =3D SPAPR_XIVE(dev);
> >> +
> >> +    if (!xive->nr_targets) {
> >> +        error_setg(errp, "Number of interrupt targets needs to be gre=
ater 0");
> >> +        return;
> >> +    }
> >> +    /* We need to be able to allocate at least the IPIs */
> >> +    if (!xive->nr_irqs || xive->nr_irqs < xive->nr_targets) {
> >> +        error_setg(errp, "Number of interrupts too small");
> >> +        return;
> >> +    }
> >> +}
> >> +
> >> +static Property spapr_xive_properties[] =3D {
> >> +    DEFINE_PROP_UINT32("nr-irqs", sPAPRXive, nr_irqs, 0),
> >> +    DEFINE_PROP_UINT32("nr-targets", sPAPRXive, nr_targets, 0),
> >=20
> > I'm a bit uneasy about the number of targets having to be set in
> > advance: this can make life awkward when CPUs are hotplugged.  I know
> > there's something similar in xics, but it has caused some hassles, and
> > we're starting to move away from it.
> >=20
> > Do you really need this?
> >=20
>=20
> Some of the internal table size depend on the number of cpus=20
> defined for the machine.

Which ones?  My impression was that there needed to be at least #cpus
* #priority-levels EQs, but there could be more than that, so it was
no longer as tightly bound to the number if "interrupt servers" as xics.

> When the sPAPRXive object is instantiated,=20
> we use xics_max_server_number() to get the max number of cpus
> provisioned.
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gQt10JDuGyDb0HQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE7VcACgkQbDjKyiDZ
s5KU9Q//fdAgtGA9NC6pHhaFVblRhmBc1Q8Wa7wr7ZLL0/kAjsKrde9RXsRcLeSj
U4fm94TfgjraaNlJ2+tUw7iyv4EDT/kHLFPmd+JIV9m8eAN5KCBaxCULxU/ZiqyH
U9FpozL4OjOKzocrGIbGRHRZ1XuQiF/h1nT4IkrWUs2i8EGUOeFN4KF3ZrARHgdu
9zRNzVmluq2o0Wb4pQLPCWuw12lflRRGzEb2Z6SZTnxMvwVMyAgMkRU/TceKowkp
4wu3FdzOb9GWHzTosXjhoNAzbCdjPE8rhstFeO2C5HcQ1to01dXyZM+3Rfc8dnnP
4ONXbEnGKL42wiG60VvTZd+yGZqL8FAbktV3mgWhNPzEXmj9M8+07Kao1d2pvHdI
e0+H9HOpNnuuU7mY2Pr97SBMtnX/iL2H74Bq2BSCTQgt4fJLnFWE2r9OkOzaLF8/
UnVbpwVcSx9nWd2AB8JS6jB0LgyiB8xwHRovgTn/zYgkerZiNlzHR9pmywRGcKX7
wjYuiqR++JPIpA+7Z+tiZ1ZlT1/aCwjx0OQ6BI21McKOlY2/GYimeWz958j42rAD
QrlbXzFZG1KGRXP58GXKjGkscOCZ+Kv1ZDPH9dsqPmrkIbc2U927UQ5RO2VA1kiw
gbdEZM5sFn3/yTmdKGpcIdxgjjlULXkEqACaR987uUKj9MAlK+8=
=sNKK
-----END PGP SIGNATURE-----

--gQt10JDuGyDb0HQ5--
