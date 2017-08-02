Received: from eggs.gnu.org ([2001:4830:134:3::10]:60814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcuia-00036J-Dn
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcuiV-0001ab-EX
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:33:48 -0400
Date: Thu, 3 Aug 2017 00:22:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170802142213.GB394@umbus.fritz.box>
References: <150116311662.21142.16740109690791414399.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<150118863714.22858.14396414884081097996@loki>
	<20170728042745.GM3098@umbus.fritz.box>
	<20170802101456.2a036225@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <20170802101456.2a036225@bahia.lan>
Subject: Re: [Qemu-devel] [for-2.10 PATCH] spapr_drc: fix realize and
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 10:14:56AM +0200, Greg Kurz wrote:
> On Fri, 28 Jul 2017 14:27:45 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jul 27, 2017 at 03:50:37PM -0500, Michael Roth wrote:
> > > Quoting Greg Kurz (2017-07-27 08:45:47) =20
> > > > If object_property_add_alias() returns an error in realize(), we sh=
ould
> > > > propagate it to the caller and certainly not unref the DRC. =20
> > >=20
> > > Indeed. I think that was the result of this part of the code
> > > originally living in spapr_dr_connector_new() during development,
> > > where it had previously made sense to free the object if there was a
> > > failure and then return NULL. We definitely shouldn't be during it
> > > now... =20
> >=20
> > Yes, I think that's right.
> >=20
> > I've applied this fix to ppc-for-2.10.
> >=20
> > >  =20
> > > >=20
> > > > Same thing goes for unrealize(). Since object_property_del() is the=
 last
> > > > call, we can even get rid of the intermediate Error *.
> > > >=20
> > > > And finally, unrealize() should undo all registrations performed by
> > > > realize().
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >=20
> > > > David,
> > > >=20
> > > > As agreed on the list, here's the version of the fix for 2.10. I'll=
 respin
> > > > my PHB hotplug series on top of it.
> > > >  =20
> > >=20
> > >=20
> > > Since spapr_dr_connector_new() calls realize() with errp =3D NULL, we
> > > basically lose the error now. I think maybe we should at least report=
 it
> > > still, but even better would be to have _new() call object_property_*=
 with
> > > error_abort, since callers of spapr_dr_connector_new() don't all check
> > > for the return value and even if they did the appropriate action would
> > > always be to report+abort() anyway. =20
> >=20
> > I agree.  Well, except I think it should be &error_fatal, not
> > &error_abort.  But that can be a follow up patch.
> >=20
>=20
> Hmmm... when we'll hotplug a PHB, an error during the realization of
> a PCI DRC would then terminate QEMU. I'd rather add an errp argument
> to spapr_dr_connector_new() and propagate the error instead.

Ah, good point.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmB4BIACgkQbDjKyiDZ
s5Lf+RAAmFJzUWfnYF70LiZZ+0dgGWiGSkxbDT9DnW1KrC06RQOMSK0R8unFzrdk
jzE2dxqKSMKsehpBbGZweYJt+R12gmYsZMbExlUtrPg975jfXgmzitM3wlrx/oSo
+3jcJzLpax+D/4doIrVHOKiFmJYzmB4G/E/CK46SV1cWdhTomC+AowoZwx1rGngr
4BzVL+3sj6/vbY5Zs30uDwfUDoU0OV9L0tznVdnhZG+CjM7KqCZMxUGEoyXS0KiF
F+TK/FOaHQHL9rt9kjCCOdODx0dgKEhxPM1Qauouq4+195wlr1BKj+Ii8IkCwUwe
oxUZlTTWpE9hshfAIaUxJqutEsZtV68gqp0k52e6VTfPoeBcx/B2UUDIVijazOu/
i+BDTI1OLO2x0HkYazlKsP/klWkYZO4Fr3AQeNsR2g5dd9+vbiZrQaN+vXEYZLXd
CngPOyYAjU8L4/9CghKtltIApn/wMeds1cZYh4G6LfO87NM5Kura59xuIHNpGoc+
UuJbtE4xdyBJD8xF6QaDpGz0iaDzLmOQfp8oqpMmNZqHYccqiOlZxfQvV4mRC/kH
PIcO54l+g2b21//P+qJrZmOQTam+sUpzmVP2fAMRqlrASBvs0pIPivlQqjz5fsKd
cejPunbrQpuYNjVdeMFPH/ZJW4E93DMNb8V5TV3KWic9gmsDgoA=
=ugwu
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
