Received: from eggs.gnu.org ([2001:4830:134:3::10]:58862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQO-0008Sc-Jt
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQN-0001qI-Mw
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:52 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQN-0001mH-Fq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:34:51 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQK-0008Sx-HI
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:34:48 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:13 +0100
Message-Id: <20180816133438.17061-6-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/30] target/arm: Reformat integer register dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

With PC, there are 33 registers.  Three per line lines up nicely
without overflowing 80 columns.

Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 45a6c2a3aa1..358f169c755 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -137,14 +137,13 @@ void aarch64_cpu_dump_state(CPUState *cs, FILE *f,
     int el = arm_current_el(env);
     const char *ns_status;
 
-    cpu_fprintf(f, "PC=%016"PRIx64"  SP=%016"PRIx64"\n",
-            env->pc, env->xregs[31]);
-    for (i = 0; i < 31; i++) {
-        cpu_fprintf(f, "X%02d=%016"PRIx64, i, env->xregs[i]);
-        if ((i % 4) == 3) {
-            cpu_fprintf(f, "\n");
+    cpu_fprintf(f, " PC=%016" PRIx64 " ", env->pc);
+    for (i = 0; i < 32; i++) {
+        if (i == 31) {
+            cpu_fprintf(f, " SP=%016" PRIx64 "\n", env->xregs[i]);
         } else {
-            cpu_fprintf(f, " ");
+            cpu_fprintf(f, "X%02d=%016" PRIx64 "%s", i, env->xregs[i],
+                        (i + 2) % 3 ? " " : "\n");
         }
     }
 
-- 
2.18.0
