Received: from eggs.gnu.org ([2001:4830:134:3::10]:49707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz4-0000Qj-E6
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz3-0000ZP-Jc
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:30 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:57268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYz3-0000YW-Eu
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:29 -0400
Received: by mail-pg0-x234.google.com with SMTP id 7so109364pgd.13
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:13 -0700
Message-Id: <20170914183516.19537-8-richard.henderson@linaro.org>
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/10] target/ppc: Support Capstone in
 disas_set_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org

Cc: qemu-ppc@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c7b4a7c02a..b976784d21 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -35,6 +35,7 @@
 #include "mmu-book3s-v3.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
+#include "disas/capstone.h"
 
 //#define PPC_DUMP_CPU
 //#define PPC_DEBUG_SPR
@@ -10662,6 +10663,11 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
     }
     info->disassembler_options = (char *)"any";
     info->print_insn = print_insn_ppc;
+
+    info->cap_arch = CS_ARCH_PPC;
+#ifdef TARGET_PPC64
+    info->cap_mode = CS_MODE_64;
+#endif
 }
 
 static Property ppc_cpu_properties[] = {
-- 
2.13.5
