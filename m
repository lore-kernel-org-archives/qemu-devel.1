Received: from eggs.gnu.org ([2001:4830:134:3::10]:57862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiVQ-0002Ki-7f
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiVN-0003r6-5m
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:53:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiVM-0003pg-Vf
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:52:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E306219D23B
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:52:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:52:50 +0200
Message-Id: <20170613095251.11493-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2] Misc migration cleanups
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

The 1st 10 pages have already been reviewed, only missing one is this one
that removes includes that are not needed after so many movements of code.

Please, review.

Thanks, Juan.


Juan Quintela (1):
  migration: Remove unneeded includes

 include/migration/colo.h  | 3 ---
 include/migration/misc.h  | 2 ++
 migration/block.c         | 6 ------
 migration/colo-failover.c | 2 ++
 migration/colo.c          | 2 --
 migration/exec.c          | 2 --
 migration/fd.c            | 2 --
 migration/global_state.c  | 1 -
 migration/migration.c     | 6 ------
 migration/migration.h     | 2 --
 migration/postcopy-ram.c  | 4 +---
 migration/qemu-file.c     | 2 --
 migration/ram.c           | 4 ----
 migration/savevm.c        | 6 ------
 14 files changed, 5 insertions(+), 39 deletions(-)

-- 
2.9.4
