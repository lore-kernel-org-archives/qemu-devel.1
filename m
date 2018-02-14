Received: from eggs.gnu.org ([2001:4830:134:3::10]:53984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA6-0008MM-Jq
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzA4-00078Z-88
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:58 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39660 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1elzA3-00078F-Uh
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:39:56 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 14 Feb 2018 15:39:28 +0000
Message-Id: <20180214153938.5410-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 00/10] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit bec9c64ef7be8063f1192608b83877bc5c9ea217:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-02-13 18:24:08 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180214a

for you to fetch changes up to 3e0c8050ebba3f55dc2d92b3790a3cfb80786d07:

  migration: pass MigrationState to migrate_init() (2018-02-14 10:37:09 +0000)

----------------------------------------------------------------
Migration pull 20180214

Note that the 'Add test for migration to bad destination' displays
a 'Connection refused' during running, but still gives the correct exit
code and OK (It's checking that the source doesn't fail when
it can't connect, so that's the right error).
If it's particularly disliked that patch can be skipped individually.

----------------------------------------------------------------
Dr. David Alan Gilbert (3):
      tests/migration: Add source to PC boot block
      migration: Fix early failure cleanup
      tests/migration: Add test for migration to bad destination

Greg Kurz (1):
      migration: improve documentation of postcopy-ram

Peter Xu (5):
      migration: better error handling with QEMUFile
      migration: reuse mis->userfault_quit_fd
      migration: provide postcopy_fault_thread_notify()
      migration: allow send_rq to fail
      migration: pass MigrationState to migrate_init()

Ross Lagerwall (1):
      migration/xen: Check return value of qemu_fclose

 docs/devel/migration.rst                 |   4 +-
 hmp-commands.hx                          |   3 +-
 migration/migration.c                    |  47 +++++++++----
 migration/migration.h                    |  10 +--
 migration/postcopy-ram.c                 |  60 ++++++++++------
 migration/postcopy-ram.h                 |   2 +
 migration/ram.c                          |  33 ++++++---
 migration/savevm.c                       |  48 +++++++++++--
 qapi/migration.json                      |  10 +--
 tests/migration-test.c                   | 117 ++++++++++++++-----------------
 tests/migration/rebuild-x86-bootblock.sh |  33 +++++++++
 tests/migration/x86-a-b-bootblock.h      |  51 ++++++++++++++
 tests/migration/x86-a-b-bootblock.s      |  92 ++++++++++++++++++++++++
 13 files changed, 388 insertions(+), 122 deletions(-)
 create mode 100755 tests/migration/rebuild-x86-bootblock.sh
 create mode 100644 tests/migration/x86-a-b-bootblock.h
 create mode 100644 tests/migration/x86-a-b-bootblock.s
