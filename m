Received: from eggs.gnu.org ([2001:4830:134:3::10]:53477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0YeD-0005oB-0O
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:18:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1d0Ye7-0004sm-W5
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:18:44 -0400
Received: from mail-yb0-x243.google.com ([2607:f8b0:4002:c09::243]:35489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1d0Ye7-0004sV-Qy
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 15:18:39 -0400
Received: by mail-yb0-x243.google.com with SMTP id 19so97715ybl.2
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 12:18:39 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 18 Apr 2017 15:18:16 -0400
Message-Id: <20170418191817.10430-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH] timer.h: Provide better monotonic time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Tested and confirmed that the stretch i386 debian qcow2 image on a
raspberry pi 2 works.

Fixes: LP#: 893208 <https://bugs.launchpad.net/qemu/+bug/893208/>
Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 include/qemu/timer.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 8a1eb74839..1b518bca30 100644
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
2.11.0
