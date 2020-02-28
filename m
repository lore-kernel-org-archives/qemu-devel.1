Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BF5C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C14B24672
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3TDQLEn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C14B24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ivr-0003y9-Aw
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifJ-0007ju-Gl
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifH-0001x6-U4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifH-0001wY-No
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id d138so2303904wmd.5
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/fspnfbWHr/iEc26cj3LysOXZAm0hum7R0BOuileGqY=;
 b=Z3TDQLEnn2KAhrI5sZeL3qfZxJrRZhngXm27pLNarxuobTbmtUXL07LrnPuhATd2NB
 veibm57iaNXkRDrrmgneS+5t8DX15408H6sEQL36gzuR6cy93fc+rF9C33XGwtj3CB7X
 cOo4dH4XoT8iyMvL8ztOGh4QIT93CboIPICNxvJYP80i3PxRdYq4Gyaz4ObaXQOhRh2I
 1UL/Lo7jU7kuuWapEaVdWvLKkGrL2YFT2gzUXRBgC9HQmFZZLPeI9+FortsYDWgdplui
 GWyZU2FKPYZ+JVRYTAQW4oPsWbQrogksSN6Yyl6pIaOxKrZHAYZM2jbSv/9O7hnigPy7
 rlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/fspnfbWHr/iEc26cj3LysOXZAm0hum7R0BOuileGqY=;
 b=XXFbWrOXQu8KiAjE+72jFX/acYTEw+3p+8oXlw1mlOn3IrfviKyuEL53tZeiq/mewI
 bjMGigx4XKdI1ZWorP1L0ZBtvhcSyPXgKYErUpi1GffgfXlvqqqCi6hKEtxtXc1HrhmE
 tc1mI3n7MSu+sPvzNA94aB2N6P29RGOdsa7lqLit1heirKT6hrO3y1jck1ZyXnzOXZDB
 QWT20uFAz0xcV4AnEbsxHB4LNVyiD3DmlUSXxDIysmj2Bf7pkGagLxCIJ+buQ7Iy1l4n
 Vz19kJFfb2PZ6Si37Oer7YuOwmgKkhX6qjI4hebftj5v48olfUVLH03lE7gidv3aYan4
 CAQQ==
X-Gm-Message-State: APjAAAWR9nbjJAhdqzYdbrlt0v5qCNXU4KL9L8kv2URwI2WKedpkaeLt
 tziGNLAFttY+Z65nqr0nKyZsNdzFUaj1+g==
X-Google-Smtp-Source: APXvYqyIV/o92HQoNA1SwD3Fbi4Bmmp7bKwD0yiU6Q6KoSW/RJpweLxWxxdfI+xIE2FJ3F9qtPelAA==
X-Received: by 2002:a1c:48c1:: with SMTP id v184mr5517173wma.5.1582907942412; 
 Fri, 28 Feb 2020 08:39:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.39.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:39:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/33] target/arm: Move the vfp decodetree calls next to the
 base isa
Date: Fri, 28 Feb 2020 16:38:24 +0000
Message-Id: <20200228163840.23585-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

From: Richard Henderson <richard.henderson@linaro.org>

Have the calls adjacent as an intermediate step toward
actually merging the decodes.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200224222232.13807-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 83 +++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 54 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 5b7cad1ea2d..6259064ea7c 100644
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


