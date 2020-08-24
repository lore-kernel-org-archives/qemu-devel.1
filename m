Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F440C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F25DF206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYqi7V4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25DF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA99m-0005md-5c
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46890)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95j-0005MI-K0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:50533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95h-0004oy-5r
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id t2so7449112wma.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=bicHsrkJoIe9jeaWg/9f6nFp7gIOjDehttwEI0gLG2o=;
 b=QYqi7V4vcBcgg/EE2vIm6WNkSj0Sj7Jg/Wheh/USsydsRiV5l0rDiznxd7yG+8tyyF
 3KfOlH0s666gNC/YUDY+/4/VwknpbNaVx4FTIjetFMl0qQ8YLxyZiHJkY4RD90j6CVdS
 JgqQGBAduNjJdZucGh6qwaMAzUOJBhzGNLBOvX8goeQ1dmq0uDkaNJRHxbeJ6/anpgFq
 6MK2yI43hrq9tFqCg95gX8hpdN19yqu3O66h989tE4n6ZWHKRasusd193UGoRd+f1dhZ
 b1t1uyCallSEbIZMdZF1LxhqvQulX1XF8M7HlUtpC89uPazgsB3oyT4w2dsIDsx+OpVx
 tviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bicHsrkJoIe9jeaWg/9f6nFp7gIOjDehttwEI0gLG2o=;
 b=hDXMu4OhRkq4bz8jeMUKsP8C5qZAl7tUaSUUDN+ha3EA3VXiJtTUCvnUxRk1JgoSK6
 LmWNyNMGr/G9qAqScj972I8zth/lULVRDEtTS8NqqYbsriobutydp/ftmTngIJIEyU9H
 Wd1i9wl25ow10OzpfeBAVSGN9qhWUQy50KQ+iHk4O7HkLZ4BKEyuXfLoRYw2HJZy9qyK
 MEsXspudMxfdh/YeWajhiL56mKnOpALE5GzE/X+MUWUDwOesaNwj8OAE0du92QqzolXp
 B0kgpthwuXi1c0r9Jyxzxu8aGznKN7XdMo33jjLwCPdrQKB1yNcj6o/EnBSSp/JCJXYh
 GtLA==
X-Gm-Message-State: AOAM532Px5HbL31eKmlNXel//n7IeicWSpNqYfQ1ur8O3mABVJqBWozW
 2Ugjkporpi9v5tSqHuZ9e1vquuNqbCRSS7QU
X-Google-Smtp-Source: ABdhPJwq6dZQX90WCcrEifnlxk72oCnsDWWKa7xi+PWvCQLm/nw3yyV/2uOlHcL8LpY0Ifjac2kVCA==
X-Received: by 2002:a1c:9dc7:: with SMTP id g190mr3178243wme.118.1598262515274; 
 Mon, 24 Aug 2020 02:48:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/27] target/arm: Do M-profile NOCP checks early and via
 decodetree
Date: Mon, 24 Aug 2020 10:48:02 +0100
Message-Id: <20200824094811.15439-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

For M-profile CPUs, the architecture specifies that the NOCP
exception when a coprocessor is not present or disabled should cover
the entire wide range of coprocessor-space encodings, and should take
precedence over UNDEF exceptions.  (This is the opposite of
A-profile, where checking for a disabled FPU has to happen last.)

Implement this with decodetree patterns that cover the specified
ranges of the encoding space.  There are a few instructions (VLLDM,
VLSTM, and in v8.1 also VSCCLRM) which are in copro-space but must
not be NOCP'd: these must be handled also in the new m-nocp.decode so
they take precedence.

This is a minor behaviour change: for unallocated insn patterns in
the VFP area (cp=10,11) we will now NOCP rather than UNDEF when the
FPU is disabled.

As well as giving us the correct architectural behaviour for v8.1M
and the recommended behaviour for v8.0M, this refactoring also
removes the old NOCP handling from the remains of the 'legacy
decoder' in disas_thumb2_insn(), paving the way for cleaning that up.

Since we don't currently have a v8.1M feature bit or any v8.1M CPUs,
the minor changes to this logic that we'll need for v8.1M are marked
up with TODO comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200803111849.13368-6-peter.maydell@linaro.org
---
 target/arm/m-nocp.decode       | 42 +++++++++++++++++++++++++++
 target/arm/vfp.decode          |  2 --
 target/arm/translate.c         | 30 ++++++++++----------
 target/arm/meson.build         |  1 +
 target/arm/translate-vfp.c.inc | 52 +++++++++++++++++++++++++++-------
 5 files changed, 100 insertions(+), 27 deletions(-)
 create mode 100644 target/arm/m-nocp.decode

diff --git a/target/arm/m-nocp.decode b/target/arm/m-nocp.decode
new file mode 100644
index 00000000000..7182d7d1217
--- /dev/null
+++ b/target/arm/m-nocp.decode
@@ -0,0 +1,42 @@
+# M-profile UserFault.NOCP exception handling
+#
+#  Copyright (c) 2020 Linaro, Ltd
+#
+# This library is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This library is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library; if not, see <http://www.gnu.org/licenses/>.
+
+#
+# This file is processed by scripts/decodetree.py
+#
+# For M-profile, the architecture specifies that NOCP UsageFaults
+# should take precedence over UNDEF faults over the whole wide
+# range of coprocessor-space encodings, with the exception of
+# VLLDM and VLSTM. (Compare v8.1M IsCPInstruction() pseudocode and
+# v8M Arm ARM rule R_QLGM.) This isn't mandatory for v8.0M but we choose
+# to behave the same as v8.1M.
+# This decode is handled before any others (and in particular before
+# decoding FP instructions which are in the coprocessor space).
+# If the coprocessor is not present or disabled then we will generate
+# the NOCP exception; otherwise we let the insn through to the main decode.
+
+{
+  # Special cases which do not take an early NOCP: VLLDM and VLSTM
+  VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
+  # TODO: VSCCLRM (new in v8.1M) is similar:
+  #VSCCLRM      1110 1100 1-01 1111 ---- 1011 ---- ---0
+
+  NOCP         111- 1110 ---- ---- ---- cp:4 ---- ----
+  NOCP         111- 110- ---- ---- ---- cp:4 ---- ----
+  # TODO: From v8.1M onwards we will also want this range to NOCP
+  #NOCP_8_1     111- 1111 ---- ---- ---- ---- ---- ---- cp=10
+}
diff --git a/target/arm/vfp.decode b/target/arm/vfp.decode
index 5fd70f975ae..2c793e3e87f 100644
--- a/target/arm/vfp.decode
+++ b/target/arm/vfp.decode
@@ -213,5 +213,3 @@ VCVT_sp_int  ---- 1110 1.11 110 s:1 .... 1010 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_sp
 VCVT_dp_int  ---- 1110 1.11 110 s:1 .... 1011 rz:1 1.0 .... \
              vd=%vd_sp vm=%vm_dp
-
-VLLDM_VLSTM  1110 1100 001 l:1 rn:4 0000 1010 0000 0000
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 362d1cc50fb..958e9b6699f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1176,6 +1176,7 @@ static TCGv_ptr vfp_reg_ptr(bool dp, int reg)
 #define ARM_CP_RW_BIT   (1 << 20)
 
 /* Include the VFP and Neon decoders */
+#include "decode-m-nocp.c.inc"
 #include "translate-vfp.c.inc"
 #include "translate-neon.c.inc"
 
@@ -8433,6 +8434,19 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         ARCH(6T2);
     }
 
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        /*
+         * NOCP takes precedence over any UNDEF for (almost) the
+         * entire wide range of coprocessor-space encodings, so check
+         * for it first before proceeding to actually decode eg VFP
+         * insns. This decode also handles the few insns which are
+         * in copro space but do not have NOCP checks (eg VLLDM, VLSTM).
+         */
+        if (disas_m_nocp(s, insn)) {
+            return;
+        }
+    }
+
     if ((insn & 0xef000000) == 0xef000000) {
         /*
          * T32 encodings 0b111p_1111_qqqq_qqqq_qqqq_qqqq_qqqq_qqqq
@@ -8481,21 +8495,7 @@ static void disas_thumb2_insn(DisasContext *s, uint32_t insn)
         /* Coprocessor.  */
         if (arm_dc_feature(s, ARM_FEATURE_M)) {
             /* 0b111x_11xx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx */
-            if (extract32(insn, 24, 2) == 3) {
-                goto illegal_op; /* op0 = 0b11 : unallocated */
-            }
-
-            if (((insn >> 8) & 0xe) == 10 &&
-                dc_isar_feature(aa32_fpsp_v2, s)) {
-                /* FP, and the CPU supports it */
-                goto illegal_op;
-            } else {
-                /* All other insns: NOCP */
-                gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
-                                   syn_uncategorized(),
-                                   default_exception_el(s));
-            }
-            break;
+            goto illegal_op;
         }
         if (((insn >> 24) & 3) == 3) {
             /* Neon DP, but failed disas_neon_dp() */
diff --git a/target/arm/meson.build b/target/arm/meson.build
index bd46cdb5239..89900907125 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,6 +5,7 @@ gen = [
   decodetree.process('neon-ls.decode', extra_args: '--static-decode=disas_neon_ls'),
   decodetree.process('vfp.decode', extra_args: '--static-decode=disas_vfp'),
   decodetree.process('vfp-uncond.decode', extra_args: '--static-decode=disas_vfp_uncond'),
+  decodetree.process('m-nocp.decode', extra_args: '--static-decode=disas_m_nocp'),
   decodetree.process('a32.decode', extra_args: '--static-decode=disas_a32'),
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
diff --git a/target/arm/translate-vfp.c.inc b/target/arm/translate-vfp.c.inc
index 2d63fa0d399..d376bd1c1ad 100644
--- a/target/arm/translate-vfp.c.inc
+++ b/target/arm/translate-vfp.c.inc
@@ -95,14 +95,11 @@ static inline long vfp_f16_offset(unsigned reg, bool top)
 static bool full_vfp_access_check(DisasContext *s, bool ignore_vfp_enabled)
 {
     if (s->fp_excp_el) {
-        if (arm_dc_feature(s, ARM_FEATURE_M)) {
-            gen_exception_insn(s, s->pc_curr, EXCP_NOCP, syn_uncategorized(),
-                               s->fp_excp_el);
-        } else {
-            gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
-                               syn_fp_access_trap(1, 0xe, false),
-                               s->fp_excp_el);
-        }
+        /* M-profile handled this earlier, in disas_m_nocp() */
+        assert (!arm_dc_feature(s, ARM_FEATURE_M));
+        gen_exception_insn(s, s->pc_curr, EXCP_UDEF,
+                           syn_fp_access_trap(1, 0xe, false),
+                           s->fp_excp_el);
         return false;
     }
 
@@ -2842,9 +2839,14 @@ static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
         !arm_dc_feature(s, ARM_FEATURE_V8)) {
         return false;
     }
-    /* If not secure, UNDEF. */
+    /*
+     * If not secure, UNDEF. We must emit code for this
+     * rather than returning false so that this takes
+     * precedence over the m-nocp.decode NOCP fallback.
+     */
     if (!s->v8m_secure) {
-        return false;
+        unallocated_encoding(s);
+        return true;
     }
     /* If no fpu, NOP. */
     if (!dc_isar_feature(aa32_vfp, s)) {
@@ -2863,3 +2865,33 @@ static bool trans_VLLDM_VLSTM(DisasContext *s, arg_VLLDM_VLSTM *a)
     s->base.is_jmp = DISAS_UPDATE_EXIT;
     return true;
 }
+
+static bool trans_NOCP(DisasContext *s, arg_NOCP *a)
+{
+    /*
+     * Handle M-profile early check for disabled coprocessor:
+     * all we need to do here is emit the NOCP exception if
+     * the coprocessor is disabled. Otherwise we return false
+     * and the real VFP/etc decode will handle the insn.
+     */
+    assert(arm_dc_feature(s, ARM_FEATURE_M));
+
+    if (a->cp == 11) {
+        a->cp = 10;
+    }
+    /* TODO: in v8.1M cp 8, 9, 14, 15 also are governed by the cp10 enable */
+
+    if (a->cp != 10) {
+        gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
+                           syn_uncategorized(), default_exception_el(s));
+        return true;
+    }
+
+    if (s->fp_excp_el != 0) {
+        gen_exception_insn(s, s->pc_curr, EXCP_NOCP,
+                           syn_uncategorized(), s->fp_excp_el);
+        return true;
+    }
+
+    return false;
+}
-- 
2.20.1


