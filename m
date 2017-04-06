Received: from eggs.gnu.org ([2001:4830:134:3::10]:38356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6d6-0002Ab-KM
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cw6d5-0008Jh-TH
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:35:12 -0400
Date: Thu, 6 Apr 2017 13:35:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170406123501.GJ21895@stefanha-x1.localdomain>
References: <20170403160936.28293-1-mreitz@redhat.com>
	<20170403160936.28293-10-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvznHscUikHnwW2p"
Content-Disposition: inline
In-Reply-To: <20170403160936.28293-10-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 for-2.10 09/16]
 block/qcow2: Generalize preallocate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--GvznHscUikHnwW2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 06:09:29PM +0200, Max Reitz wrote:
> This patch adds two new parameters to the preallocate() function so we
> will be able to use it not just for preallocating a new image but also
> for preallocated image growth.
>=20
> The offset parameter allows the caller to specify a virtual offset from
> which to start preallocating. For newly created images this is always 0,
> but for preallocating growth this will be the old image length.
>=20
> The new_length parameter specifies the supposed new length of the image
> (basically the "end offset" for preallocation). During image truncation,
> bdrv_getlength() will return the old image length so we cannot rely on
> its return value then.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GvznHscUikHnwW2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY5jX1AAoJEJykq7OBq3PIPzkIAIkHpk4/hRjU6z61bTt42zqX
cPcbV/txIoExH9dVOgqJ+nmPgCxQbJ8k6V9nEIwyV4ctft678fqyuVGTqLVel6fM
vWnQsTSgYjdxPAxOv32LCX/nv59NvPGdl27tK1yGYUDJK/alD/XCTBHqLFJm7IGZ
tpkwwlhsQcMf0kH7qIZfYvvh6FZCt7SrS/wsj6qcEvgiyMNwnNK3uICVhDpWcymG
0WN3w1MQJ33OOcd+ir3QbzRfqIFek0h1+GjxhL7/WkltHJyBhLGkmygoRPn04OHg
6Jh/4hUVrTtDj5JfaCognCWT+8eZYhkb1q/iy/+CvOMAqVDs9UCJ1dFatc0u0sE=
=xlUg
-----END PGP SIGNATURE-----

--GvznHscUikHnwW2p--
