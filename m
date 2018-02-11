Received: from eggs.gnu.org ([2001:4830:134:3::10]:36951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekmhE-0002Gp-An
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 03:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekmhD-00005i-0t
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 03:09:12 -0500
Date: Sun, 11 Feb 2018 19:08:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180211080831.GC11634@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
	<1513896817.2743.63.camel@kernel.crashing.org>
	<683d0912-ad48-927c-8235-5358417be44c@kaod.org>
	<1516187433.31850.189.camel@kernel.crashing.org>
	<2226ed5e-f666-8060-2edd-998d2f5107ed@kaod.org>
	<1516224472.31850.193.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uLm21ivgZj9Xvi41"
Content-Disposition: inline
In-Reply-To: <1516224472.31850.193.camel@kernel.crashing.org>
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


--uLm21ivgZj9Xvi41
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 08:27:52AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2018-01-17 at 15:39 +0100, C=E9dric Le Goater wrote:
> > Migration is a problem. We will need both backend QEMU objects to be=20
> > available anyhow if we want to migrate. So we are back to the current=
=20
> > solution creating both QEMU objects but we can try to defer some of the=
=20
> > KVM inits and create the KVM device on demand at CAS time.
>=20
> Do we have a way to migrate a piece of info from the machine *first*
> that indicate what type of XICS/XIVE to instanciate ?

Nope.  qemu migration doesn't work like that.  Yes, it should, and
everyone knows it, but changing it is a really long term project.

>=20
> > The next problem is the ICP object that currently needs the KVM device=
=20
> > fd to connect the vcpus ... So, we will need to change that also.=20
> > That is probably the biggest problem today. We need a way to disconnect=
=20
> > the vpcu from the KVM device and see how we can defer the connection.
> > I need to make sure this is possible, I can check that without XIVE
>=20
> Ben.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uLm21ivgZj9Xvi41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp/+f0ACgkQbDjKyiDZ
s5JN0RAAvBVPVQ32F/jPri/yYkOGR4otkDkIu1YxdISio2MEzla2Ptae5CvJMWMn
MbsfqkY4+A29iGqi+vhcWPlMdJsMXZiK4DQ5tDMeA2HtCe7uI1Y8XEOowFBHlNRp
HE+h2qKPnf4t4itl7cx/USlatTUcy5ZJxLqdiO3U4GET7EoaQjPc1j78UmX2g31r
AWMHQGVxdEs1tg9PGHMaA6kvi+cIbdG9SdXSG7DAtmJDF3M/f7Q+PkqkxwTDcgUX
drDlXYpR9c5V8Bd3aDrhd1BdGX+b+OuSaWilUbu3VNRZ5YnL/R5GWM1nZujhd/5k
IvEGozYAj+qlF7vWjgK82KMmuNESQ0ALVhC7ryd5qVyQ7Fme4vE39fYUeZLuS7Rc
yLNzKeYrrcNmiE9QjaWdY1i+5bGjJR9S2Vwfozbyz5bCaqQF0UzV1YLQPKjMBpsR
1Qa1D7z4XILFVHEQQSEix9fcvdVmqk463Awe+9w2m8YzBY6A76ZGDRM6jkOOOzsZ
myDYo5cYpIXnfAo6KsP26gRwOW67lC0Gkh4hhZYsWRMlhpPCMo2jJOgq4z3HjHaX
oi6pEL+bp6QssA/pz5uIltcuFAagT/UvB50x6Hrk1p7tA+1EFM2Y4ZQcN1eKqDvm
krcD3bQ20hfpcSVcAiSGrpbPeOhdK4FeCgZKsJsRqu4nNVA6/YM=
=gPIe
-----END PGP SIGNATURE-----

--uLm21ivgZj9Xvi41--
