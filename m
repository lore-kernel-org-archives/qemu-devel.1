Received: from eggs.gnu.org ([2001:4830:134:3::10]:57648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eMTW7-0004IR-Do
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 01:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eMTW3-0001nH-HQ
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 01:49:15 -0500
Received: from 7.mo177.mail-out.ovh.net ([46.105.61.149]:43734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eMTW3-0001mT-A4
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 01:49:11 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 928428FF6A
	for <qemu-devel@nongnu.org>; Wed,  6 Dec 2017 07:49:09 +0100 (CET)
Date: Wed, 6 Dec 2017 07:49:04 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171206074904.14da15f6@bahia.lan>
In-Reply-To: <20171206002544.GQ3057@umbus.fritz.box>
References: <151239850618.30749.18071098158203257789.stgit@bahia.lan>
	<20171206002544.GQ3057@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/rt4Dww8XBnH0d0R2ZABQq3x";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] spapr: fix LSI interrupt specifiers in
 the device tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>

--Sig_/rt4Dww8XBnH0d0R2ZABQq3x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Dec 2017 11:25:44 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Dec 04, 2017 at 03:41:46PM +0100, Greg Kurz wrote:
> > PAPR 2.7 C.6.9.1.2 describes the "#interrupt-cells" property of the
> > PowerPC External Interrupt Source Controller node as follows:
> >=20
> > =E2=80=9C#interrupt-cells=E2=80=9D
> >=20
> >   Standard property name to define the number of cells in an interrupt-
> >   specifier within an interrupt domain.
> >=20
> >   prop-encoded-array: An integer, encoded as with encode-int, that deno=
tes
> >   the number of cells required to represent an interrupt specifier in i=
ts
> >   child nodes.
> >=20
> >   The value of this property for the PowerPC External Interrupt option =
shall
> >   be 2. Thus all interrupt specifiers (as used in the standard =E2=80=
=9Cinterrupts=E2=80=9D
> >   property) shall consist of two cells, each containing an integer enco=
ded
> >   as with encode-int. The first integer represents the interrupt number=
 the
> >   second integer is the trigger code: 0 for edge triggered, 1 for level
> >   triggered.
> >=20
> > This patch fixes the interrupt specifiers in the "interrupt-map" proper=
ty
> > of the PHB node, that were setting the second cell to 8 (confusion with
> > IRQ_TYPE_LEVEL_LOW ?) instead of 1.
> >=20
> > VIO devices and RTAS event sources use the same format for interrupt
> > specifiers: while here, we introduce a common helper to handle the
> > encoding details.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > Tested-by: C=C3=A9dric Le Goater <clg@kaod.org> =20
>=20
> Looks good, but I'd request two minor changes.
>=20
> 1) Please reference LoPAPR instead of the internal PAPR, since other
> people can't see it.
>=20
> 2) Change the helper's name to spapr_dt_xics_irq(), for both brevity
> and specificity.
>=20

Sure, I'll do that. Thanks!


--Sig_/rt4Dww8XBnH0d0R2ZABQq3x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlonkuAACgkQcdTV5YIv
c9a2gw/+M2Z8wJKuCRX/kuf8qnzBp/Glr09cEykr/pq5oUkRH997EDDLC/oIwiK1
RusR4jAyO+K4GHSAdhN9A7XULxH93/PPiGBGG9ilQ5NWWez09w5g8J1nZjPi8XLj
8YLp1bPALbtoNjFXWcmDAhZgFqA9AfAISACuCqAA2qHVu6eCjuL0TUNT8vkp1f/n
lOD16KqhtbpxhmqJB1K+RcEgEL7WeMgnkH+xTfhtt1Ga4P2YiQ6APha3XkOWuZAn
hV0IGAbs8J5z1n6MayHHeQuUUVydpfhdYIYC2uX5YwiP9YKOy80Ar6CuawizitrM
dRt1N2AEVS/lTSkSZbR5stvp6G7S8LaHdksD2+CYdvFFzkUEk2kyaHk6C+YV2/bf
YeHXksq+4fsMIDOX/Knn4+sno0J3mBpK02dkRcwLWxXTJ/RPy4JEn9H1PA4R/WtH
VHFBmc+4n+Ba8zkg9CIpY8taGYzbBesZqPmo7gg6vw2/beEBwJGNQi+gDKSsQlhG
gQ77STMv0hb+x651UuftwV+aGS7PVrtYmxZCT9dUJvc4XYyXq66EOsr0wP/GvMSY
0jOaRdtHa5keucoSTHPHiF9DuMS2U9aqr9GJcbz64PgoSVR8t+rbC610stYATTz7
4WXAxhdLuOhHqRuAOrOBmQMIZPG94KenvkXktjxIoDiZEyJKODg=
=ONoE
-----END PGP SIGNATURE-----

--Sig_/rt4Dww8XBnH0d0R2ZABQq3x--
