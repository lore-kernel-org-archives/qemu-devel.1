Received: from eggs.gnu.org ([2001:4830:134:3::10]:49644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3KO-000702-Hm
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3KN-0003GM-Fn
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3KN-0003Fj-7U
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CC424E33B
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:53:22 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:52:42 +0100
Message-Id: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/27] Migration pull
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
- rebase on top of lastest
- fix compilation on 32bit machines
- add Peter Xu cleanups

Please, apply.

The following changes since commit fd06527b80c88c8dde1b35fdc692685b68d2fd93:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2018-01-15 10:39:29 +0000)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180115

for you to fetch changes up to 816306826a45f4d15352e32d157172af3a35899f:

  migration: remove notify in fd_error (2018-01-15 12:48:13 +0100)

----------------------------------------------------------------
migration/next for 20180115

----------------------------------------------------------------
Alexey Perevalov (6):
      migration: introduce postcopy-blocktime capability
      migration: add postcopy blocktime ctx into MigrationIncomingState
      migration: calculate vCPU blocktime on dst side
      migration: postcopy_blocktime documentation
      migration: add blocktime calculation into migration-test
      migration: add postcopy total blocktime into query-migrate

Dr. David Alan Gilbert (2):
      docs: Convert migration.txt to rst
      migration: Guard ram_bytes_remaining against early call

Juan Quintela (4):
      migration: Use proper types in json
      migration: print features as on off
      migration: free addr in the same function that we created it
      migration: free result string

Laurent Vivier (1):
      migration: fix analyze-migration.py script with radix table

Peter Xu (13):
      migration: assert colo instead of check
      migration: qemu_savevm_state_cleanup() in cleanup
      migration: remove "enable_colo" var
      migration: split use of MigrationState.total_time
      migration: move vm_old_running into global state
      migration: introduce downtime_start
      migration: introduce migrate_calculate_complete
      migration: use switch at the end of migration
      migration: cleanup stats update into function
      migration: major cleanup for migrate iterations
      migration: put the finish part into a new function
      migration: remove some block_cleanup_parameters()
      migration: remove notify in fd_error

Vladimir Sementsov-Ogievskiy (1):
      migration: finalize current_migration object

 docs/devel/{migration.txt => migration.rst} | 484 +++++++++++++++-------------
 hmp.c                                       |  37 ++-
 include/migration/misc.h                    |   1 +
 migration/migration.c                       | 423 ++++++++++++++----------
 migration/migration.h                       |  35 ++
 migration/postcopy-ram.c                    | 258 ++++++++++++++-
 migration/ram.c                             |   3 +-
 migration/socket.c                          |   4 +-
 migration/trace-events                      |   6 +-
 qapi/migration.json                         |  37 ++-
 scripts/analyze-migration.py                |   4 +
 tests/migration-test.c                      |  19 +-
 vl.c                                        |   1 +
 13 files changed, 895 insertions(+), 417 deletions(-)
 rename docs/devel/{migration.txt => migration.rst} (58%)
