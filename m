Received: from eggs.gnu.org ([2001:4830:134:3::10]:45545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAmuQ-0007gS-2r
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 21:38:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAmuL-0004OX-Rc
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 21:38:18 -0400
Date: Tue, 24 Apr 2018 11:26:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180424012622.GM19804@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524472299.3017.20.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S66JdqtemGhvbcZP"
Content-Disposition: inline
In-Reply-To: <1524472299.3017.20.camel@redhat.com>
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org


--S66JdqtemGhvbcZP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 10:31:39AM +0200, Andrea Bolognani wrote:
> On Fri, 2018-04-20 at 20:21 +1000, David Gibson wrote:
> > On Fri, Apr 20, 2018 at 11:31:10AM +0200, Andrea Bolognani wrote:
> > > I'll check out what other distros are doing: if all the major ones
> > > are defaulting to 64 KiB pages these days, it might be reasonable
> > > to do the same and pretend smaller page sizes don't exist at all in
> > > order to avoid the pain of having to tweak yet another knob, even
> > > if that means leaving people compiling their own custom kernels
> > > with 4 KiB page size in the dust.
> >=20
> > That's my guess.
>=20
> I just checked RHEL 7, Fedora 27, OpenSUSE Leap 42.3, Debian 9 and
> Ubuntu 16.04: they all use 64 KiB pages, so I'd conclude leaving
> out 4 KiB pages support is basically a non-issue.

Good to hear, thanks for checking.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--S66JdqtemGhvbcZP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlreh74ACgkQbDjKyiDZ
s5LLOxAA5r5x1I/ROx1Zom2pqUKi+DXQD6AhcpqojcQLotA5fAo8f2Jsbp3Fuw7I
d3hjrtkQC8Gf4go5lsja2xBA5OGLtJdddlwwfHXTWou5F4Q/IUQgjB+MEsxEIBfW
bqH6+9jnEqrRIopMuzGhziM5OP2KNkU4IclwWMCSeWdvli9o2iTxFNKBccEKAZJ2
5en1kBEudu1GkImeeO/Z0VvdSmB609BZ58h/1iIxCFCTkMRvduUa+gKgS9oe8hmE
FtYgGCdb8vBb76J6zWerbhr3VWKx4EL1wfQOmYTvYetXBUFN+raSa7ObD/ttGkoh
e4XGxoqLOCiE5qYSS4TieY8TvMZaxrrouMdFW+7NzR795zdgSOWQmlkycf4Exo7s
BVXPrStM6sPL2jhFCm4ogrmuNcihuFluXuS5CgBod8uvwZKp3KbURJHH6UtqZTNJ
BPYAlUQeODAoUdUkoTjyY3Vg5e+7OdegxWPCPTQ8qZvqh+wJhs48hAs/kRNxJREj
sl0M2fJC/2R7hHRq5RFwxdP1utj80vjhzQ3EwTkFsrstf97s3OuBUW6IShw2YcTc
9S5wQWvjXmGzp8Yau+FFFGA8q5GxQe/PY0CjHkGnK7c8d8IQkzP6i0duUih8eQ4j
JnTRCvIq2rVKGg57/9K9i2IJDbNRiXsEh4wuMdU6jtPH5kLgGss=
=Cuit
-----END PGP SIGNATURE-----

--S66JdqtemGhvbcZP--
