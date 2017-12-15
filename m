Received: from eggs.gnu.org ([2001:4830:134:3::10]:58934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePpcK-0007KU-7W
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ePpcE-0004Ya-7d
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 08:01:32 -0500
Date: Sat, 16 Dec 2017 00:01:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171215130115.GL7753@umbus.fritz.box>
References: <20171215061739.9494-1-clg@kaod.org>
	<df01dd59-d118-0bc4-3c1e-21bdaa3e47b0@ozlabs.ru>
	<40d07664-5f54-bd1c-f7f7-d11e7909e5a6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tv2SIFopg1r47n4a"
Content-Disposition: inline
In-Reply-To: <40d07664-5f54-bd1c-f7f7-d11e7909e5a6@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: change powernv_ prefix
 to pnv_ for overall naming consistency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--tv2SIFopg1r47n4a
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2017 at 08:16:57AM +0100, C=E9dric Le Goater wrote:
> On 12/15/2017 07:43 AM, Alexey Kardashevskiy wrote:
> > On 15/12/17 17:17, C=E9dric Le Goater wrote:
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/ppc/pnv.c         | 84 ++++++++++++++++++++++++++-----------------=
---------
> >>  hw/ppc/pnv_core.c    |  8 ++---
> >>  hw/ppc/pnv_lpc.c     |  2 +-
> >>  include/hw/ppc/pnv.h |  8 ++---
> >>  4 files changed, 51 insertions(+), 51 deletions(-)
> >>
> >> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> >> index c35c439d816b..4bc5f61d0da7 100644
> >> --- a/hw/ppc/pnv.c
> >> +++ b/hw/ppc/pnv.c
> >> @@ -77,7 +77,7 @@ static const char *pnv_chip_core_typename(const PnvC=
hip *o)
> >>   * that has a different "affinity". In practice, it means one range
> >>   * per chip.
> >>   */
> >> -static void powernv_populate_memory_node(void *fdt, int chip_id, hwad=
dr start,
> >> +static void pnv_populate_memory_node(void *fdt, int chip_id, hwaddr s=
tart,
> >>                                           hwaddr size)
> >=20
> > You may also want to fix indentations like the line above.
>=20
> yes. I missed that. I should run indent after using sed.
>=20
> While I am at it, I can also change the name of the routines=20
> populating the device tree.=20
>=20
> David,=20
>=20
> are you following more or less this pattern :
>=20
> 	<machine>_dt_<device>

Well, I'd only really thought about it for pseries, and I'm using
"spapr_dt_whatever()" there rather than "pseries_dt_whatever()".  Plus
that's where I'm intending to head, but I think there are still a fair
few exceptions.

"pnv_dt_whatever()" seems like a good convention for the powernv code,
though.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tv2SIFopg1r47n4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlozx5sACgkQbDjKyiDZ
s5J97w//QA2sPqnPgycVWu8nLxTphL1BHfs+xJxXYVaYb0fVJmyotM4+1pnwn8/E
LhiQoc7pCK489T4c5NVb1uyNLlNQ5LUOGy1mqEBfTOEu0FRXK5uJ+yG9/acMbRM4
kHchbG628bj+vKHzRnzOR3UMo62xoaa1sD/XehMM/ty2jIfOd8B3XQnPl2GNIfeV
nFkICM0bXSI0rcu6lx/7m9JNiC3jWzuEksPH9a2SOAhefg1sWbU/RzvbCSXD7anj
9lYC+b9FteVhiicwIB4qNsnZIxf5VtRoOqXFit83wSll5/tPnOqXnMwFcBqzug5P
IwIlLQA5H3P0/AyqriCm6FTdNb3/3aZFM21JG+LqYfoE2+19ZfmjUZyx4xHHIP2R
djUyhzN4VBB1yCoEIQ12ixglpWTLOXy+UTiKTeKl2ixXmq27ApAuaK+qNTBM2DpQ
oUlCTbRwy97FNKveZUNhQAQS6ALrfCXky/1dJORGlf1aZjqe0h3e3uecsSy9uRwP
7zfrcLfMjVXybH4ZoeoqXuGVyZAgSjhDEtPUfMW3hlTy25LRvvYlflVFkj3+E8Tq
1CXe58wONYX3j1V35GoPQXbYC5aBQqd/+aeiliA2gpgfoNXLiPklDx+OHvDY761C
vzrmZWCIKtDwdrxB7+tm4LhisYK88D7ddVhj8kyySVNIfIOxgD8=
=2i65
-----END PGP SIGNATURE-----

--tv2SIFopg1r47n4a--
