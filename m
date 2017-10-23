Received: from eggs.gnu.org ([2001:4830:134:3::10]:35623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fGt-0005Rz-QJ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6fGp-00085s-PN
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6fGp-00084l-JI
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 12:08:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D4F8356D2
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 16:08:06 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 23 Oct 2017 18:07:39 +0200
Message-Id: <20171023160800.20540-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/21] Migration  pull request
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

This includes:

- Postocpy bitmap on destination (alexey)
- pre-switchover patches (dave)
- ram_state cleanup (peter)
- reviewed part of set_migrate_state (me)
- grammar fix from eric
- patch reviewed from multifd

Please, Apply.

The following changes since commit e822e81e350825dd94f41ee2538ff1432b812eb9:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-10-20 15:04:00 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20171023

for you to fetch changes up to 87db1a7d89677e3dbc8b3763e417b9376009bdbb:

  migration: Improve migration thread error handling (2017-10-23 18:03:43 +0200)

----------------------------------------------------------------
migration/next for 20171023

----------------------------------------------------------------
Alexey Perevalov (3):
      migration: postcopy_place_page factoring out
      migration: introduce qemu_ufd_copy_ioctl helper
      migration: add bitmap for received page

Dr. David Alan Gilbert (7):
      migration: Add 'pause-before-switchover' capability
      migration: Add 'pre-switchover' and 'device' statuses
      migration: Wait for semaphore before completing migration
      migration: migrate-continue
      migrate: HMP migate_continue
      migration: allow cancel to unpause
      migration: pause-before-switchover for postcopy

Juan Quintela (7):
      migration: Fix migrate_test_apply for multifd parameters
      migratiom: Remove max_item_age parameter
      migration: Make cache size elements use the right types
      migration: Move xbzrle cache resize error handling to xbzrle_cache_resize
      migration: Make cache_init() take an error parameter
      qapi: Fix grammar in x-multifd-page-count descriptions
      migration: Improve migration thread error handling

Peter Xu (4):
      migration: provide ram_state_init()
      migration: provide ram_state_cleanup
      migration: clean up xbzrle cache init/destroy
      migration: new ram_init_bitmaps()

 hmp-commands.hx          |  12 +++
 hmp.c                    |  13 +++
 hmp.h                    |   1 +
 include/exec/ram_addr.h  |  10 ++
 migration/migration.c    | 131 +++++++++++++++++++----
 migration/migration.h    |  11 +-
 migration/page_cache.c   |  25 +++--
 migration/page_cache.h   |   7 +-
 migration/postcopy-ram.c |  54 ++++++----
 migration/postcopy-ram.h |   4 +-
 migration/ram.c          | 267 +++++++++++++++++++++++++++++++++--------------
 migration/ram.h          |   7 +-
 migration/tls.c          |   1 -
 qapi/migration.json      |  36 ++++++-
 14 files changed, 436 insertions(+), 143 deletions(-)
