Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADB0C4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:37:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2703B207FF
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ra11ZBum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2703B207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmUU-0002Zf-Qh
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJl-00076F-09
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJj-00018t-8x
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:24 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:35794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJh-00014c-AG
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:22 -0400
Received: by mail-pg1-x530.google.com with SMTP id p30so8941512pgl.2
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eQFl1TFXthP4AT6NgGUJRpsDofwtKBJ7n5fJYlO6V1Y=;
 b=ra11ZBumrgiUZtKOkdbajdgjI0Ui7WB3PzcfVJJQ8pAW+v6ozDasf/sUE5GCDcGek7
 ah/h2czo7ydjBtog0hRMQBWNFlq8mL7g8AgAkv+Qfj9m9cdjy/MD4jpR5KgKnv1nyzXI
 XaWlg/z77spMO73l2S5YQfe0/SuJRuyVnOEqNvaNMnNjTNOKEjmEFdC/eFPaXElSMG8V
 teGfFm6ORQsKwJpQmil6aLjP2geSMExdgRzdF2OXfC9G/PUaSwYOd4rP/s7w9LUp+zck
 tDA0tkivrYjzbNwT7DRzAQUEA62LeSKPotugg3MXfv0+ikYYAUAkl8mhMMgOSlWrlHLa
 m+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eQFl1TFXthP4AT6NgGUJRpsDofwtKBJ7n5fJYlO6V1Y=;
 b=Gy0opnEaGE7K9x9SWorN0T2eRdItrJ1zfEHhllZwXRfd7hAFdEeNwHqARk2tLFU1Fp
 u/wU99QAGlx+Qm6aBKXUyo6sBRhB7bTY8gbeOAUPGJ0UNs4zuYAmlG16z+ANkJpnVUgV
 BDwvSOJOY7uVupEJTdi1fR8oFkk8IfLaE9W5hYjQScrutDl2G/SYLfGzpYZZ39g1sUZk
 tj7PsWYEO7WRIJ4O307Hb5ccln3JzVucjPjJ0rwza9hDAl9s/6xBFd8QX8ar/OjVVB/9
 VqJFkPJhOabGAckmefhzAPiosunbFl38Xa2x/fA4KeENlOTld0TGtBO+ZW7uMa0+6M05
 3fqQ==
X-Gm-Message-State: APjAAAUcsXN+8qQOgBPblq2O7VOyd2M6jNEPhssrx5SazYEpiCECuQ+A
 FOyyJ6SaH/U4JZI0+TaouJ+wJvVrh/Y=
X-Google-Smtp-Source: APXvYqwSPfHs82xth0h1e7beJbj6C7P+ENU/aGhgcyJ43Wki4GolmJX2pcYqztdvcRleTYi2zE5few==
X-Received: by 2002:a63:ea45:: with SMTP id l5mr16785414pgk.189.1571005575331; 
 Sun, 13 Oct 2019 15:26:15 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/23] tcg/ppc: Update vector support for v3.00 dup/dupi
Date: Sun, 13 Oct 2019 15:25:43 -0700
Message-Id: <20191013222544.3679-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::530
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These new instructions are conditional on MSR.VEC for TX=1,
so we can consider these Altivec instructions.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 5b7d1bd2dc..d308d69aba 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -596,11 +596,14 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 
 #define XXPERMDI   (OPCD(60) | (10 << 3) | 7)  /* v2.06, force ax=bx=tx=1 */
 #define XXSEL      (OPCD(60) | (3 << 4) | 0xf) /* v2.06, force ax=bx=cx=tx=1 */
+#define XXSPLTIB   (OPCD(60) | (360 << 1) | 1) /* v3.00, force tx=1 */
 
 #define MFVSRD     (XO31(51) | 1)   /* v2.07, force sx=1 */
 #define MFVSRWZ    (XO31(115) | 1)  /* v2.07, force sx=1 */
 #define MTVSRD     (XO31(179) | 1)  /* v2.07, force tx=1 */
 #define MTVSRWZ    (XO31(243) | 1)  /* v2.07, force tx=1 */
+#define MTVSRDD    (XO31(435) | 1)  /* v3.00, force tx=1 */
+#define MTVSRWS    (XO31(403) | 1)  /* v3.00, force tx=1 */
 
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
@@ -931,6 +934,10 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, TCGReg ret,
             return;
         }
     }
+    if (have_isa_3_00 && val == (tcg_target_long)dup_const(MO_8, val)) {
+        tcg_out32(s, XXSPLTIB | VRT(ret) | ((val & 0xff) << 11));
+        return;
+    }
 
     /*
      * Otherwise we must load the value from the constant pool.
@@ -3021,7 +3028,22 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src)
 {
     tcg_debug_assert(dst >= TCG_REG_V0);
-    tcg_debug_assert(src >= TCG_REG_V0);
+
+    /* Splat from integer reg allowed via constraints for v3.00.  */
+    if (src < TCG_REG_V0) {
+        tcg_debug_assert(have_isa_3_00);
+        switch (vece) {
+        case MO_64:
+            tcg_out32(s, MTVSRDD | VRT(dst) | RA(src) | RB(src));
+            return true;
+        case MO_32:
+            tcg_out32(s, MTVSRWS | VRT(dst) | RA(src));
+            return true;
+        default:
+            /* Fail, so that we fall back on either dupm or mov+dup.  */
+            return false;
+        }
+    }
 
     /*
      * Recall we use (or emulate) VSX integer loads, so the integer is
@@ -3482,6 +3504,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     static const TCGTargetOpDef sub2
         = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
     static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
+    static const TCGTargetOpDef v_vr = { .args_ct_str = { "v", "vr" } };
     static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
     static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
     static const TCGTargetOpDef v_v_v_v
@@ -3651,8 +3674,9 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
         return &v_v_v;
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
-    case INDEX_op_dup_vec:
         return &v_v;
+    case INDEX_op_dup_vec:
+        return have_isa_3_00 ? &v_vr : &v_v;
     case INDEX_op_ld_vec:
     case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
-- 
2.17.1


