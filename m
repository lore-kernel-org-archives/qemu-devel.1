Received: from eggs.gnu.org ([2001:4830:134:3::10]:60546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e37XN-0000Za-Hk
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 17:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e37XG-0003d9-DQ
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 17:30:31 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52653)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e37XG-0003bY-53
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 17:30:26 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 13 Oct 2017 17:30:20 -0400
Message-Id: <1507930220-17461-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] futex: add missing header guards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

The header file was introduced by fbcc3e5 ("qemu-thread: optimize QemuLockCnt
with futexes on Linux", 2017-01-16) without header guards. Add them.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/futex.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/qemu/futex.h b/include/qemu/futex.h
index bb7dc9e..91ae889 100644
--- a/include/qemu/futex.h
+++ b/include/qemu/futex.h
@@ -11,6 +11,9 @@
  *
  */
 
+#ifndef QEMU_FUTEX_H
+#define QEMU_FUTEX_H
+
 #include <sys/syscall.h>
 #include <linux/futex.h>
 
@@ -34,3 +37,5 @@ static inline void qemu_futex_wait(void *f, unsigned val)
         }
     }
 }
+
+#endif /* QEMU_FUTEX_H */
-- 
2.7.4
