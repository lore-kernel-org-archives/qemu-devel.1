Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BB2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE81206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kFRER9Dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE81206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAghg-00029C-JJ
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg42-00008S-T0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:08 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg40-000205-45
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:06 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ls14so122955pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RvFJSD7Zh4rSxdM1y2eF+nLQTn/KQL07U6ICYBiMb68=;
 b=kFRER9DxURxEDgZHd7YIls5QJIoQuf5VY76p0sYQWvgvG30AC/w4r0qgKGCCbRshOq
 3xPCwnwPVH4THKI+nuHNpCdaTKZEzpBKONg/7utJb0r5ahOUj/evI/P9cUeMyPu3kRWo
 eQFqoMkIUXNutGmyH41oqKTb9ykpl8UjBhm4HxhNr1MYRmIqTdDSmu6++daJyzMJLsPN
 tnhydTFtk0xrs+op55sLV4gOZRdFLRUoAiwJ1aHZANTBNNQ96RdfUghAFOkcs1rnzDMK
 K1HoXStMGS8AUKwglwal5ZvfJTdDGtdykgzIWsQqjuRZX2iNNiKVS/ZTuYDIy38zeMmO
 DRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RvFJSD7Zh4rSxdM1y2eF+nLQTn/KQL07U6ICYBiMb68=;
 b=slKzL3mSMsKta4qPRdkmgv6m4+1+3bLx7UyYoxDxsYKO0yCL0ye+r8vLrUlESldOMF
 SSc7qwJ7IYcrmUkTjc0qKJvBqHr7P1W86sfmmhsp7Yf6Qvp2dSfBTnnuagk94ijgWeWw
 QkmvvfsXeTAcPwb75j82wB/I+1HAzwCQIn8tUmRVwQpirHvFqDECpPjuzT1Wy/L74X9h
 gkacLmHsFvi7Yol910V6K4y5i5zhFFcJqX9NuiD3jzvDEAFgGQneKiMmQJAHR0K7PAAE
 lvyYHWr1EpJ1NHM3pE5T77tHQdWvdaLlzzi6KuBZY2OwaR7DeMBjxsjl5cPtKEfTrVUX
 79Tg==
X-Gm-Message-State: AOAM530YRBtP8q+fzffvz74FrZudptUJLmcAiMvSC4C77SnZtJwYT1uq
 sY2WY34aqUz1EC7vayzbREdefcfXel2vjA==
X-Google-Smtp-Source: ABdhPJwxSah2AsMJMCzFF8mNxcJsHCH0YcWffJr1X7m3hdpNOZSdfSIeCp4DAwisxNRQDmwM3hYkLA==
X-Received: by 2002:a17:90a:fc98:: with SMTP id
 ci24mr3152772pjb.101.1598389262443; 
 Tue, 25 Aug 2020 14:01:02 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 56/77] target/microblaze: Store "current" iflags in insn_start
Date: Tue, 25 Aug 2020 13:59:29 -0700
Message-Id: <20200825205950.730499-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

This data is available during exception unwinding, thus
we can restore it from there directly, rather than saving
it during the TB.  Thus we may remove the t_sync_flags()
calls in the load/store operations.

Note that these calls were missing from the other places
where runtime exceptions may be raised, such as idiv and
the floating point operations.

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
index 7fd1efd3fb..930b8a9600 100644
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
@@ -1647,7 +1645,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     int bound;
 
     dc->cpu = cpu;
-    dc->synced_flags = dc->tb_flags = dc->base.tb->flags;
+    dc->tb_flags = dc->base.tb->flags;
     dc->delayed_branch = !!(dc->tb_flags & D_FLAG);
     dc->jmp = dc->delayed_branch ? JMP_INDIRECT : JMP_NOJMP;
     dc->cpustate_changed = 0;
@@ -1667,7 +1665,10 @@ static void mb_tr_tb_start(DisasContextBase *dcb, CPUState *cs)
 
 static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
 {
-    tcg_gen_insn_start(dcb->pc_next);
+    DisasContext *dc = container_of(dcb, DisasContext, base);
+
+    tcg_gen_insn_start(dc->base.pc_next, dc->tb_flags & ~MSR_TB_MASK);
+    dc->insn_start = tcg_last_op();
 }
 
 static bool mb_tr_breakpoint_check(DisasContextBase *dcb, CPUState *cs,
@@ -1909,4 +1910,5 @@ void restore_state_to_opc(CPUMBState *env, TranslationBlock *tb,
                           target_ulong *data)
 {
     env->pc = data[0];
+    env->iflags = data[1];
 }
-- 
2.25.1


