Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AEE6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:21:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC7D21556
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y6XGhVWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC7D21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnrh-0000hu-GI
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37342)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnQ-00082M-4M
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:08 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:33171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnO-0002Db-0v
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:07 -0400
Received: by mail-pj1-x1029.google.com with SMTP id md22so473180pjb.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=W2Y3ZHQJCdZHuqmnkSlt2vnfygEUmtT0oY/lhiXUYbI=;
 b=y6XGhVWUJhO/ZRRjICQprkVRKJksalYNbdPWalE+iW94gKTVGlTSwbsGfQEw/HznCM
 b3oMYBgDiiHgc8gWi0BBAMXTxrYrkUFpmWkUfCqE6Q8tdpd9hMKFw5nmFaUfC0cJLSm4
 nE/bkCb61wzh/r6nUnYANAq9nQHSdj3WCNLlkFrvg8s2UNnlSkr6mhnTu1aX4vYj2CVz
 YXiipk1mMgigOBAnaG4B14r3U9Ozd1lj7LJ98QoZ0lzTic+XYiNVn6gVvYwyAsyad0Cn
 WFScv0OghMmVFs2TjJQn0GxkdpLkOUQ/pyR3lu22jR4ajkxOjvGuXG7AVodOMdu8M5bu
 kycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W2Y3ZHQJCdZHuqmnkSlt2vnfygEUmtT0oY/lhiXUYbI=;
 b=fKN4KoiXvlS1/5awRvFYG++SaMhhOu4yxDuRvzpEb3naXltZzP0ravzEc3WgITywbQ
 a5neh2FIpAdZW78tN9en3NAwOQdaTddeMLKrG6mMp0+nP/lBzOMJMqtqXa6Fd4YNdkw+
 9nfaYcHQ1vZfQEk8oP4JeX3K32YgtnjKD07fasoi3coLSN/ozYFg8cxaDKxCnfbMZR6K
 +m5SVf1MnlJGnmbL391GusuAazCowE3dEGkT3zWrSAngZb68bIvoPAzC8kYMGRmBcgjL
 mfQ3BWa8IhRpsr0W8BGa7nOLOs9romhnEs20BhPEMOpmLyYZN8NQnx13fOYQ9l4qLMO2
 pddA==
X-Gm-Message-State: AOAM5311HG4vOo0xNekwiuv4+ynO5ATSMfQkuXJkrjj9dkYuAna3xAkD
 GwZDbtNkc+Sd3bMFMFuxPgnn2vkkJW95vw==
X-Google-Smtp-Source: ABdhPJw9MGTq7d/3bPkOt7+1aArNkbAAqS/J/Yb1X37rFVFdNMCRcjZOLERl/rpx5RRwgiDs7geBKA==
X-Received: by 2002:a17:90a:af84:: with SMTP id
 w4mr1185258pjq.94.1599610624125; 
 Tue, 08 Sep 2020 17:17:04 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/43] tcg: Increase tcg_out_dupi_vec immediate to int64_t
Date: Tue,  8 Sep 2020 17:16:16 -0700
Message-Id: <20200909001647.532249-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we don't store more than tcg_target_long in TCGTemp,
we shouldn't be limited to that for code generation.  We will
be able to use this for INDEX_op_dup2_vec with 2 constants.

Also pass along the minimal vece that may be said to apply
to the constant.  This allows some simplification in the
various backends.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                    | 31 +++++++++++++++++++++++++-----
 tcg/aarch64/tcg-target.c.inc | 12 ++++++------
 tcg/i386/tcg-target.c.inc    | 22 ++++++++++++---------
 tcg/ppc/tcg-target.c.inc     | 37 +++++++++++++++++++++++-------------
 4 files changed, 69 insertions(+), 33 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 84bdcc6537..6474a695f2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -116,8 +116,8 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src);
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                              TCGReg dst, TCGReg base, intptr_t offset);
-static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg dst, tcg_target_long arg);
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg dst, int64_t arg);
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
                            unsigned vece, const TCGArg *args,
                            const int *const_args);
@@ -132,8 +132,8 @@ static inline bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
 {
     g_assert_not_reached();
 }
-static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                                    TCGReg dst, tcg_target_long arg)
+static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
+                                    TCGReg dst, int64_t arg)
 {
     g_assert_not_reached();
 }
@@ -3308,7 +3308,28 @@ static void temp_load(TCGContext *s, TCGTemp *ts, TCGRegSet desired_regs,
         if (ts->type <= TCG_TYPE_I64) {
             tcg_out_movi(s, ts->type, reg, ts->val);
         } else {
-            tcg_out_dupi_vec(s, ts->type, reg, ts->val);
+            uint64_t val = ts->val;
+            MemOp vece = MO_64;
+
+            /*
+             * Find the minimal vector element that matches the constant.
+             * The targets will, in general, have to do this search anyway,
+             * do this generically.
+             */
+            if (TCG_TARGET_REG_BITS == 32) {
+                val = dup_const(MO_32, val);
+                vece = MO_32;
+            }
+            if (val == dup_const(MO_8, val)) {
+                vece = MO_8;
+            } else if (val == dup_const(MO_16, val)) {
+                vece = MO_16;
+            } else if (TCG_TARGET_REG_BITS == 64 &&
+                       val == dup_const(MO_32, val)) {
+                vece = MO_32;
+            }
+
+            tcg_out_dupi_vec(s, ts->type, vece, reg, ts->val);
         }
         ts->mem_coherent = 0;
         break;
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 72c4d25fdb..5692607087 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -853,14 +853,14 @@ static void tcg_out_logicali(TCGContext *s, AArch64Insn insn, TCGType ext,
     tcg_out_insn_3404(s, insn, ext, rd, rn, ext, r, c);
 }
 
-static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg rd, tcg_target_long v64)
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg rd, int64_t v64)
 {
     bool q = type == TCG_TYPE_V128;
     int cmode, imm8, i;
 
     /* Test all bytes equal first.  */
-    if (v64 == dup_const(MO_8, v64)) {
+    if (vece == MO_8) {
         imm8 = (uint8_t)v64;
         tcg_out_insn(s, 3606, MOVI, q, rd, 0, 0xe, imm8);
         return;
@@ -887,7 +887,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
      * cannot find an expansion there's no point checking a larger
      * width because we already know by replication it cannot match.
      */
-    if (v64 == dup_const(MO_16, v64)) {
+    if (vece == MO_16) {
         uint16_t v16 = v64;
 
         if (is_shimm16(v16, &cmode, &imm8)) {
@@ -906,7 +906,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         tcg_out_insn(s, 3606, MOVI, q, rd, 0, 0x8, v16 & 0xff);
         tcg_out_insn(s, 3606, ORR, q, rd, 0, 0xa, v16 >> 8);
         return;
-    } else if (v64 == dup_const(MO_32, v64)) {
+    } else if (vece == MO_32) {
         uint32_t v32 = v64;
         uint32_t n32 = ~v32;
 
@@ -2430,7 +2430,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                         tcg_out_insn_3617(s, insn, is_q, vece, a0, a1);
                         break;
                     }
-                    tcg_out_dupi_vec(s, type, TCG_VEC_TMP, 0);
+                    tcg_out_dupi_vec(s, type, MO_8, TCG_VEC_TMP, 0);
                     a2 = TCG_VEC_TMP;
                 }
                 insn = cmp_insn[cond];
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index e2852cbb09..6b7cbaa47a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -933,8 +933,8 @@ static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
     return true;
 }
 
-static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
-                             TCGReg ret, tcg_target_long arg)
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg ret, int64_t arg)
 {
     int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
 
@@ -947,7 +947,14 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         return;
     }
 
-    if (TCG_TARGET_REG_BITS == 64) {
+    if (TCG_TARGET_REG_BITS == 32 && vece < MO_64) {
+        if (have_avx2) {
+            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTD + vex_l, ret);
+        } else {
+            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
+        }
+        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
+    } else {
         if (type == TCG_TYPE_V64) {
             tcg_out_vex_modrm_pool(s, OPC_MOVQ_VqWq, ret);
         } else if (have_avx2) {
@@ -955,14 +962,11 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
         } else {
             tcg_out_vex_modrm_pool(s, OPC_MOVDDUP, ret);
         }
-        new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
-    } else {
-        if (have_avx2) {
-            tcg_out_vex_modrm_pool(s, OPC_VPBROADCASTD + vex_l, ret);
+        if (TCG_TARGET_REG_BITS == 64) {
+            new_pool_label(s, arg, R_386_PC32, s->code_ptr - 4, -4);
         } else {
-            tcg_out_vex_modrm_pool(s, OPC_VBROADCASTSS, ret);
+            new_pool_l2(s, R_386_32, s->code_ptr - 4, 0, arg, arg >> 32);
         }
-        new_pool_label(s, arg, R_386_32, s->code_ptr - 4, 0);
     }
 }
 
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index bc6fb09adb..ff56f1971f 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -908,31 +908,41 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 }
 
-static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
-                             tcg_target_long val)
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg ret, int64_t val)
 {
     uint32_t load_insn;
     int rel, low;
     intptr_t add;
 
-    low = (int8_t)val;
-    if (low >= -16 && low < 16) {
-        if (val == (tcg_target_long)dup_const(MO_8, low)) {
+    switch (vece) {
+    case MO_8:
+        low = (int8_t)val;
+        if (low >= -16 && low < 16) {
             tcg_out32(s, VSPLTISB | VRT(ret) | ((val & 31) << 16));
             return;
         }
-        if (val == (tcg_target_long)dup_const(MO_16, low)) {
+        if (have_isa_3_00) {
+            tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11));
+            return;
+        }
+        break;
+
+    case MO_16:
+        low = (int16_t)val;
+        if (low >= -16 && low < 16) {
             tcg_out32(s, VSPLTISH | VRT(ret) | ((val & 31) << 16));
             return;
         }
-        if (val == (tcg_target_long)dup_const(MO_32, low)) {
+        break;
+
+    case MO_32:
+        low = (int32_t)val;
+        if (low >= -16 && low < 16) {
             tcg_out32(s, VSPLTISW | VRT(ret) | ((val & 31) << 16));
             return;
         }
-    }
-    if (have_isa_3_00 && val == (tcg_target_long)dup_const(MO_8, val)) {
-        tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11));
-        return;
+        break;
     }
 
     /*
@@ -952,14 +962,15 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
         if (TCG_TARGET_REG_BITS == 64) {
             new_pool_label(s, val, rel, s->code_ptr, add);
         } else {
-            new_pool_l2(s, rel, s->code_ptr, add, val, val);
+            new_pool_l2(s, rel, s->code_ptr, add, val >> 32, val);
         }
     } else {
         load_insn = LVX | VRT(ret) | RB(TCG_REG_TMP1);
         if (TCG_TARGET_REG_BITS == 64) {
             new_pool_l2(s, rel, s->code_ptr, add, val, val);
         } else {
-            new_pool_l4(s, rel, s->code_ptr, add, val, val, val, val);
+            new_pool_l4(s, rel, s->code_ptr, add,
+                        val >> 32, val, val >> 32, val);
         }
     }
 
-- 
2.25.1


