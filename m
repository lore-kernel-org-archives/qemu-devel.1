Received: from eggs.gnu.org ([2001:4830:134:3::10]:41258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8Ft-0005TZ-GO
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eg8Fq-00018s-BF
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eg8Fq-00018G-5E
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 07:09:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 88D3D4A6F3
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 12:09:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 29 Jan 2018 13:09:19 +0100
Message-Id: <20180129120932.12874-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/13] Migration PULL request
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

- migrate_fd_connect cleanup (dave)
- use MAX_VM_PACKAGED_SIZE
  have to change (1<<32) for UINT32_MAX to get no warnings on win32
- Use right s->threashord_size(wei)
- patches reviewed from info/migrate, migration tests and multifd (me)

Later, Juan.

The following changes since commit 6233b4a8c2a32ef6955a921246fa08705bbb3676:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-26' into staging (2018-01-26 17:29:14 +0000)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180129

for you to fetch changes up to 4b6bb0a77761b8a906a540e927c7a9dde99bc10f:

  tests: Adjust sleeps for migration test (2018-01-29 12:10:22 +0100)

----------------------------------------------------------------
migration/next for 20180129

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      migration/savevm.c: set MAX_VM_CMD_PACKAGED_SIZE to 1ul << 32

Dr. David Alan Gilbert (2):
      migration: Allow migrate_fd_connect to take an Error *
      migration: Route errors down through migration_channel_connect

Juan Quintela (9):
      migration: Drop current address parameter from save_zero_page()
      tests: Remove deprecated migration tests commands
      tests: Consolidate accelerators declaration
      tests: Use consistent names for migration
      tests: Add deprecated commands migration test
      tests: Add migration precopy test
      tests: Add migration xbzrle test
      tests: Create migrate-start-postcopy command
      tests: Adjust sleeps for migration test

Wei Wang (1):
      migration: use s->threshold_size inside migration_update_counters

 migration/channel.c    |  34 +++----
 migration/channel.h    |   3 +-
 migration/exec.c       |   2 +-
 migration/fd.c         |   2 +-
 migration/migration.c  |  12 ++-
 migration/migration.h  |   2 +-
 migration/ram.c        |  11 +--
 migration/rdma.c       |   2 +-
 migration/savevm.c     |   2 +-
 migration/socket.c     |   4 +-
 migration/tls.c        |   3 +-
 migration/trace-events |   2 +-
 tests/migration-test.c | 252 ++++++++++++++++++++++++++++++++++++++-----------
 13 files changed, 236 insertions(+), 95 deletions(-)
