Received: from eggs.gnu.org ([2001:4830:134:3::10]:47937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnpm-0001IN-Qs
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKnpl-0002I7-7j
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:06:38 -0500
Date: Fri, 1 Dec 2017 15:17:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171201041717.GG30161@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-18-clg@kaod.org>
	<20171130055542.GG3023@umbus.fritz.box>
	<f0a75998-97c0-218d-0473-78788dab1f3a@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L+ofChggJdETEG3Y"
Content-Disposition: inline
In-Reply-To: <f0a75998-97c0-218d-0473-78788dab1f3a@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 17/25] spapr: add a sPAPRXive object to the
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>


--L+ofChggJdETEG3Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 03:38:46PM +0000, C=E9dric Le Goater wrote:
> >> +    } else {
> >> +        /* XIVE uses the full range of IRQ numbers. The CPU IPIs will
> >> +         * use the range below XICS_IRQ_BASE, which is unused by XICS=
=2E */
> >> +        spapr->xive =3D spapr_xive_create(spapr, XICS_IRQ_BASE + XICS=
_IRQS_SPAPR,
> >> +                                        &error_fatal);
> >=20
> > XICS_IRQ_BASE =3D=3D 4096, and XICS_IRQS_SPAPR (which we should rename =
at
> > some point) =3D=3D 1024.
>=20
> BTW, why XICS_IRQ_BASE =3D=3D 4096 ? I could not find a reason for
> this offset.

It's basically arbitrary.  Possible I copied the value used in
practice on a PowerVM system of the time, but I don't recall for sure.

> > So we have a total irq space of 5k, which is a bit odd.  I'd be ok
> > with rounding it out to 8k for newer machines if that's useful.
>=20
> ok. and using a machine class value to maintain compatibility. That=20
> would be useful if we allocate more PHBs.=20
>=20
> > Sparse allocations in there might make life easier for getting
> > consistent irq numbers without an "allocator" per se (because we can
> > use different regions for VIO, PCI intx, MSI, etc. etc.).
>=20
> So, do you think we should modify the IRQ allocator routines to be=20
> able to segment the IRQ number space and let devices specify the
> range they want to use ?

No, I'm suggesting *eliminating* the IRQ allocator routines (except
for backwards compat) and having devices "just know" their irq numbers
based on their own device number and the portion of the overall irq
space they're supposed to live in.

PCI MSI is an exception, obviously, it will need some sort of runtime
allocation.

> That would be useful for the PHB LSIs. The starting IRQ for the PHB
> could be aligned on some value depending on the PHB index, first=20
> would come the LSI interrupts and then the MSIs which are allocated=20
> later on by the guest. We would have predictable values.
>=20
> Thanks,
>=20
> C.=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L+ofChggJdETEG3Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlog180ACgkQbDjKyiDZ
s5KHIw/9HJQXrdkuNZ5yFV+uGKHjwPLH2VqJ2b3kQWRdTvTwyNBwIWee091RO4tJ
Z3hfVYQYJQmWqlb6qumJTFuWJvvxuQ09LVh3pfgYGJy1mKc7KHsHuL7Cj5kLLTyr
Q9XXUV+fR+hqQVnNS+ee1m1J2g/7hHLsh0cwFuKQ5GTAijbjS3il7Vj/hG5eJzJY
QYzfRRFE22Q+VINvtOkaAS3cWDt5p9xlCqyiXCcdNYa27GPY1R9PmQ1lsMx25TvE
A5Cx1878Sdxp1wmgGSgA183qIEPHjfPL/08DzSFaOg0EJqnptR37Ki43748Ye03y
QUsJYuzixFyK2qHxJ0oCxF8XF3e72rjZi2dC1s9MvmvaNF2neyVajSesoAyN1374
lNcV0BkXQrvPZEOu8hInyuKv+WxuV6i5nh/SdXIyflMYLg/mEyKPNXV70YzN/7K5
QuDE9Do+v8QUGr+u/vevuFY5oyrz/l3NxnJbR+agIGu+ulxER0CLxI7vHiwYhm3E
dL7fewPDlpcFMWLPp9G+fVqo80Twt1sA3sn5/a8SavxC3KEnu07StaXOyGY1H1Yc
73cwrx++bZbZQEDeq6y0L/d/g0SNVyAFxtnEhOAIKs/p7seHLqvXIEfk0//+tbzH
d3a+CIYhjuj4sWUOLn4rIfMapI0BC5ZrTghJrC5SnWlX/2OXCnQ=
=9lBV
-----END PGP SIGNATURE-----

--L+ofChggJdETEG3Y--
