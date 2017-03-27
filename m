Received: from eggs.gnu.org ([2001:4830:134:3::10]:50309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOyB-0005pA-Dv
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOy8-0002UT-BT
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:21:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csOy8-0002UL-6F
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:21:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C35EB7E9F0
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:21:34 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 27 Mar 2017 15:21:23 +0800
Message-Id: <1490599288-11751-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 0/5] several migrations related patches
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

Mostly small touch-ups, the last one looks like a cpu throttle bug on
time slice calculation (or I missed anything?). Anyway, please review,
thanks.

Peter Xu (5):
  migration: set current_active_state once
  migration: rename max_size to threshold_size
  hmp: info migrate_capability format tunes
  hmp: info migrate_parameters format tunes
  cpu: throttle: fix throttle time slice

 cpus.c                      |  6 ++----
 hmp.c                       | 26 +++++++++++---------------
 include/migration/vmstate.h |  3 ++-
 migration/migration.c       | 18 +++++++++---------
 migration/savevm.c          |  4 ++--
 5 files changed, 26 insertions(+), 31 deletions(-)

-- 
2.7.4
