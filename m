Received: from eggs.gnu.org ([2001:4830:134:3::10]:57989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cuEFS-0002wN-RQ
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 04:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cuEFP-00044K-Oy
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 04:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cuEFP-00043H-Io
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 04:18:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10A3E61B91
	for <qemu-devel@nongnu.org>; Sat,  1 Apr 2017 08:18:58 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Sat,  1 Apr 2017 16:18:41 +0800
Message-Id: <1491034725-23968-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/4] several migrations related patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "\\  Dr . David Alan Gilbert \\ " <dgilbert@redhat.com>, peterx@redhat.com

v2:
- fix comment for threshold_size [Dave]
- drop patch 5
- add Dave's r-b for each patch

Mostly small touch-ups, the last one looks like a cpu throttle bug on
time slice calculation (or I missed anything?). Anyway, please review,
thanks.

Peter Xu (4):
  migration: set current_active_state once
  migration: rename max_size to threshold_size
  hmp: info migrate_capability format tunes
  hmp: info migrate_parameters format tunes

 hmp.c                       | 26 +++++++++++---------------
 include/migration/vmstate.h |  3 ++-
 migration/migration.c       | 22 +++++++++++++---------
 migration/savevm.c          |  4 ++--
 4 files changed, 28 insertions(+), 27 deletions(-)

-- 
2.7.4
