Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE57C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B1420872
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wm0Tqh6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B1420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4fN-0004Wz-V5
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:06:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dM-0002nw-Hd
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4b6-0002km-BC
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:21 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4b6-0002k9-5E
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:20 -0400
Received: by mail-pf1-x441.google.com with SMTP id 13so5245068pfw.9
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=AirXKI1PS8HjM151RJTWK1/DcdzF7g0f+0zrycENkFI=;
	b=wm0Tqh6H8BruN8LoznuFQnO8IBRQrSBDUwa6HZXqppYfvP+XRHdNxXMQ7cfk3bpO5P
	8xlHRPHyvzHVpdESOY0TItUQBqGvwnEyXJiVVemZEqZjU4M/+Bw3lJWwTF07NDw7Yub8
	GydwAlO7H8i9I0NWaOnUrxSkVE3QartU5bHWzbGvg2p0yTKFf5pVuxsf+gFTajD3sxdX
	7u5uKbNrOxfeVHiy6mj4RhZ7N9z9ePv/LsPOmua3934sK1pcYtRQ/+QfwIekub0nPanU
	cX+ZcUN8ZjfcUcJbbIrmegC7ckeN1H75gXOW2uZQsIBw3/7XwoW7YOVnoz7HTEejPNUC
	aXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=AirXKI1PS8HjM151RJTWK1/DcdzF7g0f+0zrycENkFI=;
	b=Qeteu6zpCPHKyGfVdaVwfXMIxrn7ZEpWGKUfZnrnLcTdFlz0aAclbVnrQyiFDxUoMW
	hZe3DsxpaY0twUo2E1Oe14nIzIuRhOTWrHmdEWhnXD3PJPdlm74EqdbHKUWqrJ1afpIR
	SFBlifcXpN4lFWqbeGwRVWetaA6OvFXMH4DI6NS43BbK2m96bRsZI+DMh9kMWePcfbM0
	dHvteOCMMnORbsJ1D6HFg9L+2P+olCEvMmncti4Vwkcg5ADJUDpMCbx1yaHeao5Fg8Ov
	B521+kBo5Cl4GpAYPejQYq4fjm4QlpWoyxZmPBNROJXun+n/A4WMm02KHOEYoouWWESi
	VZoA==
X-Gm-Message-State: APjAAAW8eZsF7cyDAcJIrS6fnXprybYuTipMRjnsgEbGN6cuKNrNi8pL
	FxPUXU1Y7vHDBlXVLiurxIwwpMaB5lk=
X-Google-Smtp-Source: APXvYqwmjSFLSwtSlkaUpFNfHPclHpDVGynX4Y0J2szRGDTZ/IOOkEvpzy5GtuDStNceYmO2lyPFVw==
X-Received: by 2002:a63:a351:: with SMTP id v17mr64525226pgn.431.1558206138956;
	Sat, 18 May 2019 12:02:18 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.18
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:56 -0700
Message-Id: <20190518190157.21255-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 15/16] tcg/aarch64: Allow immediates for vector
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


