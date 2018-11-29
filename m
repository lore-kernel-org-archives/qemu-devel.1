Received: from eggs.gnu.org ([2001:4830:134:3::10]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSVAE-0007yr-SY
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSVA9-00080Y-IM
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:52:04 -0500
Date: Fri, 30 Nov 2018 09:44:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129224416.GB30479@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-33-clg@kaod.org>
	<20181129041244.GH14697@umbus.fritz.box>
	<0afb583f-4474-7e44-f291-85010bdb173c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <0afb583f-4474-7e44-f291-85010bdb173c@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 32/36] spapr/rtas: modify
 spapr_rtas_register() to remove RTAS handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 05:40:18PM +0100, C=E9dric Le Goater wrote:
> On 11/29/18 5:12 AM, David Gibson wrote:
> > On Fri, Nov 16, 2018 at 11:57:25AM +0100, C=E9dric Le Goater wrote:
> >> Removing RTAS handlers will become necessary when the new pseries
> >> machine supporting multiple interrupt mode is introduced.
> >=20
> > I'd prefer this to be done as a separate spapr_rtas_unregister()
> > helper, just to improve greppability.
>=20
> ok. I should propose an inline :
>=20
> static inline void spapr_rtas_unregister(int token)=20
> {=20
> 	spapr_rtas_register(token, NULL, NULL);=20
> }

Fair enough.

>  =20
> >=20
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  hw/ppc/spapr_rtas.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >> index d6a0952154ac..e005d5d08151 100644
> >> --- a/hw/ppc/spapr_rtas.c
> >> +++ b/hw/ppc/spapr_rtas.c
> >> @@ -404,7 +404,7 @@ void spapr_rtas_register(int token, const char *na=
me, spapr_rtas_fn fn)
> >> =20
> >>      token -=3D RTAS_TOKEN_BASE;
> >> =20
> >> -    assert(!rtas_table[token].name);
> >> +    assert(!name || !rtas_table[token].name);
> >> =20
> >>      rtas_table[token].name =3D name;
> >>      rtas_table[token].fn =3D fn;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwAa8AACgkQbDjKyiDZ
s5J5/RAAjoSDsi5JS0e3MatGjYpF8qS1y0Dwhmmlu4QTVVwVP3Ouz1EU9tYpoMbl
hxpHYU5PKD43znJ7A+PXJhL08CTr+GP82tX+iN8itB3RADDKpXxvymkP4FsgvJMA
CKMUXIBfBSQeSWfwDYj+K9THuPKicd987HpLUi+hg3xR2QxcuY1HgiWtCR0LROU7
CL9b39FgblDChCm3XZ7aFkBfIeLue5W9imquSrQ1bRXF/BVRK5Ofu2SPYGXLe+eh
7EPe9MnPK9iPHzAqXMzqsqzrtGYqJ6rdnhCl0vri2QRfW38iKCJ2TuQPYxvQ1/b2
q5BgIVbemcSkTyUv9wnQyS3PBjNb/UmrbpfE1EFHxExVu/d0r0fCqpTf1lYJBmmr
bez1iYqd3RIhu7dxMfa1ZkQIa6yPvvLRX3cEHcenFi/0Edqkh7uozg4Ce56IwN3H
9+6tKMBZwHUUcUHsnPbD+FqOI+LWFlNsxrr4oU2/GEQRk2iLHQSW23Y/EX2MXZOX
0kNP0X+0UBrwzo1OeAnhzIm3ln2YfGJ6drsAYeFXnWTfSJMGnnn277ucr6zoAajB
Jwy3ACvKWz07QCCigH7bW+6zdN48F5QJO7MJ15TcMf3izXkUSL63oJul02/Rx10G
ljSrCwWSIPCLW2mZOFPA3pzEPH4st2YtoWAELXm9p4EIXP7jNJY=
=BP7Q
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
