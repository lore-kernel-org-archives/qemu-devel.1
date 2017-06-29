Received: from eggs.gnu.org ([2001:4830:134:3::10]:33876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQa3V-0003k3-MA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:04:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dQa3M-0004oh-7L
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:04:25 -0400
Date: Thu, 29 Jun 2017 15:04:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170629140411.GB18146@stefanha-x1.localdomain>
References: <20170627224616.18538-1-el13635@mail.ntua.gr>
	<20170627224616.18538-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <20170627224616.18538-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] block: add default
 implementations for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 28, 2017 at 01:46:16AM +0300, Manos Pitsidianakis wrote:
> bdrv_co_get_block_status_from_file() and
> bdrv_co_get_block_status_from_backing() set *file to bs->file and
> bs->backing respectively, so that bdrv_co_get_block_status() can recurse
> to them. Future block drivers won't have to duplicate code to implement
> this.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/blkdebug.c          | 12 +-----------
>  block/commit.c            | 12 +-----------
>  block/io.c                | 24 ++++++++++++++++++++++++
>  block/mirror.c            | 12 +-----------
>  include/block/block_int.h | 16 ++++++++++++++++
>  5 files changed, 43 insertions(+), 33 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZVQjbAAoJEJykq7OBq3PIMHkIAL1nhk8WRoZfk3MgtayzfMY1
lCQ3QwGzuH8T3+OFxno1Gsu4nozx26cF/Po30zI1cpFPGrjOaz7wbQHTbQ+fzOX9
MehhOOMB3aPoC28eJVH0aXtAPVjM0ODaVF1UXKKXi8phocKjhtC+ocdR1G1R/QQE
4aDawQr+Zw+S2WXSU+fuassKYl6+dajW4/NiWEU0ZuVZ2+vdWRHiuwCkqgU2sk+v
f1mtxT0OOnPevPdNtQ2wY7sbRQpA/2C8KhlKmA9DjXZxRHPvNzopkJUzRcJRp0wM
dV0MAlEMU4DcbWXq9i1vmQKDmkCte2lAaricRfKLz2xV3UoYCIXSWNuW53EMIsE=
=/G7H
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
