Received: from eggs.gnu.org ([2001:4830:134:3::10]:50628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOzG-0006XU-PL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csOzG-0002vm-1a
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csOzF-0002vW-SP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 03:22:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBA4E8E673
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 07:22:44 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 27 Mar 2017 15:21:26 +0800
Message-Id: <1490599288-11751-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1490599288-11751-1-git-send-email-peterx@redhat.com>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] hmp: info migrate_capability format tunes
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

Dump the info in a single line is hard to read. Do it one per line.
Also, the first "capabilities:" didn't help much. Let's remove it.

CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hmp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hmp.c b/hmp.c
index edb8970..95eef8c 100644
--- a/hmp.c
+++ b/hmp.c
@@ -265,13 +265,11 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
     caps = qmp_query_migrate_capabilities(NULL);
 
     if (caps) {
-        monitor_printf(mon, "capabilities: ");
         for (cap = caps; cap; cap = cap->next) {
-            monitor_printf(mon, "%s: %s ",
+            monitor_printf(mon, "%s: %s\n",
                            MigrationCapability_lookup[cap->value->capability],
                            cap->value->state ? "on" : "off");
         }
-        monitor_printf(mon, "\n");
     }
 
     qapi_free_MigrationCapabilityStatusList(caps);
-- 
2.7.4
