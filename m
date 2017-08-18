Received: from eggs.gnu.org ([2001:4830:134:3::10]:60557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diy44-0006ba-Ks
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 03:21:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diy3z-0000jy-Vg
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 03:21:00 -0400
Date: Fri, 18 Aug 2017 22:18:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170818121850.GC3658@umbus.fritz.box>
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<20170818015321.GN5509@umbus.fritz.box>
	<194c2b39-e36a-24ea-1ba4-527593b7226f@free.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Content-Disposition: inline
In-Reply-To: <194c2b39-e36a-24ea-1ba4-527593b7226f@free.fr>
Subject: Re: [Qemu-devel] [RFC PATCH 09/12] ppc440: Add emulation of
 plb-pcix controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Fran=E7ois?= Revol <revol@free.fr>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 01:07:28PM +0200, Fran=E7ois Revol wrote:
> Hi,
>=20
> Le 18/08/2017 =E0 03:53, David Gibson a =E9crit :
> > On Sun, Aug 13, 2017 at 07:04:38PM +0200, BALATON Zoltan wrote:
> >=20
> > You know I'm going to say it, right: needs a commit message.
> >=20
> > What's a "plb-pcix", and what's an example of a 440 SoCs which has it.
>=20
> IIRC that's the PCI(express) controller, which is not memory-mapped but
> inside the DCR address space, so accessed from the PLB.
>=20
> See:
>=20
> http://www.embeddeddeveloper.com/assets/processors/amcc/datasheets/PP460E=
X_DS2063.pdf
>=20
> page 9, 13.

Sure, I can guess that.  But my point is that this is the sort of
information (including the link) that ought to be in the commit
message.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmW2ycACgkQbDjKyiDZ
s5JD3BAApmj/yakalPHbJxC5JNtLbk2UmkUjrjcnCW9fxpHbhCvMwyjVzi34C088
jYwCVqcPgd9woPKdfXGTLFvgqEJ6YhGEtI7pJNQYMIQ+hjE80FkqhXWch/u4FvCF
GbsGJ4ZQdeqCH/xLGHJPp/xGqBnrncFkBr8XDI7dFW60dhcLIKY4CGLwW5rSO4EK
li0iWhylS2estoTlPxlj8EsTwyS0VptqA5hS7U9V0tTjpSmjRhP+k2mRI+fakhvd
BTwgpgEQlk4jypBw1Kp7qxYh6sQMFN1R9l30UrFLOQDXUW2+6o2eOaUlr84ksmfb
zLWIDn1nrYoWccIWkpC7KLrfK9LaA5i4EUFfClOsNzLB2CqUyn5UXwhMpwTP0JgF
1Y2ue+sCs20srEkT2N191L8e5b+CmrIXmIJUMnKX25fiLRi1asYlj530Jf2gV5pW
EeBVcs0qDhGC5cqH8np/I7sB6MMspagOxzYwa4n4McXruQIfvecTScAL6NgYdvwl
6v0FhPIetDbUS1kVaaDaBFd5PjTspWlmrXtQ/ALmcoCjsdCEUM1vux7FF3ktvmgT
vW5ALKsDaKQq1FrNYe3N+GOzmxGFzu9vMJwrnsZkPKVeEAard/RkE07U1wbBOFdA
+zp5dQNA0UAU9IuYdXj2nUOzq6Xbh+YtOLQaFcvGAsrEMHl02qU=
=CYJK
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
