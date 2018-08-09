Received: from eggs.gnu.org ([2001:4830:134:3::10]:37805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnboh-0006nA-DH
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fnbog-0003Ec-LP
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:51 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:33013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fnbog-0003E6-G0
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 23:40:50 -0400
Received: by mail-pl0-x22e.google.com with SMTP id b90-v6so1948879plb.0
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 20:40:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  8 Aug 2018 20:40:31 -0700
Message-Id: <20180809034033.10579-10-richard.henderson@linaro.org>
In-Reply-To: <20180809034033.10579-1-richard.henderson@linaro.org>
References: <20180809034033.10579-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/11] target/arm: Reformat integer register
 dump
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-stable@nongnu.org

With PC, there are 33 registers.  Three per line lines up nicely
without overflowing 80 columns.

Cc: qemu-stable@nongnu.org (3.0.1)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 45a6c2a3aa..358f169c75 100644
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
2.17.1
