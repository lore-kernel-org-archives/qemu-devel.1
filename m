Received: from eggs.gnu.org ([2001:4830:134:3::10]:49109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctwle-0002uh-IQ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctwlc-0002Lh-FA
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:39:05 -0400
References: <20170328205129.15138-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <40582b4b-41f0-1e49-022a-2794df62a2f4@redhat.com>
Date: Fri, 31 Mar 2017 15:38:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170328205129.15138-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UWLdeCuWbLFaaM5hjHcucRgRKSjr6guwg"
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
--UWLdeCuWbLFaaM5hjHcucRgRKSjr6guwg
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>
Message-ID: <40582b4b-41f0-1e49-022a-2794df62a2f4@redhat.com>
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

Applied to my block-next branch:

https://github.com/XanClic/qemu/commits/block-next

Max


--UWLdeCuWbLFaaM5hjHcucRgRKSjr6guwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljeW+0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A40cH/0r/hJ2iLXv7ZsIbINyHn+TnFPZdy4EQ
o5poHkKMZhpXtvHlMUZUcmePkJx8+8Q1Aiqxh/QzD0Q/vNhzWbxmcyTUcT35OZ9T
PQ7zeO6xPh7kh3Nx25pY57fbebUVfdFm6Za9Aej1TYn8sr968DmCPa7CHNijxBLC
E/sgxuDTCw+EKrWNlZrnYVtAcLOhOBzgPE95zcxa8/vKGtfSlhvzLNDAtMYqnyHo
N2wc0XRCb6D9hRP34fVkubpLJxtKBKkb6iYVf4oXsecyXUX8S6RUFl1017gZhOcl
1PyBr6c/JG/8uYNqS/KVYXdh7wtHZz72tRGhpt8drhq9UymLrTrpplY=
=dMIy
-----END PGP SIGNATURE-----

--UWLdeCuWbLFaaM5hjHcucRgRKSjr6guwg--
