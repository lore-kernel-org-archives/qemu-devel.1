Received: from eggs.gnu.org ([2001:4830:134:3::10]:47623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQMhe-0004Tf-K3
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fQMhd-00083U-He
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 20:53:30 -0400
Date: Wed, 6 Jun 2018 10:53:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180606005317.GD17757@umbus.fritz.box>
References: <20180507180835.4b7b9222@bahia.lan>
	<20180507165242.46502-1-leandro.lupori@gmail.com>
	<20180604005322.GE4251@umbus> <20180605184612.42099707@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <20180605184612.42099707@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3] target/ppc: Allow PIR read in
 privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: luporl <leandro.lupori@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 06:46:12PM +0200, Greg Kurz wrote:
> On Mon, 4 Jun 2018 10:53:22 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, May 07, 2018 at 01:52:42PM -0300, luporl wrote:
> > > According to PowerISA, the PIR register should be readable in privile=
ged
> > > mode also, not only in hypervisor privileged mode.
> > >=20
> > > PowerISA 3.0 - 4.3.3 Processor Identification Register
> > >=20
> > > "Read access to the PIR is privileged; write access is not
> > > provided." =20
> >=20
> > Yes... but a little further down it says "The PIR is a hypervisor
> > resource".  Looking at the older 2.07 ISA, it says that
> > guest-supervisor mode reads to the PIR should be redirected to the
> > GPIR register, which this change won't accomplish.
> >=20
>=20
> Hmmm, there are two definitions for the PIR, one in Book III-S (4.3.3)
> and one in Book III-E (5.3.3). It looks like you're referring to the
> latter...
>=20
> [Category:Embedded.Hypervisor]
> Read accesses to the PIR in guest supervisor state are
> mapped to the GPIR.
>=20
> The Book III-S definition doesn't mention the GPIR.

Oops, sorry.  Yes the GPIR stuff is only for BookE.  The statement
about the PIR being a hypervisor resource is definitely in the BookS
section, however (both 2.07 and 3.0).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsXMH0ACgkQbDjKyiDZ
s5I26RAAxNnVUBDiYGowBfy1AqUD7vuv1QWoQZ9P1cwySPWi6JJj+lX988q+h2bg
qvFcgm3GxB8/zu7sWPxjWK2MM+36UNxaSJsjS/VbmgnQyP7DPXE2dccCIIPM6BhH
qd3CCDDaUnvQHAqEmX73fC9WLSZUYQYGliuA+tylY1LtJJrwE9EDoJNJHZNABhiZ
UWYkdUC2P/KGqlSz3qpavpMmC3lbe0tw1Cdhh0gjV/k3nyqBr7hd3oXlp6BWnsmb
gpe8Y5k70nup+hwkYiiNWMPHDcFGTByPm2YHj53NYwzkMmPhF/B00r27piExcDP3
LJBLqbH1dN0HbRc/7Kx7xeDTPQvTWGcqoc0QknR6JYQfEURxQ7MxcDqNEuAKAKAo
jpLwXL0cel3NaDUZNYuCI5j0uVg89ZA9o9jYKcN84O8WwV5Npm9engG8EblSuBd1
d5tiym2hPkWrZ+MthVN0F1feNHhD0e8b8dyhfYB0CXYaj2utZwtaTjcyC+lIuEpC
9uRvBpQZMHSm6Z9wsmdl8WVBDIGeZbWb2b7i6h7/P4gaO8yp3FKAeD5A2xnm82eV
CAhgdD9XKG/MIAffRc2ft2DCWRmjtNhcSt5vhGfUIly9p6Jd8nLL2iMj8qSz3YZJ
R0x2hqC8Kye43gcyiTwjUWMMmbQbPNWLcB/iAMoz3PVAdOHGPRw=
=T7xy
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
