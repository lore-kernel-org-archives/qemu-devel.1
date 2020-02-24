Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B44C38BFF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795562176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tF5EoHy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795562176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MLW-0002Ky-MX
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37955)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7o-0004Xp-Pt
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7n-0005us-Cv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:52 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46341)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7n-0005uN-6V
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:51 -0500
Received: by mail-pg1-x543.google.com with SMTP id y30so5817897pga.13
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jm8KlY79fmi10gEwUaheKwxsBU3LYmbPeN5QBjFnnb0=;
 b=tF5EoHy5mkqDGJ11etcAOiB0Np57GLPUdwsPK1yz19pH0koGH/STl2Yc73VDAWUgAh
 NdMaFiBTz/m0AgPc41k0z+WeYCY7EoYDLsq+ttMBFy95yDu0iyl8EBY+nQ1AiBYyuWPB
 owt6cWmAv/x+1NU12HAuE+eaMv6RydEtWKiTi95pALW1Q3zEBPY9kkL/hJVBZHNE6Jd5
 5FlAuAYCr+VouSgI+8lUb6FZCo8DP4zjcZ7w59QZBng0cUjQun7RUdcCEMOPMbLx1A9v
 YtnMTi3yiQTJXWJT/T2VF0kWoPmUKxPlqwL3bm4YM5b2ewvHkTf/a2N++NnCmt721GlC
 TVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jm8KlY79fmi10gEwUaheKwxsBU3LYmbPeN5QBjFnnb0=;
 b=RxmscznJrQEcYEYPaSag40yF7v8JP2v4dEdZr8xlHLxLyxaM6DwxgAzydS9I1zzWm8
 zWcP16/ESR0NDPi2x7zCWfjsqesBhz8rnc+MsTG4fJZPJD1zFiZd1+BKMCfhjeT1d9q6
 ms9hphNby7gCylFqwojUeLiwgyrT2Hq6BUjyacZAEquET7Al4d4nD8N4UjHsW37k4rKo
 iEGPOMs2Ca1XQCBrULObMx6yu/VCFFg+cnLFV9rjrk6O+q+UqG4gPNW78Ic2FPvuQY2a
 i4kUD9xVCZsg62fvWnzyixM9zlgP9rqym3uhjdlHThGdmVib/XDsGsVsl7R3OiWijn1T
 U1Mg==
X-Gm-Message-State: APjAAAX0Bvh8kQS/LushH/M4sBIDwIveCsLuXf0PRXB0tTaLxJAC8Dfr
 J2eziG7PKH9NBtVi4YpuGoPT8wrYQ2s=
X-Google-Smtp-Source: APXvYqzXHK7wmq7szzmDa9BJUqt40iM7rniCQefQiXXJlK6vHVoA+Wec/8IM+dH34W3/iSFAOBzKOw==
X-Received: by 2002:a62:ab06:: with SMTP id p6mr29829193pff.52.1582582969821; 
 Mon, 24 Feb 2020 14:22:49 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/17] target/arm: Move the vfp decodetree calls next to
 the base isa
Date: Mon, 24 Feb 2020 14:22:27 -0800
Message-Id: <20200224222232.13807-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200224222232.13807-1-richard.henderson@linaro.org>
References: <20200224222232.13807-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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

Have the calls adjacent as an intermediate step toward
actually merging the decodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Fix fallthrough in disas_arm_insn vs vfp insns.
---
 target/arm/translate.c | 83 +++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5b7cad1ea2..6259064ea7 100644
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
@@ -10778,7 +10753,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         ARCH(5);
 
         /* Unconditional instructions.  */
-        if (disas_a32_uncond(s, insn)) {
+        /* TODO: Perhaps merge these into one decodetree output file.  */
+        if (disas_a32_uncond(s, insn) ||
+            disas_vfp_uncond(s, insn)) {
             return;
         }
         /* fall back to legacy decoder */
@@ -10805,13 +10782,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -10842,7 +10812,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
         arm_skip_unless(s, cond);
     }
 
-    if (disas_a32(s, insn)) {
+    /* TODO: Perhaps merge these into one decodetree output file.  */
+    if (disas_a32(s, insn) ||
+        disas_vfp(s, insn)) {
         return;
     }
     /* fall back to legacy decoder */
@@ -10852,11 +10824,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
     case 0xd:
     case 0xe:
         if (((insn >> 8) & 0xe) == 10) {
-            /* VFP.  */
-            if (disas_vfp_insn(s, insn)) {
-                goto illegal_op;
-            }
-        } else if (disas_coproc_insn(s, insn)) {
+            /* VFP, but failed disas_vfp.  */
+            goto illegal_op;
+        }
+        if (disas_coproc_insn(s, insn)) {
             /* Coprocessor.  */
             goto illegal_op;
         }
@@ -10945,7 +10916,14 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -10962,17 +10940,15 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
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
@@ -10995,9 +10971,8 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
                 goto illegal_op;
             }
         } else if (((insn >> 8) & 0xe) == 10) {
-            if (disas_vfp_insn(s, insn)) {
-                goto illegal_op;
-            }
+            /* VFP, but failed disas_vfp.  */
+            goto illegal_op;
         } else {
             if (insn & (1 << 28))
                 goto illegal_op;
-- 
2.20.1


