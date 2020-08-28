Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3DDC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5819F207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuZ64azi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5819F207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfgy-0007qM-Kr
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFH-0001o0-Pf
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:47 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfFF-0005Nk-Mt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:47 -0400
Received: by mail-pl1-x641.google.com with SMTP id j11so522473plk.9
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WdEFi+R7EYBujKDXCMlxM8N86OEUIuERS99vJP4r/ZY=;
 b=XuZ64aziDli3AE/LOOJNGgV5PG5yY2BybIXNRjRtjmVvvAKdu3B2WEacbPwvuN7JhR
 dLTEWClgwAF0thY5JWPl0KX45iaP5XcXsdceuXtndawhRWFh8sSWc4hLjDVpy+dhMeyD
 Rnan7PL8rwWEYZIJ1qdQKhuWptRF29KIfqGQsS4SMwePh3R1/QeUUs5La1JIAjCVjh/f
 A22t0HvCjNLzDB0Ed+tOFEK1ogIdzVOgwcv8gjdhvhNIdZ1gOcPvFCH83BCk4y6pjRSz
 8Yhgx2EdFY3negU//XJL5BPFWPzkGGoW1ZIpDZDhYInLoY6wCGddr6p6ZtU9j5r5xXtQ
 kcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WdEFi+R7EYBujKDXCMlxM8N86OEUIuERS99vJP4r/ZY=;
 b=ZhR6ddfu9PaK2/C228APyrBoatt0yV/lXDby4UIPrISAUEvMUFHXow7jtEIGgz8p12
 /GWlUYBX0+ca2MKr7pKeCX7toaIfLstNDjh0WIOJ5iwcNgZi/2HLG8vCbN72Ch4tjWa1
 +phEcRj1SdUkTYW/9sMGLXMXTiLCZ3DDV0lIwv0QjbnS3e/xjHB9OaCmBpx+HL+OGPIv
 zPy4Mj6gaOIVRD+0n7UcS41esX2x13OMRYiZXp4VCTTfv8vKVGtgumkddKFcclev/lj+
 MUU8ygdkD9Mg0Oztc9xImrLXRz56xjkatoCf7UVpI+9THJXpeVxcY+0kMwH4kMLJemeE
 DwsA==
X-Gm-Message-State: AOAM530pdoT7Sogs1NT1g1IpbYQZEusiS8c4EQSXcvaQdtdXiyehY3pK
 kSI4Q8SNYCM8RA6wiPcfF+PznkrKE1mQAw==
X-Google-Smtp-Source: ABdhPJzBYPaHpNFOFiVCiVbQwj7GOYC1UugJTKf407nR2zZJ0OSLRhQx4GnBb0PdKYcjOZVZ4UbT6A==
X-Received: by 2002:a17:902:aa04:: with SMTP id
 be4mr1501377plb.294.1598624443915; 
 Fri, 28 Aug 2020 07:20:43 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 57/76] target/microblaze: Store "current" iflags in
 insn_start
Date: Fri, 28 Aug 2020 07:19:10 -0700
Message-Id: <20200828141929.77854-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
Cc: edgar.iglesias@xilinx.com
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


