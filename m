Received: from eggs.gnu.org ([2001:4830:134:3::10]:55343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNh-0000Fl-84
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNg-0003Xv-7g
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:45 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:39664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJnNg-0003Xi-2C
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:44 -0400
Received: by mail-pl0-x22d.google.com with SMTP id c19-v6so5311903pls.6
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:57:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 18 May 2018 14:57:30 -0700
Message-Id: <20180518215734.18833-5-richard.henderson@linaro.org>
In-Reply-To: <20180518215734.18833-1-richard.henderson@linaro.org>
References: <20180518215734.18833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/8] target/riscv: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e5a56d4e3..d630e8fd6c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -219,11 +219,13 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f,
             cpu_fprintf(f, "\n");
         }
     }
-    for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, " %s %016" PRIx64,
-            riscv_fpr_regnames[i], env->fpr[i]);
-        if ((i & 3) == 3) {
-            cpu_fprintf(f, "\n");
+    if (flags & CPU_DUMP_FPU) {
+        for (i = 0; i < 32; i++) {
+            cpu_fprintf(f, " %s %016" PRIx64,
+                riscv_fpr_regnames[i], env->fpr[i]);
+            if ((i & 3) == 3) {
+                cpu_fprintf(f, "\n");
+            }
         }
     }
 }
-- 
2.17.0
