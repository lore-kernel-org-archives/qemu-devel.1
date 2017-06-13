Received: from eggs.gnu.org ([2001:4830:134:3::10]:32842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh44-0007a3-4c
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKh42-0007tV-RC
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 04:20:40 -0400
Date: Tue, 13 Jun 2017 16:07:11 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170613080711.GC30171@umbus>
References: <149692935202.12119.3614006195497745877.stgit@bahia>
	<149692939833.12119.5229563110691809599.stgit@bahia>
	<20170612141546.GH18542@umbus>
	<20170613091455.3f307990@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Content-Disposition: inline
In-Reply-To: <20170613091455.3f307990@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/6] xics: directly register ICPState
 objects to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 09:14:55AM +0200, Greg Kurz wrote:
> On Mon, 12 Jun 2017 22:15:46 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jun 08, 2017 at 03:43:18PM +0200, Greg Kurz wrote:
> > > The ICPState objects are currently registered to vmstate as qdev obje=
cts.
> > > Their instance ids are hence computed automatically in the migration =
code,
> > > and thus depends on the order the CPU cores were plugged.
> > >=20
> > > If the destination had its CPU cores plugged in a different order tha=
n the
> > > source, then ICPState objects will have different instance_ids and lo=
ad
> > > the wrong state.
> > >=20
> > > Since CPU objects have a reliable cpu_index which is already used as
> > > instance_id in vmstate, let's use it for ICPState as well.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >=20
> > This is certainly an improvement.  You answered my query on the
> > previous version as to why this doesn't break migration, but that
> > information should go into the commit message.
> >=20
>=20
> I'll add this explanation to the changelog.
>=20
> > So, ideally, we would use the XICS "server number" as the migration
> > key.  That's an architected part of the XICs state, since those values
> > are entered explicitly into the ICS.  We have a way to go from server
> > number to ICP at the moment, but not the reverse, but we can fix that.
> >=20
> > Unfortunately I think those won't always match existing automatically
> > generated IDs, which makes things harder.
> >=20
>=20
> Maybe things will get better when cpu_dt_id can be contiguous:
>=20
> http://www.spinics.net/lists/kvm/msg150390.html
>=20
> But I guess it won't help with existing machine types.

Right.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP50vAAoJEGw4ysog2bOShegP/2PP42VyCCEiGk8Kx6jmtYVu
HqNJdEg6l6Gm/KcggCJ5Gw6SyCr9+eJhjSYFpaaP6TxHuw3CUNZiAjB5p5n8D1nb
iRR/Dx685CZ+ln9y9/SGMVOerLfOXmPi4WSpPUeaMdJyPiwdudNNsxY1XxKGiDZO
crNW3TEEIa069dcU4632FXNbA00BCOJDIhwEB5YtComDu3IexbDmxgAAwbLGvVo3
sKjbXBAosaeMLHOz85AeyhBPmtIY6pbZdXV1lnSQySsKNaygnZYyJwC5ywIZoQ3d
tlsCcPCgkEE3fvSDglflKy5fnic5yZgcRsCgncTuicG6KPBnBVH6wmUXtqNL79k7
/sWelKI52DdEZRg5GLdGW/OZeLRGGm2FiPOSsF4DbIEeCiHty6nYys0FvXtMA+BR
UJ2kWmaZRuZuzaedYjvQ/GDopeuPnzSJNRRJBuU+lZg6okFAGpSYSmFmHUek3Z3e
7S/JcRquKrAV0nwxVnIOz43Up46UcVmq/DD0Ub0CnHciHkHLEaGdh2bw9Qx+K0K1
Lu/uQgKkG7bfSS5yPTtINOHWFkaQn8LNMLUyT+YMkSOFS9uObYktgn/nJUnQOMAL
q7EaAe45Qff5OnruZ9uq/ERUA73qLrGPYgzbbFCGUR8Q3DHMpTZU8K3qFSwlZvcf
AHRgzKAhVqUN4gpT7WKR
=RQB7
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
