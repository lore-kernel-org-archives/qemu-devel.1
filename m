Received: from eggs.gnu.org ([2001:4830:134:3::10]:47424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY82k-0005ye-90
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY82h-0002kB-7s
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fY82h-0002jn-36
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 06:51:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 906F5401EF04
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 10:51:18 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 27 Jun 2018 18:51:07 +0800
Message-Id: <20180627105112.31401-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] migation: unbreak postcopy recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

v2:
- break the first patch into several
- fix a QEMUFile leak

Please review.  Thanks,

Peter Xu (5):
  migration: delay postcopy paused state
  migration: move income process out of multifd
  migration: do explicit incoming setup for rdma
  migration: unbreak postcopy recovery
  migration: unify incoming processing

 migration/ram.h       |  2 +-
 migration/exec.c      |  3 ---
 migration/fd.c        |  3 ---
 migration/migration.c | 34 +++++++++++++++++++++++++++-------
 migration/ram.c       | 11 +++++------
 migration/rdma.c      |  3 ++-
 migration/savevm.c    |  6 +++---
 migration/socket.c    |  5 -----
 8 files changed, 38 insertions(+), 29 deletions(-)

-- 
2.17.1
