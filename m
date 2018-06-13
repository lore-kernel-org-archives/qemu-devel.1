Received: from eggs.gnu.org ([2001:4830:134:3::10]:36992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT29S-0007Fm-DE
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT29O-0006ta-Fq
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 05:33:14 -0400
Date: Wed, 13 Jun 2018 18:52:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613085246.GZ30690@umbus.fritz.box>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-2-david@gibson.dropbear.id.au>
	<6a1cc08b-5509-f03d-7da7-97429d7003c5@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1RfOVxRbNnn9f8MI"
Content-Disposition: inline
In-Reply-To: <6a1cc08b-5509-f03d-7da7-97429d7003c5@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 1/7] spapr: Clean up cpu realize/unrealize
 paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--1RfOVxRbNnn9f8MI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:11:45AM +0200, C=E9dric Le Goater wrote:
> On 06/13/2018 08:57 AM, David Gibson wrote:
> > spapr_cpu_init() and spapr_cpu_destroy() are only called from the spapr
> > cpu core realize/unrealize paths, and really can only be called from th=
ere.
> >=20
> > Those are all short functions, so fold the pairs together for simplicit=
y.
> > While we're there rename some functions and change some parameter types
> > for brevity and clarity.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> Still a call to spapr_cpu_reset(cpu). We should try to get rid of it
> one day.

Yeah, I know.  I'm wrestling with that along with some of the pagesize
stuff.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1RfOVxRbNnn9f8MI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg21sACgkQbDjKyiDZ
s5ImXQ/+Nc3CC3ScitfRrT8DNDc4STDGsmwnoy18Ep5Hnf5FPWecAJgiSRC7aLHH
oP22gsKfbrIrPGAjgzQRcR2obP2oIzZshFuwtNjj8iCFmpQg/Kk439A0m6iuaW0P
iYRmr3ibU3uInD4LEYSL08vZJ8IoGgzQ3ofpuhfBHOSEHu4jaUckxQsNEyADGfjV
gi6gyl1qrD79Dn3o34bozPiGVvQHL/nXR95IeLtaS5PW8uJNswKwXXaqHDpLY2sB
FBPjbDEz5uBEtRoP2EwffGp3aXq75FJQX7+ir/4PG8V0LIk8UTKz8RjIxtmeQZ0h
R4p8cppr9ktjtBdUrmJyg1YeK3cujjdaixpCbBgD55q0k9JASUX+BbFR+NBSe2aS
YBUGbV5k7aqMbe+rhP3OrmQ/bNqpprGP5gR+j2zKENR4xA5BeT3k5N7FH5mAZQJR
iMwjXuHnbv4Vu6zl6JYhEPgHiE7b/eXlPEdMKaodTva3Z72hrF/3LwDzrJ+iI4t+
gtDzlO9FieYSLRwSfJMCu4g2bxbi20/EVziu9X9chtnbCSYKAGnPjhg9Lbu9MHjm
44mJwdYKOvNED76VSalVID27nfO9twYs3/5SwIz1CQqC6c8JHjm73qNXQP9qZoTN
DKu1gDvxYwPWLB6RNsYD3FvCWgLsJtbxZsjitta1pd537knoJP4=
=1+KQ
-----END PGP SIGNATURE-----

--1RfOVxRbNnn9f8MI--
