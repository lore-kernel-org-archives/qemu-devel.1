Received: from eggs.gnu.org ([2001:4830:134:3::10]:53580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch2ix-0003dc-Am
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch2iw-0005tE-2e
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:22:59 -0500
Date: Fri, 24 Feb 2017 09:55:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223225523.GE17615@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<20170222033423.GK12577@umbus.fritz.box>
	<e58f7cfa-c03c-ca25-a973-7894253d2dcc@kaod.org>
	<20170223030711.GC12577@umbus.fritz.box>
	<811fbebe-91d5-b4ee-aef7-f05427c6205d@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <811fbebe-91d5-b4ee-aef7-f05427c6205d@kaod.org>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 00/22] ppc/xics: simplify ICS
 and ICP creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 08:19:31AM +0100, C=E9dric Le Goater wrote:
> > Apart from that I'm pretty happy with the endpoint you reach.  I'm a
> > bit less convinced about the path taken to get there.  I'm not sure if
> > it's worth the churn of doing this reorg, but I think we'd get there
> > more clearly and with less intermediate abstraction violations if it
> > was done by:
> >=20
> >      1. Introduce the xics qom interface, but have it implemented by
> >         the existing xics object
> >      2. Change the ics and icp to only interact with the xics object
> >         via the qom interface
> >      3. Implement the qom interface in the spapr machine
> >      4. Change to spapr directly creating ics and icp objects,
> >         pointing back to itself as the xics interface provider
> >      5. Remove the xics concrete object
>=20
> So that's a full rewrite of the patchset to reach the same point.=20
> I can only grumble for such a proposal :/=20

Yeah.. point taken.

> > This also has the advantage that the qom path changing parts are
> > isolated to step (4), meaning problems with migration should be easier
> > to localize.
>=20
> and migration works.

Oh, that's a nice surprise.  Ok never mind about the rework, just
address the other comments and repost.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr2hbAAoJEGw4ysog2bOSTPUP/AhYh+6RshGlB8jIWeAJWWOi
E5kHno6scb2nu/f8Z1LfsuMYVwJbc7f6VJtzcOf10BQPp5FGJ6tFykJGyEj/EsTv
msn50rzo7n2LjFx6EjjNZY0sqtV6f6H4Wa28qNIDyz1ZXoQ9JHZLuEl8ornSd/Oe
hoJv/ZfTJvNrAEm59yAE2rkQwzXHnsJye+VFaIBdP3AsKpKalDTeLo5PTl/IhxRL
o49gIFUpW6H/LiBNNpCYO+6vSlnMKRHpz3sMMIPrrUiUVDYYqqM9Pw1hb9kpzDha
OikgBAUFNKbjWmyusMKacS9n3xVX3Y7d5dwlf6V3wsSBYX2hqqTd/55TKoSSd4J/
bdjnSdFW2iUhgE3W7wcPT3mFBlmjZeqd9iVA4Vix/B1WHfznsAIqX2KrHinXgIQ2
VjnnzTW1f2B3gq/282AD9Xre7gXQ9j+FyGIa5RuOvY/Y0vly0svm4eCx5jmEO13b
Swe5/y9uZ4G9gKokwCdKxfdn0WjhRJLGJ93nKE8u1GZeBxL3MeK5ODba3+kG8zFA
/GP8snkq2600RVpDcvDctLxwnv+FEmwc11dCPRI7i7xZGpV+88vfot7FGBW6Vh32
TBq8fMoubJMRxlVJKCuyeK8NGV6Hxww4lCBgnkItbtZn6FAN9MCYNKXoV5sh/iI7
D+SejDVrUfayaL9F/wr5
=qZEO
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
