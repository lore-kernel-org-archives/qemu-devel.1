Received: from eggs.gnu.org ([2001:4830:134:3::10]:33211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecJiD-0004iw-Om
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 18:35:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecJiC-0002Cj-CH
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 18:35:13 -0500
Date: Fri, 19 Jan 2018 10:35:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118233505.GA30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<20180115063235.7518-7-sjitindarsingh@gmail.com>
	<20180118052029.GR30352@umbus.fritz.box>
	<0cdab21f-0f70-f705-9ae3-e95eea69f65e@ozlabs.ru>
	<20180118055348.GU30352@umbus.fritz.box>
	<3680b2ae-def7-9b00-81d8-eb66ec0bea4e@ozlabs.ru>
	<650522f0-9667-f6c5-1c45-b54619440b69@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5LK7OEqpP/xdrAG9"
Content-Disposition: inline
In-Reply-To: <650522f0-9667-f6c5-1c45-b54619440b69@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 6/6]
 target/ppc/spapr: Add H-Call H_GET_CPU_CHARACTERISTICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--5LK7OEqpP/xdrAG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 02:30:27PM -0600, Eric Blake wrote:
> On 01/18/2018 02:11 AM, Alexey Kardashevskiy wrote:
>=20
> >>>> I think you just assert() for this.  The only way these could get a
> >>>> different value is if there's a bug elsewhere.
> >>>
> >>>
> >>> Why not return H_HARDWARE or other error?
> >>
> >> Because what's the guest supposed to do with it.=20
> >=20
> > "oops"
> >=20
> >> This is an internal
> >> qemu problem, so it should be dealt with via an internal qemu
> >> mechanism.
> >=20
> > Do we have assert() enabled in production? If not, then assert =3D=3D n=
oop,
> > error_report is just a noise.
>=20
> See commit 262a69f4.  Yes, assert() is enabled in production, for
> security reasons (aka it's easier to do that than to audit that
> migration is still safe even with no-op asserts).

TBH, assert()s usually aren't disabled in production.  That's the
theory behind them, but in practice AFAICT, the debugging utility
almost always outweighs the performance cost which is usually pretty
small.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5LK7OEqpP/xdrAG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphLykACgkQbDjKyiDZ
s5KT9w//ZoAxVrlntxNtB8nT1XJs+s9RnizJ+ZkRb+/BfSyRoGgO07xV0cypCDLF
gHVNOpEl4joBV3OXEilYEOxMZ9dT6twuO7QQvgEcMV+zBo2OJy3PNg7m5ttsZqpj
Kq5tVk2C2B0BHxTs+X6IQiqmqFYWkLDJMt7AOS+bU0NwHhEq/XG52wNCoR66QQHR
SfKbwg6U9G5zbKW2Vcm2GEmMxuaAmf469mXxfjzVi8/AUnT0G73WZs0rFsj9s8YO
jedQCntqumcNz0ElS7Dhgfq2y+pGAATurtasZQA/zWgQlDLwUJ/hlMQslMJ7rCip
8JQSQtP5HtEKsPoJnI7CPl5JWCfRu4ALDy9xM6D6eFIJZn/7eViGLqWGtnSRe3cU
GH4QGO6Wh0pI/BoYgIu6Sr5Seoer9zcGB4DYxP40g12qrZ7iYmPJ+QRTETvqqVZc
KFBDXp4YmLxAnnsN29sSBZzWGHFjq9C+XHdLVGKuOG4tWDb948X82eXNR4j9Zzd2
B+8WrUM9yKXJwuhkSRmjrY65PrpTk6P8Wpaj9w2Nw7nS46qKVo2iMGJrzjR8hpay
6m5r1Dorwz76TuhZZH57t/zLtmv2mUaksW5vLue9qDbuI5FEh23sxGZ7wfAQXYb7
2xcEYp3Q7mYnDvODXGKGwbkmlnMT9L3lDPZanjYUnYfYn4UwjGs=
=nk+o
-----END PGP SIGNATURE-----

--5LK7OEqpP/xdrAG9--
