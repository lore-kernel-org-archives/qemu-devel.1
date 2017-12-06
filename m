Received: from eggs.gnu.org ([2001:4830:134:3::10]:34985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMVov-0004zT-QV
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMVou-0007Oy-FR
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:16:49 -0500
Date: Wed, 6 Dec 2017 19:44:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171206084454.GU3057@umbus.fritz.box>
References: <151254799678.27605.10670816153836184660.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+k4Drb7WGefOwc9B"
Content-Disposition: inline
In-Reply-To: <151254799678.27605.10670816153836184660.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: fix LSI interrupt specifiers in
 the device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--+k4Drb7WGefOwc9B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 09:13:16AM +0100, Greg Kurz wrote:
> LoPAPR 1.1 B.6.9.1.2 describes the "#interrupt-cells" property of the
> PowerPC External Interrupt Source Controller node as follows:
>=20
> =E2=80=9C#interrupt-cells=E2=80=9D
>=20
>   Standard property name to define the number of cells in an interrupt-
>   specifier within an interrupt domain.
>=20
>   prop-encoded-array: An integer, encoded as with encode-int, that denotes
>   the number of cells required to represent an interrupt specifier in its
>   child nodes.
>=20
>   The value of this property for the PowerPC External Interrupt option sh=
all
>   be 2. Thus all interrupt specifiers (as used in the standard =E2=80=9Ci=
nterrupts=E2=80=9D
>   property) shall consist of two cells, each containing an integer encoded
>   as with encode-int. The first integer represents the interrupt number t=
he
>   second integer is the trigger code: 0 for edge triggered, 1 for level
>   triggered.
>=20
> This patch fixes the interrupt specifiers in the "interrupt-map" property
> of the PHB node, that were setting the second cell to 8 (confusion with
> IRQ_TYPE_LEVEL_LOW ?) instead of 1.
>=20
> VIO devices and RTAS event sources use the same format for interrupt
> specifiers: while here, we introduce a common helper to handle the
> encoding details.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Tested-by: C=C3=A9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.12.  This has been wrong forever, so I don't
think we need to rush it into 2.11.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+k4Drb7WGefOwc9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlonrgMACgkQbDjKyiDZ
s5K5hA/9FLEdHu3qrFjMTEUZvlg3effAAkn1JXsBp6wAejIhxfIOXZxHGvbOB6iq
Io2GLexDZTRmgNHOjV2iOY6yyQeIccrr20SM35sb5WuDJBbj+cUS1GgD2KytjVM+
FmG219Ev6g2/mDTyOY47f1kFnEGXD29ESEdBAwl4kgccZMKeTdYdgKZbRiMZEjkl
r2DCCQdj3WhLu5Su3b9iBqn762g39xXHTUkoSN7eYJwaiSnghuHKjyXpK7wzhyrx
0AGjEf3h8Bl1xXHTsluxMC9gdVFPG3XhKYwKgvd8g+MJqlf22gGtq2NuA/qypTgi
+iI1QTksMHBqzmjJVZkcoKpfEq4FnoZnntalPeRlGMC7Ou0tN6Nlk5je2v1Lumnw
3F/ZZFKZUWO6qdwVLTajs+ZvnczIoYpgH5s6BgT+eMHVwod7GxtNzpqjAxpt6RDu
UNzSdHJFgbFMUmOG6+pU+xABKIA2J0mPtoYM3PGJ8ixrboYXyAolPW8WXbabcYPe
c2Vo+JypoAFRRs5v+l/mWtP+yZQcrTf8sRHl3fjy4NiySL/YAftQBdMeFPeNFz/D
wRw41zz9O3I2e+HQXwFDm2F7xYGRzw68pAhHQX8InrkkCSA6gxng0x0a3bRzuwQN
Syxx7LmYiOR83qVqerLqmvU9OuAKGs3iL5/sGUH99RxJ+gyE8/Y=
=3FDz
-----END PGP SIGNATURE-----

--+k4Drb7WGefOwc9B--
