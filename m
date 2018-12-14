Received: from eggs.gnu.org ([2001:4830:134:3::10]:59026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1D-0006IK-SX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXe1C-0007k9-Jw
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:03 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:38262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXe1C-0007hV-Bm
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 22:20:02 -0500
Received: by mail-oi1-x232.google.com with SMTP id a77so3480349oii.5
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 19:20:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 13 Dec 2018 21:19:22 -0600
Message-Id: <20181214031923.29527-33-richard.henderson@linaro.org>
In-Reply-To: <20181214031923.29527-1-richard.henderson@linaro.org>
References: <20181214031923.29527-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 31/32] include: move exec/tb-hash-xx.h to
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
index 0278f4da04..ab4e708180 100644
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
2.17.2
