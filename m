Received: from eggs.gnu.org ([2001:4830:134:3::10]:47350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjgk5-0002yf-To
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cjgk2-0003nv-QW
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:31:05 -0500
Received: from ozlabs.org ([103.22.144.67]:34065)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1cjgk2-0003nk-Ed
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 01:31:02 -0500
Date: Fri, 3 Mar 2017 17:30:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170303063055.GK667@umbus.fritz.box>
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
	<448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
	<20170223224911.GC17615@umbus.fritz.box>
	<20170224001613.GG17615@umbus.fritz.box>
	<CAFEAcA9V_1NA6-JgZd7Pc1hwih+uBKBrt4MPi4+kPWRu-xduPA@mail.gmail.com>
	<20170227010528.GM17615@umbus.fritz.box>
	<CAFEAcA9rR8X1Hg=w5FfYsoVSYjZYQAt+MaURKJ82mTyYohJOBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="++alDQ2ROsODg1x+"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9rR8X1Hg=w5FfYsoVSYjZYQAt+MaURKJ82mTyYohJOBw@mail.gmail.com>
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


--++alDQ2ROsODg1x+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 10:11:57AM +0000, Peter Maydell wrote:
> On 27 February 2017 at 01:05, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > On Fri, Feb 24, 2017 at 10:35:35AM +0000, Peter Maydell wrote:
> >> On 24 February 2017 at 00:16, David Gibson <david@gibson.dropbear.id.a=
u> wrote:
> >> > Ok, I've pushed libfdt upstream patches to (a) make passing NULL to
> >> > setprop() with zero length explicitly safe and (b) add an
> >> > fdt_setprop_empty() helper macro.  Do you want me to make a pullreq =
to
> >> > update the qemu submodule?
> >>
> >> Yes, please. Are we OK with using a random libfdt commit or do
> >> we update only to proper release tags?
> >
> > I'm find with a random SHA, but that's not really my department - I'm
> > upstream libfdt maintainer, but update policy in the qemu tree seems
> > like a qemu side decision.
> >
> >> There's no real rush with
> >> this so if you have a release due shortly it might be better
> >> to wait for that.
> >
> > dtc/libfdt releases are a rather haphazard affair.  Usually they
> > happen when somebody complains that there hasn't been a release with
> > some feature they want.  Our tests are both fast to run and have
> > reasonaably good coverage, so random commits are usually good.  So a
> > "release" is usually just slapping a new version number onto whatever
> > is in master and making a tag and tarball.
>=20
> >From my end I think we'd rather use a proper release version
> (if only because it's then easier to refer to and to state
> as a dependency for packaged versions if required). It looks
> like we've done that for our previous updates (starting
> with 1.3.0 and then moving to 1.4.0 and 1.4.2) so I think
> we should continue using released versions.

Ok, I've made the upstream release, and sent a pull request with an
update for the qemu submodule.  I've bundled it up with a SLOF update,
which I forgot to put in the ppc pull request I also made today.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--++alDQ2ROsODg1x+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYuQ2fAAoJEGw4ysog2bOScC0QALK6116tSUHahvfFiDlJB5io
1uYWUcBZt+zaOuJ+peKmhBgF1WxjWdhdZp8LRre6HdwERICmypXjP2b8leH/WIr8
vgxmsgCsiMmsVy3BvAGDDHcE0kQU/Mun+4ao2qE0Q5zoGCyHcQ4f9MJwdLhaieZQ
UqHzS4lBY2N4YzFqqyE/yrTG434i9Ou8Qw/kXmCM2I3AbgW9X5UD1wbClCM9l6tP
R2G1ao0QCXOEMuYColZrd3NpWk0bJkfyzXt16bnACymZ3KlOk825ZK/5w+w/puII
Tkb+i1BU3lJOM2cKpXErRqAEe/aUbP1LjLFraehwNjRBbjKPLWp0etB1qWS2Zru8
p6aoiFjYKhNxL9UEK6mHrm7nz5AL+MyDCC2+x+kJRqjVMHT5Z+satcBwp30Ba/hE
VeJ/he5QhIC+l8kAo8vqdqlR9FgROXfnAysF6SUP+/YumoiV51GWyHsigljg6ybK
v5Uj7PcyrA/U6UJ1hNgwU/D4oMD11Xa63S4y0oenqpkiWLQYIiuCTxqSHW3O+8f7
X+JEMGhomz7NezS3olmLkWDS4sGnaKzWvtARRT177vNIKn1V2zAfaUhinOvrzHgh
cmaVXQgFdTXS5vYxwf8Uj6nRkFEkLxF+SPlfgIzv6IAsWISfL1XNvY16clTF0aP5
9zvyNeHKxrFkoZBpawkR
=UveY
-----END PGP SIGNATURE-----

--++alDQ2ROsODg1x+--
