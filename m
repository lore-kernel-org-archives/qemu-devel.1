Received: from eggs.gnu.org ([2001:4830:134:3::10]:34396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAqQF-0003VY-Rc
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dAqQF-0002t4-1L
	for qemu-devel@nongnu.org; Wed, 17 May 2017 00:18:51 -0400
Date: Wed, 17 May 2017 14:18:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170517041816.GG15596@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484840466.20089.893964776019028654.stgit@bahia.lan>
	<a94cf0ed-3318-fb2d-f16c-4d2b12fff3bb@kaod.org>
	<20170515151602.61dc381d@bahia>
	<b2fe560d-e8ef-dc47-2f7a-e06092a503b6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline
In-Reply-To: <b2fe560d-e8ef-dc47-2f7a-e06092a503b6@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 6/6] spapr: fix migration of ICP objects
 from/to older QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 06:11:27PM +0200, C=E9dric Le Goater wrote:
> >>> +        int smt =3D kvmppc_smt_threads();
> >>> +        int nr_servers =3D DIV_ROUND_UP(max_cpus * smt, smp_threads)=
; =20
> >>
> >> may be we should reintroduce nr_servers at the machine level ?=20
> >>
> >=20
> > I had reintroduced it but then I realized it was only used in this
> > function.
>=20
> nr_servers is also used when the device tree is populated with the=20
> interrupt controller nodes. No big deal.

Which is guest visible, so we should really make that stay the same
for older machine types.  I'd like to avoid re-introducing nr_servers
as a property if we can, but maybe we can't.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V32M1hWVjliPHW+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZG88IAAoJEGw4ysog2bOSXrUQAM8Z/kAWpysDY8mVS6/yDoO3
eOuhrVTeyaWZ+0zTvoja9iikpEzokYW8hIkHgAcWtQzHz8eCOtzM2tYcNZ7itKDd
nMt7BSi+2lfu2Pm7pLUMXplnCOBMuWyhN65adQ1qb6SwMcgL1f4VEYD1zpVcVN+R
GGa8BGEi+dJlk7PhBAPyyVFArBwFeuyJWJVeLe1eO9as1QnvXmrtwEURYMpWAVZU
TGh9gMB+zTN+enlETpeWMkmi6gSD5w72pEnBU6Gbn+2ee9CihhwGrjTIPjkVm9X9
slg2dLrhNasmmTQNnvBNZc3+13WJ8jUe3XimQBZZ42ehLs+ozAcMX/DhKDkPOeqT
LJ/rEOnloFaP4Wzgf7Vq/fOhOuZdy6JO5Us60+Lfxxd0x63JUXNKEYNYW7AYa1bx
o4dbMmcpAJQXwt0qIKW3hQRsEZFowfcvMq08Kg9fanO4KaVQJjq19z/idKCcqGdJ
/a8646VOkIB2Id36oD94yq8Y394A4OjeFibN5/FR5FSVlrHKNQ+kp0QkDotYvttI
PcwsjeXSxZ1QczYiGtzpFdkgeYJjf9+lT2miIPjCZSECw6uGH3EjKxbHHv3Lirrm
95U1J/HHP8DI8BW+DSD9OAl9xJEXoRAv5nHdKMJZEROT3DFJhzN4IKQ3Ez1ucgDq
0txC/gEK92v+9z+iUVQm
=5EpF
-----END PGP SIGNATURE-----

--V32M1hWVjliPHW+c--
