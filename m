Received: from eggs.gnu.org ([2001:4830:134:3::10]:40350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKo-0006hs-Rn
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjJl-0008PL-9k
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:11 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53323)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjJl-0008Oy-1u
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:09 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:14 -0400
Message-Id: <20181025172057.20414-6-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 05/48] include: move exec/tb-hash-xx.h to
 qemu/xxhash.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/tb-hash.h                       | 2 +-
 include/{exec/tb-hash-xx.h => qemu/xxhash.h} | 6 +++---
 tests/qht-bench.c                            | 2 +-
 util/qsp.c                                   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename include/{exec/tb-hash-xx.h => qemu/xxhash.h} (97%)

diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 731ba4c272..4f3a37d927 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -20,7 +20,7 @@
 #ifndef EXEC_TB_HASH_H
 #define EXEC_TB_HASH_H
 
-#include "exec/tb-hash-xx.h"
+#include "qemu/xxhash.h"
 
 #ifdef CONFIG_SOFTMMU
 
diff --git a/include/exec/tb-hash-xx.h b/include/qemu/xxhash.h
similarity index 97%
rename from include/exec/tb-hash-xx.h
rename to include/qemu/xxhash.h
index 98ce4b628a..fe35dde328 100644
--- a/include/exec/tb-hash-xx.h
+++ b/include/qemu/xxhash.h
@@ -31,8 +31,8 @@
  * - xxHash source repository : https://github.com/Cyan4973/xxHash
  */
 
-#ifndef EXEC_TB_HASH_XX_H
-#define EXEC_TB_HASH_XX_H
+#ifndef QEMU_XXHASH_H
+#define QEMU_XXHASH_H
 
 #include "qemu/bitops.h"
 
@@ -119,4 +119,4 @@ static inline uint32_t qemu_xxhash6(uint64_t ab, uint64_t cd, uint32_t e,
     return qemu_xxhash7(ab, cd, e, f, 0);
 }
 
-#endif /* EXEC_TB_HASH_XX_H */
+#endif /* QEMU_XXHASH_H */
diff --git a/tests/qht-bench.c b/tests/qht-bench.c
index 2ea132fe57..4d885ca303 100644
--- a/tests/qht-bench.c
+++ b/tests/qht-bench.c
@@ -9,7 +9,7 @@
 #include "qemu/atomic.h"
 #include "qemu/qht.h"
 #include "qemu/rcu.h"
-#include "exec/tb-hash-xx.h"
+#include "qemu/xxhash.h"
 
 struct thread_stats {
     size_t rd;
diff --git a/util/qsp.c b/util/qsp.c
index dc29c41fde..410f1ba004 100644
--- a/util/qsp.c
+++ b/util/qsp.c
@@ -61,7 +61,7 @@
 #include "qemu/timer.h"
 #include "qemu/qht.h"
 #include "qemu/rcu.h"
-#include "exec/tb-hash-xx.h"
+#include "qemu/xxhash.h"
 
 enum QSPType {
     QSP_MUTEX,
-- 
2.17.1
