Received: from eggs.gnu.org ([2001:4830:134:3::10]:35607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXgZ3-00023K-8O
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXgZ1-0003x2-Ud
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:26:21 -0400
Date: Wed, 19 Jul 2017 14:25:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170719042543.GV3140@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436617.3350.9.camel@kernel.crashing.org>
	<20170719040150.GU3140@umbus.fritz.box>
	<1500437897.3350.17.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tYlHSoJ8Aop8eNG2"
Content-Disposition: inline
In-Reply-To: <1500437897.3350.17.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--tYlHSoJ8Aop8eNG2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2017 at 02:18:17PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2017-07-19 at 14:01 +1000, David Gibson wrote:
> > On Wed, Jul 19, 2017 at 01:56:57PM +1000, Benjamin Herrenschmidt wrote:
> > > On Wed, 2017-07-19 at 13:08 +1000, David Gibson wrote:
> > > > On Wed, Jul 05, 2017 at 07:13:17PM +0200, C=E9dric Le Goater wrote:
> > > > > Let's provide an empty shell for the XIVE controller model with a
> > > > > couple of attributes for the IRQ number allocator. The latter is
> > > > > largely inspired by OPAL which allocates IPI IRQ numbers from the
> > > > > bottom of the IRQ number space and allocates the HW IRQ numbers f=
rom
> > > > > the top.
> > > > >=20
> > > > > The number of IPIs is simply deduced from the max number of CPUs =
the
> > > > > guest supports and we provision a arbitrary number of HW irqs.
> > > > >=20
> > > > > The XIVE object is kept private because it will hold internal tab=
les
> > > > > which do not need to be exposed to sPAPR.
> > >=20
> > > It does have an MMIO presence though... more than one even. There's t=
he
> > > TIMA (per-HW thread control area) and there's the per-interrupt MMIO
> > > space which are exposed to the guest. There's also the per-queue
> > > MMIO control area too.
> >=20
> > Ok.  Always?  Or just on powernv?
> >=20
> > If it only has an MMIO presence on powernv, then the "core" xive
> > object should probably be TYPE_DEVICE, with the powernv specific
> > device being a SysBusDevice which incorporates the core xive device
> > inside it.
>=20
> No the ones above are on PAPR. PowerNV has even more :-)

Ok.  SusBusDevice is reasonable then.

> The TIMA (thread management area) is the MMIO area through which
> you control the current CPU priority etc...
>=20
> It's designed in HW to "know" which core/thread is accessing it (it's
> at a fixed address) and respond appropriately based on that and which
> virtual CPU has been activated on that core/thread.
>=20
> It's part of what allows XIVE to deliver interrupts without any HV
> calls.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tYlHSoJ8Aop8eNG2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllu30YACgkQbDjKyiDZ
s5LwlxAA3ijoiCvP1kSzXbb8d168GY8j0sqnu9FWG3E2zOumS2oAPwW82AJjygyr
XdhYx+Lz4PMHjXEBJjWqOzFSGJRDgeWRTlsMSNP+C9CqdSuSHMS9DubIy2VPBjpi
EKTGOI8tUJkC6dv43QTM3gpTO49v2Wdut4dKGKpzxUZrkC2f7Ta37/QcSfABL7DP
eomkIfOy9UzoJpwYEn2b9DwzYdMnEdfvsVQilp+HvZmFcSHky/rvuf4DIA3VnxpJ
ZUaWAB69SHg3y4mwMaYg8ujhpXfZ1k0E+TumudexG0ClvxtqBuLLSTsHKrwuou7a
AVrLzQtkRE1WQWA45wdmVsQXoJKJDVf4tnccyH5zvA3jJzpJ/0dfX5tdfZ30zyw7
DH/LyePLg/hW/iF4bdyYDRva6//COHfPwOXUxnEVYHMgTsQu8GUIKKPtzeJ2UcxA
mZY4KZWqZVEcjAZ2LE58JNTnKXY8Zg/t7vel8GMg89R6etRIhPSSYPaQst49pAm6
GgVgNk73MnGW0ssWO8t4rDrjYpeP1JDR3hb/jSjKPsMsVN6bFudCzV9i+rpZi8DG
TLmzPoX9ihvuKCJumgY8b7v2Je7iY6Esd9Ho+vsG4RtMbVM6oHi4oLEaDzXMXDqZ
NDR6dVENCnEq9qR6+bD9cVYRcJGN60bsjZ0nvpbgw6w8HqrwzJI=
=0fwp
-----END PGP SIGNATURE-----

--tYlHSoJ8Aop8eNG2--
