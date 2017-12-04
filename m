Received: from eggs.gnu.org ([2001:4830:134:3::10]:44587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfw3-0006VS-4I
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:52:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfw2-0000cy-3M
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:52:43 -0500
Date: Mon, 4 Dec 2017 12:20:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204012029.GI2130@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-15-clg@kaod.org>
	<20171130044922.GC3023@umbus.fritz.box>
	<36b5b7a1-63f1-30ac-0fa6-a22b49df065f@kaod.org>
	<20171201041015.GE30161@umbus.fritz.box>
	<1512225938.2224.69.camel@kernel.crashing.org>
	<1512225979.2224.70.camel@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZY5CS28jBCfb727c"
Content-Disposition: inline
In-Reply-To: <1512225979.2224.70.camel@au1.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 14/25] spapr: push the XIVE EQ data in OS
 event queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ZY5CS28jBCfb727c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2017 at 08:46:19AM -0600, Benjamin Herrenschmidt wrote:
> On Sat, 2017-12-02 at 08:45 -0600, Benjamin Herrenschmidt wrote:
> > On Fri, 2017-12-01 at 15:10 +1100, David Gibson wrote:
> > >=20
> > > Hm, ok.  Guest endian (or at least, not definitively host-endian) data
> > > in a plain uint32_t makes me uncomfortable.  Could we use char data[4]
> > > instead, to make it clear it's a byte-ordered buffer, rather than a
> > > number as far as the XIVE is concerned.
> > >=20
> > > Hm.. except that doesn't quite work, because the hardware must define
> > > which end that generation bit ends up in...
> >=20
> > It also needs to be written atomically. Just say it's big endian.
>=20
> Also the guest reads it using be32_to_cpup...

Ok.  Definitely should be treated as BE and read/written with the be32
DMA helper functions.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZY5CS28jBCfb727c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlokot0ACgkQbDjKyiDZ
s5I+Pg//ULFqFeGKqWfeky16NUwkHTj7Yeck9v73HEUkkLHRpoLWtvKqsZnvTgV0
BVdgTinIOZg6VsrCiuF9kHkLxV6WsnlE2wF+KP7EnM0e7wDx9At5rFUuFjPhQK4C
6PbkFWheL/qjUuV2S4kHdrYB0Ae+c66XOHiJUwaKroOkByR9HQpSf754KBeh27+2
iKHtIRd+PcO/t7eNpQdOVqIQlypgD+HO7kIhLZ6chuqBxzp+2LmdIbSSW4b4tm/M
JaCpzrnkPMFAiz+t7833fKGmDETwDKm1h4WgHgkL9qcxddktRMoVvexSunO1a95i
2ix0AJHJqAOSOLD+toK3N359c3UU8b94kNIwh4UHjADlDcoD/aC0K1MRkyErZ2dK
MuMEUGGvEhA2A1bhinb0WbLkfDNjMM7S7cgQEdeUQZVSEASpk48XaU191LnyYrtW
qYq72dfCUsn/YZkO0iDEanHDsORw80xmc1qA5pWrZqbea3YUiJwo7HarL265SMqx
ZZk+0nygX1iQRNKntA5twW+Spsvm1a+Mpf5dlJNviwB/dxgxRUD+6hRXft8pRPoY
UraSSyXTH149dbIfuCZfA8qAKn3E/tYbnbQvJmo2u4cRwDZwjU+TEZqOkLhoNWQ7
dOB/f2FZuKZ8V1B7ylD53rJPJiKEOyVjaT9FYtqmCJegm1m+DOU=
=75DD
-----END PGP SIGNATURE-----

--ZY5CS28jBCfb727c--
