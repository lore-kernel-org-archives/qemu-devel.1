Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyJMi-0006Qn-NL
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eyJMf-0001Eh-V0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:39:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eyJMf-0001Dk-RC
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:39:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C91440267D7
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 15:39:48 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 20 Mar 2018 15:39:41 +0000
Message-Id: <20180320153941.50954-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH] postcopy: Stub postcopy_request_shared_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com
Cc: quintela@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On systems without userfault/eventfd/etc we need a stub
for it to link.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/postcopy-ram.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 146bc09c17..856b13453b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -954,6 +954,12 @@ void *postcopy_get_tmp_page(MigrationIncomingState *mis)
     return NULL;
 }
 
+int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
+                                 uint64_t client_addr, uint64_t rb_offset)
+{
+    assert(0);
+    return -1;
+}
 #endif
 
 /* ------------------------------------------------------------------------- */
-- 
2.14.3
