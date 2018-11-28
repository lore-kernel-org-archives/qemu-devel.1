Received: from eggs.gnu.org ([2001:4830:134:3::10]:53568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRpnl-0007Cg-8V
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 21:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRpnk-00026u-EF
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 21:42:09 -0500
Date: Wed, 28 Nov 2018 13:41:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181128024158.GV2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-10-clg@kaod.org>
	<20181128001324.GS2251@umbus.fritz.box>
	<e49e34890be88a484b61e62e9a128ca3ff4f67ab.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="buDNgeHiu+HCsDEc"
Content-Disposition: inline
In-Reply-To: <e49e34890be88a484b61e62e9a128ca3ff4f67ab.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH v5 09/36] ppc/xive: notify the CPU when the
 interrupt priority is more privileged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--buDNgeHiu+HCsDEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 01:32:21PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2018-11-28 at 11:13 +1100, David Gibson wrote:
> > Don't you need a cast to avoid (nsr << 8) being a shift-wider-than-size?
>=20
> Shouldn't be a problem as long as it fits in an int, no ?

I dunno, I can never remember the rules about when C extends and when
it doesn't.  I'm not sure anybody does, which is kind of the point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--buDNgeHiu+HCsDEc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv+AHYACgkQbDjKyiDZ
s5LjwBAAkWLFmB0UO7B3RB3eRrx1KXeDXHK/wgFmBb6WEFFBcuFVP/N1P2Zyc8Lh
oe//exRn1QATb8+sRxJs5rXVNbuO7tY3Hn2vjHwaxcpYkeJJkHQQ6IQ5LZS7peZK
zE420nq0lqlWxB62bG+FdltdmYDiNP7xwPrY4ABJHj5giAkSwGSrXolDDGPjFht/
8pNj+wUouVoLY8k/aDHiXBYEd6hoN36ezdu8ZEgelYm+5CoorQcg+N3rqdFp5ldY
ZrwjwTAmqqFfci0GAv8jyrYgFS8TqwKtuGFqNzmljTaplNVD381dkThqrxE/y0ND
E2wYZJXKuGb8rC3NJMDVAyp7AcAwi0N5oU14bD194KyvZCRWH+DURYy5uejb/nc2
oLKDTaS76b2NEX0NZ0H+j0RbvaBtth5nbIq9t1Y9qMpbQx6vQZN6h6tTAzFKNmGx
+JAo6fAmpVrdt8knrJpWULzBy8BcjleSMNVU2UT40GkbsGf4Gp3kgGnfqTmgeUPq
AWv8N3uvZnoTakD5fITPBrAEsc3nBvIXbjiu8+UK64nH/pibg/ka4ze//2KAlisd
uLe56B1cXh9RTekqN4118IWTjgTqi5bITP1Dt2u/TJGNKG8FGqnVLNrJrBXpZ76F
qvTuhAv/RLOJKa/nGqyz6mBVQiSORQmrrQIChLA7hwL6elCIYUo=
=sqFJ
-----END PGP SIGNATURE-----

--buDNgeHiu+HCsDEc--
