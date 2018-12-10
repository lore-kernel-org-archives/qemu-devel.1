Received: from eggs.gnu.org ([2001:4830:134:3::10]:47129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWCRw-0002m5-7K
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 22:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWCRr-0004em-UE
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 22:41:40 -0500
Date: Mon, 10 Dec 2018 14:41:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181210034121.GH4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-18-clg@kaod.org>
	<131a6a34fcda6202739362ceb9555fd65d4439a9.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AzNpbZlgThVzWita"
Content-Disposition: inline
In-Reply-To: <131a6a34fcda6202739362ceb9555fd65d4439a9.camel@kernel.crashing.org>
Subject: Re: [Qemu-devel] [PATCH v7 17/19] spapr: Add a pseries-4.0 machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--AzNpbZlgThVzWita
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 09:05:06AM +1100, Benjamin Herrenschmidt wrote:
> On Sun, 2018-12-09 at 20:46 +0100, C=E9dric Le Goater wrote:
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
>=20
> If you're going to do that, can we include large decrementer in there
> too ? (patches from Suraj in my tree but they night need a bit of
> massaging).

We don't need to worry about that here.  The machine type's not
considered finalized until the release, so as long as you get the
large dec stuff in before the 4.0 release, it's fine.

Looks like Eduardo and others are probably doing a big batch machine
type update via the machine tree.  That will probably conflict, but it
should be a fairly easy one for me to sort out when the time comes.

>=20
> >  include/hw/compat.h |  3 +++
> >  hw/ppc/spapr.c      | 25 ++++++++++++++++++++++---
> >  2 files changed, 25 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > index 6f4d5fc64704..70958328fe7a 100644
> > --- a/include/hw/compat.h
> > +++ b/include/hw/compat.h
> > @@ -1,6 +1,9 @@
> >  #ifndef HW_COMPAT_H
> >  #define HW_COMPAT_H
> > =20
> > +#define HW_COMPAT_3_1 \
> > +    /* empty */
> > +
> >  #define HW_COMPAT_3_0 \
> >      /* empty */
> > =20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index fa41927d95dd..4012ebd794a4 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3971,19 +3971,38 @@ static const TypeInfo spapr_machine_info =3D {
> >      }                                                                \
> >      type_init(spapr_machine_register_##suffix)
> > =20
> > - /*
> > +/*
> > + * pseries-4.0
> > + */
> > +static void spapr_machine_4_0_instance_options(MachineState *machine)
> > +{
> > +}
> > +
> > +static void spapr_machine_4_0_class_options(MachineClass *mc)
> > +{
> > +    /* Defaults for the latest behaviour inherited from the base class=
 */
> > +}
> > +
> > +DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> > +
> > +/*
> >   * pseries-3.1
> >   */
> > +#define SPAPR_COMPAT_3_1                                              \
> > +    HW_COMPAT_3_1
> > +
> >  static void spapr_machine_3_1_instance_options(MachineState *machine)
> >  {
> > +    spapr_machine_4_0_instance_options(machine);
> >  }
> > =20
> >  static void spapr_machine_3_1_class_options(MachineClass *mc)
> >  {
> > -    /* Defaults for the latest behaviour inherited from the base class=
 */
> > +    spapr_machine_4_0_class_options(mc);
> > +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_1);
> >  }
> > =20
> > -DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
> > +DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
> > =20
> >  /*
> >   * pseries-3.0
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AzNpbZlgThVzWita
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwN4F4ACgkQbDjKyiDZ
s5KnTQ//V4iRFrqRE2ol5zUeJgkU8FvZeqEyvdLED1lMHKejRpd7CZR3YIITpow/
ODkl1aV8pHaSr0w2o4avpWC/uiU62E183r2TLDluWHafwtl7T9V95Qh4KyabTQ1L
iqcNhDLVEcOJVx++3Qi7Yya5AY+jbOGNPaVsZAg6dfBmcNAVq2z+ksR4w+27DdAd
sxQ3X0NG8gyyBxrBqJs9lOamG/Go87+PMyyncUN3eQhJcfiDKO/T+juuLruCOiaC
u2wzUHp8zCILpWA/Sz9rRIkohVYp2JdrK2EY7UN979pDyZGGdhoBiir1EySs2NMj
91Ase+mn+KbPYWDxMWCUxTbfv+sMo2I/PmMagRB1zL2Vu/53FTzLB6VJRGBpf9No
gFCJeBmhl6N7QNROzwdaXEQNg5WtyTUxJzFABea/TZ5r/1NviATmfHGVSy9HwSkk
1KKDRuDHXqTLonfMhzFzYC+N5FlmO5zFVabhIz/v8ZgHKbmwuelsorRG+2x3EVsA
dXpfpWhAIWT8mALW7BTNhDF9oUxxfHVAjnqBkKlw7s6VXfh2bQOrT6/p7gqWdACc
e4Y8mFqx/KE21BHQhBCgTB6A2SocyVr9mmO5xRwNkao1X4cCmJUdIoPVa9hjdtuE
EWIYHKyctsRqkWmAGP2QLTXsIhsUZAM8+V0hbtD/29APQyJhe04=
=asAs
-----END PGP SIGNATURE-----

--AzNpbZlgThVzWita--
