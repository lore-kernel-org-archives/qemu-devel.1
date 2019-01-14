Received: from eggs.gnu.org ([209.51.188.92]:37150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnW-0005uT-RC
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1giqnW-00015W-4i
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:14 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:38930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1giqnV-00014v-Vy
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 20:12:14 -0500
Received: by mail-pg1-x535.google.com with SMTP id w6so8737363pgl.6
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 17:12:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 Jan 2019 12:11:18 +1100
Message-Id: <20190114011122.5995-14-richard.henderson@linaro.org>
In-Reply-To: <20190114011122.5995-1-richard.henderson@linaro.org>
References: <20190114011122.5995-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 13/17] target/arm: Set PSTATE.TCO on exception
 entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

R0085 specifies that exception handlers begin with tag checks overridden.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index df43deb0f8..1e9ccf0b2e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -8830,7 +8830,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT, "...with ELR 0x%" PRIx64 "\n",
                   env->elr_el[new_el]);
 
-    pstate_write(env, PSTATE_DAIF | new_mode);
+    pstate_write(env, PSTATE_DAIF | PSTATE_TCO | new_mode);
     env->aarch64 = 1;
     aarch64_restore_sp(env, new_el);
 
-- 
2.17.2
