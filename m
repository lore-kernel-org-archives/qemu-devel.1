Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12503C282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD5621479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmCZJcm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD5621479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkr8-0001Dj-0m
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:56:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXW-00010C-5A
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkXU-0000kk-Ar
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:57 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkXT-0000Vm-Er
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:55 -0400
Received: by mail-pf1-x443.google.com with SMTP id 10so3469439pfo.5
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=mhAi7YY1D/Om/C4ZnAkNiJSYsKDzvLj0JsVFt1Dgh9U=;
	b=zmCZJcm27PstlkuhldKwmMKQmxp9Yzd0x15/C1jtoJKIo2kegOfxWkgX/uLivPsB3G
	1pNV860ee579IRtM9JNNBH1p+aS+mQoZT1Px5z2Hkq5jzaY1JTygSalGcZ1AaCMBKuS0
	9UWEEcxHTE5Y1jbSoUfZzJ7nFJELo2zgrdEwpzz2W83Qh0L6UOxBNkwPXZ4AqieD9KCH
	b1F7DBP8DvPSqRmJ2g7i/jUI/YN3B1M+JtFdqO19p+wka/evm8rvF88Hd53tbSI1Fqx/
	gaJysFbORGKhjKw5d28iW1p5mE/xcGF/aWGADzY84LSq61Rj4P+Ns07bpyLy270UM3Om
	bKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=mhAi7YY1D/Om/C4ZnAkNiJSYsKDzvLj0JsVFt1Dgh9U=;
	b=XaEiN20xyaydgmFqLNTXsiAo9Di34eIDJUuhRL04v4uENACLGkMq+kAiamU4QNPCEO
	dw2RuQCJEvwyUE4ZHvITd2p2/S9CAGz87CVMou51e1Kr5qp8quFwsRGKNYvcNYUpVuf1
	pq8yEwNXGy8FCFiOax+mziQ5Nz6DdyJxMGpZVE3S6sSx3hF/mGfcsUpK+c2mqmVFzwu5
	nv5sR+KJiqjHUP0zr2pZPokbqQd+j0lQ/wMOoBaOQSZQTrD7kQ0HQKC9cYh+S4NxGkiO
	pSwmJX+lsAn5a8D6x4fsQ/ljV4KXlUTukYK6k/jySGZeL5WXZjG/mqQaByBIg34gpxwx
	ynzw==
X-Gm-Message-State: APjAAAUVUrw7CeBkJoxols3NmpZYZt2PZ2KmvrJBccPr9rtrkpfvaeSx
	lQS1o6m53m906TCf98lNMa9ZLMCEcQ8=
X-Google-Smtp-Source: APXvYqyWHcPB//FAjqmE4cTgRzm7yJmRnpvRYEC1xQIhmI/c5wz3ijO3246VyUGmrFw7H80dnsdGDg==
X-Received: by 2002:a65:5106:: with SMTP id f6mr8138632pgq.253.1555745745442; 
	Sat, 20 Apr 2019 00:35:45 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:42 -1000
Message-Id: <20190420073442.7488-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH 38/38] tcg/aarch64: Use ORRI and BICI for
 vector logical operations
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073442.cerEUlQnFW0FlOyfnSrjaKdd2ilkqY2OyzIOKegCtmA@z>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c | 77 ++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index 20c8699f79..1e79a60fb2 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -119,6 +119,8 @@ static inline bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_LIMM 0x200
 #define TCG_CT_CONST_ZERO 0x400
 #define TCG_CT_CONST_MONE 0x800
+#define TCG_CT_CONST_PVI  0x1000
+#define TCG_CT_CONST_IVI  0x2000
 
 /* parse target specific constraints */
 static const char *target_parse_constraint(TCGArgConstraint *ct,
@@ -154,6 +156,12 @@ static const char *target_parse_constraint(TCGArgConstraint *ct,
     case 'M': /* minus one */
         ct->ct |= TCG_CT_CONST_MONE;
         break;
+    case 'P': /* vector positive immediate */
+        ct->ct |= TCG_CT_CONST_PVI;
+        break;
+    case 'I': /* vector inverted immediate */
+        ct->ct |= TCG_CT_CONST_IVI;
+        break;
     case 'Z': /* zero */
         ct->ct |= TCG_CT_CONST_ZERO;
         break;
@@ -294,6 +302,7 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
                                   const TCGArgConstraint *arg_ct)
 {
     int ct = arg_ct->ct;
+    int op, cmode, imm8;
 
     if (ct & TCG_CT_CONST) {
         return 1;
@@ -313,6 +322,16 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
     if ((ct & TCG_CT_CONST_MONE) && val == -1) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_PVI) &&
+        is_fimm(val, &op, &cmode, &imm8) &&
+        op == 0 && ((1 << cmode) & 0x555)) {
+        return 1;
+    }
+    if ((ct & TCG_CT_CONST_IVI) &&
+        is_fimm(~val, &op, &cmode, &imm8) &&
+        op == 0 && ((1 << cmode) & 0x555)) {
+        return 1;
+    }
 
     return 0;
 }
@@ -514,6 +533,8 @@ typedef enum {
     /* AdvSIMD modified immediate */
     I3606_MOVI      = 0x0f000400,
     I3606_MVNI      = 0x2f000400,
+    I3606_ORRI      = 0x0f001400,
+    I3606_BICI      = 0x2f001400,
 
     /* AdvSIMD shift by immediate */
     I3614_SSHR      = 0x0f000400,
@@ -2217,20 +2238,48 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_insn(s, 3617, ABS, is_q, vece, a0, a1);
         break;
     case INDEX_op_and_vec:
-        tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
+        if (const_args[2]) {
+            int op, cmode, imm8;
+            is_fimm(~a2, &op, &cmode, &imm8);
+            tcg_out_mov(s, type, a0, a1);
+            tcg_out_insn(s, 3606, BICI, is_q, a0, 0, cmode, imm8);
+        } else {
+            tcg_out_insn(s, 3616, AND, is_q, 0, a0, a1, a2);
+        }
         break;
     case INDEX_op_or_vec:
-        tcg_out_insn(s, 3616, ORR, is_q, 0, a0, a1, a2);
+        if (const_args[2]) {
+            int op, cmode, imm8;
+            is_fimm(a2, &op, &cmode, &imm8);
+            tcg_out_mov(s, type, a0, a1);
+            tcg_out_insn(s, 3606, ORRI, is_q, a0, 0, cmode, imm8);
+        } else {
+            tcg_out_insn(s, 3616, ORR, is_q, 0, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_andc_vec:
+        if (const_args[2]) {
+            int op, cmode, imm8;
+            is_fimm(a2, &op, &cmode, &imm8);
+            tcg_out_mov(s, type, a0, a1);
+            tcg_out_insn(s, 3606, BICI, is_q, a0, 0, cmode, imm8);
+        } else {
+            tcg_out_insn(s, 3616, BIC, is_q, 0, a0, a1, a2);
+        }
+        break;
+    case INDEX_op_orc_vec:
+        if (const_args[2]) {
+            int op, cmode, imm8;
+            is_fimm(~a2, &op, &cmode, &imm8);
+            tcg_out_mov(s, type, a0, a1);
+            tcg_out_insn(s, 3606, ORRI, is_q, a0, 0, cmode, imm8);
+        } else {
+            tcg_out_insn(s, 3616, ORN, is_q, 0, a0, a1, a2);
+        }
         break;
     case INDEX_op_xor_vec:
         tcg_out_insn(s, 3616, EOR, is_q, 0, a0, a1, a2);
         break;
-    case INDEX_op_andc_vec:
-        tcg_out_insn(s, 3616, BIC, is_q, 0, a0, a1, a2);
-        break;
-    case INDEX_op_orc_vec:
-        tcg_out_insn(s, 3616, ORN, is_q, 0, a0, a1, a2);
-        break;
     case INDEX_op_ssadd_vec:
         tcg_out_insn(s, 3616, SQADD, is_q, vece, a0, a1, a2);
         break;
@@ -2413,6 +2462,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
     static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
     static const TCGTargetOpDef w_w_w = { .args_ct_str = { "w", "w", "w" } };
+    static const TCGTargetOpDef w_w_wI = { .args_ct_str = { "w", "w", "wI" } };
+    static const TCGTargetOpDef w_w_wP = { .args_ct_str = { "w", "w", "wP" } };
     static const TCGTargetOpDef w_w_wZ = { .args_ct_str = { "w", "w", "wZ" } };
     static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
     static const TCGTargetOpDef r_r_rA = { .args_ct_str = { "r", "r", "rA" } };
@@ -2568,11 +2619,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
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
@@ -2586,6 +2633,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sarv_vec:
     case INDEX_op_aa64_sshl_vec:
         return &w_w_w;
+    case INDEX_op_or_vec:
+    case INDEX_op_andc_vec:
+        return &w_w_wP;
+    case INDEX_op_and_vec:
+    case INDEX_op_orc_vec:
+        return &w_w_wI;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
     case INDEX_op_abs_vec:
-- 
2.17.1


