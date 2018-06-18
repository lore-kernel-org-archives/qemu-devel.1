Received: from eggs.gnu.org ([2001:4830:134:3::10]:60412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUicc-00017b-CF
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 21:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUicY-0005oA-6A
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 21:06:18 -0400
Date: Mon, 18 Jun 2018 11:06:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180618010606.GL25461@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<c1ca5bce109e674d0cc7ed46bbcaa41863a6319c.1528935420.git.balaton@eik.bme.hu>
	<20180614013510.GD3042@umbus.fritz.box>
	<alpine.BSF.2.21.1806141003570.19899@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V3eawNQxI9TAjvgi"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806141003570.19899@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 7/9] sm501: Implement i2c part for
 reading monitor EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>


--V3eawNQxI9TAjvgi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 10:06:33AM +0200, BALATON Zoltan wrote:
> On Thu, 14 Jun 2018, David Gibson wrote:
> > On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >=20
> > Again needs a commit message expanding on what this is and why it's
> > useful.
>=20
> What else need to be explained apart from that SM501 has an i2c part which
> is used to access EDID info of attached monitor. But this is what the com=
mit
> title already says. This patch implements that so far not emulated part of
> the chip.

In this case it would be sufficient just to say the same thing, but in
a less compressed form than the subject line.  e.g.

| The sm501 controller includes an i2c slave from which the monitor's
| EDID information can be read.  This wasn't yet implemented in qemu,
| so this patch adds it.
|
| (The sm501 part is used only by the SH4 and PPC sam460ex machine
| types in qemu)

>=20
> > [snip]
> > >  static const VMStateDescription vmstate_sm501_sysbus =3D {
> > >      .name =3D TYPE_SYSBUS_SM501,
> > > -    .version_id =3D 1,
> > > -    .minimum_version_id =3D 1,
> > > +    .version_id =3D 2,
> > > +    .minimum_version_id =3D 2,
> > >      .fields =3D (VMStateField[]) {
> > >          VMSTATE_STRUCT(state, SM501SysBusState, 1,
> > >                         vmstate_sm501_state, SM501State),
> >=20
> > Additionally, since you're changing the migration stream, you need to
> > point out that this is not used in any machine types which support
> > cross-version migration.
>=20
> AFAIK it is only used in SH4 and PPC sam460ex.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--V3eawNQxI9TAjvgi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsnBX0ACgkQbDjKyiDZ
s5Knaw/8D3n4vG510yct2dpUXn3vchrpMmSxuoI+unte0ZjQwAeslBkzYn2BIE3i
Z+xwI6KQgJjrTLpWzo5roHtDtpkK1Wu4SGHaGJcPOwBlsYbn2hhaeKyMKY9/X1+A
eqxLZ7S8zxT/lEPBwL0VDpGDp5poVrL7qiv+8i2gEjPYKjhvPGfVq46YzlzK0BbV
rAOXwWFKtcl/Ejw4Tpeng29e6VvvHTdUGR5rw/dYphgLzv5TqDlof103oDwT0HOh
IZi17HzioAklW57I3bJX8/Bd2FkgaqODICJdSTwjmAzf/a4qcrDOwrQjm3Gqfkdn
Zy1akSPCPctqcRC+6nE1FqCzujvLEZH0b6cZ5fyr5KBvB8hkG6zrrUNi1JoqbYvr
UqlXTKvtsJetZBJPSAxstgDYYXe/Q6M0pTr78543hC7kgy6cV4FwbTdL9C769XHq
du7EKFLfmZFOdHu3R+kvejhbYPwN5RJFn0auFX3P42GIR6F0eAs73k+hlb2MDkbk
VYRcERh5hHGGmO+9syL+8K84Yn9pAy/Yc1v/e8BbSCFC5RBLL8yjXhaMhzDHV43n
NFpOklaCTdngvZ+c3XhumZnJk65qz7lLhl6FGJ85fk9hkRD6b8F6I/uBfKF1VWe4
cy6tQeGPT1vjdxVRcxhqCmIGQk4W1oe/eVTp9ZJHkWrV7Wtxo6k=
=Nb4b
-----END PGP SIGNATURE-----

--V3eawNQxI9TAjvgi--
