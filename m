Received: from eggs.gnu.org ([2001:4830:134:3::10]:59518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Kao-0007vx-0F
	for qemu-devel@nongnu.org; Wed, 10 May 2017 01:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Kaj-0007uj-ST
	for qemu-devel@nongnu.org; Wed, 10 May 2017 01:55:22 -0400
Received: from ozlabs.org ([103.22.144.67]:53001)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d8Kai-0007uX-P3
	for qemu-devel@nongnu.org; Wed, 10 May 2017 01:55:17 -0400
Date: Wed, 10 May 2017 15:55:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170510055507.GT25748@umbus.fritz.box>
References: <1493977730-20581-1-git-send-email-pbonzini@redhat.com>
	<20170508061359.GH25748@umbus.fritz.box>
	<e1b235c4-14c1-549f-45bf-c5175401f949@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Nx8xdmI2KD3LNVVP"
Content-Disposition: inline
In-Reply-To: <e1b235c4-14c1-549f-45bf-c5175401f949@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ppc: xics: fix compilation with CentOS 6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgibson@redhat.com, stefanha@redhat.com


--Nx8xdmI2KD3LNVVP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 09:25:19AM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 08/05/2017 08:13, David Gibson wrote:
> >>
> >> 	Please start including Docker-based tests in your pre-pull-request te=
sts.
> > Um.. is there some doco on how to execute these.  I tried "make
> > docker-test" and "make docker-image" and they both just seem to hang
> > at:
> >=20
> > umbus:~/src/qemu (ppc-for-2.10)$ make docker-image
> >   BUILD   travis
> >=20
> > strace shows docker blocked on a futex.
>=20
> Try "make docker-test-full@centos6 V=3D1".

So, the problem I hit above was just that it was taking time to
download all the image data - without V=3D1, it wasn't showing progress
so it looked like it wasn't doing anything.

With that done, I get further, but it's still a bit of a pain in the
arse.  If I run as a normal user things fail, because the sudo
authorization runs out before a test is complete.  If I run as root it
screws up permissions on my git tree so I have to re-chown before
operating as a normal user again.  And testing the full set of images
takes an age - I've been running this all day, and AFAICT it's barely
through half the available images.  If I'm testing for multiple days
it means what I'm finally sending a pullreq for is no longer against
the latest master, which I don't really like.

Any ideas to make this less painful?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Nx8xdmI2KD3LNVVP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEqs4AAoJEGw4ysog2bOS2+0QAJnRD3PjLODAJ/6Ba5qQuq/e
xCsVWSt9O50Zvsm/WYa8cer1YEq6PXbuBaS4AnJYeHTrXzk8DxDb+PXpMWVeJ7+A
0Y/IZpZZqqUvUkQ8tRriIGzxL4W7AngyNVY3ki5SVH/6okbLqSy5PKlgGAuNnm++
RmEumz8GAGJ9anG+OcfRw9SvFLRThEbPDLg0OzqcOyYT86YGZzSCDZ3gF3EClLcJ
daxKLXikDRjOi8/6Wr/yEX+/L3Kfytz/q9lAuAE3FDj/8kKV5QSKasj8Y4O0yK+j
fZA/qNeDr7tVla0gP1jNzo/YNWNzthBPakkdSYEknGraQbu5hHmk1R8jGT6O2A9E
aReLJzHTzQaV/J8ugLsD3OWt9edTIiNmauwaMzX75Fc8oOYzFklkkssVsSBWLmEL
LHjwHci8j9Uhr2mbR562qgTKMMSUpnJY+L2YwfuQ1PoM7IVzd3Zb6gVFJDhMsxA+
ez4Y5R/rGUCjwAtKdU68Jlwgo7eNfbXpJwoI9gTAImTqE760bKrY2hzM+1w95zsT
6b2QPSGeUQQf+DCsYSp6nvxbZ1XduApSFsjV2kXDTd+kZws8F3lvH+GdW7rAl5e/
mtCeMA5i/6y3wKsCN3kIcWFWiUYDgKEFbKawPPvPlXbPR3AWfJX0hWBHifbIRdRH
aMw+UiRG+jtMIIU9DsZV
=1thn
-----END PGP SIGNATURE-----

--Nx8xdmI2KD3LNVVP--
