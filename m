Received: from eggs.gnu.org ([2001:4830:134:3::10]:34535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVU-0006mL-36
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVQ-0006qn-Vb
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWfVQ-0006p7-PO
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9303C04AC57
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:38:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Jan 2018 10:38:20 +0100
Message-Id: <20180103093834.20879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 00/14] Migration pull request
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

This are the changes for migration that are already reviewed.

Please, apply.

Later, Juan.


The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:

  Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)

are available in the Git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20180103

for you to fetch changes up to 8a18afdcd8d2d6ab31f9de89d2f20fdadb89beb8:

  migration: finalize current_migration object (2018-01-03 09:28:56 +0100)

----------------------------------------------------------------
migration/next for 20180103

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

Vladimir Sementsov-Ogievskiy (1):
      migration: finalize current_migration object

 docs/devel/{migration.txt => migration.rst} | 484 +++++++++++++++-------------
 hmp.c                                       |  37 ++-
 include/migration/misc.h                    |   1 +
 migration/migration.c                       | 118 ++++---
 migration/migration.h                       |  13 +
 migration/postcopy-ram.c                    | 258 ++++++++++++++-
 migration/ram.c                             |   3 +-
 migration/socket.c                          |   4 +-
 migration/trace-events                      |   6 +-
 qapi/migration.json                         |  37 ++-
 scripts/analyze-migration.py                |   4 +
 tests/migration-test.c                      |  19 +-
 vl.c                                        |   1 +
 13 files changed, 696 insertions(+), 289 deletions(-)
 rename docs/devel/{migration.txt => migration.rst} (58%)
