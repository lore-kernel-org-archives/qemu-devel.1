Received: from eggs.gnu.org ([2001:4830:134:3::10]:38646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eEXzK-0004oc-4W
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:58:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eEXzG-0007YI-78
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 04:58:38 -0500
Date: Tue, 14 Nov 2017 20:08:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171114090851.GB20747@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<20171113055103.GD1014@umbus.fritz.box>
	<20171113105010.3d295e14@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <20171113105010.3d295e14@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 13, 2017 at 10:50:10AM +0100, Greg Kurz wrote:
> On Mon, 13 Nov 2017 16:51:03 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Nov 10, 2017 at 03:20:07PM +0000, C=E9dric Le Goater wrote:
> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > > ---
> > >  hw/ppc/spapr.c | 16 +++++++++++++++-
> > >  1 file changed, 15 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index d682f013d422..a2dcbee07214 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -3687,6 +3687,20 @@ static const TypeInfo spapr_machine_info =3D {
> > >      type_init(spapr_machine_register_##suffix)
> > > =20
> > >  /*
> > > + * pseries-2.12
> > > + */
> > > +static void spapr_machine_2_12_instance_options(MachineState *machin=
e)
> > > +{
> > > +}
> > > +
> > > +static void spapr_machine_2_12_class_options(MachineClass *mc)
> > > +{
> > > +    /* Defaults for the latest behaviour inherited from the base cla=
ss */
> > > +}
> > > +
> > > +DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
> > > +
> > > +/*
> > >   * pseries-2.11
> > >   */
> > >  static void spapr_machine_2_11_instance_options(MachineState *machin=
e)
> > > @@ -3698,7 +3712,7 @@ static void spapr_machine_2_11_class_options(Ma=
chineClass *mc)
> > >      /* Defaults for the latest behaviour inherited from the base cla=
ss */
> > >  }
> > > =20
> > > -DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> > > +DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
> > > =20
> > >  /*
> > >   * pseries-2.10 =20
> >=20
> > Uh.. not quite right.  You also need to chain the 2.11 hooks onto the
>=20
> Well, this happens in patch 5, but you're right it probably makes more
> sense to consolidate in a single patch.
>=20
> Also, this patch should have dropped the "Defaults for the latest..."
> comment...
>=20
> > new 2.12 ones.  Never mind, we'll need it sooner or later, so I've put
> > my own version into ppc-for-2.12.
> >=20
>=20
> ... and so should your version I guess.

Good point, amended.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloKsqEACgkQbDjKyiDZ
s5La8w/+IM9mJzeM56iNGV6jyLB9K3ao4y/oqH3bfV5RCrYFuO3UNRqYYF5j7NwJ
lq9KklqEN0jmYmfhPT2J/89AuAivK6Y7Or0BcGa0CHFQWAuoG8dmleb3NJ5XfNs8
FXrL9aZ6lC9msmuLfRDUyEBFdaJaZ1x/HTPvH4dfl7IBm8HVBFfx6+1LAPA1Z19B
aOJui1Npu34ATp2Ghy3mRbHJXIhJOsQTfcJOZ4l0o7VP1SI8Wwq/WNelWn8eWBIa
s8ffW02lIfXia/zAhwh4+BoN5nED9VCHYW0d7nbY8ZV2HblPbS/H2ZZK0Dx1R54F
L4wzgsQgHYaQD7Ffvl3rPx7gNeRFOpIJSpO8kdtLV4amHDxVmjxIDfQq+mHEnQom
c1Re4aRl8wo8RQHtZEvz9GPK9YRN90PeapYk3YgFF21R2czQD3PnIXZ1RxubzUJP
44SFMMugBoQsMcYSCl5yNzWKRRoWVm/2ApFka6Mr4E6PVqeA9LiOS/Lo0L00ee41
1V/IoIaXjEqzuGGB5kXcMgVr79NYG/+3CK7BMRhDp+u3lBQCagH4OhGww29kmCN0
zeOKmNMYbUasrLClnMZUHr64mJBcmM1vTG/PFc2Xk7zDn0aNzYN5tu8IGJBsK4NF
xgM3+kDpFnxVsdnwGYb58uaBGo1Faz1Fo3+Wyhy5sOEk5q0S/8Y=
=ltBV
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
