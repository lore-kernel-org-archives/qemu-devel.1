Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B995DC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B072083E
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ev6EIxf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B072083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmjc-0008RD-MG
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL6-00066z-KC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:24 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:36788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL4-000680-If
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:24 -0400
Received: by mail-pg1-x542.google.com with SMTP id p37so841156pgl.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JvfZllGqlVqD0CA01I4iiAGGIf7AsK3G+Mi2JTCVFGs=;
 b=Ev6EIxf0n7M8vi8k/883pvGf4f/auC7RojkaSpBla3XvHHbbt6b0m2P96Ei02cvVvU
 mgKWzMQFxB8VIeIqIxkOE362LjefsgV6OuM8YEiEEGO2F7xzN2K8iHQrMkuefe2/z/fm
 Sa8BwVXc6YJ2SryRG0++LQm0rz/gm70XYyABAT4pQsVHU55jO1Wi8To370Zj22mGzhcC
 3jBIXJvw5iVHxCVFIXkmxLWHqoBCjfJWRsa5vPu2AnfG55lVIqvO+LVRr73TPkQn7xRO
 eLdEk1cjZUtNNAvgrzk9cMSsFMhcSgT+G0FV5VHigdezx7zcveYsMjzPqsRHndr+DnYg
 F9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JvfZllGqlVqD0CA01I4iiAGGIf7AsK3G+Mi2JTCVFGs=;
 b=BijTuBRwSjGwSNi14f8KlFGABqdN7yRnoz/WLxBzst1IalRkHsFdfVm6L169yGM25c
 GZM9Yz5guRQZswkeVkDR1w7LtBBtwnDH8EY0zZeb1F/4ZRknCA4M+PUfP0K6vlAV4beE
 lxzFrN+OHUqf3xHKkcW35UeSekZVUksJhCq58o7wK/eHm5b5uN96TKHRDLw8qB0MJnyj
 07dL4aEmrjExbZz+Dw9VFrKpyhQ+0gnFKj2tYYEYaCWd4SW0k8SBC5UkC7kVymT7eQCU
 o7xrtRbdiPg7WC1hqatNa/khTwLfzpFdZucHdlXZA58C37pq0+R5MvCQU/GFhaue90oy
 UI0A==
X-Gm-Message-State: AOAM531z69nohJWG5KZvJ9u/TG2pKIwitRCxFywH9TRuq6UWqVexHpzi
 ANN5h0DBax+1TpJhzcOHHvnRdVrlZVTpMw==
X-Google-Smtp-Source: ABdhPJzznIN/8OJep7ud9Q4C+BKgFVHoZ5n1+ORPSjXJtkUQcyJiQdPFj6K3XWCxnGLCYxgdyd6jjQ==
X-Received: by 2002:aa7:9795:: with SMTP id o21mr1820676pfp.26.1598890040779; 
 Mon, 31 Aug 2020 09:07:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/76] target/microblaze: Store "current" iflags in insn_start
Date: Mon, 31 Aug 2020 09:05:42 -0700
Message-Id: <20200831160601.833692-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This data is available during exception unwinding, thus
we can restore it from there directly, rather than saving
it during the TB.  Thus we may remove the t_sync_flags()
calls in the load/store operations.

Note that these calls were missing from the other places
where runtime exceptions may be raised, such as idiv and
the floating point operations.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  2 ++
 target/microblaze/translate.c | 24 +++++++++++++-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a5df1fa28f..83fadd36a5 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -228,6 +228,8 @@ typedef struct CPUMBState CPUMBState;
 #define STREAM_CONTROL   (1 << 3)
 #define STREAM_NONBLOCK  (1 << 4)
 
+#define TARGET_INSN_START_EXTRA_WORDS 1
+
 struct CPUMBState {
     uint32_t btaken;
     uint32_t btarget;
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 97a436c8d5..d2ee163294 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -58,6 +58,9 @@ typedef struct DisasContext {
     DisasContextBase base;
     MicroBlazeCPU *cpu;
 
+    /* TCG op of the current insn_start.  */
+    TCGOp *insn_start;
+
     TCGv_i32 r0;
     bool r0_set;
 
@@ -71,7 +74,7 @@ typedef struct DisasContext {
 
     unsigned int cpustate_changed;
     unsigned int delayed_branch;
-    unsigned int tb_flags, synced_flags; /* tb dependent flags.  */
+    unsigned int tb_flags;
     unsigned int clear_imm;
     int mem_index;
 
@@ -96,12 +99,11 @@ static int typeb_imm(DisasContext *dc, int x)
 /* Include the auto-generated decoder.  */
 #include "decode-insns.c.inc"
 
-static inline void t_sync_flags(DisasContext *dc)
+static void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
-    if (dc->tb_flags != dc->synced_flags) {
-        tcg_gen_movi_i32(cpu_iflags, dc->tb_flags);
-        dc->synced_flags = dc->tb_flags;
+    if ((dc->tb_flags ^ dc->base.tb->flags) & ~MSR_TB_MASK) {
+        tcg_gen_movi_i32(cpu_iflags, dc->tb_flags & ~MSR_TB_MASK);
     }
 }
 
@@ -770,7 +772,6 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
         }
     }
 
-    t_sync_flags(dc);
     sync_jmpstate(dc);
 
     /*
@@ -893,7 +894,6 @@ static bool trans_lwx(DisasContext *dc, arg_typea *arg)
     /* lwx does not throw unaligned access errors, so force alignment */
     tcg_gen_andi_tl(addr, addr, ~3);
 
-    t_sync_flags(dc);
     sync_jmpstate(dc);
 
     tcg_gen_qemu_ld_i32(cpu_res_val, addr, dc->mem_index, MO_TEUL);
@@ -929,7 +929,6 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
         }
     }
 
-    t_sync_flags(dc);
     sync_jmpstate(dc);
 
     tcg_gen_qemu_st_i32(reg_for_read(dc, rd), addr, mem_index, mop);
@@ -1046,7 +1045,6 @@ static bool trans_swx(DisasContext *dc, arg_typea *arg)
     TCGLabel *swx_fail = gen_new_label();
     TCGv_i32 tval;
 
-    t_sync_flags(dc);
     sync_jmpstate(dc);
 
     /* swx does not throw unaligned access errors, so force alignment */
@@ -1655,7 +1653,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     int bound;
 
     dc->cpu = cpu;
-    dc->synced_flags = dc->tb_flags = dc->base.tb->flags;
+    dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
     dc->jmp = dc->delayed_branch ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
@@ -1675,7 +1673,10 @@ static void mb_tr_tb_start(DisasContextBase *dcb, CPUState *cs)
 
 static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
 {
-    tcg_gen_insn_start(dcb->pc_next);
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+
+    tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
+    dc->insn_start = tcg_last_op();
 }
 
 static bool mb_tr_breakpoint_check(DisasContextBase *dcb, CPUState *cs,
@@ -1917,4 +1918,5 @@ void restore_state_to_opc(CPUMBState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     env->pc = data[0];
+    env->iflags = data[1];
 }
-- 
2.25.1


