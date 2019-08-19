Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCC0C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6D012070B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 22:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I3cLjXuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D012070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzq1i-000122-9n
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 18:21:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMf-0002S4-BG
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hzpMd-0006d1-A6
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:57 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hzpMb-0006Ya-92
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 17:38:55 -0400
Received: by mail-pl1-x644.google.com with SMTP id 4so1584506pld.10
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ya11/VX/aRn7vG6mAkOVxrie0vDf0+2x0xJimT8Kw/s=;
 b=I3cLjXuSdVRvaHttEFWO9xBVqNs1NkIOgvZVedtNuoVMPL71J3umdP1DUTEkzHkCSJ
 KMDZSOE4l1CDRRan+IG4AprZMjriFaLecR9fv2URZ7NjbDPZAAYvx5huDgW1/sw1euGZ
 bEHpTWn89HiwJ2N+yqUrAqeSsT9YG1ILdHpjkIsk07CyPj6NLkTZYMiep26znN9lzY+Z
 nBNDMoSI/7K49b/f5I+r/PAb7D8VcXB32Kpw0cKPHl3VN34eOJ9BBucSubGXNqK5RYuE
 yoWDnwrcBiWg44E/ffk4oua5oTGg14oCYsyaGYayIkaSj12MxODfOiGUC5t5e0lBUIrE
 nPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ya11/VX/aRn7vG6mAkOVxrie0vDf0+2x0xJimT8Kw/s=;
 b=lv3q8VXjGdikn6WmqoNRAH4uzflF5LLt9G808ahSXaqnCF2hR/jCWHkDDGDXm4iWk0
 zJDKk94nva4e5MW6W6lPw03jCATw6YelC8EcJkXa8esq+aHsCqPnAPSnkofIZ/FnsLk5
 hwSh1HDMO3Ca6Qi2v4lnoWkNLzntdqMFdosNQ7QSaHmf6Ns7zxcqoP+aEUejW61Vid8W
 lRr7ScQHUG6JzEcwy5Ih1ys75Zi94VR4IXsgxnmWdC24DfY1aualRnr+xpWxxWMeCrTC
 TkcU4viYY3KCL88m+cBW09GJEVI+kSrLoH4j543WRS1JDq3rjJOgWT+Ac0/q2wqvDc97
 2rLA==
X-Gm-Message-State: APjAAAX6w5ciEinNVgL/pRxObL2+MTBwnFCV1Si2R4CTz0wjEh46EnCp
 Qk9I4Rb5hTY6LsdLVljKF42zWoQyScA=
X-Google-Smtp-Source: APXvYqzlo+d5k+D+qQ6WqPxHhAgweq6oUyBsw/d97NTJlpfUxwz5l70LANos5TgZDTx28i5gm0bMJA==
X-Received: by 2002:a17:902:6b07:: with SMTP id
 o7mr24108861plk.180.1566250728492; 
 Mon, 19 Aug 2019 14:38:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d2sm13446951pjs.21.2019.08.19.14.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 14:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:37:29 -0700
Message-Id: <20190819213755.26175-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213755.26175-1-richard.henderson@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v2 42/68] target/arm: Simplify disas_thumb2_insn
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fold away all of the cases that now just goto illegal_op,
because all of their internal bits are now in decodetree.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 79 ++----------------------------------------
 1 file changed, 3 insertions(+), 76 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d1078ca1ec..25c74206c2 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10433,9 +10433,6 @@ static bool thumb_insn_is_16bit(DisasContext *s, uint32_t pc, uint32_t insn)
 /* Translate a 32-bit thumb instruction. */
 static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
 {
-    uint32_t rn;
-    int op;
-
     /*
      * ARMv6-M supports a limited subset of Thumb2 instructions.
      * Other Thumb1 architectures allow only 32-bit
@@ -10476,34 +10473,10 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
     }
     /* fall back to legacy decoder */
 
-    rn = (insn >> 16) & 0xf;
     switch ((insn >> 25) & 0xf) {
     case 0: case 1: case 2: case 3:
         /* 16-bit instructions.  Should never happen.  */
         abort();
-    case 4:
-        /* All in decodetree */
-        goto illegal_op;
-    case 5:
-        /* All in decodetree */
-        goto illegal_op;
-    case 13: /* Misc data processing.  */
-        op = ((insn >> 22) & 6) | ((insn >> 7) & 1);
-        if (op < 4 && (insn & 0xf000) != 0xf000)
-            goto illegal_op;
-        switch (op) {
-        case 0: /* Register controlled shift, in decodetree */
-        case 1: /* Sign/zero extend, in decodetree */
-        case 2: /* SIMD add/subtract, in decodetree */
-        case 3: /* Other data processing, in decodetree */
-            goto illegal_op;
-        case 4: case 5:
-            /* 32-bit multiply.  Sum of absolute differences, in decodetree */
-            goto illegal_op;
-        case 6: case 7: /* 64-bit multiply, Divide, in decodetree */
-            goto illegal_op;
-        }
-        break;
     case 6: case 7: case 14: case 15:
         /* Coprocessor.  */
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
@@ -10532,6 +10505,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 }
 
                 if (arm_dc_feature(s, ARM_FEATURE_VFP)) {
+                    uint32_t rn = (insn >> 16) & 0xf;
                     TCGv_i32 fptr = load_reg(s, rn);
 
                     if (extract32(insn, 20, 1)) {
@@ -10590,50 +10564,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
         }
         break;
-    case 8: case 9: case 10: case 11:
-        if (insn & (1 << 15)) {
-            /* Branches, misc control.  */
-            if (insn & 0x5000) {
-                /* Unconditional branch, in decodetree */
-                goto illegal_op;
-            } else if (((insn >> 23) & 7) == 7) {
-                /* Misc control */
-                if (insn & (1 << 13))
-                    goto illegal_op;
-
-                if (insn & (1 << 26)) {
-                    /* hvc, smc, in decodetree */
-                    goto illegal_op;
-                } else {
-                    op = (insn >> 20) & 7;
-                    switch (op) {
-                    case 0: /* msr cpsr, in decodetree  */
-                    case 1: /* msr spsr, in decodetree  */
-                        goto illegal_op;
-                    case 2: /* cps, nop-hint, in decodetree */
-                        goto illegal_op;
-                    case 3: /* Special control operations, in decodetree */
-                    case 4: /* bxj, in decodetree */
-                        goto illegal_op;
-                    case 5: /* Exception return.  */
-                    case 6: /* MRS, in decodetree */
-                    case 7: /* MSR, in decodetree */
-                        goto illegal_op;
-                    }
-                }
-            } else {
-                /* Conditional branch, in decodetree */
-                goto illegal_op;
-            }
-        } else {
-            /*
-             * 0b1111_0xxx_xxxx_0xxx_xxxx_xxxx
-             *  - Data-processing (modified immediate, plain binary immediate)
-             * All in decodetree.
-             */
-            goto illegal_op;
-        }
-        break;
     case 12:
         if ((insn & 0x01100000) == 0x01000000) {
             if (disas_neon_ls_insn(s, insn)) {
@@ -10641,14 +10571,11 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             }
             break;
         }
-        /* Load/store single data item, in decodetree */
         goto illegal_op;
     default:
-        goto illegal_op;
+    illegal_op:
+        unallocated_encoding(s);
     }
-    return;
-illegal_op:
-    unallocated_encoding(s);
 }
 
 static void disas_thumb_insn(DisasContext *s, uint32_t insn)
-- 
2.17.1


