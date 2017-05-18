Received: from eggs.gnu.org ([2001:4830:134:3::10]:55111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHRT-0004qw-TW
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHRQ-0003XA-Kc
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:09:55 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:36473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBHRQ-0003Wy-Bg
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:09:52 -0400
Received: by mail-wr0-x242.google.com with SMTP id v42so5237939wrc.3
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 02:09:52 -0700 (PDT)
Date: Thu, 18 May 2017 10:09:49 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170518090949.GE30862@stefanha-x1.localdomain>
References: <20170517111346.21450-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Content-Disposition: inline
In-Reply-To: <20170517111346.21450-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/7] Migration pull request
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


--4Epv4kl9IRBfg3rk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 01:13:39PM +0200, Juan Quintela wrote:
> Hi
>=20
> This pull request:
> - drop block capability patch (now they is being reviewed)
> - add following patches that got reviewed:
>   * page_cache.c into migration
>   * postcopy stuff into postocpy-ram.c
>   * check_migratable change
>=20
> Please apply.
>=20
> Thanks, Juan.
>=20
> The following changes since commit cdece0467c00007cf8e3f4b3c3f0b13bf2c4fe=
a9:
>=20
>   block/win32: fix 'ret not initialized' warning (2017-05-16 15:34:18 +01=
00)
>=20
> are available in the git repository at:
>=20
>   git://github.com/juanquintela/qemu.git tags/migration/20170517
>=20
> for you to fetch changes up to 1bfe5f0586083747f1602931713111673849cd9d:
>=20
>   migration: Move check_migratable() into qdev.c (2017-05-17 12:04:59 +02=
00)
>=20
> ----------------------------------------------------------------
> migration/next for 20170517
>=20
> ----------------------------------------------------------------
> Juan Quintela (7):
>       migration: Fix regression with compression threads
>       migration: Pass Error ** argument to {save,load}_vmstate
>       ram: Rename RAM_SAVE_FLAG_COMPRESS to RAM_SAVE_FLAG_ZERO
>       migration: Create migration/blocker.h
>       migration: Move page_cache.c to migration/
>       migration: Move postcopy stuff to postcopy-ram.c
>       migration: Move check_migratable() into qdev.c
>=20
>  Makefile.objs                                 |  1 -
>  block/qcow.c                                  |  2 +-
>  block/vdi.c                                   |  2 +-
>  block/vhdx.c                                  |  2 +-
>  block/vmdk.c                                  |  2 +-
>  block/vpc.c                                   |  2 +-
>  block/vvfat.c                                 |  2 +-
>  hmp.c                                         |  9 +++-
>  hw/9pfs/9p.c                                  |  2 +-
>  hw/core/qdev.c                                | 20 +++++++--
>  hw/display/qxl.c                              |  2 +-
>  hw/display/virtio-gpu.c                       |  2 +-
>  hw/intc/arm_gic_kvm.c                         |  2 +-
>  hw/intc/arm_gicv3_its_kvm.c                   |  2 +-
>  hw/intc/arm_gicv3_kvm.c                       |  2 +-
>  hw/misc/ivshmem.c                             |  2 +-
>  hw/scsi/vhost-scsi.c                          |  2 +-
>  hw/virtio/vhost.c                             |  2 +-
>  include/migration/blocker.h                   | 35 +++++++++++++++
>  include/migration/migration.h                 | 50 ----------------------
>  include/migration/vmstate.h                   |  2 +
>  include/sysemu/sysemu.h                       |  6 +--
>  migration/Makefile.objs                       |  2 +-
>  migration/migration.c                         | 34 +--------------
>  page_cache.c =3D> migration/page_cache.c        |  0
>  {include/migration =3D> migration}/page_cache.h |  0
>  migration/postcopy-ram.c                      | 18 ++++++++
>  migration/postcopy-ram.h                      | 26 ++++++++++++
>  migration/ram.c                               | 35 +++++++++------
>  migration/savevm.c                            | 61 +++++++++++++++------=
------
>  replay/replay-snapshot.c                      |  8 +++-
>  stubs/migr-blocker.c                          |  2 +-
>  stubs/vmstate.c                               |  5 +--
>  target/i386/kvm.c                             |  2 +-
>  tests/Makefile.include                        |  2 +-
>  vl.c                                          |  4 +-
>  36 files changed, 194 insertions(+), 158 deletions(-)
>  create mode 100644 include/migration/blocker.h
>  rename page_cache.c =3D> migration/page_cache.c (100%)
>  rename {include/migration =3D> migration}/page_cache.h (100%)
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHWTdAAoJEJykq7OBq3PIlM8H/107mTq2iof/ObeKtMDK6wPR
/N05+O5xqs9le+XhF9M2TgbuhzsfBR7Aj8JLDHHQtS6nDSa47dGGSnDiK7kpJjU+
0JJ7UUA+z0m3X3sCFyZlffrzKf2By3n+KR7CeVBNAYuwR/kZymNIhKGFtH6uOTSG
fr3B3kQGJJSWva/cngwLiK+zVuSBFC78ppiDSEoYNpSlaP2VDxImEozHUMmqy9M5
eXXXq/5rfgrmpshCANTLmLvOrav8nPBE5ENlEwJrXRdQTVxLZT53MideZqtoJe0P
2XJKHixwA0D4tCPv6LQyh0o6qv3BB5NNFba8OxXuH5isMsa24kyONUIyb6QWFf8=
=g55F
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--
