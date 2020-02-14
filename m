Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA71C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA6012086A
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kfgDX/Av"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA6012086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2ffw-0007sf-32
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVY-0004aD-Cd
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVX-0000HG-1P
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:08 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33844)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVW-0000Gh-Rq
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:16:06 -0500
Received: by mail-pf1-x441.google.com with SMTP id i6so5272579pfc.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2kZ9BsLAsFQXYPLtyMT3ZoVnOYLNLzYgitMu8C6B1ag=;
 b=kfgDX/AvC7uAk2+/8dqYe+dRnlgoXukH0uruVMfMj9VSUyM3F2LxP3l93gzpy5mSH9
 lbip3mDlr+1wqQ/v1DNOo9EwUYHQgLXFdcX3hyDbeTPIApbyVQVeyrlweUp7KT6yf6zw
 3xVb8wDIHXqI0LYzLRJonFw/EasfWyN/0EWLwb48LRKYxUjozt+eAeabiM09Sdi4x/dZ
 1Bu089O3lo1QXr1sJozglvqtK/rvVvXkN/t0rlQIGCjqOtHigUOK8ZbFDQ4oB9cRaRcs
 pLMNoeiKXmTbOgyK2eypewi5R+yvP83qlgak9nPikfJ5rVgxt2ZXHxH5zzLfNxn3w05S
 F/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2kZ9BsLAsFQXYPLtyMT3ZoVnOYLNLzYgitMu8C6B1ag=;
 b=qRjRh7y5yqMauDyRSv+IMV42yI1h2pkybxZdzVcusbTSu7ru7qQDzxaljfSfqCdaOu
 L0ttu6W8/Qs2jt7wyUZk1kua77WfD8PDHc+aZD34CToPB2yMqMrVcWbWHCmgmb4NOP7e
 CDP2WI4vynKxFZVxdbqlelT2rP0qDCzTxFopvdeBFA8TX/97aAn6bFZl/wSBu6ji0o4q
 nCJoIB9j67rBLz73fFr8pPWpi53NpTwlPUN85PtBPqOiPbzwUcQ62Qso3kesnKVc/9Km
 U2LR0AUqDdp6Gf/OjFOY/6KhkokN72pcnOe0wVBV+EbmNqrOrsWUKwxMtCg8rAQhFWb/
 bd2Q==
X-Gm-Message-State: APjAAAWRYIYr7aD/HWq/ym3pYDwxMiIGkRISTjVyW2tTUsw7WgBQBqRj
 jCwPyJX4t9dHmjmiC+PKxRw4ZMfp8s0=
X-Google-Smtp-Source: APXvYqwwK6+u6ob85GTch+wY+iB9rRTfZzcmgkuGythmfDj1PKt58Dqk17Squ8jVVPWLs7W7hFPazA==
X-Received: by 2002:a65:68ce:: with SMTP id k14mr4655713pgt.336.1581704165314; 
 Fri, 14 Feb 2020 10:16:05 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:16:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/19] target/arm: Move the vfp decodetree calls next to the
 base isa
Date: Fri, 14 Feb 2020 10:15:42 -0800
Message-Id: <20200214181547.21408-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214181547.21408-1-richard.henderson@linaro.org>
References: <20200214181547.21408-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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

Have the calls adjacent as an intermediate step toward
actually merging the decodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 80 +++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 56 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b2641b4262..5cabe6b2e9 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2646,31 +2646,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
     tcg_temp_free_i32(tmp);
 }
 
-/*
- * Disassemble a VFP instruction.  Returns nonzero if an error occurred
- * (ie. an undefined instruction).
- */
-static int disas_vfp_insn(DisasContext *s, uint32_t insn)
-{
-    /*
-     * If the decodetree decoder handles this insn it will always
-     * emit code to either execute the insn or generate an appropriate
-     * exception; so we don't need to ever return non-zero to tell
-     * the calling code to emit an UNDEF exception.
-     */
-    if (extract32(insn, 28, 4) == 0xf) {
-        if (disas_vfp_uncond(s, insn)) {
-            return 0;
-        }
-    } else {
-        if (disas_vfp(s, insn)) {
-            return 0;
-        }
-    }
-    /* If the decodetree decoder didn't handle this insn, it must be UNDEF */
-    return 1;
-}
-
 static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 {
 #ifndef CONFIG_USER_ONLY
@@ -10524,7 +10499,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         ARCH(5);
 
         /* Unconditional instructions.  */
-        if (disas_a32_uncond(s, insn)) {
+        /* TODO: Perhaps merge these into one decodetree output file.  */
+        if (disas_a32_uncond(s, insn) ||
+            disas_vfp_uncond(s, insn)) {
             return;
         }
         /* fall back to legacy decoder */
@@ -10551,13 +10528,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             return;
         }
-        if ((insn & 0x0f000e10) == 0x0e000a00) {
-            /* VFP.  */
-            if (disas_vfp_insn(s, insn)) {
-                goto illegal_op;
-            }
-            return;
-        }
         if ((insn & 0x0e000f00) == 0x0c000100) {
             if (arm_dc_feature(s, ARM_FEATURE_IWMMXT)) {
                 /* iWMMXt register transfer.  */
@@ -10588,7 +10558,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         arm_skip_unless(s, cond);
     }
 
-    if (disas_a32(s, insn)) {
+    /* TODO: Perhaps merge these into one decodetree output file.  */
+    if (disas_a32(s, insn) ||
+        disas_vfp(s, insn)) {
         return;
     }
     /* fall back to legacy decoder */
@@ -10597,12 +10569,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     case 0xc:
     case 0xd:
     case 0xe:
-        if (((insn >> 8) & 0xe) == 10) {
-            /* VFP.  */
-            if (disas_vfp_insn(s, insn)) {
-                goto illegal_op;
-            }
-        } else if (disas_coproc_insn(s, insn)) {
+        if (((insn >> 8) & 0xe) != 10 && disas_coproc_insn(s, insn)) {
             /* Coprocessor.  */
             goto illegal_op;
         }
@@ -10691,7 +10658,14 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         ARCH(6T2);
     }
 
-    if (disas_t32(s, insn)) {
+    /*
+     * TODO: Perhaps merge these into one decodetree output file.
+     * Note disas_vfp is written for a32 with cond field in the 
+     * top nibble.  The t32 encoding requires 0xe in the top nibble.
+     */
+    if (disas_t32(s, insn) ||
+        disas_vfp_uncond(s, insn) ||
+        ((insn >> 28) == 0xe && disas_vfp(s, insn))) {
         return;
     }
     /* fall back to legacy decoder */
@@ -10708,17 +10682,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 goto illegal_op; /* op0 = 0b11 : unallocated */
             }
 
-            if (disas_vfp_insn(s, insn)) {
-                if (((insn >> 8) & 0xe) == 10 &&
-                    dc_isar_feature(aa32_fpsp_v2, s)) {
-                    /* FP, and the CPU supports it */
-                    goto illegal_op;
-                } else {
-                    /* All other insns: NOCP */
-                    gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
-                                       syn_uncategorized(),
-                                       default_exception_el(s));
-                }
+            if (((insn >> 8) & 0xe) == 10 &&
+                dc_isar_feature(aa32_fpsp_v2, s)) {
+                /* FP, and the CPU supports it */
+                goto illegal_op;
+            } else {
+                /* All other insns: NOCP */
+                gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
+                                   syn_uncategorized(),
+                                   default_exception_el(s));
             }
             break;
         }
@@ -10740,10 +10712,6 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
             if (disas_neon_data_insn(s, insn)) {
                 goto illegal_op;
             }
-        } else if (((insn >> 8) & 0xe) == 10) {
-            if (disas_vfp_insn(s, insn)) {
-                goto illegal_op;
-            }
         } else {
             if (insn & (1 << 28))
                 goto illegal_op;
-- 
2.20.1


