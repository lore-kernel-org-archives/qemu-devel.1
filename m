Received: from eggs.gnu.org ([2001:4830:134:3::10]:49902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvZG-0004dn-LM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpvZC-0005MC-Rq
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 07:33:42 -0400
Date: Mon, 20 Mar 2017 11:33:30 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320113330.GQ17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214032.26672-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V2tfspbppmK1TQo2"
Content-Disposition: inline
In-Reply-To: <20170313214032.26672-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 02/16] block: Add
 PreallocMode to bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--V2tfspbppmK1TQo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:40:18PM +0100, Max Reitz wrote:
> For block drivers that just pass a truncate request to the underlying
> protocol, we can now pass the preallocation mode instead of aborting if
> it is not PREALLOC_MODE_OFF.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/block/block.h  |  3 ++-
>  block.c                | 12 +++++++++---
>  block/blkdebug.c       |  8 +-------
>  block/block-backend.c  |  2 +-
>  block/crypto.c         |  8 +-------
>  block/parallels.c      | 11 +++++++----
>  block/qcow.c           |  6 ++++--
>  block/qcow2-refcount.c |  2 +-
>  block/qcow2.c          |  4 ++--
>  block/raw-format.c     |  8 +-------
>  block/vhdx-log.c       |  2 +-
>  block/vhdx.c           |  3 ++-
>  12 files changed, 32 insertions(+), 37 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--V2tfspbppmK1TQo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz74KAAoJEJykq7OBq3PIFBwH/0h6rrtaF4nXwF/i9fict1Np
KID0qirRrXo+dSSXKpATQYWr8zEtED8QZ6kPMfEGQFbm3zdrsRBApdL/Z2Lzsu0d
oNG7WGSY5sKy+8vTwirdQG5mo81mFsDSD2NLRA1C6csH8CX0m098IdiKg6fS/0eq
UFj65CfBJvwlK8LxVQ2ULtXW5HakdEYfClRjInB/ii5WlAhW6Tb2eb7325DhXNpo
gDncDloDuQdELqWOyqKS9ZzrElgjoTzzF6sEBweU08hMfWXb+toJaslwmayp3JRU
yOUs0rbZp7lwwhq+IS/f9gW863sUEa8Brh3/ZVpAQlFeWJ7FHLyTcWsIn4o6nWE=
=/juV
-----END PGP SIGNATURE-----

--V2tfspbppmK1TQo2--
