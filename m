Received: from eggs.gnu.org ([2001:4830:134:3::10]:33882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAZy-0005ZS-85
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAZv-0001DS-0X
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvAZu-0001BY-OE
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 583BE7CDE2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 23:08:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 01:07:54 +0200
Message-Id: <20170921230812.7095-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/18] Migration PULL request
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

To make merges easier, this includes:
- Peter Xu reviewed patches from Postocpy recovery (3)
- Alexey reviewed pages from block postcopy (4)
- Vladimir reviewed patches (3)
- reviewed patches from Multifd (me)

Please apply, Juan.


The following changes since commit ff5667ed53c544c4dc88dcd7cb23cc509c9a55e0:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-sparc-signed' into staging (2017-09-21 10:56:09 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170921

for you to fetch changes up to 0fba48d49815d84d7ab30f6ee7a48384b823722e:

  migration: split ufd_version_check onto receive/request features part (2017-09-21 14:01:44 +0200)

----------------------------------------------------------------
migration/next for 20170921

----------------------------------------------------------------
Alexey Perevalov (3):
      migration: pass MigrationIncomingState* into migration check functions
      migration: fix hardcoded function name in error report
      migration: split ufd_version_check onto receive/request features part

Juan Quintela (9):
      migration: Create migration_ioc_process_incoming()
      migration: Teach it about G_SOURCE_REMOVE
      migration: Add comments to channel functions
      migration: Create migration_has_all_channels
      migration: Add multifd capability
      migration: Create x-multifd-channels parameter
      migration: Create x-multifd-page-count parameter
      migration: Create multifd migration threads
      migration: Split migration_fd_process_incoming

Peter Xu (3):
      bitmap: remove BITOP_WORD()
      bitmap: introduce bitmap_count_one()
      bitmap: provide to_le/from_le helpers

Vladimir Sementsov-Ogievskiy (3):
      migration: add has_postcopy savevm handler
      migration: fix ram_save_pending
      migration: split common postcopy out of ram postcopy

 hmp.c                        |  14 +++
 include/glib-compat.h        |   2 +
 include/migration/register.h |   1 +
 include/qemu/bitmap.h        |  17 ++++
 migration/channel.c          |  18 +++-
 migration/exec.c             |   2 +-
 migration/fd.c               |   2 +-
 migration/migration.c        | 176 +++++++++++++++++++++++++++++++----
 migration/migration.h        |   9 ++
 migration/postcopy-ram.c     | 100 ++++++++++++++++++--
 migration/postcopy-ram.h     |   2 +-
 migration/ram.c              | 216 ++++++++++++++++++++++++++++++++++++++++++-
 migration/ram.h              |   5 +
 migration/savevm.c           |  56 ++++++++---
 migration/socket.c           |  10 +-
 qapi/migration.json          |  39 +++++++-
 util/bitmap.c                |  47 ++++++++++
 util/bitops.c                |   6 +-
 18 files changed, 664 insertions(+), 58 deletions(-)
