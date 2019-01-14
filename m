Received: from eggs.gnu.org ([209.51.188.92]:44740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix09-0006VP-S4
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gix08-00022H-BR
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:41 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:35598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gix08-0001vs-49
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:40 -0500
Received: by mail-lj1-x241.google.com with SMTP id x85-v6so18121425ljb.2
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 23:49:32 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 Jan 2019 23:48:54 -0800
Message-Id: <20190114074855.16891-7-jcmvbkbc@gmail.com>
In-Reply-To: <20190114074855.16891-1-jcmvbkbc@gmail.com>
References: <20190114074855.16891-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 6/7] target/xtensa: drop dump_state helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Drop unused helper dump_state from op_helper.c

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/helper.h    |  1 -
 target/xtensa/op_helper.c | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/target/xtensa/helper.h b/target/xtensa/helper.h
index 2ebba0b2c2bf..89eb97e26514 100644
--- a/target/xtensa/helper.h
+++ b/target/xtensa/helper.h
@@ -15,7 +15,6 @@ DEF_HELPER_2(movsp, void, env, i32)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(simcall, void, env)
 #endif
-DEF_HELPER_1(dump_state, void, env)
 
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_3(waiti, void, env, i32, i32)
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index d3e61e22fe82..b0ef828f9ae5 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -93,17 +93,6 @@ void xtensa_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
                                   addr);
 }
 
-#endif
-
-void HELPER(dump_state)(CPUXtensaState *env)
-{
-    XtensaCPU *cpu = xtensa_env_get_cpu(env);
-
-    cpu_dump_state(CPU(cpu), stderr, fprintf, 0);
-}
-
-#ifndef CONFIG_USER_ONLY
-
 void HELPER(update_ccount)(CPUXtensaState *env)
 {
     uint64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-- 
2.11.0
