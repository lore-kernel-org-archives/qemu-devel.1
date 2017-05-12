Received: from eggs.gnu.org ([2001:4830:134:3::10]:44932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9Cu8-0005L1-3j
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d9Cu7-0008BL-Cm
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:54:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d9Cu7-0008AH-63
	for qemu-devel@nongnu.org; Fri, 12 May 2017 11:54:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B51161D04
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 15:54:54 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 12 May 2017 17:54:47 +0200
Message-Id: <20170512155449.9003-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Remove old MigrationParams
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

changes from v2
- Patch 1 included in pull request
- disable block_shared when we disable block_enable
- enable block_enabled when we enable block_shared

Please, review.

[v2]

- make migrate_block_set_* take a boolean
- disable block migration in colo to maintain semantics.

[v1]
Upon a time there were MigrationParms (only used for block migration)
and then MigrationParams used for everything else.  This series:

- create migration capabilities for block parameters
- make the migrate command line parameters to use capabilities
- remove MigrationParams completely


Juan Quintela (2):
  migration: Remove use of old MigrationParams
  migration: Remove old MigrationParams

 include/migration/migration.h | 11 ++---------
 include/migration/vmstate.h   |  1 -
 include/qemu/typedefs.h       |  1 -
 include/sysemu/sysemu.h       |  3 +--
 migration/block.c             | 17 ++---------------
 migration/colo.c              |  7 ++++---
 migration/migration.c         | 22 ++++++++++++++--------
 migration/savevm.c            | 18 +++---------------
 8 files changed, 26 insertions(+), 54 deletions(-)

-- 
2.9.3
