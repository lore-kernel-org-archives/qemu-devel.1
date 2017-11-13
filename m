Received: from eggs.gnu.org ([2001:4830:134:3::10]:38190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEBO6-0006gh-Sg
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eEBO3-0006JE-0Y
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:50:42 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:34545)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eEBO2-0006Ew-Qb
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:50:38 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 96D41CCCE1
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 10:50:25 +0100 (CET)
Date: Mon, 13 Nov 2017 10:50:10 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171113105010.3d295e14@bahia.lan>
In-Reply-To: <20171113055103.GD1014@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<20171113055103.GD1014@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/0JTgyd_NSl=.JMI=KEFOIxK";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 01/11] spapr: add pseries 2.12
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

--Sig_/0JTgyd_NSl=.JMI=KEFOIxK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Nov 2017 16:51:03 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Nov 10, 2017 at 03:20:07PM +0000, C=C3=A9dric Le Goater wrote:
> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/ppc/spapr.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d682f013d422..a2dcbee07214 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3687,6 +3687,20 @@ static const TypeInfo spapr_machine_info =3D {
> >      type_init(spapr_machine_register_##suffix)
> > =20
> >  /*
> > + * pseries-2.12
> > + */
> > +static void spapr_machine_2_12_instance_options(MachineState *machine)
> > +{
> > +}
> > +
> > +static void spapr_machine_2_12_class_options(MachineClass *mc)
> > +{
> > +    /* Defaults for the latest behaviour inherited from the base class=
 */
> > +}
> > +
> > +DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> > +
> > +/*
> >   * pseries-2.11
> >   */
> >  static void spapr_machine_2_11_instance_options(MachineState *machine)
> > @@ -3698,7 +3712,7 @@ static void spapr_machine_2_11_class_options(Mach=
ineClass *mc)
> >      /* Defaults for the latest behaviour inherited from the base class=
 */
> >  }
> > =20
> > -DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> > +DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> > =20
> >  /*
> >   * pseries-2.10 =20
>=20
> Uh.. not quite right.  You also need to chain the 2.11 hooks onto the

Well, this happens in patch 5, but you're right it probably makes more
sense to consolidate in a single patch.

Also, this patch should have dropped the "Defaults for the latest..."
comment...

> new 2.12 ones.  Never mind, we'll need it sooner or later, so I've put
> my own version into ppc-for-2.12.
>=20

... and so should your version I guess.

--Sig_/0JTgyd_NSl=.JMI=KEFOIxK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAloJatIACgkQcdTV5YIv
c9bqKBAAwNLWNx6bFr78+oFSLvbmlRnh0CTLADg3DRlTjO0WazFViFoCbRFf760T
sXsTZPaBHliLPO5S+2iulRmTWDClUIWzsHtauLEstOB73aNFCjVX/PJENzltD52s
puuWltrgRT1HkEQKR9Mzm6KYNGbtqLBkHClGNTjFtudvyWhR1HQovjylDd2ByfHy
zNKEQE5lPybNa3a5mAFqypEilJ8Nx9QQH0qL4mbkS51eC3iMagpYljfBuWFJWZYT
HVVG9f1j8FwD49BQRplWwRqA4OUbPJiMWxXKOgucF7kHnd473ALnlS7kax5kqytc
Y8qlUEgrv7SJUH13i8CUL9/1yTuVgvZ1Wk+nOP6hyzKQ1ntuOBFZCJMa1lOAhNFt
NLGutvvpRp+H+lCvPu6sTvGdxiHWY7YKxJ+2kHgFoKePGV1nJB8sepecWhoEyjwD
Bw/MAygjyTkuQ76rPK3hFmOb2Y3JLZjSeclRUV/KJKqism2FVFOMW1GngBue6d3I
Fks4LijswXYmI1rz+boDcyvvFnEeKjwFtDM6SylxF27k6yn/DMXIbqz5MJV+f5xd
TzfBi4EAbZftwv+44j5K5rGl1kevih9so6+USRRggyltTCLyjSwezKlW34PN2cRz
NbVm4Sm22ftpx4U4LA2cpVHbEEAYtuIyIJkHE2x6qi8cUxASNII=
=b9c7
-----END PGP SIGNATURE-----

--Sig_/0JTgyd_NSl=.JMI=KEFOIxK--
