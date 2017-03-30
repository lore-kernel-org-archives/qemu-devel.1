Received: from eggs.gnu.org ([2001:4830:134:3::10]:49356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctZOw-00079f-Od
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ctZOs-00032q-RS
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 08:42:06 -0400
Date: Thu, 30 Mar 2017 13:41:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170330124149.GF25420@stefanha-x1.localdomain>
References: <20170328205129.15138-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline
In-Reply-To: <20170328205129.15138-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 for-2.10 0/4] block: Add errp to b{lk,
 drv}_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 10:51:25PM +0200, Max Reitz wrote:
> Having an Error parameter for these functions makes sense because we
> sometimes want a bit more information than just "Something failed". Some
> drivers already use error_report() and the like to emit this additional
> information, so it's rather obvious that we do want a real error object
> here.
>=20
>=20
> v3:
> - Patch 2: Keep "Could not resize image" message in qcow2_create2() by
>            using error_prepend() [Kevin]
> - Patch 3: Dropped archipelago
> - Patch 4:
>   - Keep errno information where available [Kevin]
>   - Make all drivers generate error messages [Stefan/Eric]
>   - Drop generic error message from bdrv_truncate() [Stefan/Eric]
>=20
>=20
> Max Reitz (4):
>   block/vhdx: Make vhdx_create() always set errp
>   block: Add errp to b{lk,drv}_truncate()
>   block: Add errp to BD.bdrv_truncate()
>   block: Add .bdrv_truncate() error messages
>=20
>  include/block/block.h          |  2 +-
>  include/block/block_int.h      |  2 +-
>  include/sysemu/block-backend.h |  2 +-
>  block.c                        | 16 +++++++++++-----
>  block/blkdebug.c               |  4 ++--
>  block/block-backend.c          |  5 +++--
>  block/commit.c                 |  5 +++--
>  block/crypto.c                 |  5 +++--
>  block/file-posix.c             | 19 +++++++++++++------
>  block/file-win32.c             |  6 +++---
>  block/gluster.c                |  7 +++++--
>  block/iscsi.c                  |  6 ++++--
>  block/mirror.c                 |  2 +-
>  block/nfs.c                    | 12 ++++++++++--
>  block/parallels.c              | 13 ++++++++-----
>  block/qcow.c                   |  6 +++---
>  block/qcow2-refcount.c         |  5 ++++-
>  block/qcow2.c                  | 24 +++++++++++++++---------
>  block/qed.c                    |  8 +++++---
>  block/raw-format.c             |  6 ++++--
>  block/rbd.c                    |  3 ++-
>  block/sheepdog.c               | 14 ++++++--------
>  block/vdi.c                    |  4 ++--
>  block/vhdx-log.c               |  2 +-
>  block/vhdx.c                   | 25 ++++++++++++++++++-------
>  block/vmdk.c                   | 13 +++----------
>  block/vpc.c                    | 13 +++++++------
>  blockdev.c                     | 21 +--------------------
>  qemu-img.c                     | 17 ++++-------------
>  qemu-io-cmds.c                 |  5 +++--
>  30 files changed, 147 insertions(+), 125 deletions(-)
>=20
> --=20
> 2.12.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY3P0NAAoJEJykq7OBq3PIOZsIAJgSO/rl/ADLyhw9GZpkBPLQ
XtRhUAS1RLkFLyT4KwyG4Pu7POEXXo0s3fZnwAqBJkHBT5AY4DdSIXH9qq/EMx0w
OYwhKBQudAdGG7gBkZGL4EiQONQnijKo9gHBjEiD6itT5RtkEKk+5TPnfZuZkf0+
cvUnqUowsLR73TNrYRwpEqkRL1Bb644bNdzefVyJn2EiG4XeUKLDrr4cXui6yvN+
Y8I2/cBkHWFRhnzDR05ALmm8T0OzMfzHZO8idu1oAJ+c7vrLFt3NMzgEpF3fxrwD
WvnWWSMslYR1JphmV+HNKRc5voMf3ZRmCOvEPp/OlMisPiTdbnxDCHZlMOR0wMs=
=dnUv
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
