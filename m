Received: from eggs.gnu.org ([2001:4830:134:3::10]:55678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYAPP-0005uG-Hf
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYAPM-0003WV-Eb
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:22:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYAPM-0003WA-9r
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 09:22:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E8242805A530
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 13:22:51 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed, 27 Jun 2018 21:22:42 +0800
Message-Id: <20180627132246.5576-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/4] migation: unbreak postcopy recovery
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

v3:
- keep the recovery logic even for RDMA by dropping the 3rd patch and
  touch up the original 4th patch (current 3rd patch) to suite that [Dave]

v2:
- break the first patch into several
- fix a QEMUFile leak

Please review.  Thanks,

Peter Xu (4):
  migration: delay postcopy paused state
  migration: move income process out of multifd
  migration: unbreak postcopy recovery
  migration: unify incoming processing

 migration/ram.h       |  2 +-
 migration/exec.c      |  3 ---
 migration/fd.c        |  3 ---
 migration/migration.c | 44 ++++++++++++++++++++++++++++++++++++-------
 migration/ram.c       | 11 +++++------
 migration/savevm.c    |  6 +++---
 migration/socket.c    |  5 -----
 7 files changed, 46 insertions(+), 28 deletions(-)

-- 
2.17.1
