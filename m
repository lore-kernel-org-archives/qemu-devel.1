Received: from eggs.gnu.org ([2001:4830:134:3::10]:50473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGWU-0001EY-8N
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAGWR-0000u7-8a
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:58:54 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAGWR-0000tk-3f
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:58:51 -0400
Received: by mail-qk0-x244.google.com with SMTP id k74so17235762qke.2
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:58:50 -0700 (PDT)
Date: Mon, 15 May 2017 14:58:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515135848.GL1201@stefanha-x1.localdomain>
References: <20170512155249.8853-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pFej7zHSL6C5fFIz"
Content-Disposition: inline
In-Reply-To: <20170512155249.8853-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/5] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com


--pFej7zHSL6C5fFIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 12, 2017 at 05:52:44PM +0200, Juan Quintela wrote:
> Hi
>=20
> This pull contains:
> - Fix regression with compression threads (mea culpa)
> - start of includes migration (creating of blocker.h header)
> - Use Error** correctly after several iterations
> - Rename of RAM_SAVE_FLAG_COMPRESS
> - Create block capabilities for shared and enable
>=20
> Please, apply.
>=20
>=20
>=20
> The following changes since commit ecc1f5adeec4e3324d1b695a7c54e3967c5269=
49:
>=20
>   maintainers: Add myself as linux-user reviewer (2017-05-11 13:31:11 -04=
00)
>=20
> are available in the git repository at:
>=20
>   git://github.com/juanquintela/qemu.git tags/migration/20170512
>=20
> for you to fetch changes up to f15e5850905dea6a09e29ef14df508ec236321d9:
>=20
>   migration: Create migration/blocker.h (2017-05-12 17:10:57 +0200)
>=20
> ----------------------------------------------------------------
> migration/next for 20170512
>=20
> ----------------------------------------------------------------
> Juan Quintela (5):
>       migration: Fix regression with compression threads
>       migration: Pass Error ** argument to {save,load}_vmstate
>       ram: Rename RAM_SAVE_FLAG_COMPRESS to RAM_SAVE_FLAG_ZERO
>       migration: Create block capabilities for shared and enable
>       migration: Create migration/blocker.h
>=20
>  block/qcow.c                  |  2 +-
>  block/vdi.c                   |  2 +-
>  block/vhdx.c                  |  2 +-
>  block/vmdk.c                  |  2 +-
>  block/vpc.c                   |  2 +-
>  block/vvfat.c                 |  2 +-
>  hmp.c                         |  9 ++++++--
>  hw/9pfs/9p.c                  |  2 +-
>  hw/display/qxl.c              |  2 +-
>  hw/display/virtio-gpu.c       |  2 +-
>  hw/intc/arm_gic_kvm.c         |  2 +-
>  hw/intc/arm_gicv3_its_kvm.c   |  2 +-
>  hw/intc/arm_gicv3_kvm.c       |  2 +-
>  hw/misc/ivshmem.c             |  2 +-
>  hw/scsi/vhost-scsi.c          |  2 +-
>  hw/virtio/vhost.c             |  2 +-
>  include/migration/block.h     |  3 +++
>  include/migration/blocker.h   | 35 +++++++++++++++++++++++++++++
>  include/migration/migration.h | 21 +++---------------
>  include/sysemu/sysemu.h       |  4 ++--
>  migration/migration.c         | 37 +++++++++++++++++++++++++++++++
>  migration/ram.c               | 35 +++++++++++++++++------------
>  migration/savevm.c            | 51 +++++++++++++++++++++----------------=
------
>  qapi-schema.json              |  7 +++++-
>  replay/replay-snapshot.c      |  8 +++++--
>  stubs/migr-blocker.c          |  2 +-
>  target/i386/kvm.c             |  2 +-
>  vl.c                          |  4 +++-
>  28 files changed, 165 insertions(+), 83 deletions(-)
>  create mode 100644 include/migration/blocker.h
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--pFej7zHSL6C5fFIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGbQXAAoJEJykq7OBq3PI6W0H/1WI8tu4p8BxQuImpnrEKUyk
grJ29DH0swWCFs2ULVmSJdA7VJTqZLlnIGMR5NYA6aoecq0p2QmJVA9D85zjyIw0
bbu1xSCdPOBY98T0emG3DqgWyWoGRg1U6khpwwXWWK+k4DV09rVRqbQl0z0G7sz3
g1SZnC48EZrQ/wUdhw87F7GoelaSAtlbeJvp54XPJ0jOQzoJk+j82j4MhmD7Bw6e
MmJGzfZF+I3Y2N5G/sfcioEAQfOTQWb7+yO+7JjrOEgg8z316M5UqmABcdCxayDi
yJPAAFGUiysWDIwGbORvUHTPvglDq+K9p4QLRwNyo+0sym2IJem9PGwlnggiJ2w=
=epe1
-----END PGP SIGNATURE-----

--pFej7zHSL6C5fFIz--
