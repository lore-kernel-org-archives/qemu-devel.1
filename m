Received: from eggs.gnu.org ([2001:4830:134:3::10]:33258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTg-0005Mh-PE
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTa-0006hR-SJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTa-0006fN-Cq
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTS-000144-L5
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:06:59 +0100
Message-Id: <1497362826-21125-11-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 10/17] timer.h: Provide better monotonic time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pranith Kumar <bobby.prani@gmail.com>

Tested and confirmed that the stretch i386 debian qcow2 image on a
raspberry pi 2 works.

Fixes: LP#: 893208 <https://bugs.launchpad.net/qemu/+bug/893208/>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-id: 20170418191817.10430-1-bobby.prani@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/qemu/timer.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 8a1eb74..1b518bc 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -1020,10 +1020,9 @@ static inline int64_t cpu_get_host_ticks(void)
 /* The host CPU doesn't have an easily accessible cycle counter.
    Just return a monotonically increasing value.  This will be
    totally wrong, but hopefully better than nothing.  */
-static inline int64_t cpu_get_host_ticks (void)
+static inline int64_t cpu_get_host_ticks(void)
 {
-    static int64_t ticks = 0;
-    return ticks++;
+    return get_clock();
 }
 #endif
 
-- 
2.7.4
