Received: from eggs.gnu.org ([2001:4830:134:3::10]:35546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSFuW-0002ux-P6
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSFuT-0001tb-Mu
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:02:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSFuT-0001tJ-Im
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:02:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94EBA738E0
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:02:32 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 11 Jun 2018 14:02:26 +0800
Message-Id: <20180611060228.2998-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] migation: unbreak postcopy recovery
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

Postcopy recovery is broken on master.  Patch 1 fixes it up.

Patch 2 fixes a possible race for postcopy recovery.

Tests: postcopy recovery, make check, iotests (currently qcow2 iotests
051 & 102 break on master; this series didn't bring more).

Please review.  Thanks,

Peter Xu (2):
  migration: unbreak postcopy recovery
  migration: delay postcopy paused state

 migration/ram.h       |  2 +-
 migration/exec.c      |  3 ---
 migration/fd.c        |  3 ---
 migration/migration.c | 34 ++++++++++++++++++++++++++--------
 migration/ram.c       | 11 +++++------
 migration/rdma.c      |  3 ++-
 migration/savevm.c    |  6 +++---
 migration/socket.c    |  5 -----
 8 files changed, 37 insertions(+), 30 deletions(-)

-- 
2.17.1
