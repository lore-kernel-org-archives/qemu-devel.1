Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BF4C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E07720663
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FIq+AsBt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E07720663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43363 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmbS-0002e5-MP
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51281)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJR-0006sZ-Fy
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJQ-0000wF-2E
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:05 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:34411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJP-0000vo-QP
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:04 -0400
Received: by mail-pg1-x52b.google.com with SMTP id k20so1581273pgi.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=2nm6apASWDrwzmzKxYCzPimVGo2WIvIIu5cuSVCbrLo=;
 b=FIq+AsBtzJEMj+Ub3hHexvQg67ZOjEOj5LoCn+vtrMT21HKgQkT10oP2/LuIVsEm8l
 k3C8vtupic8MulQii1EFrlaXJ58UFF7ZrcBrP/HHm4BhNTfkpqOwu2Je9+pvUK6ih40X
 NugfJQkzHF3rXhP5cV538gf7XAyVtk0tYairH18RQ3m9iZ7uGp1F67m06qUCMMUDDnQ0
 DYrgFXOs6baftnQPBHFvOdM6h+636imrNcLJSU0EMr3H2dc7DcCkbKb2tguS5jEq5Xbo
 ftylbwMXDirqlpTvV9hS1tB38b1KAKbHUJfzVqjXUc5VumTG+yB7vnyU/VIYd2slNhzI
 oT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=2nm6apASWDrwzmzKxYCzPimVGo2WIvIIu5cuSVCbrLo=;
 b=VNBF8NcDmW46wopSR37P7IwMhTl9d/+NTr2JfcRp9KDBtBUkbr6e8eBTlFZpJQez3j
 hTLLAFi818QZDy9XgdSHys5dU7zw/72eK67WmcsFR13OVuzyUS+D2lTrVSl9GPuijcEc
 pdzPIuXS+Y2/tc19/avmNfZ2z2mRDwHksDlQjc0oHsOpp1y4OiDQ1Ni+4qXcrLoc0szf
 fibBlXDGraudj4c+9KODKftAcb6nIb0T2DWsauCQ8X2PSQnrEln7f+wNBEuZYF4UwODO
 qaLQFjTdSnHrHYM/BXNDnev1adr/AqH+eGB21TDcT/xtQHiIt7BbjJV9QLmyPt4irz/y
 Mkug==
X-Gm-Message-State: APjAAAVKkCkyYHyy6GIZeJX+qLN5qN9zR0Xh3cDqXTQCy2ah1jvkMil1
 V0uC92FWTqwGJYtl4no5Ka/F8bsRWss=
X-Google-Smtp-Source: APXvYqztNq9FyCbJsIwkUMSclTIgFNkoTKsLUrbY5tE8k/KEyDoDtNnDiLZFqEh6TQSaPJxm2MXRuA==
X-Received: by 2002:a17:90a:9b86:: with SMTP id
 g6mr32617333pjp.76.1571005562380; 
 Sun, 13 Oct 2019 15:26:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/23] tcg/ppc: Support vector shift by immediate
Date: Sun, 13 Oct 2019 15:25:33 -0700
Message-Id: <20191013222544.3679-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52b
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
Cc: peter.maydell@linaro.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For Altivec, this is done via vector shift by vector,
and loading the immediate into a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 tcg/ppc/tcg-target.h     |  2 +-
 tcg/ppc/tcg-target.inc.c | 58 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 57 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 3ebbbfa77e..ffb226946b 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -160,7 +160,7 @@ extern bool have_altivec;
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_cmp_vec          1
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_sat_vec          1
diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index a1165209fc..a9264eccbe 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -514,6 +514,16 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define VCMPGTUH   VX4(582)
 #define VCMPGTUW   VX4(646)
 
+#define VSLB       VX4(260)
+#define VSLH       VX4(324)
+#define VSLW       VX4(388)
+#define VSRB       VX4(516)
+#define VSRH       VX4(580)
+#define VSRW       VX4(644)
+#define VSRAB      VX4(772)
+#define VSRAH      VX4(836)
+#define VSRAW      VX4(900)
+
 #define VAND       VX4(1028)
 #define VANDC      VX4(1092)
 #define VNOR       VX4(1284)
@@ -2860,8 +2870,14 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return vece <= MO_32;
     case INDEX_op_cmp_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
         return vece <= MO_32 ? -1 : 0;
     default:
         return 0;
@@ -2968,7 +2984,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         umin_op[4] = { VMINUB, VMINUH, VMINUW, 0 },
         smin_op[4] = { VMINSB, VMINSH, VMINSW, 0 },
         umax_op[4] = { VMAXUB, VMAXUH, VMAXUW, 0 },
-        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 };
+        smax_op[4] = { VMAXSB, VMAXSH, VMAXSW, 0 },
+        shlv_op[4] = { VSLB, VSLH, VSLW, 0 },
+        shrv_op[4] = { VSRB, VSRH, VSRW, 0 },
+        sarv_op[4] = { VSRAB, VSRAH, VSRAW, 0 };
 
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0 = args[0], a1 = args[1], a2 = args[2];
@@ -3015,6 +3034,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_umax_vec:
         insn = umax_op[vece];
         break;
+    case INDEX_op_shlv_vec:
+        insn = shlv_op[vece];
+        break;
+    case INDEX_op_shrv_vec:
+        insn = shrv_op[vece];
+        break;
+    case INDEX_op_sarv_vec:
+        insn = sarv_op[vece];
+        break;
     case INDEX_op_and_vec:
         insn = VAND;
         break;
@@ -3059,6 +3087,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     tcg_out32(s, insn | VRT(a0) | VRA(a1) | VRB(a2));
 }
 
+static void expand_vec_shi(TCGType type, unsigned vece, TCGv_vec v0,
+                           TCGv_vec v1, TCGArg imm, TCGOpcode opci)
+{
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+
+    /* Splat w/bytes for xxspltib.  */
+    tcg_gen_dupi_vec(MO_8, t1, imm & ((8 << vece) - 1));
+    vec_gen_3(opci, type, vece, tcgv_vec_arg(v0),
+              tcgv_vec_arg(v1), tcgv_vec_arg(t1));
+    tcg_temp_free_vec(t1);
+}
+
 static void expand_vec_cmp(TCGType type, unsigned vece, TCGv_vec v0,
                            TCGv_vec v1, TCGv_vec v2, TCGCond cond)
 {
@@ -3110,14 +3150,25 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 {
     va_list va;
     TCGv_vec v0, v1, v2;
+    TCGArg a2;
 
     va_start(va, a0);
     v0 = temp_tcgv_vec(arg_temp(a0));
     v1 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
-    v2 = temp_tcgv_vec(arg_temp(va_arg(va, TCGArg)));
+    a2 = va_arg(va, TCGArg);
 
     switch (opc) {
+    case INDEX_op_shli_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_shlv_vec);
+        break;
+    case INDEX_op_shri_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_shrv_vec);
+        break;
+    case INDEX_op_sari_vec:
+        expand_vec_shi(type, vece, v0, v1, a2, INDEX_op_sarv_vec);
+        break;
     case INDEX_op_cmp_vec:
+        v2 = temp_tcgv_vec(arg_temp(a2));
         expand_vec_cmp(type, vece, v0, v1, v2, va_arg(va, TCGArg));
         break;
     default:
@@ -3317,6 +3368,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_smin_vec:
     case INDEX_op_umax_vec:
     case INDEX_op_umin_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_dup_vec:
-- 
2.17.1


