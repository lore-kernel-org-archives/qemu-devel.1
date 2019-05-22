Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F1EC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65F720881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="znq81cNx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65F720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZxJ-0005Bw-7U
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:43:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj5-0003Ai-Cx
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZj3-0007Rv-T4
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:47 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30]:46061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZj3-0007PU-LX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:45 -0400
Received: by mail-yb1-xb30.google.com with SMTP id e128so1480256ybc.12
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AirXKI1PS8HjM151RJTWK1/DcdzF7g0f+0zrycENkFI=;
	b=znq81cNxYJ9g9UuAhySNCaQGt5NzrUBrLXec0wgVcvco3cbRyvXp4gn5o8PFqAKx4V
	bjrU9tGZAHQFK9yhYYM0HVrRoXqNgMD/bw1NQZx+Var/9j8x5jx18Cvu8l9PZcRqRHKr
	yG3bbV+Esbu4eujiqBkquTs/rol4gBu4CIRrX4NyC4wBXqol+gBXkZdLUMV0OJPl0xvz
	XRwFKLq1/Ss6uq7Gx4yOiiP9QpusQEFrxxocaDqnYvTK0MyCs6fssDYmbgtOHmwbkePz
	YndSUmtk0nKdc1jqH9oXIQAIRZ9eRcflCiQoXEk/a7rlh12udjwHDkCugQLM2d0WnwEK
	7gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AirXKI1PS8HjM151RJTWK1/DcdzF7g0f+0zrycENkFI=;
	b=oFz0Nuej9wNzk3H3+EHhtF5CvDks4f86USAPtgCEd4OczAAu/Kg4BLVt6Ml/nxX9mJ
	ZijGLoEmq0aQ9LySI+VLk610Co8ArmOebY65HJEvr4vrtnezfObKm9Zlq6XhzYRTaSyd
	7Dq+Z7fMoQcpel5YsdJhSmEPNpNVPRMlpS1lQoMAepGFPF04HE5rZY2EFU1vxEtZ1CNk
	YrLU7L/mmjMTSSyeYuQAsoyactZIobxUcbUCFkiSkFi6uVY0C3MoiAxgNFHmOENoYdZf
	hZOGmXRVEyQ/j9zrA9mE3DQ3MPx1xfYxz8qBS7e1wI+lE9t4b1WnoK9/+9PlA9Q1pc5X
	D0aw==
X-Gm-Message-State: APjAAAUrwibEf91Cd3u6yF+86yDHBDNJ9kxWycy8B4jgJTLttOlMZ7QL
	vEWNYL9NvWcwghun5JQSgPeu+slmSY8=
X-Google-Smtp-Source: APXvYqxs+L0/WtRjtAG7ArO9YVkIBWt5CcffmqSEoS1ZrmMgzeGSxkrB2kW1mLmHfzPNWUFy+HuYgg==
X-Received: by 2002:a25:7502:: with SMTP id q2mr22709271ybc.31.1558564120013; 
	Wed, 22 May 2019 15:28:40 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:20 -0400
Message-Id: <20190522222821.23850-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b30
Subject: [Qemu-devel] [PULL 15/16] tcg/aarch64: Allow immediates for vector
 ORR and BIC
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The allows immediates to be used for ORR and BIC,
as well as the trivial inversions, ORC and AND.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 90 +++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 7 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 52c18074ae..9e1dad9696 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -119,6 +119,8 @@ static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_LIMM 0x200
 #define TCG_CT_CONST_ZERO 0x400
 #define TCG_CT_CONST_MONE 0x800
+#define TCG_CT_CONST_ORRI 0x1000
+#define TCG_CT_CONST_ANDI 0x2000
 
 /* parse target specific constraints */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
@@ -154,6 +156,12 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'M': /* minus one */
         ct->ct |= TCG_CT_CONST_MONE;
         break;
+    case 'O': /* vector orr/bic immediate */
+        ct->ct |= TCG_CT_CONST_ORRI;
+        break;
+    case 'N': /* vector orr/bic immediate, inverted */
+        ct->ct |= TCG_CT_CONST_ANDI;
+        break;
     case 'Z': /* zero */
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
@@ -293,6 +301,16 @@ static int is_shimm32_pair(uint32_t v32, int *cmode, int *imm8)
     return i;
 }
 
+/* Return true if V is a valid 16-bit or 32-bit shifted immediate.  */
+static bool is_shimm1632(uint32_t v32, int *cmode, int *imm8)
+{
+    if (v32 == deposit32(v32, 16, 16, v32)) {
+        return is_shimm16(v32, cmode, imm8);
+    } else {
+        return is_shimm32(v32, cmode, imm8);
+    }
+}
+
 static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct)
 {
@@ -317,6 +335,23 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
         return 1;
     }
 
+    switch (ct & (TCG_CT_CONST_ORRI | TCG_CT_CONST_ANDI)) {
+    case 0:
+        break;
+    case TCG_CT_CONST_ANDI:
+        val = ~val;
+        /* fallthru */
+    case TCG_CT_CONST_ORRI:
+        if (val == deposit64(val, 32, 32, val)) {
+            int cmode, imm8;
+            return is_shimm1632(val, &cmode, &imm8);
+        }
+        break;
+    default:
+        /* Both bits should not be set for the same insn.  */
+        g_assert_not_reached();
+    }
+
     return 0;
 }
 
@@ -2278,6 +2313,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     TCGType type = vecl + TCG_TYPE_V64;
     unsigned is_q = vecl;
     TCGArg a0, a1, a2, a3;
+    int cmode, imm8;
 
     a0 = args[0];
     a1 = args[1];
@@ -2309,20 +2345,56 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
         break;
     case INDEX_op_and_vec:
+        if (const_args[2]) {
+            is_shimm1632(~a2, &cmode, &imm8);
+            if (a0 == a1) {
+                tcg_out_insn(s, 3606, BIC, is_q, a0, 0, cmode, imm8);
+                return;
+            }
+            tcg_out_insn(s, 3606, MVNI, is_q, a0, 0, cmode, imm8);
+            a2 = a0;
+        }
         tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
         break;
     case INDEX_op_or_vec:
+        if (const_args[2]) {
+            is_shimm1632(a2, &cmode, &imm8);
+            if (a0 == a1) {
+                tcg_out_insn(s, 3606, ORR, is_q, a0, 0, cmode, imm8);
+                return;
+            }
+            tcg_out_insn(s, 3606, MOVI, is_q, a0, 0, cmode, imm8);
+            a2 = a0;
+        }
         tcg_out_insn(s, 3616, ORR, is_q, 0, a0, a1, a2);
         break;
-    case INDEX_op_xor_vec:
-        tcg_out_insn(s, 3616, EOR, is_q, 0, a0, a1, a2);
-        break;
     case INDEX_op_andc_vec:
+        if (const_args[2]) {
+            is_shimm1632(a2, &cmode, &imm8);
+            if (a0 == a1) {
+                tcg_out_insn(s, 3606, BIC, is_q, a0, 0, cmode, imm8);
+                return;
+            }
+            tcg_out_insn(s, 3606, MOVI, is_q, a0, 0, cmode, imm8);
+            a2 = a0;
+        }
         tcg_out_insn(s, 3616, BIC, is_q, 0, a0, a1, a2);
         break;
     case INDEX_op_orc_vec:
+        if (const_args[2]) {
+            is_shimm1632(~a2, &cmode, &imm8);
+            if (a0 == a1) {
+                tcg_out_insn(s, 3606, ORR, is_q, a0, 0, cmode, imm8);
+                return;
+            }
+            tcg_out_insn(s, 3606, MVNI, is_q, a0, 0, cmode, imm8);
+            a2 = a0;
+        }
         tcg_out_insn(s, 3616, ORN, is_q, 0, a0, a1, a2);
         break;
+    case INDEX_op_xor_vec:
+        tcg_out_insn(s, 3616, EOR, is_q, 0, a0, a1, a2);
+        break;
     case INDEX_op_ssadd_vec:
         tcg_out_insn(s, 3616, SQADD, is_q, vece, a0, a1, a2);
         break;
@@ -2505,6 +2577,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
     static const TCGTargetOpDef w_w_w = { .args_ct_str = { "w", "w", "w" } };
+    static const TCGTargetOpDef w_w_wO = { .args_ct_str = { "w", "w", "wO" } };
+    static const TCGTargetOpDef w_w_wN = { .args_ct_str = { "w", "w", "wN" } };
     static const TCGTargetOpDef w_w_wZ = { .args_ct_str = { "w", "w", "wZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_rA = { .args_ct_str = { "r", "r", "rA" } };
@@ -2660,11 +2734,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
     case INDEX_op_mul_vec:
-    case INDEX_op_and_vec:
-    case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
-    case INDEX_op_andc_vec:
-    case INDEX_op_orc_vec:
     case INDEX_op_ssadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
@@ -2691,6 +2761,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &w_r;
     case INDEX_op_dup_vec:
         return &w_wr;
+    case INDEX_op_or_vec:
+    case INDEX_op_andc_vec:
+        return &w_w_wO;
+    case INDEX_op_and_vec:
+    case INDEX_op_orc_vec:
+        return &w_w_wN;
     case INDEX_op_cmp_vec:
         return &w_w_wZ;
     case INDEX_op_bitsel_vec:
-- 
2.17.1


