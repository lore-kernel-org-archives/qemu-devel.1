Received: from eggs.gnu.org ([2001:4830:134:3::10]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJ7W-0008Mx-4a
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:39:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxJ7V-0002e0-EK
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:39:50 -0400
References: <20170927125340.12360-1-berrange@redhat.com>
	<20170927125340.12360-2-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <80c29ed7-ca42-d5aa-3af0-ee6461277dcb@redhat.com>
Date: Wed, 27 Sep 2017 22:39:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170927125340.12360-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hpHAsQbqQFReutAs1EeBd9JM9ISW0H0Xd"
Subject: Re: [Qemu-devel] [PATCH v4 1/6] block: use 1 MB bounce buffers for
 crypto instead of 16KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hpHAsQbqQFReutAs1EeBd9JM9ISW0H0Xd
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <80c29ed7-ca42-d5aa-3af0-ee6461277dcb@redhat.com>
Subject: Re: [PATCH v4 1/6] block: use 1 MB bounce buffers for crypto instead
 of 16KB
References: <20170927125340.12360-1-berrange@redhat.com>
 <20170927125340.12360-2-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-27 14:53, Daniel P. Berrange wrote:
> Using 16KB bounce buffers creates a significant performance
> penalty for I/O to encrypted volumes on storage which high
> I/O latency (rotating rust & network drives), because it
> triggers lots of fairly small I/O operations.
>=20
> On tests with rotating rust, and cache=3Dnone|directsync,
> write speed increased from 2MiB/s to 32MiB/s, on a par
> with that achieved by the in-kernel luks driver. With
> other cache modes the in-kernel driver is still notably
> faster because it is able to report completion of the
> I/O request before any encryption is done, while the
> in-QEMU driver must encrypt the data before completion.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--hpHAsQbqQFReutAs1EeBd9JM9ISW0H0Xd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnMDIgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AtT8H/iLnHaYcbqVBcMiCuSHeLcuTAXrGZjV5
iIZmGdtTs0c3U/gzenUMEqbTElFJvK9mu1uNdfHX8rbs1wgWdcKkJZf8jE3l8ZC8
f7lqduhpshV20NPKjiAdURwPffp9BWU422YcxX+UzWv+owhUEgZB3OEFn5XGDJnB
MFh/T5S5owfW+F89ERulxg4oWd7yjhqM8ph6YqifvE2BLy/lUjGx23TlrxTIear1
q1aYlLXYiiFNLfwtT5Bb5wqLCmA0qs38GTzeQKHnO4Y9AIqaHMTT0LcoRS8ZbdmI
qy0HPOISENQpUOEdAV2Y7a4a0dc7k23oz+y4wJYRJhtFs0HBgV6H8uc=
=4tU8
-----END PGP SIGNATURE-----

--hpHAsQbqQFReutAs1EeBd9JM9ISW0H0Xd--
