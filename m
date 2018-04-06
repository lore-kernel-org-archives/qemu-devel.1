Received: from eggs.gnu.org ([2001:4830:134:3::10]:41624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4GDD-0005FR-Ve
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:30:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4GDC-0003Cw-Ta
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 21:30:43 -0400
Date: Fri, 6 Apr 2018 11:09:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180406010903.GB3212@umbus.fritz.box>
References: <20180405021437.16761-1-david@gibson.dropbear.id.au>
	<20180405021437.16761-14-david@gibson.dropbear.id.au>
	<20180405151255.63da677e@bahia.lan>
	<20180405152734.2e984bc5.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
Content-Disposition: inline
In-Reply-To: <20180405152734.2e984bc5.cohuck@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13 13/13] target/ppc: Fold slb_nr
 into PPCHash64Options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 03:27:34PM +0200, Cornelia Huck wrote:
> On Thu, 5 Apr 2018 15:12:55 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Thu,  5 Apr 2018 12:14:37 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > > @@ -4000,7 +4000,12 @@ DEFINE_SPAPR_MACHINE(2_13, "2.13", true);
> > >   * pseries-2.12
> > >   */
> > >  #define SPAPR_COMPAT_2_12                                           =
   \
> > > -    HW_COMPAT_2_12 =20
> >=20
> > This hunk doesn't apply on master, nor on your ppc-for-2.13 branch...
> >=20
> > It looks like a patch to introduce the 2.13 machine type is missing.
> >=20
> > FWIW, Connie has already queued a patch to do so for s390x, that also
> > introduces HW_COMPAT_2_12.
> >=20
> > https://github.com/cohuck/qemu/commit/b54cde7350b6681b4349b904e0f9a8a8d=
58c0951
> >=20
> > Maybe the HW_COMPAT_ macros should be added in a standalone patch ?
> >=20
> > Cc'ing Connie for insights.
> >=20
> > > +    HW_COMPAT_2_12                                                  =
   \
> > > +    {                                                               =
   \
> > > +        .driver =3D TYPE_POWERPC_CPU,                               =
     \
> > > +            .property =3D "pre-2.13-migration",                     =
     \
> > > +            .value    =3D "on",                                     =
     \ =20
>=20
> I think the usual procedure is
>=20
> - every arch that uses compat machines queues a patch that creates the
>   new compat machine(s) and adds an empty HW_COMPAT_<version>
> - whoever has their queue pulled first wins wrt hw_compat

That's my understanding as well.  It's an easy conflict to resolve.

> So, I'm happy with anyone adding the empty HW_COMPAT_2_12 -- it needn't
> be me :)

Likewise.  I'm planning to keep it in my tree for the time being, so
as not to rely on external patches, but when the 2.13 tree opens, who
wins the race is mostly chance, and that's fine.

> [We could also introduce the 2.13 machines for all architectures in one
> sweep, but I think that would be generating needless churn for arch
> maintainers.]
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrGyK0ACgkQbDjKyiDZ
s5IdORAAoOqqbVbV+wfJs4A0HZIw8I3eti/2W4D0h6hXtG0FwNf+Ln0gR8ArOowF
ZJtgHRKrtt2AAMgFp+EcTO5alLESIRRE/1e4HjVoPdnVB/x4wluasvt1nDZhD2zj
u5c+SQygHYrxZT3I3cbA7kihwj/D8YFPo/YkWejYdoMOEWobndqJ95dq/Yda+XcH
IKbfhP/kQod6wxIPXyOFcLnkTNSBh7tbnsWda1iwCDFAOZI0K3Qq68mreGllo0KK
aU5bHa/NJUvrRtQuKB/+AXW39UC+GlZKhPxXqkNY+/3CuUUoXq80JZF97bTHIaIY
HJgLtHJJGiq+dnKGM9pyI9jxK1edvnaH5zSi1f8ijtj5dpfAka/JTowyEbe2CRoI
ce5UD4sLn22sjk+KeHdWJ+z1ys1MwWtOm3d941bb+6zSXy41HG/5FBG2C6PAGxYL
tnVOcL6Y0Vou8GDAv8zHi/sn8FA0J8ISq1kmqPCCMS9FOhqHPXUw9S5StRpEzl03
1sy/yh/XOtIbSvVJTXgDJ9CyC4M0c2EzMQwBs0vgJJz8cW739MdkCmv0bArtA/9Z
QXOdKp3fQHBMxq2Ic6jZo559vnhhvaC6E1NSlyiNH3WpRFT+o0OgOBpX4sQXpNLk
UJy438GDwxGblY7AlBT+EUdQVectm/MUi0TbTbea9SLVqqLWpbE=
=3LJ7
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--
