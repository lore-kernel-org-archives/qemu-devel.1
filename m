Received: from eggs.gnu.org ([2001:4830:134:3::10]:52084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMDP-0000bZ-Ia
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMDK-0002Tp-JN
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:19:51 -0500
Date: Tue, 6 Dec 2016 20:18:43 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206201843.GD2521@stefanha-x1.localdomain>
References: <20161206160345.22425-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <20161206160345.22425-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.8] qapi: Document
 DEVICE_TRAY_MOVED addition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 10:03:45AM -0600, Eric Blake wrote:
> Commit 2d76e72 failed to add a versioning tag to 'id'.
>=20
> I audited all qapi*.json files from v2.7.0 to the current
> state of the tree, and didn't find any other additions where
> we failed to use a version tag.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> Doc-only, so safe for 2.8. But we're also close enough to -rc3
> that I'm fine if it has to go in later via -stable.
>=20
>  qapi/block.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRx0jAAoJEJykq7OBq3PIfLcIALAZc4vO+GZ3yLU6pe2wadoc
WDI30PsBjKdbgNXWZ/aGx6APQPZmIXqsQVGTT+0qWr03pJdt34CNQFiUCpFx6Ve8
yhXYU5Rh/dCv/cG09zrJib5Y/YotVTFJo+TLWmAvKHAsy6DFJsdfuTW7T/owVoL4
rmQeV8P/HVH/Dlz0p43hycsQOY+Ze+4eQ0IUY0Iy9E7Byt5PqUX6f76n5/i96yrX
3d5t+6hCthg8+nfBLKTlVN0wJqGq6yqCHl5QHPD5sAPtYcTwpRdqQskki97/CmuI
M3T20yBbJWJLuKbuicVUidTcUzCyKNDjyro7oYLUcWuREwd2lb6RYxM1LOiCFBU=
=pPiJ
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
