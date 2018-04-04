Received: from eggs.gnu.org ([2001:4830:134:3::10]:45237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1f3kXp-0003un-B7
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:41:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1f3kXo-0005Hw-B1
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:41:53 -0400
Date: Wed, 4 Apr 2018 17:41:41 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180404154141.GS38016@angien.pipo.sk>
References: <20180403110810.25624-1-kwolf@redhat.com>
	<d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jZNlLGxhPb4urluq"
Content-Disposition: inline
In-Reply-To: <d1633a50-2aad-af64-081c-bfac72b89e12@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, prasanna.kalever@redhat.com


--jZNlLGxhPb4urluq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 08:09:49 -0500, Eric Blake wrote:
> On 04/03/2018 06:08 AM, Kevin Wolf wrote:
> > The legacy command line interface gets the socket path from an option
> > called 'socket'. QAPI in contract uses SocketAddress, where the
> > corresponding option is called 'path'.
> >=20
> > Fix the gluster block driver to accept both 'socket' and 'path', with
> > 'path' being the preferred syntax.
> >=20
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1545155
> >=20
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/gluster.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)

Thanks for fixing this. I'm using the new syntax in the -blockdev code
in libvirt and since I'm qapi- schema-checking the results, it would
not be possible to use the legacy approach.

>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Should we also add a deprecation warning for 'socket' and update the
> deprecation documentation, so we can start the clock ticking on getting
> rid of maintaining the back-compat glue forever?

Well, that won't be as easy. Since there is at least one qemu release
which declared this in the QAPI schema but did not support using it it's
hard for libvirt to detect that this was fixed, and thus we can't infer
a capability which would be used to switch to the new-syntax only.

--jZNlLGxhPb4urluq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlrE8jIACgkQHGwCByjY
1Gq4jxAAjBTAYwSidRlKYFBkP5C2J3YfctNpnk+ejsgDGqocvUWdG4U/mfEgZoa9
Lwkw77Vsi7MdwAMwnm0H+dv6FmVo9ENumiQo+1qfOE9Pc3I7dpCiaydsP9HNU6By
FLGOiV3iDqdm8PGSJF+1VbwtuFwkzMTK5uTuocttnRYULzk2WvFOG2D0qv2J2j6e
oK1bu9RelmdY4x7dwkMYTSYYPx+QegpZyLvRmx6lM82lCA3zZeEROtTGwbWKrXkF
b+FdaThWtYslDsvN2WDtUUKAVIjGph2wxwZD4Z3p/wpOFbtb9UN7UvIaYmSH1oaM
XRLv2XPJxk828a3ye9vwbXSdp2FpxCqZCpKBjZryuop+ClkfyViEfJrtyF+88PRC
CCCkBezZ34HayTdedWkGk8R4+4roDcADVG/thq56xoSEDHdwsZdnGZpveG7kb7QT
jRskdPutrXkcq2O79gJGT4dJJ90yHROKSZ7gcdH9rRNda7pyrauhwWxWl8x+36kA
1ObM/8Axeos3SvaGI/FOXHBuR13R+4EXqbOZUJCWzV+jPZNrKCTT8DEpz5x7ZsXH
7XWAn0rmNj3lmCLuTFeZf4JRjSyL1F+TpkSaUVlyE/Ic//xNUMr7lqlUAC4QN3Oe
SZ2AeFJH2SfJNZQ/b6fk5j/L2hmrABj9h7+g4HnVNaTpdRty/JM=
=OUd4
-----END PGP SIGNATURE-----

--jZNlLGxhPb4urluq--
