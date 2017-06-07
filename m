Received: from eggs.gnu.org ([2001:4830:134:3::10]:33603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkU-0005SP-LK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dIXkR-0005JT-Gc
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dIXkR-0005JL-AT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:59:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EF4E4E4D0
	for <qemu-devel@nongnu.org>; Wed,  7 Jun 2017 09:59:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  7 Jun 2017 11:59:19 +0200
Message-Id: <20170607095926.1834-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] Migration PULL requset
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

This is the migration pull requset, it contains:
- fix for segfault of io tests (QingFeng)
- half of make consistent output
- Make RAMState dynamic.

Please, apply.

Thanks, Juan.

The following changes since commit 65dfad62a176f5265f801683be64149c5ad55f7d:

  Merge remote-tracking branch 'remotes/xtensa/tags/20170606-xtensa' into staging (2017-06-06 17:00:12 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170607

for you to fetch changes up to eefff991d059d299b917627d2a95bce34d2f97f3:

  qemu/migration: fix the double free problem on from_src_file (2017-06-07 10:20:56 +0200)

----------------------------------------------------------------
migration/next for 20170607

----------------------------------------------------------------
Juan Quintela (6):
      ram: Unfold get_xbzrle_cache_stats() into populate_ram_info()
      ram: We only print throttling information sometimes
      ram: Call migration_page_queue_free() at ram_migration_cleanup()
      ram: Move ZERO_TARGET_PAGE inside XBZRLE
      ram: Use MigrationStats for statistics
      ram: Make RAMState dynamic

QingFeng Hao (1):
      qemu/migration: fix the double free problem on from_src_file

 migration/migration.c |  59 ++++++-------
 migration/ram.c       | 233 +++++++++++++++++++-------------------------------
 migration/ram.h       |  15 +---
 migration/savevm.c    |   1 -
 4 files changed, 114 insertions(+), 194 deletions(-)
