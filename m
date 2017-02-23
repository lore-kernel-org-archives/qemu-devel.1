Received: from eggs.gnu.org ([2001:4830:134:3::10]:50958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXg-0006ZJ-4F
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgkXd-0001Sg-2z
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:58:08 -0500
Date: Thu, 23 Feb 2017 14:43:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223034351.GH12577@umbus.fritz.box>
References: <1487563478-22265-1-git-send-email-sjitindarsingh@gmail.com>
	<1487563478-22265-2-git-send-email-sjitindarsingh@gmail.com>
	<20170220051626.GA661@balbir.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Xp2nimoPFnvF0aLh"
Content-Disposition: inline
In-Reply-To: <20170220051626.GA661@balbir.ozlabs.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 01/10]
 target/ppc/POWER9: Add ISAv3.00 MMU definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com


--Xp2nimoPFnvF0aLh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 04:16:26PM +1100, Balbir Singh wrote:
> On Mon, Feb 20, 2017 at 03:04:29PM +1100, Suraj Jitindar Singh wrote:
> > POWER9 processors implement the mmu as defined in version 3.00 of the I=
SA.
> >=20
> > Add a definition for this mmu model and set the POWER9 cpu model to use
> > this mmu model.
> >=20
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > ---
> >  target/ppc/cpu-qom.h        | 5 ++++-
> >  target/ppc/mmu_helper.c     | 2 ++
> >  target/ppc/translate_init.c | 3 +--
> >  3 files changed, 7 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > index b7977ba..4e3132b 100644
> > --- a/target/ppc/cpu-qom.h
> > +++ b/target/ppc/cpu-qom.h
> > @@ -86,10 +86,13 @@ enum powerpc_mmu_t {
> >      POWERPC_MMU_2_07       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> >                               | POWERPC_MMU_64K
> >                               | POWERPC_MMU_AMR | 0x00000004,
> > -    /* FIXME Add POWERPC_MMU_3_OO defines */
> >      /* Architecture 2.07 "degraded" (no 1T segments)           */
> >      POWERPC_MMU_2_07a      =3D POWERPC_MMU_64 | POWERPC_MMU_AMR
> >                               | 0x00000004,
> > +    /* Architecture 3.00 variant                               */
> > +    POWERPC_MMU_3_00       =3D POWERPC_MMU_64 | POWERPC_MMU_1TSEG
> > +                             | POWERPC_MMU_64K
> > +                             | POWERPC_MMU_AMR | 0x00000005,
>=20
> I wonder if we need a POWERPC_MMU_RADIX that we can then attach
> with future versions

That's probably a good idea.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Xp2nimoPFnvF0aLh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrlp3AAoJEGw4ysog2bOSEdAQAOHvMh3uoDi+f7M/gbGdAZxm
P2cvEhYbEoFq1DxJFdev2zW7htc9VNkgjkzkGZ7+jMMRGqMWqrcop/GUSucjMI/u
C9NAIrujxMDsM3csZidjibxTBOdgMVT/OWGtFWPaeChPZcTIbCQcc+tIvtQOhpRW
lLXMFyrML2+LjtZ/e2KvPgV+ovof/eQehZG4W2nB8t+xLnzYXnkCHqmAc8c12AzK
Cyiw4zUHfkc/uRN2jLNCeQBKdMDwb6aXAZYwyFFpg+TgnGnzonh3bGj7R26xsHgW
YyBh4ELAQypx8PUJkUKf98wO4xKFzmlzyMiyYZhjFDrR5+TE6prFbVxcKrLuOEPP
eoiR0QLlee4K+7W9EvJgJscgLTvELFR9g9cUNQqd2bVBk/LKQm0yvpumCs3DKRp1
81WeYxB/f8LNa4/3Ru6TAn/Ei0woEASmiW5nWcRtRkykTJPQLq6MTVUJVX10SKhR
vZ4rqbPP4DQ+zVAyFQJu8v9ZRgc47ip5zaxIUHBxMQEjNF2uFZfVIdupFgNQefEh
QAZbO4CfEGyIyU+F3aLMsOz17VtO61ZZcp+cItT7Q7gFQBLe3lk5vNnIZB5DCJq9
ZsMAzgzmwtUPLQhZOEt6yXAyTNDos1MsCe4grBA0XO2ol331mn8gzafvD26IYG3W
BuDglu43whoijj/OxQb/
=myfr
-----END PGP SIGNATURE-----

--Xp2nimoPFnvF0aLh--
