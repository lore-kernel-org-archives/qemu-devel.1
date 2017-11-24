Received: from eggs.gnu.org ([2001:4830:134:3::10]:46437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eIBue-000547-HN
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:12:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eIBua-0004uJ-BM
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 06:12:52 -0500
Date: Fri, 24 Nov 2017 22:12:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171124111235.GE18727@umbus.fritz.box>
References: <20171123170524.3865-1-clg@kaod.org>
	<20171124000918.GF22454@umbus.fritz.box>
	<91e790c1-186e-fecf-a2ae-c0ede1b17d7c@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <91e790c1-186e-fecf-a2ae-c0ede1b17d7c@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] pcc: define the Power-saving mode Exit
 Cause Enable bits in PowerPCCPUClass
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 08:04:59AM +0100, C=E9dric Le Goater wrote:
> On 11/24/2017 01:09 AM, David Gibson wrote:
> > On Thu, Nov 23, 2017 at 06:05:24PM +0100, C=E9dric Le Goater wrote:
> >> and use the value to define precisely the default value of the LPCR in
> >> the helper routine cpu_ppc_set_papr()
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Applied to ppc-for-2.12.
> >=20
> > Sorry, I forgot if we needed this for 2.11 - if so, I can move it
> > over.
>=20
> The next patchset fixes reboot and CPU hotplug under TCG.=20
>=20
> But we are 10 days before 2.11, TCG is clearly not the most=20
> used accelerators for sPAPR, I am the only one complaining=20
> about it because of XIVE. I Let you decide.

Ah, yes, I remember now.

Yeah, 2.12 it is.  I'm already squeezing in quite enough late fixes
for 2.11 :/.

> Sending the v4 of ""disable the decrementer interrupt when a=20
> CPU is unplugged" now.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloX/qEACgkQbDjKyiDZ
s5JGLhAAsPqIUKb1YJoMynhKtgcTX8QyW/pO2oPGnRYYyi4maq8DGvCz+BNiomTv
38glXKq3BZYvzRkRo12ech/WJyX3IEDFZT7XPqrEq4T0IY+uOv7iAqSTO7c4eUZz
BoIRJGTeUQTeZjQ69H98HONfFquDA9vnXxnIgiMphh8ovxv0q89v6d5V8EAYYE6p
pUJrlCNBYJ2zr4cD0Y3/FSwzYTzUoTi3laxLzqv59lREMwPp+sWRFjYBBcgrjRPR
112PIoIc+23BD89FrbWHbgGIBgPpmfiseH8Zu9RGIODVVhPT4H4qoHYf+QV0Y64y
qZek9Q79c3WIX/1SSQLGmq7Hh7rn+iEtep4LKVwM0atZWv2XgHip5VOzB1BMJRML
1zHEri/gOBlS2YtIMgVa9BSQ5hDIf3r8eQNZ2ftOHDIyi9bbUOkyUu3HX7bdTgO+
zKhvLoqqGziaXv5kS29J5MgCxkE4fIq4+o+NdUthebcxaenDsSXH/FcbUhse8uQD
5CmuBpm/F1olmsuUihGmisYgCRvU1g4HJb2qNcWLtnTJGGZuEd5LGUbUdGJvtCUs
4d9IvSI6/XXTgb9Qm1XtDUAhBOL+YNJZN4zonGio7yMnapLg/EBjHrHhJ0mKHcXe
ZUptxnSRDol7WW4okfFU9CLqmEZLPdT384tnciBHU1fcsDWq8ig=
=pY3C
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
