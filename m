Received: from eggs.gnu.org ([2001:4830:134:3::10]:59402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq10i-0007Ln-DT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq10d-0000Ev-S4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:54:40 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:33192)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq10d-0000Df-L2
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 13:54:35 -0400
Received: by mail-pf0-x22e.google.com with SMTP id y68so641526pfd.0
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 10:54:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 10:54:30 -0700
Message-Id: <20170907175430.2720-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH] tcg/tci: Add TCG_TARGET_DEFAULT_MO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Missed being added as part of 71650df7b0ee.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci/tcg-target.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 06963288dc..8df628a319 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -192,4 +192,9 @@ static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
 {
 }
 
+/* We could notice __i386__ or __s390x__ and reduce the barriers depending
+   on the host.  But if you want performance, you use the normal backend.
+   We prefer consistency across hosts on this.  */
+#define TCG_TARGET_DEFAULT_MO  (0)
+
 #endif /* TCG_TARGET_H */
-- 
2.13.5
