Received: from eggs.gnu.org ([2001:4830:134:3::10]:47582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDc-0003XM-7q
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1citDb-0001Xj-70
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:16 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:36993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1citDa-0001TI-25
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 20:38:15 -0500
Date: Wed, 1 Mar 2017 11:16:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170301001602.GC12571@umbus.fritz.box>
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
	<448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
	<20170223224911.GC17615@umbus.fritz.box>
	<20170224001613.GG17615@umbus.fritz.box>
	<CAFEAcA9V_1NA6-JgZd7Pc1hwih+uBKBrt4MPi4+kPWRu-xduPA@mail.gmail.com>
	<20170227010528.GM17615@umbus.fritz.box>
	<CAFEAcA9rR8X1Hg=w5FfYsoVSYjZYQAt+MaURKJ82mTyYohJOBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
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


--z4+8/lEcDcG5Ke9S
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

Ok; I just tagged and released dtc 1.4.3.  I'll send a qemu update
when I get a chance to remind myself how to do submodule updates
again.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYthLCAAoJEGw4ysog2bOSY40QAJhv2Qbsx0F/ng6MuP+Y16OS
+PySMCzq4zs2cCWVRyZ3Ad6SThOEP2WjF3v8Ad4BHZsz6aOzs/oF5PsmKJxoYv8D
Ey4n+9/23cm/HpB0+M/i3Mdl+39xNyiSjCNWYvAXDmF6fxhTdkKuF0eT0yMAzkUz
2VzUx7RzhendeT4FSebcRh8jRczdfhgTkN/VecxeCa9LsxZk6E5NVz3nErclazqx
osCW735pBQocZR1K5MAJ1cO/RuO7wfTSqE95nuKvKx8rODnsLkRY3V5pqadMaeHf
wWdkRKz1cktq0IJIBD4jpV35RVxuWm0JQ2yfLdZbtZ8dfizLJGfdq9MnEdY7Oaea
AlxXIH4VOBS7hNLxjOJaQBPON5FmDzHlcyogd0QvyXXPg11bb/BHIK1pHwTcNW0A
7dwCzD0XhlelR+tRC6OZHtnL7U5V0KJMjB0iCwe/bKakR9haib9IFKEpiNS7419T
B2+Fsw6JpJD9e0kUfSpn/RV906fvAL6NsZVCe0pZQTMSrp/qZfpvTWgIE3Z6OBxu
urTw+wMosGuLQCtifclv435VzIxaKPMikWHnKLGoMnH87wBQ88Al6mRcdz/E7nYu
0i8jYwuc0Y8nshHJ38632aFj/hgS8QNfoz5phE22hru5Y7V76mJwk2Dq7l/W6oVk
KBvX/RlC5h+Zu1g7iyW7
=ZEna
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
