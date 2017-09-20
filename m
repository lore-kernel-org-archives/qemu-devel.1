Received: from eggs.gnu.org ([2001:4830:134:3::10]:43075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dueoY-0000Pu-5d
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dueoX-0007wu-1j
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dueoW-0007wa-S7
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A9FF13AB2
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:46:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 20 Sep 2017 12:46:23 +0200
Message-Id: <20170920104639.2335-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/16] Migration PULL request
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

To make merges easier, this includes:
- Peter Xu reviewed patches from Postocpy recovery (3)
- Alexey reviewed pages from block postcopy (4)
- reviewed patches from Multifd (me)

Please apply, Juan.

The following changes since commit c51700273ad9802a21c19f8d2b4bcb67c38e74ac:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20170919-v2' into staging (2017-09-19 18:08:48 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170920

for you to fetch changes up to bfaf91242bd9dc168ccd8e7919c604757b410d3d:

  migration: introduce postcopy-blocktime capability (2017-09-20 11:29:27 +0200)

----------------------------------------------------------------
migration/next for 20170920

----------------------------------------------------------------
Alexey Perevalov (4):
      migration: pass MigrationIncomingState* into migration check functions
      migration: fix hardcoded function name in error report
      migration: split ufd_version_check onto receive/request features part
      migration: introduce postcopy-blocktime capability

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

 hmp.c                    |  14 ++++
 include/glib-compat.h    |   2 +
 include/qemu/bitmap.h    |  17 ++++
 migration/channel.c      |  18 ++++-
 migration/exec.c         |   2 +-
 migration/fd.c           |   2 +-
 migration/migration.c    | 146 ++++++++++++++++++++++++++++++++--
 migration/migration.h    |   8 ++
 migration/postcopy-ram.c | 100 ++++++++++++++++++++---
 migration/postcopy-ram.h |   2 +-
 migration/ram.c          | 202 +++++++++++++++++++++++++++++++++++++++++++++++
 migration/ram.h          |   5 ++
 migration/savevm.c       |   2 +-
 migration/socket.c       |  10 ++-
 qapi/migration.json      |  42 +++++++++-
 util/bitmap.c            |  47 +++++++++++
 util/bitops.c            |   6 +-
 17 files changed, 593 insertions(+), 32 deletions(-)
