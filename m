Received: from eggs.gnu.org ([2001:4830:134:3::10]:40730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuaw-000358-3d
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcuar-0003GA-JE
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcuar-0003Ey-7Y
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:30:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7179D808255B
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 15:30:20 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 10 Jul 2018 16:30:01 +0100
Message-Id: <20180710153016.131258-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/15] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peterx@redhat.com, quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 2b83714d4ea659899069a4b94aa2dfadc847a0=
13:

  target/arm: Use correct mmu_idx for exception-return unstacking (2018-0=
7-10 10:54:40 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180710a

for you to fetch changes up to 858b6d62249a9a9510fae6c808a3d2de80e689b5:

  migration: reorder MIG_CMD_POSTCOPY_RESUME (2018-07-10 15:23:23 +0100)

----------------------------------------------------------------
Migration pull 2018-07-10 (for 3.0)

Migration fixes and migration test fixes, mostly
around postcopy and postcopy recovery

----------------------------------------------------------------
Peter Xu (15):
      migration: delay postcopy paused state
      migration: move income process out of multifd
      migration: unbreak postcopy recovery
      migration: unify incoming processing
      migration: simplify check to use qemu file buffer
      migration: loosen recovery check when load vm
      migration: fix incorrect bitmap size calculation
      migration: show pause/recover state on dst host
      tests: introduce migrate_postcopy_* helpers
      tests: allow migrate() to take extra flags
      tests: introduce migrate_query*() helpers
      tests: introduce wait_for_migration_status()
      tests: add postcopy recovery test
      tests: hide stderr for postcopy recovery test
      migration: reorder MIG_CMD_POSTCOPY_RESUME

 migration/exec.c       |   3 -
 migration/fd.c         |   3 -
 migration/migration.c  |  46 +++++++++--
 migration/ram.c        |  32 ++++----
 migration/ram.h        |   2 +-
 migration/savevm.c     |  24 +++---
 migration/socket.c     |   5 --
 tests/migration-test.c | 211 +++++++++++++++++++++++++++++++++++++++----=
------
 8 files changed, 238 insertions(+), 88 deletions(-)
