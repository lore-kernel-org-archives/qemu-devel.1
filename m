Received: from eggs.gnu.org ([2001:4830:134:3::10]:46949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csyFA-0000T9-AG
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 17:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csyF9-0007vx-9R
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 17:01:32 -0400
References: <20170328205129.15138-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <905f9d1f-7bc8-d04a-66a7-c59d2e43e240@redhat.com>
Date: Tue, 28 Mar 2017 23:01:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170328205129.15138-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HlhGfAuBag11lVQNGGTPijdjEhPwgWDH6"
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
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HlhGfAuBag11lVQNGGTPijdjEhPwgWDH6
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Message-ID: <905f9d1f-7bc8-d04a-66a7-c59d2e43e240@redhat.com>
Subject: Re: [PATCH v3 for-2.10 0/4] block: Add errp to b{lk,drv}_truncate()
References: <20170328205129.15138-1-mreitz@redhat.com>
In-Reply-To: <20170328205129.15138-1-mreitz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.03.2017 22:51, Max Reitz wrote:
> Having an Error parameter for these functions makes sense because we
> sometimes want a bit more information than just "Something failed". Som=
e
> drivers already use error_report() and the like to emit this additional=

> information, so it's rather obvious that we do want a real error object=

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

Oops, forgot the backport-diff against v2, here you go:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences,
respectively

001/4:[----] [--] 'block/vhdx: Make vhdx_create() always set errp'
002/4:[0001] [FC] 'block: Add errp to b{lk,drv}_truncate()'
003/4:[0003] [FC] 'block: Add errp to BD.bdrv_truncate()'
004/4:[0025] [FC] 'block: Add .bdrv_truncate() error messages'


Max

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



--HlhGfAuBag11lVQNGGTPijdjEhPwgWDH6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljazxkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARgoH/2Wg6amIxhMhnCq2oUKssZ1n7dVG18zi
QEYXn8Q+f0SsLJj8Gy63b4KxmyQnmfFyLXhkRL1pxu4/XQPFwS/GShVQK44Qc5dC
OyMIVMsIDRXf+OVn0svt5J2utW+ugI5xbe4cjXQfzKlwEY1sQ3buTrb3MH5gHkcR
+S5PBNzfc+WQ+8P3Ye2OQlPz9U3+Kn3wA74C8hPj/96eUOU5nvl1H1vkPzn1zry6
sPY+jmWQVYea1N9GAA2N/JCIOYwwzz4AXs44y3QbXhbKk8gfYnZLj7yqebkLkL1a
LbSYtQ2JhOzQutET+7Q616hcShqc41I4Ik4lbDOmUS56TThJPS/Julo=
=vCGm
-----END PGP SIGNATURE-----

--HlhGfAuBag11lVQNGGTPijdjEhPwgWDH6--
