Received: from eggs.gnu.org ([2001:4830:134:3::10]:57050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPAe-0008Jy-Fq
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBPAa-0006SW-21
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:25:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBPAZ-0006SK-P7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 13:24:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1A39285A0
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 17:24:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu, 18 May 2017 19:24:44 +0200
Message-Id: <20170518172453.32599-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/18] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hi

This include the following series:
- Fix non-multiple of page size migraition (dave)
- Remove use of old MigrationParms (a.k.a. now block migration is a capab=
ility)
- Cleanups of headers in migration
- Make savevm.c target independent

Please, apply.

Thanks, Juan.

The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:

  Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170518

for you to fetch changes up to 46d702b106d20beda2fcd0f96ddc44855ba262b3:

  migration: Make savevm.c target independent (2017-05-18 19:21:00 +0200)

----------------------------------------------------------------
migration/next for 20170518

----------------------------------------------------------------
Dr. David Alan Gilbert (3):
      migration: Fix non-multiple of page size migration
      postcopy: Require RAMBlocks that are whole pages
      block migration: Allow compile time disable

Juan Quintela (15):
      hmp: Use visitor api for hmp_migrate_set_parameter()
      migration: Create block capability
      migration: Remove use of old MigrationParams
      migration: Remove old MigrationParams
      migration: Create migration/xbzrle.h
      migration: Split migration/channel.c for channel operations
      migration: Export qemu-file-channel.c functions in its own file
      migration: Remove migration.h from colo.h
      migration: Move qjson.h to migration/
      migration: Split vmstate-types.c from vmstate.c
      migration: Remove qemu-file.h from vmstate.h
      migration: Remove vmstate.h from migration.h
      migration: migration.h was not needed
      exec: Create include for target_page_size()
      migration: Make savevm.c target independent

 Makefile.target                          |   2 +-
 block/qed.c                              |   1 -
 configure                                |  11 +
 exec.c                                   |  10 +
 hmp.c                                    |  23 +-
 hw/i386/pc_q35.c                         |   1 -
 hw/virtio/vhost-user.c                   |   1 -
 hw/virtio/vhost-vsock.c                  |   1 -
 hw/virtio/virtio.c                       |   1 -
 include/exec/target_page.h               |  21 +
 include/hw/hw.h                          |   1 +
 include/migration/block.h                |  24 ++
 include/migration/colo.h                 |   1 -
 include/migration/migration.h            |  30 +-
 include/migration/qemu-file.h            |   4 -
 include/migration/vmstate.h              |   4 -
 include/qemu/typedefs.h                  |   1 -
 include/sysemu/sysemu.h                  |   4 +-
 migration/Makefile.objs                  |   6 +-
 migration/block.c                        |  19 +-
 migration/channel.c                      |  67 ++++
 migration/channel.h                      |  27 ++
 migration/colo-comm.c                    |   4 +-
 migration/colo.c                         |   9 +-
 migration/exec.c                         |   1 +
 migration/fd.c                           |   1 +
 migration/migration.c                    | 149 ++++---
 migration/postcopy-ram.c                 |  18 +-
 migration/qemu-file-channel.c            |   1 +
 migration/qemu-file-channel.h            |  32 ++
 migration/qjson.c                        |   2 +-
 {include/migration =3D> migration}/qjson.h |   0
 migration/ram.c                          |   8 +-
 migration/rdma.c                         |   1 +
 migration/savevm.c                       |  40 +-
 migration/socket.c                       |   1 +
 migration/tls.c                          |   1 +
 migration/vmstate-types.c                | 661 +++++++++++++++++++++++++=
++++++
 migration/vmstate.c                      | 656 +------------------------=
-----
 migration/xbzrle.c                       |   2 +-
 migration/xbzrle.h                       |  21 +
 monitor.c                                |   1 -
 qapi-schema.json                         |  28 +-
 tests/Makefile.include                   |   2 +-
 tests/test-vmstate.c                     |   2 +
 tests/test-xbzrle.c                      |   2 +-
 46 files changed, 1102 insertions(+), 801 deletions(-)
 create mode 100644 include/exec/target_page.h
 create mode 100644 migration/channel.c
 create mode 100644 migration/channel.h
 create mode 100644 migration/qemu-file-channel.h
 rename {include/migration =3D> migration}/qjson.h (100%)
 create mode 100644 migration/vmstate-types.c
 create mode 100644 migration/xbzrle.h
