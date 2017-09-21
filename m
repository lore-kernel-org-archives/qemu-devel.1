Received: from eggs.gnu.org ([2001:4830:134:3::10]:34038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAaG-0005pe-LY
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dvAaF-0001dv-DZ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dvAaF-0001cx-6W
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FBD581E01
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 23:08:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 22 Sep 2017 01:08:04 +0200
Message-Id: <20170921230812.7095-11-quintela@redhat.com>
In-Reply-To: <20170921230812.7095-1-quintela@redhat.com>
References: <20170921230812.7095-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 10/18] bitmap: remove BITOP_WORD()
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

From: Peter Xu <peterx@redhat.com>

We have BIT_WORD(). It's the same.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 util/bitops.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/bitops.c b/util/bitops.c
index b0c35dd5f1..f2364015c4 100644
--- a/util/bitops.c
+++ b/util/bitops.c
@@ -14,15 +14,13 @@
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
 
-#define BITOP_WORD(nr)		((nr) / BITS_PER_LONG)
-
 /*
  * Find the next set bit in a memory region.
  */
 unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 			    unsigned long offset)
 {
-    const unsigned long *p = addr + BITOP_WORD(offset);
+    const unsigned long *p = addr + BIT_WORD(offset);
     unsigned long result = offset & ~(BITS_PER_LONG-1);
     unsigned long tmp;
 
@@ -87,7 +85,7 @@ found_middle:
 unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 				 unsigned long offset)
 {
-    const unsigned long *p = addr + BITOP_WORD(offset);
+    const unsigned long *p = addr + BIT_WORD(offset);
     unsigned long result = offset & ~(BITS_PER_LONG-1);
     unsigned long tmp;
 
-- 
2.13.5
