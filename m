Received: from eggs.gnu.org ([2001:4830:134:3::10]:39911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImlR-0007Xi-Dj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 22:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dImlQ-0004Wn-Ga
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 22:01:33 -0400
Date: Thu, 8 Jun 2017 11:41:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608014150.GQ13397@umbus.fritz.box>
References: <149685579678.12025.9278446121024037161.stgit@bahia.lan>
	<149685581222.12025.5541302490723329093.stgit@bahia.lan>
	<bdabdcdb-c373-f248-95da-676bf30a22ea@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tKkaNMvYmhQvRCRK"
Content-Disposition: inline
In-Reply-To: <bdabdcdb-c373-f248-95da-676bf30a22ea@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] pnv_core: drop reference on
 ICPState object during CPU realization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--tKkaNMvYmhQvRCRK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 07:49:14PM +0200, C=E9dric Le Goater wrote:
> On 06/07/2017 07:16 PM, Greg Kurz wrote:
> > Similarly to what was done to spapr with commit 249127d0dfeb, this patch
> > ensures that we don't keep an extra reference on the ICPState object. A=
lso
> > since the object was just created and not reparented yet, the call to
> > object_property_add_child() should never fail: let's pass &error_abort =
to
> > make this clear.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.10, thanks.


>=20
> Thanks,
>=20
> C.=20
>=20
> > ---
> >  hw/ppc/pnv_core.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> > index 1b7ec70f033d..e8a9a94d5a24 100644
> > --- a/hw/ppc/pnv_core.c
> > +++ b/hw/ppc/pnv_core.c
> > @@ -119,7 +119,8 @@ static void pnv_core_realize_child(Object *child, X=
ICSFabric *xi, Error **errp)
> >      Object *obj;
> > =20
> >      obj =3D object_new(TYPE_PNV_ICP);
> > -    object_property_add_child(OBJECT(cpu), "icp", obj, NULL);
> > +    object_property_add_child(OBJECT(cpu), "icp", obj, &error_abort);
> > +    object_unref(obj);
> >      object_property_add_const_link(obj, "xics", OBJECT(xi), &error_abo=
rt);
> >      object_property_set_bool(obj, true, "realized", &local_err);
> >      if (local_err) {
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tKkaNMvYmhQvRCRK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOKteAAoJEGw4ysog2bOSQgUQAIzDOsIH26f2QsDw7AW4ZyHL
WUjlW1Sz6+d4Ht2gCM+JdCX3KH8jhptmuEzkbKeblDGfXH/knGF2EfC7tkDEGeYp
/CJmW/kzGNoAV+WlFoIJWNavQRFS27O5o3VD80vQAaqUCY3Zk5yOhnBFd5BoIhBL
RKlpARWnr8IKwuDwc9esCYTppON0hIdccY9JBZ7jEi436D/8mICKxQzetXH2eSWK
Wk1/99WWA4fK/X0+UXA0kjbHfD/zfPkQTtkKd0VdTz4YB2CZpDFK+bS70Z2er0YN
DD5CKUZWwqTlktWhm7lEl6ytEu1yu/GlZSLgkOCNeauOcp70LgwduFMyLTUYJC1g
sor1AS5A5fVE0UB+boD19RbSaPiQfTTX8bA0HkrAOPXXE9VyyPgyklVMeSm5ANrX
uWdTfmyQ4iQ16xUSHvFhiIcCGa4S+TtPFkY3Sz2M9LHqdpv7eQmeLfZA0oKU6dGr
WQ1AcZnaHalxiSm84L0mZ11PPfMtgdDQcA1X8IGPfLKUkOuRbX6ctVOsAsDhhlL2
0AjcRpVPBz/HIrjAQo7YlclVQXRJ+d8H4vhT1jYdWUtypaxU7BfWlxb1BKDHPN2X
2lZhqXzCderwd0T7lTDHzg6XuOvQeGcEUdhP0QgIa9PwbqIQhv58yN3VXDofPcda
zSekLex4DWoP0q8jXtOa
=PldN
-----END PGP SIGNATURE-----

--tKkaNMvYmhQvRCRK--
