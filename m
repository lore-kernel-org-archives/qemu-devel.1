Received: from eggs.gnu.org ([2001:4830:134:3::10]:51948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6UcZ-00071K-3z
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6UcU-0005Pl-Mq
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 01:18:07 -0400
Date: Thu, 12 Apr 2018 15:16:53 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412051653.GO9425@umbus.fritz.box>
References: <20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
	<20180211080831.GC11634@umbus.fritz.box>
	<1518389717.2312.245.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iEWWOZ/QYGWEaBRW"
Content-Disposition: inline
In-Reply-To: <1518389717.2312.245.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>


--iEWWOZ/QYGWEaBRW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 09:55:17AM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2018-02-11 at 19:08 +1100, David Gibson wrote:
> > On Thu, Jan 18, 2018 at 08:27:52AM +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2018-01-17 at 15:39 +0100, C=E9dric Le Goater wrote:
> > > > Migration is a problem. We will need both backend QEMU objects to b=
e=20
> > > > available anyhow if we want to migrate. So we are back to the curre=
nt=20
> > > > solution creating both QEMU objects but we can try to defer some of=
 the=20
> > > > KVM inits and create the KVM device on demand at CAS time.
> > >=20
> > > Do we have a way to migrate a piece of info from the machine *first*
> > > that indicate what type of XICS/XIVE to instanciate ?
> >=20
> > Nope.  qemu migration doesn't work like that.  Yes, it should, and
> > everyone knows it, but changing it is a really long term project.
>=20
> Well, we have a problem then. It looks like Qemu broken migration is
> fundamentally incompatible with PAPR and CAS design...

Hrm, the fit is very clunky certainly, but i think we can make it work.

> I know we don't migrate the configuration, that's not exactly what I
> had in mind tho... Can we have some piece of *data* from the machine be
> migrated first, and use it on the target to reconfigure the interrupt
> controller before the stream arrives ?

Sorta.. maybe.. but it would probably get really ugly if we don't
preserve the usual way object lifetimes work.

> Otherwise, we have indeed no much choice but the horrible wart of
> creating both interrupt controllers with only one "active".

I really think this is the way to go, warts and all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iEWWOZ/QYGWEaBRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrO68UACgkQbDjKyiDZ
s5LgRxAAnHzY9TrOSUZvh5R/N6jZ+2mwPTIDOcDUQ9y03tgWtoThOV8WfUouMIqk
a8ojlpdXcCATLXK1ECctHtk6qRTL7sGxrYZXAjfZdnEEoRmnNmBJ9o1Yx7LcgwdN
BK5RbAeT12qltfWJMzGkYQ3aRHECI3WG8NUiPHFDoUKOouQGxqz//WLK2M0VeztR
4kV53dv6ntkVoDaFsih8D/36SLiQj8Ac7f43cPZnPsb6ICrVW5U+2yR5PNtUhUQB
cf4CC5owDA+qXQobjbCc126py4BB2dPBqL6sSQE7AGG4NK91ZNvXnKzAhSQUMkob
PE9JSq+EWet6sVobSt5kpZu9xDSkRtuHO6kIXwxD9GWEx+hWIrxhblm0TsMJcL3/
S3svImGlKbhYWPVfbKKTAkxqBH9ELgeYG0FoPVvZ0j1dNKESAd0BtylhIKpsc5bQ
nsSiY+5aSApdAsVop0PBpQ7DO3i8nrHZDjhEWLoauiaSfDIWDJCayrbl3TlDNKdy
GuESPvg/pQD6id1lu2WFYMSnGWLjlXSYQcYJuQssDSYQReNo+LFte1TjzUBfYWiD
PYEb9Kl2TMkRz3JwXw+558Sv4RbArCQi2lDCQ6vPVzynG6xa8bI6M/sLnuccQ9qQ
mn2D1h+gvJxnJPgYNfP7a7CEkpOaYl3W3xSsPYgOAWtr5WBibtI=
=FylK
-----END PGP SIGNATURE-----

--iEWWOZ/QYGWEaBRW--
