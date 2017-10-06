Received: from eggs.gnu.org ([2001:4830:134:3::10]:36358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Pio-0005cW-Er
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0Pik-0005f3-7m
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:19:10 -0400
Date: Fri, 6 Oct 2017 21:10:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006101010.GK10961@umbus.fritz.box>
References: <20171005164959.26024-1-clg@kaod.org>
	<20171005164959.26024-2-clg@kaod.org>
	<20171006090722.GD10961@umbus.fritz.box>
	<1507283610.25065.148.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDymnuGqqhW10CwH"
Content-Disposition: inline
In-Reply-To: <1507283610.25065.148.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] spapr/rtas: disable the decrementer
 interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>


--qDymnuGqqhW10CwH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 11:53:30AM +0200, Benjamin Herrenschmidt wrote:
> On Fri, 2017-10-06 at 20:07 +1100, David Gibson wrote:
> > Hm.  Checking mmu_model doesn't seem right to me.  I mean, it'll get
> > the right answer in practice, but the LPCR programming has nothing
> > whatsoever to do with the MMU.
> >=20
> > I think explicitly checking if cpu_ is a POWER9 instance with
> > object_dynamic_cast would be a better option.
>=20
> Best is ARCH 300 ... do we hvae arch versions outside of MMU model
> these days ?

Not that I could spot easily.  Apart from implicitly in the cpu
family.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qDymnuGqqhW10CwH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXVn0ACgkQbDjKyiDZ
s5KQVA//URw+SiGytb7SBGMTTP/RVqIKOZGZuKoiY45TWv6IbDuLPc1PnN6Gy5k+
brOklcxl/KRcuWLj/A8jgFa+ThHPIMYnqkNVmp5ol6Qo1Tltjpipaln/Qjj2epTx
rurdo/Ao4NnsnP917VHMQo21HtViRl1f/5YyAJa0B+TW+YTpROlV9A/8VyvnUU4h
4nvji5CbDoIR2ZcOp+D704Vnd8RVjke/2X1z+7u8OiVbDXXMMK9CMF3/8rPhMfg4
6tovqwbD0+IM3WIaqujU18luM8ZHtSP0Q9hwkfBVlMeXJox0AaL+45xdXV/D5QyP
8u8MW4c8vn1fuyBM/1JgN0OYWYPqaegEC8bmVhpe+LUm5XLNPl9xsWX98apWeB70
PEWdpUlrsi3+9b1vYVmnS6USXzHX1USEnfPGz4cnQ6DbmNEBNOT7itY792/V6+kD
EwAXbNxo7KvnLAhMTaTbvAPc41pbNQ/eS9jW5o/agQUSU6VcK7Sg+kC23N8sdHPw
wSniSKimgqm+xdW9eHGEa8hZvPOqQlBvo3tgyaHUgHb9cgr5zPuwhVTgGm03oknj
apXyHtzHZLiNYzRlFh7EfQHLtPFzsNA6pNuzKfQ5bfocepg6gzQe5kDM22GsZSdh
8LOLp6KRB45L9qxNhh6Tr3phtyBltkXo8Pl1GZ+hEfnnkeo0hDE=
=pBUx
-----END PGP SIGNATURE-----

--qDymnuGqqhW10CwH--
