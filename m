Received: from eggs.gnu.org ([2001:4830:134:3::10]:58294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAGw-0007hL-Cn
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAGv-0003I9-5x
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:42 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:52237)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ciAGu-0003HO-Om
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:38:41 -0500
Date: Mon, 27 Feb 2017 12:05:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227010528.GM17615@umbus.fritz.box>
References: <CAFEAcA8AZup28Sho8hLeCRVf4iSdLdeFHvz1h4-X7FwVBcANyg@mail.gmail.com>
	<448f3a5f-044e-bcac-60bd-2ce074021be9@redhat.com>
	<20170223224911.GC17615@umbus.fritz.box>
	<20170224001613.GG17615@umbus.fritz.box>
	<CAFEAcA9V_1NA6-JgZd7Pc1hwih+uBKBrt4MPi4+kPWRu-xduPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+0mKm/ENadSkQxF+"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9V_1NA6-JgZd7Pc1hwih+uBKBrt4MPi4+kPWRu-xduPA@mail.gmail.com>
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


--+0mKm/ENadSkQxF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 10:35:35AM +0000, Peter Maydell wrote:
> On 24 February 2017 at 00:16, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > Ok, I've pushed libfdt upstream patches to (a) make passing NULL to
> > setprop() with zero length explicitly safe and (b) add an
> > fdt_setprop_empty() helper macro.  Do you want me to make a pullreq to
> > update the qemu submodule?
>=20
> Yes, please. Are we OK with using a random libfdt commit or do
> we update only to proper release tags?

I'm find with a random SHA, but that's not really my department - I'm
upstream libfdt maintainer, but update policy in the qemu tree seems
like a qemu side decision.

> There's no real rush with
> this so if you have a release due shortly it might be better
> to wait for that.

dtc/libfdt releases are a rather haphazard affair.  Usually they
happen when somebody complains that there hasn't been a release with
some feature they want.  Our tests are both fast to run and have
reasonaably good coverage, so random commits are usually good.  So a
"release" is usually just slapping a new version number onto whatever
is in master and making a tag and tarball.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+0mKm/ENadSkQxF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs3tYAAoJEGw4ysog2bOSnnwQAJIcK3rxMiIXmBpLl+a+5K94
P6z8RDYY/RMiP3C4oNeIcPyfNuZzzKAZ4Lm8lzBQRDwJ1CCvhGQdGlLja7Iuz0jD
boNHAqBBVBtkBvlKZkwU2J48qTRYco+n+YO8Pf2fD3DRSg3uRkVQuMLNTQ9yBqo0
AUYDUTb2Iem9rbRO3/7c9Umj54uWRxxPo6vFw7VJZmPoFLVuIfQUa2b8+PbUoqfI
iP6iJZV45lVXBdwesAG29Pa2BdhFtOQwJoQRvUMUJpN5ulUuyG7SbPzL7+oTsqDT
Gt0pA/Z0vCZkHmXRX2fFvrC6EWUkFSa3s23ojnVfAN2l84+W9XsEIO3mdBlAhYNP
fc1JRhR6oL3+aYwZsTAmZoX4lWy98sIzVbk87juWBvqTIFS7aI45hGWLuhiYiML2
DbosvdbpI/VuyT1yu36iC87LZcDhWoQvuuUzdrHQJoM9i1RLlpwmjZVJKFZI/v+9
tMC8urSO08/sXiinZjflxK8rbnJLKJdn9CeQUyOfP9QryZAmdETNMB3+Lpkg0mJR
QfzhIieiJNNYhZDlYv9iuAy537Y3y72ytkEsNcmPP/xRUzRscYsc8nKBazdRHhPO
dQRd1dCrg0qSTjes9mi2bA5JcteC14eZxQ9cGPpVv1Ghjit0PW8UmLemSegswUaL
gKyTBZD0sJtQUPVpmpIq
=yH3w
-----END PGP SIGNATURE-----

--+0mKm/ENadSkQxF+--
