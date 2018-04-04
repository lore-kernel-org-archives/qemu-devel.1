Received: from eggs.gnu.org ([2001:4830:134:3::10]:48928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3kk6-00025U-7i
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:54:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f3kk5-00051F-09
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:54:34 -0400
Date: Wed, 4 Apr 2018 17:54:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180404155420.GG4482@localhost.localdomain>
References: <20180403110810.25624-1-kwolf@redhat.com>
	<d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
	<20180404154141.GS38016@angien.pipo.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <20180404154141.GS38016@angien.pipo.sk>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12] gluster: Fix
 blockdev-add with server.N.type=unix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Krempa <pkrempa@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, prasanna.kalever@redhat.com


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 04.04.2018 um 17:41 hat Peter Krempa geschrieben:
> On Tue, Apr 03, 2018 at 08:09:49 -0500, Eric Blake wrote:
> > On 04/03/2018 06:08 AM, Kevin Wolf wrote:
> > > The legacy command line interface gets the socket path from an option
> > > called 'socket'. QAPI in contract uses SocketAddress, where the
> > > corresponding option is called 'path'.
> > >=20
> > > Fix the gluster block driver to accept both 'socket' and 'path', with
> > > 'path' being the preferred syntax.
> > >=20
> > > https://bugzilla.redhat.com/show_bug.cgi?id=3D1545155
> > >=20
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > > ---
> > >  block/gluster.c | 21 +++++++++++++++++----
> > >  1 file changed, 17 insertions(+), 4 deletions(-)
>=20
> Thanks for fixing this. I'm using the new syntax in the -blockdev code
> in libvirt and since I'm qapi- schema-checking the results, it would
> not be possible to use the legacy approach.

-blockdev is validated against the schema on the QEMU side, too. The
legacy option can only be used with -drive.

> > Reviewed-by: Eric Blake <eblake@redhat.com>
> >=20
> > Should we also add a deprecation warning for 'socket' and update the
> > deprecation documentation, so we can start the clock ticking on getting
> > rid of maintaining the back-compat glue forever?
>=20
> Well, that won't be as easy. Since there is at least one qemu release
> which declared this in the QAPI schema but did not support using it it's
> hard for libvirt to detect that this was fixed, and thus we can't infer
> a capability which would be used to switch to the new-syntax only.

Markus wanted to add some way to declare capabilities for a command in
the schema that could be queried with schema introspection and would
cover such cases. I think we even discussed this with you at KVM Forum?

Eric, do you happen to know if there were any patches on the list
related to this?

Kevin

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJaxPUsAAoJEH8JsnLIjy/WmagP/1/p4PpY/HSJ7Dp3tWy1kdTo
dNGFdheyzqM0rRn2tw2fO1z1GHxEeJYdsA9wK7qk3hguNc78BwPxlhcukrtYormp
5JpwgtGcXAEwzD0V7QzW2RJaQIuNe7ABtj/F1eSWw9s8WrzFW0tNz5r2rqu7MmMm
kCaMPTT+IsjqzQnuwWqJO+dt06h0aDBrGPj0ghq/WZIDZKHsEw0wLMStigC2LDcL
yh0jA3nUwsxldDhIatcboXPShLr9zK8Bjggs8UHP/1u8pPPozpIEWPdjT+2LWuT2
SayQgdflrg4ONjy8LU1AH6GItTAf5JPENhVj1bUDovFxoEvwYwb7Nb8PByb2JXn4
kCwPDkCk+0gc48drvnSlDCWXYsAWRyau3Hkfj2uT6C5vBi/GTGM1JhEpx6vLB6+1
ibOLRsudj5r0/WlRLm6ffXKDiv8UeJw9idkYEksBuxxZ9fmN+wSRHH7Pn1Kxs7gH
/KiDcIN9yqqv3FHYa/jrI74bpfPPQiDiAsQpJAmt8eYpq6YcW3nwzaqAXQ4YZSC5
kOS/eTGLnIbVpP9JMpfwlSt94AYg4vjHI4u3xoo4pV5NI3i8gijTzrEnGoDENYs9
i5xXDyV9p12IlhkKGSWcGNAnJuMkyKylvU8P2/9Oo6HziXPTb22mp3KNO2qPU2j2
LWEY7g8VP1oTOnNoZwuk
=Dl4m
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
