Received: from eggs.gnu.org ([2001:4830:134:3::10]:49805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYzB-0000Wz-45
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsYz6-0000cS-Aw
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:37 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:44794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsYz6-0000bW-4k
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:35:32 -0400
Received: by mail-pg0-x22d.google.com with SMTP id j16so127628pga.1
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:35:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 11:35:15 -0700
Message-Id: <20170914183516.19537-10-richard.henderson@linaro.org>
In-Reply-To: <20170914183516.19537-1-richard.henderson@linaro.org>
References: <20170914183516.19537-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 09/10] target/sparc: Support Capstone in
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 0806d699e6..7eabf410de 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -24,6 +24,7 @@
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #include "qapi/visitor.h"
+#include "disas/capstone.h"
 
 //#define DEBUG_FEATURES
 
@@ -99,8 +100,10 @@ static bool sparc_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 static void cpu_sparc_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->print_insn = print_insn_sparc;
+    info->cap_arch = CS_ARCH_SPARC;
 #ifdef TARGET_SPARC64
     info->mach = bfd_mach_sparc_v9b;
+    info->cap_mode = CS_MODE_V9;
 #endif
 }
 
-- 
2.13.5
