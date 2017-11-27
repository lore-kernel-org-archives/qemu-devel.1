Received: from eggs.gnu.org ([2001:4830:134:3::10]:45381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE04-0008Ci-Fr
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE03-00006x-Ab
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:44 -0500
Date: Mon, 27 Nov 2017 18:20:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127072043.GJ11775@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-2-clg@kaod.org>
	<20171124025100.GA28000@umbus.fritz.box>
	<20171124105547.4234dc14@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="q5r20fdKX+PFtYHw"
Content-Disposition: inline
In-Reply-To: <20171124105547.4234dc14@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 01/25] ppc/xics: introduce an
 icp_create() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--q5r20fdKX+PFtYHw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2017 at 10:55:47AM +0100, Greg Kurz wrote:
> On Fri, 24 Nov 2017 13:51:00 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Nov 23, 2017 at 02:29:31PM +0100, C=E9dric Le Goater wrote:
> > > The sPAPR and the PowerNV core objects create the interrupt presenter
> > > object of the CPUs in a very similar way. Let's provide a common
> > > routine in which we use the presenter 'type' as a child identifier.
> > >=20
> > > Signed-off-by: C=E9dric Le Goater <clg@kaod.org> =20
> >=20
> > One tiny nit.., apart from that
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > > ---
> > >  hw/intc/xics.c          | 22 ++++++++++++++++++++++
> > >  hw/ppc/pnv_core.c       | 10 +---------
> > >  hw/ppc/spapr_cpu_core.c | 13 ++-----------
> > >  include/hw/ppc/xics.h   |  3 +++
> > >  4 files changed, 28 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > > index a1cc0e420c98..e4ccdff8f577 100644
> > > --- a/hw/intc/xics.c
> > > +++ b/hw/intc/xics.c
> > > @@ -384,6 +384,28 @@ static const TypeInfo icp_info =3D {
> > >      .class_size =3D sizeof(ICPStateClass),
> > >  };
> > > =20
> > > +Object *icp_create(CPUState *cs, const char *type, XICSFabric *xi, E=
rror **errp)
> > > +{
> > > +    Object *child =3D OBJECT(cs); =20
> >=20
> > In the original context 'child' made sense, since it was the child
> > object of the core.  Here, it's misleading, since it's the parent of
> > the xics link.  It's only used in a couple of places, so I suggest you
>=20
> Oops yes :)
>=20
> > just opencode OBJECT(cs) in each place.
> >=20
>=20
> or rename child to owner, as it is done with DRCs and TCE tables.

Sure.  Either's fine by me.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q5r20fdKX+PFtYHw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobvMsACgkQbDjKyiDZ
s5LlfQ/9Fcrkn4BS57e4L/YwgwkKLHZMM+5lon+xz3tK6NHil5Q7BXhSikEsfn4x
wrIDq76oD4GmtgmyvFM0fRHCsgzEZ04H7W4G29uVst32AtoIv6EzYnRq0yDLSe1w
eowT7OWNfzXA9aHa7QPV1tBfEuk3e3Vhcu0khzomcoDCM8ZODLIzv6wPNU7ECPwy
x4czzrRXxCefgNgxI6IXdCNwIhqN/QIIp38JWfqQlrMkousOP56S4Nkp9Nj1vemU
+iBARuDavy4yoF+cwO51RazPuceXrMeQymOY6pLfNs9j3FjK3F8vhk1v88v8QxR9
t0LDVKwYOIvs1ASt51jzSqoCeukSZrgj6vF7cL44VuWBPXeHjv/gSwOl6atEShYG
pgD8Ji8WGh5GiXXqq0Grcy4bztWH5s+btBWMLMo9OunKINWtJTIeaFf1zGRFwKZp
1KBMi32D/W9pAQgKmU6vOtCXrKF6WX9ePfAs/TPD0xsQDPdi4G+J4grj8VbuDN8/
Z7NSrei74DZg8YdgPvWu1UX14ogNHiksLDyDTMHv7ekIcOtzQ5evZhZb9H89CN1M
jBeAw3kU+scVdY8/GihU9uYXPlM2lQaqygL5sp2kwSL0uCpFh4gPZdiJ4bS/GxBu
9Tna1MNNwyv+y97lQWJXQzFrybS/ECvqobIHU6tXvxB3MilIIlI=
=vy2o
-----END PGP SIGNATURE-----

--q5r20fdKX+PFtYHw--
