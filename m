Received: from eggs.gnu.org ([2001:4830:134:3::10]:33872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyQY-0006hT-Nx
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dmyQX-00036p-6O
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:32:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dmyQX-00036R-0X
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 04:32:45 -0400
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Aug 2017 16:31:58 +0800
Message-Id: <1504081950-2528-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1504081950-2528-1-git-send-email-peterx@redhat.com>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 01/33] bitmap: remove BITOP_WORD()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

We have BIT_WORD(). It's the same.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 util/bitops.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/bitops.c b/util/bitops.c
index b0c35dd..f236401 100644
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
2.7.4
