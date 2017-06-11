Received: from eggs.gnu.org ([2001:4830:134:3::10]:52545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dK1bM-0001xN-Ev
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:04:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dK1bL-00017E-GW
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 08:04:16 -0400
Date: Sun, 11 Jun 2017 17:38:42 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170611093842.GA13479@umbus>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<20170609022813.GF26521@umbus.fritz.box>
	<20170609113631.229dd346@bahia.ttt.fr.ibm.com>
	<20170609102832.GL26521@umbus.fritz.box>
	<20170609170913.2e6526c3@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20170609170913.2e6526c3@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/6] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2017 at 05:09:13PM +0200, Greg Kurz wrote:
> On Fri, 9 Jun 2017 20:28:32 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jun 09, 2017 at 11:36:31AM +0200, Greg Kurz wrote:
> > > On Fri, 9 Jun 2017 12:28:13 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Thu, Jun 08, 2017 at 03:42:32PM +0200, Greg Kurz wrote: =20
> > > > > I've provided answers for all comments from the v3 review that I =
deliberately
> > > > > don't address in v4.   =20
> > > >=20
> > > > I've merged patches 1-4.  5 & 6 I'm still reviewing.
> > > >  =20
> > >=20
> > > Cool. FYI, I forgot to mention that I only tested with KVM.
> > >=20
> > > I'm now trying with TCG and I hit various guest crash on
> > > the destination (using your ppc-for-2.10 branch WITHOUT
> > > my patches): =20
> >=20
> > Drat.  What's your reproducer for this crash?
> >=20
>=20
> 1) start guest
>=20
> qemu-system-ppc64 \
>  -nodefaults -nographic -snapshot -no-shutdown -serial mon:stdio \
>  -device virtio-net,netdev=3Dnetdev0,id=3Dnet0 \
>  -netdev bridge,id=3Dnetdev0,br=3Dvirbr0,helper=3D/usr/libexec/qemu-bridg=
e-helper \
>  -device virtio-blk,drive=3Ddrive0,id=3Dblk0 \
>  -drive file=3D/home/greg/images/sle12-sp1-ppc64le.qcow2,id=3Ddrive0,if=
=3Dnone \
>  -machine type=3Dpseries,accel=3Dtcg -cpu POWER8
>=20
> 2) migrate
>=20
> 3) destination crashes (immediately or after very short delay) or
> hangs

Ok.  I'll bisect it when I can, but you might well get to it first.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZPQ+gAAoJEGw4ysog2bOSZesP/iGeLbSNy6ZTKoI/kUIPrCCi
jMMrcXgkCQTRVbNC7FbcXtHQDvFnYHnQT2gWjxMjo6GdS3LvWR2yC8Bh2iu0q3Uk
VxcuektHtYV+rlbgKD5LxRXPETZ6s7oHJcnuLYaA/WXXzuJOmJzPd7l5jCYBMfhi
1lqkAikXdCoCbG4NcjItavvcg/GpMIEhazjracLDA6pj/HqVfMK7Wkg3ESoSJBRc
w9d2fkyLZE8LnuWGNr7dHtPnd/rjNOWJhz26e3LiuI4cU2npfh8/l6MILsPGljXb
j/tT9k3BXmAyAWxPokcYqExqNbeAMF0oDev0x0yH8giEKEsw+yoPd9xfpsgjSIZa
XnzCD+fJOk1UPFmcrzKAUpduib2PoS63bOn+9DoT7uQ/0r/vEyGNUM7wWqfMekAm
autXsptp6Wski+7VD6FHGPaaXJIDgWb+v08+xZS5Dl0W17DV48vc7bT7HZjnu17C
cp0mRedEFSFZDbAbTCmcvtMFiWrUC7csFUuMOKuvknc9xIDCaORIrp8uJElHKgN1
84LHIAXLRtrsBrcdpaSZ4GlgnRHG6w5OJxcX1854qq1vOmkBn690nxh8zaKR9zWk
7UHgFQWGvBC8gW4nVFV3lwGA0Lg8M4ig8TG1zDUz1aCwTFY5Wb90uUoKFCjKn4br
3VevzXR9sTLfrHUTWKp3
=vvNC
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
