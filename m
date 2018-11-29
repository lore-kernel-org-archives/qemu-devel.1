Received: from eggs.gnu.org ([2001:4830:134:3::10]:52952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSVAA-0007xU-Vt
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSVA9-0007zl-Cf
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:52:02 -0500
Date: Fri, 30 Nov 2018 09:36:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129223651.GL14697@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-11-clg@kaod.org>
	<20181128005255.GT2251@umbus.fritz.box>
	<64aef78f-e374-9c6d-1a1f-892c4e3b0677@kaod.org>
	<20181129005402.GL2251@umbus.fritz.box>
	<a34655d5-0850-13f7-9407-a5c09f15341c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XRwESHC7KXlqFpSs"
Content-Disposition: inline
In-Reply-To: <a34655d5-0850-13f7-9407-a5c09f15341c@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 10/36] spapr/xive: introduce a XIVE
 interrupt controller
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


--XRwESHC7KXlqFpSs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 03:37:12PM +0100, C=E9dric Le Goater wrote:
> [ ... ]
> =20
> >>> With that approach it might make sense to embed it
> >>> here, rather than subclassing it=20
> >>
> >> ah. why not indeed. I have to think about it.=20
> >>
> >>> (the old composition vs. inheritance debate).
> >>
> >> he. but then the XiveRouter needs to become a QOM interface if we=20
> >> want to be able to define XIVE table accessors for sPAPRXive. See
> >> the  spapr_xive_class_init() routine.
> >=20
> > Erm.. I'm not really sure what you're getting at here.
>=20
> if we compose a sPAPRXive object with a XiveSource object and a XiveRoute=
r=20
> object, how will the  XiveRouter object access the XIVE internal tables=
=20
> which are in the sPAPRXive object ?=20
>=20
> Thinking of it, I am not sure a QOM interface would solve the problem now=
=2E=20
> So we are stuck with inheritance.

Uh.. true.  There are ways aroud it, but it gets a bit complicated.

> [ ... ]
>=20
> >>>> +qemu_irq spapr_xive_qirq(sPAPRXive *xive, uint32_t lisn)
> >>>> +{
> >>>> +    XiveSource *xsrc =3D &xive->source;
> >>>> +
> >>>> +    if (lisn >=3D xive->nr_irqs) {
> >>>> +        return NULL;
> >>>> +    }
> >>>> +
> >>>> +    if (!(xive->eat[lisn].w & EAS_VALID)) {
> >>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %x\n", l=
isn);
> >>>
> >>> I don't think this is a guest error - gettint the qirq by number
> >>> should generally be something qemu code does.
> >>
> >> Even if the IRQ was not defined by the machine ? The EAS_VALID bit is
> >> raised when the IRQ is enabled at the XIVE level, which means that the
> >> IRQ number has been claimed by some device of the machine. You cannot
> >> get a qirq by number for  some random IRQ number. Can you ?
> >=20
> > Well, you shouldn't.  The point is that it is qemu code (specifically
> > the machine setup stuff) that will be calling this, and it shouldn't
> > be calling it with irq numbers that haven't been
> > enabled/claimed/whatever.
>=20
> so it should be an assert ?

Yes.
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XRwESHC7KXlqFpSs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwAagEACgkQbDjKyiDZ
s5KXCxAAoK4H7t3D18NnYF09LtW0eq5oAyXDTqFSCrrTbiVUqWRnOHxIQ4BNruTA
SVqVbuoB18sl8bfsnmAhFi+ATPKYm9QAZojr0C2CQfUJ57fL+Mx3e20jB0EB0g7d
WQZDavjfOMMWPN2hdjF28PQxR2YRekQKk1kvT0BAkN6ZKwAJIYKfgix109lSMpMJ
+/LQWevgI5stvYK2d+RQAnhpzld0y3gcz0ViKNldrrdBqVJEAhH2+7T9VJegifwI
w40SJ/E8oyenfaPixf7LyuZz9H1VctKgC5IrXyhwneqENw+39RxqNYroc7jHEMYI
lqyKxMPLnbjIljmk7AJcLHWCXVpM+SJ6hOjYAChJ4k+vvLS4q1glocpaMz9i3CVA
v1AIaLftQjdz1D6xb3kHVHMPYMznKQaZiaLEQQk1o3NDHFgq+y/TcK7XM30kwLpF
kUAlkGN6SrEY29URc+OC6fZeC50b5eRW/UfbFQHfHLCGXX24SyI/XYc0uOH5qGoc
smZb37xgdIVDV7/ZCtbglbfYZ9cEerEdCIDGiBwRAR4+g+NTUzqqMtKvWyWYkx4T
FYBjLSpqddYlNaDwjak6Fu+g0kxD+e4k7W1Hir7lQH+1pN0Dj14syIGQmkBHXdPd
lm1TRzBP8FOnahKvqjsO4j7TpAMeczVcud/RpkCcpRJFPXErjGw=
=jACY
-----END PGP SIGNATURE-----

--XRwESHC7KXlqFpSs--
