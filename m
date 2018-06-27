Received: from eggs.gnu.org ([2001:4830:134:3::10]:34729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY95D-0006Q4-Np
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY95C-00028R-UM
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:57:59 -0400
Date: Wed, 27 Jun 2018 12:57:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627115752.GK5955@stefanha-x1.localdomain>
References: <20180626142434.22090-1-kwolf@redhat.com>
	<20180626142434.22090-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9kwpIYUMbI/2cCx"
Content-Disposition: inline
In-Reply-To: <20180626142434.22090-7-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] file-posix: Make .bdrv_co_truncate
 asynchronous
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, qemu-devel@nongnu.org


--M9kwpIYUMbI/2cCx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2018 at 04:24:34PM +0200, Kevin Wolf wrote:
> This moves the code to resize an image file to the thread pool to avoid
> blocking.
>=20
> Creating large images with preallocation with blockdev-create is now
> actually a background job instead of blocking the monitor (and most
> other things) until the preallocation has completed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/raw-aio.h |   4 +-
>  block/file-posix.c      | 265 +++++++++++++++++++++++++++---------------=
------
>  2 files changed, 153 insertions(+), 116 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--M9kwpIYUMbI/2cCx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM3vAAAoJEJykq7OBq3PIyFEH/0M5kVbMdhksg9T0yX1WNhD1
ZcTX1eVnhFKTotFU/tz6vejVbCs7ql9Afk/0OEAxPrtb5VEEXyT5Aq94tUQy5pQw
8uxVXufWWVNsIlGAALtA4BodW/ywD5ywPk/N1qgQ3EerGZgbNd4FAHfDBLTo5Xbo
vWOklt3fVrLqDocMru6l4nfxCEs3EKddf/wXxFg++sG0MzsqGKr9yw2fucaAeJVI
dQ14mwBVOlNrTkTSTTgOatVbkAF1rXgytZivn1z6+2QZ64XI4Hj9vGUJ0ZKu+RBE
r68L9fruejNC4AU9qQlG7GMDS8BgbwLqYZvj75n+F6/vt520WwBqUW6ffy7SSQo=
=RQE4
-----END PGP SIGNATURE-----

--M9kwpIYUMbI/2cCx--
