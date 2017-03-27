Received: from eggs.gnu.org ([2001:4830:134:3::10]:50324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOyE-0005q5-Gw
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOyD-0002V6-Oy
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:21:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csOyD-0002V0-JR
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:21:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A180BC0799A3
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:21:40 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 27 Mar 2017 15:21:24 +0800
Message-Id: <1490599288-11751-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1490599288-11751-1-git-send-email-peterx@redhat.com>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] migration: set current_active_state once
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

We set it right above this one. No need to set it twice.

CC: Juan Quintela <quintela@redhat.com>
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 54060f7..f9f4d98 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1938,7 +1938,6 @@ static void *migration_thread(void *opaque)
     qemu_savevm_state_begin(s->to_dst_file, &s->params);
 
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
-    current_active_state = MIGRATION_STATUS_ACTIVE;
     migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                       MIGRATION_STATUS_ACTIVE);
 
-- 
2.7.4
