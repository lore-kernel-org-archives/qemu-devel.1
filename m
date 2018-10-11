Received: from eggs.gnu.org ([2001:4830:134:3::10]:44990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwh-0006l2-2P
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAhwZ-0004j5-G2
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:33 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:33669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAhwM-0003D1-DK
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 16:52:17 -0400
Received: by mail-pg1-x534.google.com with SMTP id y18-v6so4746641pge.0
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 13:52:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 13:51:48 -0700
Message-Id: <20181011205206.3552-3-richard.henderson@linaro.org>
In-Reply-To: <20181011205206.3552-1-richard.henderson@linaro.org>
References: <20181011205206.3552-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/20] target/arm: Don't call
 tcg_clear_temp_count
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

This is done generically in translator_loop.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 1 -
 target/arm/translate.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 76b5ca3606..ac9723c1b9 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13899,7 +13899,6 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
 
 static void aarch64_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 {
-    tcg_clear_temp_count();
 }
 
 static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 426db7828a..736880ee71 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -12701,7 +12701,6 @@ static void arm_tr_tb_start(DisasContextBase *dcbase, CPUState *cpu)
         tcg_gen_movi_i32(tmp, 0);
         store_cpu_field(tmp, condexec_bits);
     }
-    tcg_clear_temp_count();
 }
 
 static void arm_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.17.1
