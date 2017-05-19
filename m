Received: from eggs.gnu.org ([2001:4830:134:3::10]:33320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBk26-0001KR-WC
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBk23-0000Ly-Sx
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:41:39 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBk23-0000L1-I8
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:41:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id k15so17763780wmh.3
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:41:35 -0700 (PDT)
Date: Fri, 19 May 2017 16:41:31 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170519154131.GB30573@stefanha-x1.localdomain>
References: <20170518172453.32599-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20170518172453.32599-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/18] Migration pull request
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


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 07:24:44PM +0200, Juan Quintela wrote:
> Hi
>=20
> This include the following series:
> - Fix non-multiple of page size migraition (dave)
> - Remove use of old MigrationParms (a.k.a. now block migration is a capab=
ility)
> - Cleanups of headers in migration
> - Make savevm.c target independent
>=20
> Please, apply.
>=20
> Thanks, Juan.
>=20
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>   git://github.com/juanquintela/qemu.git tags/migration/20170518
>=20
> for you to fetch changes up to 46d702b106d20beda2fcd0f96ddc44855ba262b3:
>=20
>   migration: Make savevm.c target independent (2017-05-18 19:21:00 +0200)
>=20
> ----------------------------------------------------------------
> migration/next for 20170518
>=20
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (3):
>       migration: Fix non-multiple of page size migration
>       postcopy: Require RAMBlocks that are whole pages
>       block migration: Allow compile time disable
>=20
> Juan Quintela (15):
>       hmp: Use visitor api for hmp_migrate_set_parameter()
>       migration: Create block capability
>       migration: Remove use of old MigrationParams
>       migration: Remove old MigrationParams
>       migration: Create migration/xbzrle.h
>       migration: Split migration/channel.c for channel operations
>       migration: Export qemu-file-channel.c functions in its own file
>       migration: Remove migration.h from colo.h
>       migration: Move qjson.h to migration/
>       migration: Split vmstate-types.c from vmstate.c
>       migration: Remove qemu-file.h from vmstate.h
>       migration: Remove vmstate.h from migration.h
>       migration: migration.h was not needed
>       exec: Create include for target_page_size()
>       migration: Make savevm.c target independent
>=20
>  Makefile.target                          |   2 +-
>  block/qed.c                              |   1 -
>  configure                                |  11 +
>  exec.c                                   |  10 +
>  hmp.c                                    |  23 +-
>  hw/i386/pc_q35.c                         |   1 -
>  hw/virtio/vhost-user.c                   |   1 -
>  hw/virtio/vhost-vsock.c                  |   1 -
>  hw/virtio/virtio.c                       |   1 -
>  include/exec/target_page.h               |  21 +
>  include/hw/hw.h                          |   1 +
>  include/migration/block.h                |  24 ++
>  include/migration/colo.h                 |   1 -
>  include/migration/migration.h            |  30 +-
>  include/migration/qemu-file.h            |   4 -
>  include/migration/vmstate.h              |   4 -
>  include/qemu/typedefs.h                  |   1 -
>  include/sysemu/sysemu.h                  |   4 +-
>  migration/Makefile.objs                  |   6 +-
>  migration/block.c                        |  19 +-
>  migration/channel.c                      |  67 ++++
>  migration/channel.h                      |  27 ++
>  migration/colo-comm.c                    |   4 +-
>  migration/colo.c                         |   9 +-
>  migration/exec.c                         |   1 +
>  migration/fd.c                           |   1 +
>  migration/migration.c                    | 149 ++++---
>  migration/postcopy-ram.c                 |  18 +-
>  migration/qemu-file-channel.c            |   1 +
>  migration/qemu-file-channel.h            |  32 ++
>  migration/qjson.c                        |   2 +-
>  {include/migration =3D> migration}/qjson.h |   0
>  migration/ram.c                          |   8 +-
>  migration/rdma.c                         |   1 +
>  migration/savevm.c                       |  40 +-
>  migration/socket.c                       |   1 +
>  migration/tls.c                          |   1 +
>  migration/vmstate-types.c                | 661 +++++++++++++++++++++++++=
++++++
>  migration/vmstate.c                      | 656 +------------------------=
-----
>  migration/xbzrle.c                       |   2 +-
>  migration/xbzrle.h                       |  21 +
>  monitor.c                                |   1 -
>  qapi-schema.json                         |  28 +-
>  tests/Makefile.include                   |   2 +-
>  tests/test-vmstate.c                     |   2 +
>  tests/test-xbzrle.c                      |   2 +-
>  46 files changed, 1102 insertions(+), 801 deletions(-)
>  create mode 100644 include/exec/target_page.h
>  create mode 100644 migration/channel.c
>  create mode 100644 migration/channel.h
>  create mode 100644 migration/qemu-file-channel.h
>  rename {include/migration =3D> migration}/qjson.h (100%)
>  create mode 100644 migration/vmstate-types.c
>  create mode 100644 migration/xbzrle.h
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHxIrAAoJEJykq7OBq3PItI0IAK942nd7CP517ecwY3qmc6c1
vI913ogNCoFWY3RGuXXbXF4l3IOlWFikUH70HMsk4JSiWPfGWVkXSNE6fQhE2WLg
0OvjJr1CrpZjBkrUlBe2kizRN9QfucNU7Bt2qIUhjxlSxGatE3+NRopSI3e72F61
dSs7LaFI54Fw388SorT6e2l8imTeslXbGmlCwoqtXc0PI4BHKN/ScWyIaAFmT/Cc
7K4nmZ1PF1nfXGWYGpUL/jdstrOy5CMoHb7a7cWGgqk80qXDmgm4ngW3lrPXUErG
cHDG7A8TjF8ExGgg2i8RvVkD2lgIxkzTSpgWRMM4j/9t66yp4RVXqttnHQIpZuU=
=sIJE
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
