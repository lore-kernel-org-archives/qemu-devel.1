Received: from eggs.gnu.org ([209.51.188.92]:57011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1zNr-0006Hw-0F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1zNq-0001yH-Ak
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:50 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1zNq-0001xO-3B
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:50 -0500
Received: by mail-pf1-x442.google.com with SMTP id i20so12289261pfo.6
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 12:12:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 12:12:43 -0800
Message-Id: <20190307201244.8971-2-richard.henderson@linaro.org>
In-Reply-To: <20190307201244.8971-1-richard.henderson@linaro.org>
References: <20190307201244.8971-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] target/arm: Put system registers in
 "system" group
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

The system group is predefined within gdb.  While the spec
seems to allow arbitrary group names, that seems to mess up
the addition of all registers to any groups.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 0c64c0292e..67c8874b3b 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -113,7 +113,7 @@ static void arm_gen_one_xml_reg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
 {
     g_string_append_printf(s, "<reg name=\"%s\"", ri->name);
     g_string_append_printf(s, " bitsize=\"%d\"", bitsize);
-    g_string_append_printf(s, " group=\"cp_regs\"/>");
+    g_string_append_printf(s, " group=\"system\"/>");
     dyn_xml->num_cpregs++;
     dyn_xml->cpregs_keys[dyn_xml->num_cpregs - 1] = ri_key;
 }
-- 
2.17.2
