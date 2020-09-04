Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1F6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4DD20684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jim0d5Sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4DD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEH5h-0002tc-Fl
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4s-0001FW-5n
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:50 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH4q-0000m7-BK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:08:49 -0400
Received: by mail-pf1-x442.google.com with SMTP id k15so5097014pfc.12
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZQFMYGAuXqpm90YweonU/9zyyJU/Tpvmv3t3sFnfv74=;
 b=jim0d5Sa8SYL2wChZ3LXLEAIbRin5s0LbsilyYYtoydpDshPTNYMbBvzCg3l7Ql0qq
 ttnpKUuTe2xiI2QNo8veE8CprCxGeV9yhrUU5CW0p/U1qqx30tJHX7wZiRpFnTgJxydH
 lh3e/7OUUZMkgA9/5lebu9q49vREjccd0W943kUu9dcyNOYYkLTTrv6AyLsRDwp74jMs
 Im6csPDqy6lkGDDsmBl4vIojHpXKkBlP6QXw5JvKNEE2UpEAgkSwEvQ1jx2cvOpoBYpp
 0cfK3oqVPI2t4u+xQE/woKovuPr7B4OGNa/3iIKl2IBa8xCasBQrLllG2ZM69tzVVqjw
 9nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZQFMYGAuXqpm90YweonU/9zyyJU/Tpvmv3t3sFnfv74=;
 b=bKoMpRSEn4RWWvybKvl6OGL8vfIGIShPefTNpQ+WBeJCRHqWk2ULHW2SJ7N7KTrlsK
 rK6GJ334ccmFdNSySEiOidJkX1mjIkvcPNpUVY0NY16ohAbvtWR2vPwV78gescd8KQQe
 pwxJ7NdcjHQfJTUwKGCy7hjTZ2VId5fnW5Q5hk8ebA3VPM5Y1VS6TIPgN/niSDQSk968
 Pn52+SqwTUPPUGbojtirHSz8ye7XEQ6w2tQ62l/LUfgMH3QBqaXQO0iCfXsg3nLghvKH
 Ao3mP4dXyZpXL1asNlaKiRqBNU85WAi/t7eBA01OKIZUV0rr53bbSuro/nArZmei8wnj
 WErQ==
X-Gm-Message-State: AOAM531KY3Pr5mkJvQO+QzBCD7GKYYBgUHSz1wvSh/3uINMHbW+O7fyD
 lGWLsIUh7NtU4ruqAIzKVXVITi1B6/P1uQ==
X-Google-Smtp-Source: ABdhPJz+pisa30GPo3+KfOF4OU19MazVlyd02c6DykYyvHhytGcb5kVzgips+jQyah+DVS5p8Ghd1Q==
X-Received: by 2002:aa7:8e85:: with SMTP id a5mr9570900pfr.96.1599246526259;
 Fri, 04 Sep 2020 12:08:46 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:08:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 01/19] target/microblaze: Collected fixes for env->iflags
Date: Fri,  4 Sep 2020 12:08:24 -0700
Message-Id: <20200904190842.2282109-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: edgar.iglesias@xilinx.com, Thomas Huth <thuth@redhat.com>, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are several problems here that can result in soft lockup,
depending on exactly where an interrupt or exception is delivered:

Include BIMM_FLAG in IFLAGS_TB_MASK, since it needs to follow D_FLAG.
Ensure that iflags is 0 when entering an interrupt/exception handler.
Add mb_cpu_synchronize_from_tb to restore iflags from tb->flags.
The change to t_sync_flags is cosmetic, but makes the code clearer.

This fixes the reported regression in acceptance/replay_kernel.py.

Fixes: 683a247ed7a4 ("target/microblaze: Store "current" iflags in insn_start")
Tested-by: Thomas Huth <thuth@redhat.com>
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  3 ++-
 target/microblaze/cpu.c       | 11 +++++++++++
 target/microblaze/helper.c    | 17 +++++++++++------
 target/microblaze/translate.c |  4 ++--
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index d11b6fa995..a25a2b427f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -270,7 +270,8 @@ struct CPUMBState {
 #define D_FLAG		(1 << 19)  /* Bit in ESR.  */
 
 /* TB dependent CPUMBState.  */
-#define IFLAGS_TB_MASK  (D_FLAG | IMM_FLAG | DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)
+#define IFLAGS_TB_MASK  (D_FLAG | BIMM_FLAG | IMM_FLAG | \
+                         DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)
 #define MSR_TB_MASK     (MSR_UM | MSR_VM | MSR_EE)
 
     uint32_t iflags;
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 67017ecc33..6392524135 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -80,6 +80,16 @@ static void mb_cpu_set_pc(CPUState *cs, vaddr value)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
 
     cpu->env.pc = value;
+    /* Ensure D_FLAG and IMM_FLAG are clear for the new PC */
+    cpu->env.iflags = 0;
+}
+
+static void mb_cpu_synchronize_from_tb(CPUState *cs, TranslationBlock *tb)
+{
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+
+    cpu->env.pc = tb->pc;
+    cpu->env.iflags = tb->flags & IFLAGS_TB_MASK;
 }
 
 static bool mb_cpu_has_work(CPUState *cs)
@@ -321,6 +331,7 @@ static void mb_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = mb_cpu_exec_interrupt;
     cc->dump_state = mb_cpu_dump_state;
     cc->set_pc = mb_cpu_set_pc;
+    cc->synchronize_from_tb = mb_cpu_synchronize_from_tb;
     cc->gdb_read_register = mb_cpu_gdb_read_register;
     cc->gdb_write_register = mb_cpu_gdb_write_register;
     cc->tlb_fill = mb_cpu_tlb_fill;
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index 48547385b0..00090526da 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -113,7 +113,10 @@ void mb_cpu_do_interrupt(CPUState *cs)
     uint32_t t, msr = mb_cpu_read_msr(env);
 
     /* IMM flag cannot propagate across a branch and into the dslot.  */
-    assert(!((env->iflags & D_FLAG) && (env->iflags & IMM_FLAG)));
+    assert((env->iflags & (D_FLAG | IMM_FLAG)) != (D_FLAG | IMM_FLAG));
+    /* BIMM flag cannot be set without D_FLAG. */
+    assert((env->iflags & (D_FLAG | BIMM_FLAG)) != BIMM_FLAG);
+    /* RTI flags are private to translate. */
     assert(!(env->iflags & (DRTI_FLAG | DRTE_FLAG | DRTB_FLAG)));
     env->res_addr = RES_ADDR_NONE;
     switch (cs->exception_index) {
@@ -146,7 +149,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
                           env->pc, env->ear,
                           env->esr, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            env->iflags &= ~(IMM_FLAG | D_FLAG);
+            env->iflags = 0;
             env->pc = cpu->cfg.base_vectors + 0x20;
             break;
 
@@ -186,14 +189,14 @@ void mb_cpu_do_interrupt(CPUState *cs)
                           "exception at pc=%x ear=%" PRIx64 " iflags=%x\n",
                           env->pc, env->ear, env->iflags);
             log_cpu_state_mask(CPU_LOG_INT, cs, 0);
-            env->iflags &= ~(IMM_FLAG | D_FLAG);
+            env->iflags = 0;
             env->pc = cpu->cfg.base_vectors + 0x20;
             break;
 
         case EXCP_IRQ:
             assert(!(msr & (MSR_EIP | MSR_BIP)));
             assert(msr & MSR_IE);
-            assert(!(env->iflags & D_FLAG));
+            assert(!(env->iflags & (D_FLAG | IMM_FLAG)));
 
             t = (msr & (MSR_VM | MSR_UM)) << 1;
 
@@ -226,13 +229,14 @@ void mb_cpu_do_interrupt(CPUState *cs)
             mb_cpu_write_msr(env, msr);
 
             env->regs[14] = env->pc;
+            env->iflags = 0;
             env->pc = cpu->cfg.base_vectors + 0x10;
             //log_cpu_state_mask(CPU_LOG_INT, cs, 0);
             break;
 
         case EXCP_HW_BREAK:
-            assert(!(env->iflags & IMM_FLAG));
-            assert(!(env->iflags & D_FLAG));
+            assert(!(env->iflags & (D_FLAG | IMM_FLAG)));
+
             t = (msr & (MSR_VM | MSR_UM)) << 1;
             qemu_log_mask(CPU_LOG_INT,
                           "break at pc=%x msr=%x %x iflags=%x\n",
@@ -242,6 +246,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
             msr |= t;
             msr |= MSR_BIP;
             env->regs[16] = env->pc;
+            env->iflags = 0;
             env->pc = cpu->cfg.base_vectors + 0x18;
             mb_cpu_write_msr(env, msr);
             break;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a377818b5e..a8a3249185 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -91,8 +91,8 @@ static int typeb_imm(DisasContext *dc, int x)
 static void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
-    if ((dc->tb_flags ^ dc->base.tb->flags) & ~MSR_TB_MASK) {
-        tcg_gen_movi_i32(cpu_iflags, dc->tb_flags & ~MSR_TB_MASK);
+    if ((dc->tb_flags ^ dc->base.tb->flags) & IFLAGS_TB_MASK) {
+        tcg_gen_movi_i32(cpu_iflags, dc->tb_flags & IFLAGS_TB_MASK);
     }
 }
 
-- 
2.25.1


