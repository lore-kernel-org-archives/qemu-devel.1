Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A90C76191
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6517921842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yAlfUCLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6517921842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Td-0006s7-5S
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NB-0004DZ-K4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4N7-0000Em-Ve
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:15 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:46601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4N5-0008UB-Tf
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id c2so24992782plz.13
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=S4Q7S2OdhUkyh4FYS2Teg9nr51SAo2OgSkvWrjYq2oc=;
 b=yAlfUCLGaE+K/ycrFuqkUrax+2KjApxCrDsxWgJP8krVVSNuMV0OY129PFHRt7NUfb
 MZ+pO47e+xOb6q4dwfQb8dDryP+hGi9T7iK4rnsztrOBVEfpt1vinn7xTEpp+TqT6oYw
 VRpWunzO/rNOE7ItF3wc8O8+loGldHc9q4kFTXpP0VetRFtAIcrkZZkLt/wLGboalAO9
 UQPfxBKLEgmaUIA3qj2AflhCfcID6o2bFDn3uUMzBhQIK6oa6s8J+MgBleEqoAAC/QmQ
 T0amOkHxIaGi//H61V7UqQ1UpWTJPZs7Vo2R3OzSgg7crrASDUKzs9CMCH62y0nNr0Fw
 yeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=S4Q7S2OdhUkyh4FYS2Teg9nr51SAo2OgSkvWrjYq2oc=;
 b=qnkFTt8BdRNyeKym4wIGeBJjPNLiMzuQohQBhQwFKehaTy0tHe8a3whxQH3ukempeF
 5WcOBhNc+WQTIUMg7r0tVwIXyzEVNYzR6NrPVzgmHJM7BSJt7AG9+28v3Z2gV/Q1t/qH
 VXRlJvfBl9b+6Cgi0TtBC/ZvNLL0aOa+hGKt7qrRjocsQVjTkggLDn/tAlfjo94NpfDm
 C5MlXZWPGnZi97Ch50seKB/bb4ehJOntrvDm0XTsolKDVuJ2ON6WNtY7UQFbIwxo3UGq
 Yb0bhZAYg6uvEBasJLQ9bCNYDcm6xyPFehuhduuDwiunYMigdeygMZMD443thX/hMMmP
 agXQ==
X-Gm-Message-State: APjAAAXVDeNyloSrH0QnMMPUE04ldqFRq0URbi1cSPWj90QOb7Yov3dO
 zVZeyHo27VUeanqMvi9pCV1upTAt160=
X-Google-Smtp-Source: APXvYqxN1S4kYTBTQyY707CtXFtWGFXUQFy8wQiQR4SJItngivxxqgUdUuqBAi3jlpqtx0d80fb+dw==
X-Received: by 2002:a17:902:d70a:: with SMTP id
 w10mr92326794ply.251.1564163467636; 
 Fri, 26 Jul 2019 10:51:07 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:53 -0700
Message-Id: <20190726175032.6769-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
Subject: [Qemu-devel] [PATCH 28/67] target/arm: Convert MOVW, MOVT
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 89 ++++++++++++++++--------------------------
 target/arm/a32.decode  |  6 +++
 target/arm/t32.decode  |  9 +++++
 3 files changed, 48 insertions(+), 56 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5bdec27265..ee97a0ccdd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7919,6 +7919,34 @@ static bool trans_ADR(DisasContext *s, arg_ri *a)
     return true;
 }
 
+static bool trans_MOVW(DisasContext *s, arg_MOVW *a)
+{
+    TCGv_i32 tmp;
+
+    if (!ENABLE_ARCH_6T2) {
+        return false;
+    }
+
+    tmp = tcg_const_i32(a->imm);
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
+static bool trans_MOVT(DisasContext *s, arg_MOVW *a)
+{
+    TCGv_i32 tmp;
+
+    if (!ENABLE_ARCH_6T2) {
+        return false;
+    }
+
+    tmp = load_reg(s, a->rd);
+    tcg_gen_ext16u_i32(tmp, tmp);
+    tcg_gen_ori_i32(tmp, tmp, a->imm << 16);
+    store_reg(s, a->rd, tmp);
+    return true;
+}
+
 /*
  * Multiply and multiply accumulate
  */
@@ -9720,7 +9748,7 @@ static bool trans_UDIV(DisasContext *s, arg_rrr *a)
 
 static void disas_arm_insn(DisasContext *s, unsigned int insn)
 {
-    unsigned int cond, val, op1, i, rn, rd;
+    unsigned int cond, val, op1, i, rn;
     TCGv_i32 tmp;
     TCGv_i32 tmp2;
     TCGv_i32 addr;
@@ -9966,26 +9994,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     /* fall back to legacy decoder */
 
     if ((insn & 0x0f900000) == 0x03000000) {
-        if ((insn & (1 << 21)) == 0) {
-            ARCH(6T2);
-            rd = (insn >> 12) & 0xf;
-            val = ((insn >> 4) & 0xf000) | (insn & 0xfff);
-            if ((insn & (1 << 22)) == 0) {
-                /* MOVW */
-                tmp = tcg_temp_new_i32();
-                tcg_gen_movi_i32(tmp, val);
-            } else {
-                /* MOVT */
-                tmp = load_reg(s, rd);
-                tcg_gen_ext16u_i32(tmp, tmp);
-                tcg_gen_ori_i32(tmp, tmp, val << 16);
-            }
-            store_reg(s, rd, tmp);
-        } else {
-            /* MSR (immediate) and hints */
-            /* All done in decodetree.  Illegal ops already signalled.  */
-            g_assert_not_reached();
-        }
+        /* All done in decodetree.  Illegal ops reach here.  */
+        goto illegal_op;
     } else if ((insn & 0x0f900000) == 0x01000000
                && (insn & 0x00000090) != 0x00000090) {
         /* miscellaneous instructions */
@@ -10725,42 +10735,9 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             /*
              * 0b1111_0xxx_xxxx_0xxx_xxxx_xxxx
              *  - Data-processing (modified immediate, plain binary immediate)
+             * All in decodetree.
              */
-            if (insn & (1 << 25)) {
-                /*
-                 * 0b1111_0x1x_xxxx_0xxx_xxxx_xxxx
-                 *  - Data-processing (plain binary immediate)
-                 */
-                if (insn & (1 << 24)) {
-                    /* Bitfield/Saturate, in decodetree */
-                    goto illegal_op;
-                } else {
-                    imm = ((insn & 0x04000000) >> 15)
-                          | ((insn & 0x7000) >> 4) | (insn & 0xff);
-                    if (insn & (1 << 22)) {
-                        /* 16-bit immediate.  */
-                        imm |= (insn >> 4) & 0xf000;
-                        if (insn & (1 << 23)) {
-                            /* movt */
-                            tmp = load_reg(s, rd);
-                            tcg_gen_ext16u_i32(tmp, tmp);
-                            tcg_gen_ori_i32(tmp, tmp, imm << 16);
-                        } else {
-                            /* movw */
-                            tmp = tcg_temp_new_i32();
-                            tcg_gen_movi_i32(tmp, imm);
-                        }
-                        store_reg(s, rd, tmp);
-                    } else {
-                        /* Add/sub 12-bit immediate, in decodetree */
-                        goto illegal_op;
-                    }
-                }
-            } else {
-                /* Data-processing (modified immediate) */
-                /* All done in decodetree.  Reach here for illegal ops.  */
-                goto illegal_op;
-            }
+            goto illegal_op;
         }
         break;
     case 12:
diff --git a/target/arm/a32.decode b/target/arm/a32.decode
index c5af685585..02d7e5b202 100644
--- a/target/arm/a32.decode
+++ b/target/arm/a32.decode
@@ -73,6 +73,12 @@ MOV_rrri         .... 000 1101 . 0000 .... ..... .. 0 ....    @s_rxr_shi
 BIC_rrri         .... 000 1110 . .... .... ..... .. 0 ....    @s_rrr_shi
 MVN_rrri         .... 000 1111 . 0000 .... ..... .. 0 ....    @s_rxr_shi
 
+%imm16           16:4 0:12
+@mov16           ---- .... .... .... rd:4 ............        &ri imm=%imm16
+
+MOVW             .... 0011 0000 .... .... ............        @mov16
+MOVT             .... 0011 0100 .... .... ............        @mov16
+
 # Data-processing (register-shifted register)
 
 @s_rrr_shr       ---- ... .... s:1 rn:4 rd:4 rs:4 . shty:2 . rm:4 \
diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 68203e3704..fdcfb60cc5 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -150,6 +150,15 @@ RSB_rri          1111 0.0 1110 . .... 0 ... .... ........     @s_rri_rot
   SUB_rri        1111 0.1 0101 0 .... 0 ... .... ........     @s0_rri_12
 }
 
+# Move Wide
+
+%imm16_26_16_12_0 16:4 26:1 12:3 0:8
+@mov16           .... .... .... .... .... rd:4 .... .... \
+                 &ri imm=%imm16_26_16_12_0
+
+MOVW             1111 0.10 0100 .... 0 ... .... ........      @mov16
+MOVT             1111 0.10 1100 .... 0 ... .... ........      @mov16
+
 # Saturate, bitfield
 
 @sat             .... .... .. sh:1 . rn:4 . ... rd:4 .. . satimm:5 \
-- 
2.17.1


