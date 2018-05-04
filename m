Received: from eggs.gnu.org ([2001:4830:134:3::10]:51792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEULW-0007s1-VB
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:37:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEULV-0005gc-W6
	for qemu-devel@nongnu.org; Fri, 04 May 2018 02:37:35 -0400
Date: Fri, 4 May 2018 16:37:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504063719.GC13229@umbus.fritz.box>
References: <152538217073.223014.17347204768561945420.stgit@bahia.lan>
	<20180504001102.GH13229@umbus.fritz.box>
	<20180504075821.0e0cbdc6@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="j6Ejlva3tMw3xXYi"
Content-Disposition: inline
In-Reply-To: <20180504075821.0e0cbdc6@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 0/3] spapr: fix backward migration from
 POWER9 to POWER8 hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-stable@nongnu.org


--j6Ejlva3tMw3xXYi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 04, 2018 at 07:58:21AM +0200, Greg Kurz wrote:
> On Fri, 4 May 2018 10:11:02 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, May 03, 2018 at 11:16:10PM +0200, Greg Kurz wrote:
> > > Hi,
> > >=20
> > > It is expected to be able to migrate a guest started with
> > >=20
> > >      -machine max-cpu-compat=3Dpower8
> > >=20
> > > from a POWER9 host to a POWER8 host. It works with recent QEMU versio=
ns,
> > > but it is badly broken if the destination runs QEMU 2.7 or older.
> > >=20
> > > This can cause problems in cloud environments that still have systems=
 with
> > > older QEMU versions, eg, hosts running ubuntu LTS 16.04.4 (QEMU 2.5) =
which
> > > are likely to stay around until admins could transition to some newer=
 OS.
> > >=20
> > > This series was lightly tested, but the patches are simple enough, so=
 I'm
> > > confident they shouldn't break anything :)
> > >=20
> > > Please review as I'd like these to go to QEMU 2.11.2 as well. =20
> >=20
> > Applied to ppc-for-2.13.  As you say, these should probably go to the
> > 2.12 and 2.11 stable trees too.
> >=20
>=20
> Cc'ing qemu-stable then

Thanks.  I'm about to go on leave, so I won't be around to shepherd
these into the stable trees any time soon.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--j6Ejlva3tMw3xXYi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr/58ACgkQbDjKyiDZ
s5KosRAAr7reOHHn3cfcpTdhXR0RsoikTci8KqfyxMe2TYWyONjGnxyB2w4Sm5X8
DWSAFaI8wVI/hceQH7sT+erO6qPBXKYy8mIJTWUO0iXBA/nYv899OqPtNRHBmYaN
quskF7xRO13CadrHo4sOlRQgrnzc4NEsHEryZa9CF5ZBVkAtp8FmIWhvdNx/GLNq
hA0nzmvHHJ+9fpA1hRwg4IVMWn+UdelWEndG2UuHAufO6XhxwnHfyJMQKex0BGQt
z4R7/myeAAaIYaszmlEhcam3iZByB5SEuW2vlJcYzlj87tNqfKgW5nMaDUMS7ADi
WqFBes+p8Gcq1iU+I1i5KcuMQ2SV6fPrqTue4uqufMRwqdkeM5tFGALQXUtts+il
lFeR7DSmhiHP8MgiOvUlDFICgkjHeBMmju3S6+HqGrI/nQYqjHtMsdYtijO2g0zg
jMSUBQB2xMlYbwCOfitKtkNyddKol0y+NfTvaY6bQvZq7xlhTF9deLdKOrB3i/IR
40SDpbEKo7gWWVW75Wba2UUPTLFV4fQtv2v1NdJhqhSjtGw/WhuedRvfkF2mMMhr
Gxz6qe0nxgX1hHzVc9Q4MNL+lm0V85LCRFRhkXIwuoSDRQCIWNClbTQyP1OsgM1b
Eyg15oIyMcNIxT/5pnPCHPZZGY25hWzbn2iqFMFdOn/xObrWtyM=
=ZlJF
-----END PGP SIGNATURE-----

--j6Ejlva3tMw3xXYi--
