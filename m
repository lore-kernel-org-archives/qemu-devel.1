Received: from eggs.gnu.org ([2001:4830:134:3::10]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xkE-0000tM-9A
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2xkD-0004vz-Fy
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:30:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2xkD-0004vj-9n
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:30:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 469F47CFAF
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 10:30:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 25 Apr 2017 12:30:46 +0200
Message-Id: <20170425103049.4073-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Remove old MigrationParams
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

Upon a time there were MigrationParms (only used for block migration)
and then MigrationParams used for everything else.  This series:

- create migration capabilities for block parameters
- make the migrate command line parameters to use capabilities
- remove MigrationParams completely

Please, review.


Juan Quintela (3):
  migration: Create block capabilities for shared and enable
  migration: Remove use of old MigrationParams
  migration: Remove old MigrationParams

 include/migration/migration.h | 14 +++++-------
 include/migration/vmstate.h   |  1 -
 include/qemu/typedefs.h       |  1 -
 include/sysemu/sysemu.h       |  3 +--
 migration/block.c             | 17 ++------------
 migration/colo.c              |  5 +----
 migration/migration.c         | 52 ++++++++++++++++++++++++++++++++++++-------
 migration/savevm.c            | 18 +++------------
 qapi-schema.json              |  7 +++++-
 9 files changed, 62 insertions(+), 56 deletions(-)

-- 
2.9.3
