Received: from eggs.gnu.org ([2001:4830:134:3::10]:47642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDf-0003YQ-SG
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDe-0001ZG-JI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:19 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:35985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1citDe-0001Xx-4U
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:18 -0500
Date: Wed, 1 Mar 2017 12:17:52 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170301011752.GH12571@umbus.fritz.box>
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
	<448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
	<20170223224911.GC17615@umbus.fritz.box>
	<20170224001613.GG17615@umbus.fritz.box>
	<CAFEAcA9V_1NA6-JgZd7Pc1hwih+uBKBrt4MPi4+kPWRu-xduPA@mail.gmail.com>
	<20170227010528.GM17615@umbus.fritz.box>
	<CAFEAcA9rR8X1Hg=w5FfYsoVSYjZYQAt+MaURKJ82mTyYohJOBw@mail.gmail.com>
	<20170301001602.GC12571@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <20170301001602.GC12571@umbus.fritz.box>
Subject: Re: [Qemu-devel] using fdt_setprop() to set properties to empty
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 11:16:02AM +1100, David Gibson wrote:
> On Mon, Feb 27, 2017 at 10:11:57AM +0000, Peter Maydell wrote:
> > On 27 February 2017 at 01:05, David Gibson <david@gibson.dropbear.id.au=
> wrote:
> > > On Fri, Feb 24, 2017 at 10:35:35AM +0000, Peter Maydell wrote:
> > >> On 24 February 2017 at 00:16, David Gibson <david@gibson.dropbear.id=
=2Eau> wrote:
> > >> > Ok, I've pushed libfdt upstream patches to (a) make passing NULL to
> > >> > setprop() with zero length explicitly safe and (b) add an
> > >> > fdt_setprop_empty() helper macro.  Do you want me to make a pullre=
q to
> > >> > update the qemu submodule?
> > >>
> > >> Yes, please. Are we OK with using a random libfdt commit or do
> > >> we update only to proper release tags?
> > >
> > > I'm find with a random SHA, but that's not really my department - I'm
> > > upstream libfdt maintainer, but update policy in the qemu tree seems
> > > like a qemu side decision.
> > >
> > >> There's no real rush with
> > >> this so if you have a release due shortly it might be better
> > >> to wait for that.
> > >
> > > dtc/libfdt releases are a rather haphazard affair.  Usually they
> > > happen when somebody complains that there hasn't been a release with
> > > some feature they want.  Our tests are both fast to run and have
> > > reasonaably good coverage, so random commits are usually good.  So a
> > > "release" is usually just slapping a new version number onto whatever
> > > is in master and making a tag and tarball.
> >=20
> > >From my end I think we'd rather use a proper release version
> > (if only because it's then easier to refer to and to state
> > as a dependency for packaged versions if required). It looks
> > like we've done that for our previous updates (starting
> > with 1.3.0 and then moving to 1.4.0 and 1.4.2) so I think
> > we should continue using released versions.
>=20
> Ok; I just tagged and released dtc 1.4.3.  I'll send a qemu update
> when I get a chance to remind myself how to do submodule updates
> again.

Uh.. actually, first I need the qemu mirror of dtc to be updated to
include the new release.  Is that synced automatically, or does
someone need to kick it?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYtiE9AAoJEGw4ysog2bOS34sP/iLxuJAJ4phMT9oFec3xhIkL
TGly46XA2xQN7Ucf6wcmCqV1Y1WYiruAcJQOw6HZsjAotHUd1c/+u5fffPjBHoqN
LVpyNHPjppm90IxJQe2kTmcIlNg9nMPlL7v4pX7NQ7U4EorGvjglcgb0U6xXikMK
f1kuK0R9n0KpFJHnOGuktSwhUgLu4xQn7sohC7wUII3GkNhFkxk2Ob4g4/abdCme
Ii9vvKSR6aJLYG1XikXE62aUvAHbwFL5bbSmOR09V2aQzupnB0NOiohIs9NBDa8V
xC6V+FSDX6IZ3q/A1MA0Xm2vb3HfHfFW+TUuro5EIx5Ea76/CpyFS3NLTGBJG4aB
SF6PlCeadws+EVnu45fZjEFL4G5cQQ+XPhRhE6u5OfUN0nNn8TcJTDIbEL3kxs24
4+jZ+wEEX3Ey+UvMLkKAQGb7LBZhdOG8HOZtY6PcnAcj1OHpmq9mAX+EyJ+RxHAB
dUpfQxBNBVxVslU4UbAaLVen5vuSj/izPZnA7oX5Lz4OJ09QiIeM/xSC92s5s9jm
gBCdNOHydf8JN30OuCVRzCgou2wpzyx/ylHvqUhbfxwIERkPjg7mo+/nG7T79kDO
abjNt0eRTKPFx24fdoL2JwfYc3bEMsxDld8ptAKsOpE8/Uj+LIxfDi4o5oaZe42A
uQiHZxXY2w0vSx6uk1Lq
=uAYM
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
