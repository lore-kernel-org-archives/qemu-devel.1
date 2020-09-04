Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2B3C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 126D420684
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 19:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1SBqr5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126D420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEHC1-0004jN-S7
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 15:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH5E-0002AW-UK
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEH5D-0000rz-3Q
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 15:09:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id k15so5097563pfc.12
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 12:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eQ3iwBZyN+fYD1otNJTbsrzs1UqXrhzf0NCiu+0zRvU=;
 b=C1SBqr5SckSyhKJ1r0VZLFFOW2MhCwnJfhyPA0S78ZD11VALisLyuDF4RlFAz82KJl
 EzKiYP/wOxfKGSdee3zZQHqHcgqTqxRRHYuoxFVFxJ/WlxEW+IRUe4WpB7fp2fujnHZV
 5aEtWrKk6JbZgnU0NiGT3ONwXszg8UtnccFlS7/pJAUp+UzWbIO8fDSGsuEBLgQD3oP7
 s6uheY3hGjVojf7kiVpK+0Idy662mQMTMTSK/WPfqsy8QXudGKIothU+whJ/4/mvyXWf
 9IJsHvfA9KE1WqWyIBWADBwSoH2zKFMPTA7JKOmUptwXitb/oOlqkA+b57n5q3jhYi4a
 yytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eQ3iwBZyN+fYD1otNJTbsrzs1UqXrhzf0NCiu+0zRvU=;
 b=NvR11JYnU2BkzjeVXRrowwMiZU89H/jeJu7CsRWvk1DY5a9egxRqoHx/1aB6roDcCs
 mlndm9lWCKqKQhp5aYeVVrWhJ9fPpmquaGdsOwomunV2C7/XlRqbOaAm8/ZGOY4rGWzk
 n/wSIJV6hsFngtdvi7tPXTAR1s+GDBOn/mI/pnxfLlEuL7LGBXU+P4etWxyuI7gYM3AU
 diUvEDexmzHl+pYKKRNfdhEPFQv/K3XvqxHGd6LebeZpomimpe9aoJg1PUd64372hn8q
 f7G6rdANp4+kH6xadbWPn7lpE5zB4K1SzSMR0Yjrzuh+Xf7iEtdNmax/L0OsmOlF0r85
 LPzA==
X-Gm-Message-State: AOAM530QuMP3THhkWORjCRSyUhGAK0TBzFAh2VwDQkYDEiuj07eXLAvr
 czlyRkoh7ePW4CLNB3GPGvJgWGSTK5V6cw==
X-Google-Smtp-Source: ABdhPJwcgRUjQc/HdqvDUGAAFz263zVLd8Me3KNges+T8wZOdL4+VbC1N1d2a/qLbUHr+l+V17/qrw==
X-Received: by 2002:a63:a709:: with SMTP id d9mr8659878pgf.168.1599246549310; 
 Fri, 04 Sep 2020 12:09:09 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x19sm1897941pge.22.2020.09.04.12.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 12:09:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 18/19] target/microblaze: Put MicroBlazeCPUConfig into
 DisasContext
Date: Fri,  4 Sep 2020 12:08:41 -0700
Message-Id: <20200904190842.2282109-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904190842.2282109-1-richard.henderson@linaro.org>
References: <20200904190842.2282109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: edgar.iglesias@xilinx.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The bulk of the translator should not have access to the
complete cpu state, to avoid the temptation to examine bits
that are in run time, but not translation time context.

We do need access to the constant cpu configuration, and
that is sufficient, so put that into DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index eca422b3db..abfcc7e6c8 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -60,7 +60,7 @@ static TCGv_i32 cpu_res_val;
 /* This is the state at translation time.  */
 typedef struct DisasContext {
     DisasContextBase base;
-    MicroBlazeCPU *cpu;
+    const MicroBlazeCPUConfig *cfg;
 
     /* TCG op of the current insn_start.  */
     TCGOp *insn_start;
@@ -159,7 +159,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 static bool trap_illegal(DisasContext *dc, bool cond)
 {
     if (cond && (dc->tb_flags & MSR_EE)
-        && dc->cpu->cfg.illegal_opcode_exception) {
+        && dc->cfg->illegal_opcode_exception) {
         gen_raise_hw_excp(dc, ESR_EC_ILLEGAL_OP);
     }
     return cond;
@@ -291,7 +291,7 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
 
 #define DO_TYPEA_CFG(NAME, CFG, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
-    { return dc->cpu->cfg.CFG && do_typea(dc, a, SE, FN); }
+    { return dc->cfg->CFG && do_typea(dc, a, SE, FN); }
 
 #define DO_TYPEA0(NAME, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typea0 *a) \
@@ -299,7 +299,7 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
 
 #define DO_TYPEA0_CFG(NAME, CFG, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typea0 *a) \
-    { return dc->cpu->cfg.CFG && do_typea0(dc, a, SE, FN); }
+    { return dc->cfg->CFG && do_typea0(dc, a, SE, FN); }
 
 #define DO_TYPEBI(NAME, SE, FNI) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
@@ -307,7 +307,7 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
 
 #define DO_TYPEBI_CFG(NAME, CFG, SE, FNI) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
-    { return dc->cpu->cfg.CFG && do_typeb_imm(dc, a, SE, FNI); }
+    { return dc->cfg->CFG && do_typeb_imm(dc, a, SE, FNI); }
 
 #define DO_TYPEBV(NAME, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
@@ -683,7 +683,7 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
         tcg_gen_movi_tl(ret, 0);
     }
 
-    if ((ra == 1 || rb == 1) && dc->cpu->cfg.stackprot) {
+    if ((ra == 1 || rb == 1) && dc->cfg->stackprot) {
         gen_helper_stackprot(cpu_env, ret);
     }
     return ret;
@@ -703,7 +703,7 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
         tcg_gen_movi_tl(ret, (uint32_t)imm);
     }
 
-    if (ra == 1 && dc->cpu->cfg.stackprot) {
+    if (ra == 1 && dc->cfg->stackprot) {
         gen_helper_stackprot(cpu_env, ret);
     }
     return ret;
@@ -712,7 +712,7 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 #ifndef CONFIG_USER_ONLY
 static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 {
-    int addr_size = dc->cpu->cfg.addr_size;
+    int addr_size = dc->cfg->addr_size;
     TCGv ret = tcg_temp_new();
 
     if (addr_size == 32 || ra == 0) {
@@ -772,7 +772,7 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
-        dc->cpu->cfg.unaligned_exceptions) {
+        dc->cfg->unaligned_exceptions) {
         record_unaligned_ess(dc, rd, size, false);
         mop |= MO_ALIGN;
     }
@@ -918,7 +918,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
-        dc->cpu->cfg.unaligned_exceptions) {
+        dc->cfg->unaligned_exceptions) {
         record_unaligned_ess(dc, rd, size, true);
         mop |= MO_ALIGN;
     }
@@ -1325,7 +1325,7 @@ DO_RTS(rtsd, 0)
 static bool trans_zero(DisasContext *dc, arg_zero *arg)
 {
     /* If opcode_0_illegal, trap.  */
-    if (dc->cpu->cfg.opcode_0_illegal) {
+    if (dc->cfg->opcode_0_illegal) {
         trap_illegal(dc, true);
         return true;
     }
@@ -1658,7 +1658,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     int bound;
 
-    dc->cpu = cpu;
+    dc->cfg = &cpu->cfg;
     dc->tb_flags = dc->base.tb->flags;
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
-- 
2.25.1


