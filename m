Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAFBC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCA3F20665
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zgfJ8FPh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA3F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAg6q-00049S-Sq
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg33-000705-D1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:05 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg30-0001d0-KT
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:04 -0400
Received: by mail-pg1-x542.google.com with SMTP id g1so3877061pgm.9
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FtEPL/E9lzDT+6PJrqbAO+r8K2BAzAB3u+X3MwdzqPI=;
 b=zgfJ8FPhE5Cmw1qKAE/xbui7J9BVJXpzpEQD8Pm2albhra/oaGRqO5TdNoCOmM9QWd
 85XMqNu0ImP912jw3JkQhOCNeykeguXFkexr7hWuskKHaMayKGb+IEcWR+H0R/pjglkm
 tThYFC6LQRrR5qRpnr4I+/CxdBY6aegVwA/jHIwxV3YnAXD/5djsGu1L2QYD3sXcX4Ib
 M510Bm3hxbi0dvpO0XTz5zywxJ8G3XnGbPi7jKDAHobhE3wZi7nB9FM6UQqWYklgZK9k
 cNMsHNaQDMH+/MseiI6GozznsxG3nUZtnBic6p0OzgXdJLXJedOb5MmhnCHeOEt3ytbl
 Aqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FtEPL/E9lzDT+6PJrqbAO+r8K2BAzAB3u+X3MwdzqPI=;
 b=e70YVNrGSdXii5k3SK9AbDhYVMnd7CqKjFfxcnYiE86UZh7mmLRlYcr5poT+3Bm/hE
 PEmTwWvSi1cA0IOzR0U8+HnU06n9Goy9rsmg88ke37AwYfokXKmlFv6alY8uN31w2oMf
 sBP8eF7+ymYyit0CbB+D7lEDmaEfIwSMNmofKktEpmGwIONO2yRIsfB7No5rLHIPGL/y
 6aCRceqP60wuft5wp35X+kiRdXmr0fAuyepxMaYTHvDr1gWMyY3+AuQzewNqxFpnDeG4
 /Fr3Ekq8GZwd5b7NrbLHgBwAmy7HFOcskR3ZtSJYoVsOPF40qNB1hR5yYfcGWJdPt/9p
 YTLA==
X-Gm-Message-State: AOAM5308tm1belP+BjJ+BD2z288qQr0FGPzEaiVI8kvH7TJSizkCuUEU
 aEIj1fFnIqYaT1rNXLlUEJ74BdncF9XDHg==
X-Google-Smtp-Source: ABdhPJy3jDaqYQ4VXSx1kE4AdY+nFP5LtY09MmNqaGAj3dKg8HtHHol+TD4i/TgGHWXs3r8Rs63Shw==
X-Received: by 2002:a63:de4d:: with SMTP id y13mr8266109pgi.247.1598389200357; 
 Tue, 25 Aug 2020 14:00:00 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.13.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 13:59:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/77] target/microblaze: Split out MSR from env->sregs
Date: Tue, 25 Aug 2020 13:58:39 -0700
Message-Id: <20200825205950.730499-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Continue eliminating the sregs array in favor of individual members.
Does not correct the width of MSR, yet.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  7 ++---
 target/microblaze/cpu.c       |  4 +--
 target/microblaze/gdbstub.c   |  4 +--
 target/microblaze/helper.c    | 49 +++++++++++++++++------------------
 target/microblaze/op_helper.c | 22 ++++++++--------
 target/microblaze/translate.c | 14 +++++-----
 6 files changed, 51 insertions(+), 49 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d1f91bb318..36de61d9f9 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -237,6 +237,7 @@ struct CPUMBState {
     uint32_t imm;
     uint32_t regs[32];
     uint64_t pc;
+    uint64_t msr;
     uint64_t sregs[14];
     float_status fp_status;
     /* Stack protectors. Yes, it's a hw feature.  */
@@ -355,7 +356,7 @@ static inline void cpu_get_tb_cpu_state(CPUMBState *env, target_ulong *pc,
     *pc = env->pc;
     *cs_base = 0;
     *flags = (env->iflags & IFLAGS_TB_MASK) |
-                 (env->sregs[SR_MSR] & (MSR_UM | MSR_VM | MSR_EE));
+             (env->msr & (MSR_UM | MSR_VM | MSR_EE));
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -370,11 +371,11 @@ static inline int cpu_mmu_index(CPUMBState *env, bool ifetch)
     MicroBlazeCPU *cpu = env_archcpu(env);
 
     /* Are we in nommu mode?.  */
-    if (!(env->sregs[SR_MSR] & MSR_VM) || !cpu->cfg.use_mmu) {
+    if (!(env->msr & MSR_VM) || !cpu->cfg.use_mmu) {
         return MMU_NOMMU_IDX;
     }
 
-    if (env->sregs[SR_MSR] & MSR_UM) {
+    if (env->msr & MSR_UM) {
         return MMU_USER_IDX;
     }
     return MMU_KERNEL_IDX;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index bde9992535..0eac068570 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -121,9 +121,9 @@ static void mb_cpu_reset(DeviceState *dev)
 
 #if defined(CONFIG_USER_ONLY)
     /* start in user mode with interrupts enabled.  */
-    env->sregs[SR_MSR] = MSR_EE | MSR_IE | MSR_VM | MSR_UM;
+    env->msr = MSR_EE | MSR_IE | MSR_VM | MSR_UM;
 #else
-    env->sregs[SR_MSR] = 0;
+    env->msr = 0;
     mmu_init(&env->mmu);
     env->mmu.c_mmu = 3;
     env->mmu.c_mmu_tlb_access = 3;
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 9ea31f8d2f..e4c4936a7a 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -62,7 +62,7 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->pc;
         break;
     case GDB_MSR:
-        val = env->sregs[SR_MSR];
+        val = env->msr;
         break;
     case GDB_EAR:
         val = env->sregs[SR_EAR];
@@ -118,7 +118,7 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->pc = tmp;
         break;
     case GDB_MSR:
-        env->sregs[SR_MSR] = tmp;
+        env->msr = tmp;
         break;
     case GDB_EAR:
         env->sregs[SR_EAR] = tmp;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 5c392deea4..a18314540f 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -117,7 +117,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
     /* IMM flag cannot propagate across a branch and into the dslot.  */
     assert(!((env->iflags & D_FLAG) && (env->iflags & IMM_FLAG)));
     assert(!(env->iflags & (DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)));
-/*    assert(env->sregs[SR_MSR] & (MSR_EE)); Only for HW exceptions.  */
+/*    assert(env->msr & (MSR_EE)); Only for HW exceptions.  */
     env->res_addr = RES_ADDR_NONE;
     switch (cs->exception_index) {
         case EXCP_HW_EXCP:
@@ -136,11 +136,11 @@ void mb_cpu_do_interrupt(CPUState *cs)
             }
 
             /* Disable the MMU.  */
-            t = (env->sregs[SR_MSR] & (MSR_VM | MSR_UM)) << 1;
-            env->sregs[SR_MSR] &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            env->sregs[SR_MSR] |= t;
+            t = (env->msr & (MSR_VM | MSR_UM)) << 1;
+            env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
+            env->msr |= t;
             /* Exception in progress.  */
-            env->sregs[SR_MSR] |= MSR_EIP;
+            env->msr |= MSR_EIP;
 
             qemu_log_mask(CPU_LOG_INT,
                           "hw exception at pc=%" PRIx64 " ear=%" PRIx64 " "
@@ -179,11 +179,11 @@ void mb_cpu_do_interrupt(CPUState *cs)
             }
 
             /* Disable the MMU.  */
-            t = (env->sregs[SR_MSR] & (MSR_VM | MSR_UM)) << 1;
-            env->sregs[SR_MSR] &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            env->sregs[SR_MSR] |= t;
+            t = (env->msr & (MSR_VM | MSR_UM)) << 1;
+            env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
+            env->msr |= t;
             /* Exception in progress.  */
-            env->sregs[SR_MSR] |= MSR_EIP;
+            env->msr |= MSR_EIP;
 
             qemu_log_mask(CPU_LOG_INT,
                           "exception at pc=%" PRIx64 " ear=%" PRIx64 " "
@@ -195,11 +195,11 @@ void mb_cpu_do_interrupt(CPUState *cs)
             break;
 
         case EXCP_IRQ:
-            assert(!(env->sregs[SR_MSR] & (MSR_EIP | MSR_BIP)));
-            assert(env->sregs[SR_MSR] & MSR_IE);
+            assert(!(env->msr & (MSR_EIP | MSR_BIP)));
+            assert(env->msr & MSR_IE);
             assert(!(env->iflags & D_FLAG));
 
-            t = (env->sregs[SR_MSR] & (MSR_VM | MSR_UM)) << 1;
+            t = (env->msr & (MSR_VM | MSR_UM)) << 1;
 
 #if 0
 #include "disas/disas.h"
@@ -216,7 +216,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
 
                     qemu_log(
                          "interrupt at pc=%x msr=%x %x iflags=%x sym=%s\n",
-                         env->pc, env->sregs[SR_MSR], t, env->iflags,
+                         env->pc, env->msr, t, env->iflags,
                          sym);
 
                     log_cpu_state(cs, 0);
@@ -226,11 +226,10 @@ void mb_cpu_do_interrupt(CPUState *cs)
             qemu_log_mask(CPU_LOG_INT,
                          "interrupt at pc=%" PRIx64 " msr=%" PRIx64 " %x "
                          "iflags=%x\n",
-                         env->pc, env->sregs[SR_MSR], t, env->iflags);
+                         env->pc, env->msr, t, env->iflags);
 
-            env->sregs[SR_MSR] &= ~(MSR_VMS | MSR_UMS | MSR_VM \
-                                    | MSR_UM | MSR_IE);
-            env->sregs[SR_MSR] |= t;
+            env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM | MSR_IE);
+            env->msr |= t;
 
             env->regs[14] = env->pc;
             env->pc = cpu->cfg.base_vectors + 0x10;
@@ -241,18 +240,18 @@ void mb_cpu_do_interrupt(CPUState *cs)
         case EXCP_HW_BREAK:
             assert(!(env->iflags & IMM_FLAG));
             assert(!(env->iflags & D_FLAG));
-            t = (env->sregs[SR_MSR] & (MSR_VM | MSR_UM)) << 1;
+            t = (env->msr & (MSR_VM | MSR_UM)) << 1;
             qemu_log_mask(CPU_LOG_INT,
                         "break at pc=%" PRIx64 " msr=%" PRIx64 " %x "
                         "iflags=%x\n",
-                        env->pc, env->sregs[SR_MSR], t, env->iflags);
+                        env->pc, env->msr, t, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            env->sregs[SR_MSR] &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
-            env->sregs[SR_MSR] |= t;
-            env->sregs[SR_MSR] |= MSR_BIP;
+            env->msr &= ~(MSR_VMS | MSR_UMS | MSR_VM | MSR_UM);
+            env->msr |= t;
+            env->msr |= MSR_BIP;
             if (cs->exception_index == EXCP_HW_BREAK) {
                 env->regs[16] = env->pc;
-                env->sregs[SR_MSR] |= MSR_BIP;
+                env->msr |= MSR_BIP;
                 env->pc = cpu->cfg.base_vectors + 0x18;
             } else
                 env->pc = env->btarget;
@@ -293,8 +292,8 @@ bool mb_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
     CPUMBState *env = &cpu->env;
 
     if ((interrupt_request & CPU_INTERRUPT_HARD)
-        && (env->sregs[SR_MSR] & MSR_IE)
-        && !(env->sregs[SR_MSR] & (MSR_EIP | MSR_BIP))
+        && (env->msr & MSR_IE)
+        && !(env->msr & (MSR_EIP | MSR_BIP))
         && !(env->iflags & (D_FLAG | IMM_FLAG))) {
         cs->exception_index = EXCP_IRQ;
         mb_cpu_do_interrupt(cs);
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index 2deef32740..3668382d36 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -78,14 +78,14 @@ void helper_debug(CPUMBState *env)
     qemu_log("PC=%" PRIx64 "\n", env->pc);
     qemu_log("rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
              "debug[%x] imm=%x iflags=%x\n",
-             env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
+             env->msr, env->sregs[SR_ESR], env->sregs[SR_EAR],
              env->debug, env->imm, env->iflags);
     qemu_log("btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) eip=%d ie=%d\n",
              env->btaken, env->btarget,
-             (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
-             (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
-             (bool)(env->sregs[SR_MSR] & MSR_EIP),
-             (bool)(env->sregs[SR_MSR] & MSR_IE));
+             (env->msr & MSR_UM) ? "user" : "kernel",
+             (env->msr & MSR_UMS) ? "user" : "kernel",
+             (bool)(env->msr & MSR_EIP),
+             (bool)(env->msr & MSR_IE));
     for (i = 0; i < 32; i++) {
         qemu_log("r%2.2d=%8.8x ", i, env->regs[i]);
         if ((i + 1) % 4 == 0)
@@ -135,15 +135,15 @@ static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
     MicroBlazeCPU *cpu = env_archcpu(env);
 
     if (b == 0) {
-        env->sregs[SR_MSR] |= MSR_DZ;
+        env->msr |= MSR_DZ;
 
-        if ((env->sregs[SR_MSR] & MSR_EE) && cpu->cfg.div_zero_exception) {
+        if ((env->msr & MSR_EE) && cpu->cfg.div_zero_exception) {
             env->sregs[SR_ESR] = ESR_EC_DIVZERO;
             helper_raise_exception(env, EXCP_HW_EXCP);
         }
         return 0;
     }
-    env->sregs[SR_MSR] &= ~MSR_DZ;
+    env->msr &= ~MSR_DZ;
     return 1;
 }
 
@@ -192,7 +192,7 @@ static void update_fpu_flags(CPUMBState *env, int flags)
     }
     if (raise
         && (env->pvr.regs[2] & PVR2_FPU_EXC_MASK)
-        && (env->sregs[SR_MSR] & MSR_EE)) {
+        && (env->msr & MSR_EE)) {
         raise_fpu_exception(env);
     }
 }
@@ -437,7 +437,7 @@ void helper_memalign(CPUMBState *env, target_ulong addr,
             if (mask == 3) {
                 env->sregs[SR_ESR] |= 1 << 11;
             }
-            if (!(env->sregs[SR_MSR] & MSR_EE)) {
+            if (!(env->msr & MSR_EE)) {
                 return;
             }
             helper_raise_exception(env, EXCP_HW_EXCP);
@@ -484,7 +484,7 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
     env = &cpu->env;
 
     cpu_restore_state(cs, retaddr, true);
-    if (!(env->sregs[SR_MSR] & MSR_EE)) {
+    if (!(env->msr & MSR_EE)) {
         return;
     }
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9f6815cc1f..9f2dcd82cd 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1809,16 +1809,16 @@ void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     qemu_fprintf(f, "rmsr=%" PRIx64 " resr=%" PRIx64 " rear=%" PRIx64 " "
                  "debug=%x imm=%x iflags=%x fsr=%" PRIx64 " "
                  "rbtr=%" PRIx64 "\n",
-                 env->sregs[SR_MSR], env->sregs[SR_ESR], env->sregs[SR_EAR],
+                 env->msr, env->sregs[SR_ESR], env->sregs[SR_EAR],
                  env->debug, env->imm, env->iflags, env->sregs[SR_FSR],
                  env->sregs[SR_BTR]);
     qemu_fprintf(f, "btaken=%d btarget=%" PRIx64 " mode=%s(saved=%s) "
                  "eip=%d ie=%d\n",
                  env->btaken, env->btarget,
-                 (env->sregs[SR_MSR] & MSR_UM) ? "user" : "kernel",
-                 (env->sregs[SR_MSR] & MSR_UMS) ? "user" : "kernel",
-                 (bool)(env->sregs[SR_MSR] & MSR_EIP),
-                 (bool)(env->sregs[SR_MSR] & MSR_IE));
+                 (env->msr & MSR_UM) ? "user" : "kernel",
+                 (env->msr & MSR_UMS) ? "user" : "kernel",
+                 (bool)(env->msr & MSR_EIP),
+                 (bool)(env->msr & MSR_IE));
     for (i = 0; i < 12; i++) {
         qemu_fprintf(f, "rpvr%2.2d=%8.8x ", i, env->pvr.regs[i]);
         if ((i + 1) % 4 == 0) {
@@ -1871,8 +1871,10 @@ void mb_tcg_init(void)
 
     cpu_SR[SR_PC] =
         tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, pc), "rpc");
+    cpu_SR[SR_MSR] =
+        tcg_global_mem_new_i64(cpu_env, offsetof(CPUMBState, msr), "rmsr");
 
-    for (i = 1; i < ARRAY_SIZE(cpu_SR); i++) {
+    for (i = SR_MSR + 1; i < ARRAY_SIZE(cpu_SR); i++) {
         cpu_SR[i] = tcg_global_mem_new_i64(cpu_env,
                           offsetof(CPUMBState, sregs[i]),
                           special_regnames[i]);
-- 
2.25.1


