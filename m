Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB6520738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcvqyZnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB6520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgOY-0000v2-Rq
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3Z-0007na-Al
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:37 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3U-0001pl-KF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id v15so7668439pgh.6
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M605GjYj/TsAqS9LhAzYjh6MlBkWbkHJca8j+nbMmp4=;
 b=jcvqyZnThZ/3ASU91duPjcaQ7BdUAPmcwiKJovm/prHu5wf2MepgTAbmV6egLNARHE
 8t29ZrUtBnhTNE4tdanV1o+IkBO55oPTUERBp/j1CjiPdiYzsNreLUH8UiMPKkQHyRh2
 lSpyTxhdVA6fwVYS+SvrL5RY6h62/l9UzcLxO6FhOlcZkZEa1iNPCEsIzP94LD+mbu3i
 u8UEy5pKY8j4MaBfi64Hdzu14yBu6iHxGTQYa8lW5iWzG7PJVN0EguWNqrGDAOe8Vgv9
 b6zw2UzodXn2BdanjCBOBSo97P7B6A8kzj7+BUbBf0mlpW5wWYPTShwjF01SpxdR3tEb
 d+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M605GjYj/TsAqS9LhAzYjh6MlBkWbkHJca8j+nbMmp4=;
 b=a75wgPiUfXzi+2SpCDkVRcI3aBHuX+Yr+MjCXUw0JqJAoeWPuB1jnMnTv52A+wU9+F
 +Em/d+rzWM6RQfoLHRatlWnmK4Qgp9i8iBlIQ3YoN5I7TVTFhtrTDgjm4a0a+9LKiVYF
 NtLUeTp9zlW9MmfstD0CevzcyN4ayTQI1HqD1eheTvKCG1LEEx6lGYIxlXHDdcXithSJ
 MKupOeUQ2Z+xUTMmxLD+wJJapjIE0CUx0PEbOoZOIjHwIrb+Af/frySUhVMEEiBIzvIW
 Tl5q0XmvytUUabMeBujt6R/Ojr1YPGAVGomsF1RPhFmWuneKE08F43G8eY84zQvsG5Qw
 fo5Q==
X-Gm-Message-State: AOAM5326DKWgyNS7Gre7yzfWj4T7p+LRh3k/1KFoCtgT38sinqiSB7BF
 enRkJAHcxp1doJziotBZ2fVQp0KWVhlCdA==
X-Google-Smtp-Source: ABdhPJw/Moh5vxoSlhVdWC1DXqJPoH5MIWmlkNClwi8E39OayFE4i966A7kwPz+T6CMC8FgYVRMjnw==
X-Received: by 2002:aa7:9552:: with SMTP id w18mr9374849pfq.150.1598389229530; 
 Tue, 25 Aug 2020 14:00:29 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/77] target/microblaze: Convert to translator_loop
Date: Tue, 25 Aug 2020 13:59:02 -0700
Message-Id: <20200825205950.730499-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

Part two of conversion to the generic translator_loop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 289 ++++++++++++++++++----------------
 1 file changed, 149 insertions(+), 140 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 45b1555f85..6a9710d76d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1595,172 +1595,181 @@ static inline void decode(DisasContext *dc, uint32_t ir)
     }
 }
 
-/* generate intermediate code for basic block 'tb'.  */
-void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
+static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
-    CPUMBState *env = cs->env_ptr;
-    MicroBlazeCPU *cpu = env_archcpu(env);
-    uint32_t pc_start;
-    struct DisasContext ctx;
-    struct DisasContext *dc = &ctx;
-    uint32_t page_start, org_flags;
-    uint32_t npc;
-    int num_insns;
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    int bound;
 
-    pc_start = tb->pc;
     dc->cpu = cpu;
-    org_flags = dc->synced_flags = dc->tb_flags = tb->flags;
-
-    dc->jmp = 0;
+    dc->synced_flags = dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
-    if (dc->delayed_branch) {
-        dc->jmp = JMP_INDIRECT;
-    }
-    dc->base.pc_first = pc_start;
-    dc->base.pc_next = pc_start;
-    dc->base.singlestep_enabled = cs->singlestep_enabled;
+    dc->jmp = dc->delayed_branch ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
     dc->abort_at_next_insn = 0;
-    dc->base.is_jmp = DISAS_NEXT;
-    dc->base.tb = tb;
 
-    if (pc_start & 3) {
-        cpu_abort(cs, "Microblaze: unaligned PC=%x\n", pc_start);
+    bound = -(dc->base.pc_first | TARGET_PAGE_MASK) / 4;
+    dc->base.max_insns = MIN(dc->base.max_insns, bound);
+}
+
+static void mb_tr_tb_start(DisasContextBase *dcb, CPUState *cs)
+{
+}
+
+static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
+{
+    tcg_gen_insn_start(dcb->pc_next);
+}
+
+static bool mb_tr_breakpoint_check(DisasContextBase *dcb, CPUState *cs,
+                                   const CPUBreakpoint *bp)
+{
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+
+    gen_raise_exception_sync(dc, EXCP_DEBUG);
+
+    /*
+     * The address covered by the breakpoint must be included in
+     * [tb->pc, tb->pc + tb->size) in order to for it to be
+     * properly cleared -- thus we increment the PC here so that
+     * the logic setting tb->size below does the right thing.
+     */
+    dc->base.pc_next += 4;
+    return true;
+}
+
+static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+    CPUMBState *env = cs->env_ptr;
+
+    /* TODO: This should raise an exception, not terminate qemu. */
+    if (dc->base.pc_next & 3) {
+        cpu_abort(cs, "Microblaze: unaligned PC=%x\n",
+                  (uint32_t)dc->base.pc_next);
     }
 
-    page_start = pc_start & TARGET_PAGE_MASK;
-    num_insns = 0;
+    dc->clear_imm = 1;
+    decode(dc, cpu_ldl_code(env, dc->base.pc_next));
+    if (dc->clear_imm) {
+        dc->tb_flags &= ~IMM_FLAG;
+    }
+    dc->base.pc_next += 4;
 
-    gen_tb_start(tb);
-    do
-    {
-        tcg_gen_insn_start(dc->base.pc_next);
-        num_insns++;
-
-        if (unlikely(cpu_breakpoint_test(cs, dc->base.pc_next, BP_ANY))) {
-            gen_raise_exception_sync(dc, EXCP_DEBUG);
-            /* The address covered by the breakpoint must be included in
-               [tb->pc, tb->pc + tb->size) in order to for it to be
-               properly cleared -- thus we increment the PC here so that
-               the logic setting tb->size below does the right thing.  */
-            dc->base.pc_next += 4;
-            break;
+    if (dc->delayed_branch && --dc->delayed_branch == 0) {
+        if (dc->tb_flags & DRTI_FLAG) {
+            do_rti(dc);
         }
-
-        /* Pretty disas.  */
-        LOG_DIS("%8.8x:\t", (uint32_t)dc->base.pc_next);
-
-        if (num_insns == max_insns && (tb_cflags(tb) & CF_LAST_IO)) {
-            gen_io_start();
+        if (dc->tb_flags & DRTB_FLAG) {
+            do_rtb(dc);
         }
-
-        dc->clear_imm = 1;
-        decode(dc, cpu_ldl_code(env, dc->base.pc_next));
-        if (dc->clear_imm)
-            dc->tb_flags &= ~IMM_FLAG;
-        dc->base.pc_next += 4;
-
-        if (dc->delayed_branch) {
-            dc->delayed_branch--;
-            if (!dc->delayed_branch) {
-                if (dc->tb_flags & DRTI_FLAG)
-                    do_rti(dc);
-                 if (dc->tb_flags & DRTB_FLAG)
-                    do_rtb(dc);
-                if (dc->tb_flags & DRTE_FLAG)
-                    do_rte(dc);
-                /* Clear the delay slot flag.  */
-                dc->tb_flags &= ~D_FLAG;
-                /* If it is a direct jump, try direct chaining.  */
-                if (dc->jmp == JMP_INDIRECT) {
-                    TCGv_i32 tmp_pc = tcg_const_i32(dc->base.pc_next);
-                    eval_cond_jmp(dc, cpu_btarget, tmp_pc);
-                    tcg_temp_free_i32(tmp_pc);
-                    dc->base.is_jmp = DISAS_JUMP;
-                } else if (dc->jmp == JMP_DIRECT) {
-                    t_sync_flags(dc);
-                    gen_goto_tb(dc, 0, dc->jmp_pc);
-                } else if (dc->jmp == JMP_DIRECT_CC) {
-                    TCGLabel *l1 = gen_new_label();
-                    t_sync_flags(dc);
-                    /* Conditional jmp.  */
-                    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);
-                    gen_goto_tb(dc, 1, dc->base.pc_next);
-                    gen_set_label(l1);
-                    gen_goto_tb(dc, 0, dc->jmp_pc);
-                }
-                break;
-            }
+        if (dc->tb_flags & DRTE_FLAG) {
+            do_rte(dc);
         }
-        if (dc->base.singlestep_enabled) {
-            break;
-        }
-    } while (!dc->base.is_jmp && !dc->cpustate_changed
-             && !tcg_op_buf_full()
-             && !singlestep
-             && (dc->base.pc_next - page_start < TARGET_PAGE_SIZE)
-             && num_insns < max_insns);
-
-    npc = dc->base.pc_next;
-    if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
-        if (dc->tb_flags & D_FLAG) {
-            dc->base.is_jmp = DISAS_UPDATE;
-            tcg_gen_movi_i32(cpu_pc, npc);
-            sync_jmpstate(dc);
-        } else
-            npc = dc->jmp_pc;
+        /* Clear the delay slot flag.  */
+        dc->tb_flags &= ~D_FLAG;
+        dc->base.is_jmp = DISAS_JUMP;
     }
 
-    /* Force an update if the per-tb cpu state has changed.  */
-    if (dc->base.is_jmp == DISAS_NEXT
-        && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
+    /* Force an exit if the per-tb cpu state has changed.  */
+    if (dc->base.is_jmp == DISAS_NEXT && dc->cpustate_changed) {
         dc->base.is_jmp = DISAS_UPDATE;
-        tcg_gen_movi_i32(cpu_pc, npc);
+        tcg_gen_movi_i32(cpu_pc, dc->base.pc_next);
     }
-    t_sync_flags(dc);
+}
+
+static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
+{
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+
+    assert(!dc->abort_at_next_insn);
 
     if (dc->base.is_jmp == DISAS_NORETURN) {
-        /* nothing more to generate */
-    } else if (unlikely(cs->singlestep_enabled)) {
-        TCGv_i32 tmp = tcg_const_i32(EXCP_DEBUG);
-
-        if (dc->base.is_jmp != DISAS_JUMP) {
-            tcg_gen_movi_i32(cpu_pc, npc);
-        }
-        gen_helper_raise_exception(cpu_env, tmp);
-        tcg_temp_free_i32(tmp);
-    } else {
-        switch (dc->base.is_jmp) {
-            case DISAS_NEXT:
-                gen_goto_tb(dc, 1, npc);
-                break;
-            case DISAS_JUMP:
-            case DISAS_UPDATE:
-                /* indicate that the hash table must be used
-                   to find the next TB */
-                tcg_gen_exit_tb(NULL, 0);
-                break;
-            default:
-                g_assert_not_reached();
-        }
+        /* We have already exited the TB. */
+        return;
     }
-    gen_tb_end(tb, num_insns);
 
-    tb->size = dc->base.pc_next - pc_start;
-    tb->icount = num_insns;
+    t_sync_flags(dc);
+    if (dc->tb_flags & D_FLAG) {
+        sync_jmpstate(dc);
+        dc->jmp = JMP_NOJMP;
+    }
 
+    switch (dc->base.is_jmp) {
+    case DISAS_TOO_MANY:
+        assert(dc->jmp == JMP_NOJMP);
+        gen_goto_tb(dc, 0, dc->base.pc_next);
+        return;
+
+    case DISAS_UPDATE:
+        assert(dc->jmp == JMP_NOJMP);
+        if (unlikely(cs->singlestep_enabled)) {
+            gen_raise_exception(dc, EXCP_DEBUG);
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
+        return;
+
+    case DISAS_JUMP:
+        switch (dc->jmp) {
+        case JMP_INDIRECT:
+            {
+                TCGv_i32 tmp_pc = tcg_const_i32(dc->base.pc_next);
+                eval_cond_jmp(dc, cpu_btarget, tmp_pc);
+                tcg_temp_free_i32(tmp_pc);
+
+                if (unlikely(cs->singlestep_enabled)) {
+                    gen_raise_exception(dc, EXCP_DEBUG);
+                } else {
+                    tcg_gen_exit_tb(NULL, 0);
+                }
+            }
+            return;
+
+        case JMP_DIRECT_CC:
+            {
+                TCGLabel *l1 = gen_new_label();
+                tcg_gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);
+                gen_goto_tb(dc, 1, dc->base.pc_next);
+                gen_set_label(l1);
+            }
+            /* fall through */
+
+        case JMP_DIRECT:
+            gen_goto_tb(dc, 0, dc->jmp_pc);
+            return;
+        }
+        /* fall through */
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void mb_tr_disas_log(const DisasContextBase *dcb, CPUState *cs)
+{
 #ifdef DEBUG_DISAS
 #if !SIM_COMPAT
-    if (qemu_loglevel_mask(CPU_LOG_TB_IN_ASM)
-        && qemu_log_in_addr_range(pc_start)) {
-        FILE *logfile = qemu_log_lock();
-        qemu_log("--------------\n");
-        log_target_disas(cs, pc_start, dc->base.pc_next - pc_start);
-        qemu_log_unlock(logfile);
-    }
+    qemu_log("IN: %s\n", lookup_symbol(dcb->pc_first));
+    log_target_disas(cs, dcb->pc_first, dcb->tb->size);
 #endif
 #endif
-    assert(!dc->abort_at_next_insn);
+}
+
+static const TranslatorOps mb_tr_ops = {
+    .init_disas_context = mb_tr_init_disas_context,
+    .tb_start           = mb_tr_tb_start,
+    .insn_start         = mb_tr_insn_start,
+    .breakpoint_check   = mb_tr_breakpoint_check,
+    .translate_insn     = mb_tr_translate_insn,
+    .tb_stop            = mb_tr_tb_stop,
+    .disas_log          = mb_tr_disas_log,
+};
+
+void gen_intermediate_code(CPUState *cpu, TranslationBlock *tb, int max_insns)
+{
+    DisasContext dc;
+    translator_loop(&mb_tr_ops, &dc.base, cpu, tb, max_insns);
 }
 
 void mb_cpu_dump_state(CPUState *cs, FILE *f, int flags)
-- 
2.25.1


