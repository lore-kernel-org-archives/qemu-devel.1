Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1D7C388F2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6145C20657
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 17:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhX270GY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6145C20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZdOE-0003uW-7f
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 12:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLr-0000vY-RY
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37911)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZdLk-0006Zl-CM
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 12:10:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id h62so5403179wme.3
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 09:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7fby/0TuuZpYxtRHhQs2DBDavF3wDEA6qD1fHKLIF9A=;
 b=zhX270GYkb9gUVD5kQ1QWboUi4iVqUsk9q5vTs1tc//YBzWpyZg8X3KVo4JHRJjjBl
 c4n5ll9XJYbFQYVW1pSQIVOjiece/v/QOTuAznFDpWzBpKwBsDGphrJfK8sQxcTlQMXK
 t4XNefBNrc8VUxlInWmopxOVoSkcE506J21DRE6bD7Yqb0n8WtXGSLIF/95PKnH8HeSI
 jylWd08hP7+2/Z3qlmSYq3TK+1dONNO2d8BqE3t6WhD2uc8yI4I79Xq2yF+MpYRpZ5xW
 /SsEcVRhaGiTaqsIS1b6DoGILX1fDeX9P1cSsAYBsmIJweVV+m//lmwIZeq5i/aMdE3z
 Y4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7fby/0TuuZpYxtRHhQs2DBDavF3wDEA6qD1fHKLIF9A=;
 b=OYG6udx95p/4e40YaF2TTE3q6AlcdBtZ3SJZF9h3v6oFpl8VVW9ph3BSq5eou/cs6V
 4TpxtSDPC0dPXLns3LRUX68leVEGXEF18Ekar9mtXRYWtras6QcPi7KQfgBqYc0wTlQI
 og8NOOmzipOcuFi1hLQGaeORioMdc9vkYNV7Eyn0uxWCof9tzCyANYwWJZIV+/nbg0Mq
 siPVs12C4Jk0/7z5gvtVMEMkodqs6K3ep1Jc6XsOjh/q6YmNP4VhV/rDCKWCwl78HcNx
 32iEiFDApEiPaPKKaGcC3ENgN6DKWD1tj9cCdhh1+btHjhQXwBK4IvPXWtCTtb8RPSST
 sBXw==
X-Gm-Message-State: AOAM532viFNtIqVILvYYf5pwIh62jH539dmdFnODI4ASwBTBbOW6tq0s
 jB19c7ozyeayXqLaC1uxuBDD5wKrjObcdw==
X-Google-Smtp-Source: ABdhPJywUHQdnaFIQ/lAaydRr5E3DfKY7Hn99KzeA2Jcn9K5/d6JO9tujQ6BBnkw0WKUqXynOZHOWw==
X-Received: by 2002:a1c:9e0e:: with SMTP id h14mr18312868wme.18.1604337030649; 
 Mon, 02 Nov 2020 09:10:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c18sm22396540wrt.10.2020.11.02.09.10.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:10:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/26] target/arm: Improve do_prewiden_3d
Date: Mon,  2 Nov 2020 17:09:50 +0000
Message-Id: <20201102171005.30690-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201102171005.30690-1-peter.maydell@linaro.org>
References: <20201102171005.30690-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We can use proper widening loads to extend 32-bit inputs,
and skip the "widenfn" step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20201030022618.785675-12-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c          |  6 +++
 target/arm/translate-neon.c.inc | 66 ++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7611c1f0f15..29ea1eb7811 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1183,6 +1183,12 @@ static void read_neon_element64(TCGv_i64 dest, int reg, int ele, MemOp memop)
     long off = neon_element_offset(reg, ele, memop);
 
     switch (memop) {
+    case MO_SL:
+        tcg_gen_ld32s_i64(dest, cpu_env, off);
+        break;
+    case MO_UL:
+        tcg_gen_ld32u_i64(dest, cpu_env, off);
+        break;
     case MO_Q:
         tcg_gen_ld_i64(dest, cpu_env, off);
         break;
diff --git a/target/arm/translate-neon.c.inc b/target/arm/translate-neon.c.inc
index 1c16c56e7ec..59368cb2436 100644
--- a/target/arm/translate-neon.c.inc
+++ b/target/arm/translate-neon.c.inc
@@ -1788,11 +1788,10 @@ static bool trans_Vimm_1r(DisasContext *s, arg_1reg_imm *a)
 static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
                            NeonGenWidenFn *widenfn,
                            NeonGenTwo64OpFn *opfn,
-                           bool src1_wide)
+                           int src1_mop, int src2_mop)
 {
     /* 3-regs different lengths, prewidening case (VADDL/VSUBL/VAADW/VSUBW) */
     TCGv_i64 rn0_64, rn1_64, rm_64;
-    TCGv_i32 rm;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -1804,12 +1803,12 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
         return false;
     }
 
-    if (!widenfn || !opfn) {
+    if (!opfn) {
         /* size == 3 case, which is an entirely different insn group */
         return false;
     }
 
-    if ((a->vd & 1) || (src1_wide && (a->vn & 1))) {
+    if ((a->vd & 1) || (src1_mop == MO_Q && (a->vn & 1))) {
         return false;
     }
 
@@ -1821,40 +1820,48 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     rn1_64 = tcg_temp_new_i64();
     rm_64 = tcg_temp_new_i64();
 
-    if (src1_wide) {
-        read_neon_element64(rn0_64, a->vn, 0, MO_64);
+    if (src1_mop >= 0) {
+        read_neon_element64(rn0_64, a->vn, 0, src1_mop);
     } else {
         TCGv_i32 tmp = tcg_temp_new_i32();
         read_neon_element32(tmp, a->vn, 0, MO_32);
         widenfn(rn0_64, tmp);
         tcg_temp_free_i32(tmp);
     }
-    rm = tcg_temp_new_i32();
-    read_neon_element32(rm, a->vm, 0, MO_32);
+    if (src2_mop >= 0) {
+        read_neon_element64(rm_64, a->vm, 0, src2_mop);
+    } else {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        read_neon_element32(tmp, a->vm, 0, MO_32);
+        widenfn(rm_64, tmp);
+        tcg_temp_free_i32(tmp);
+    }
 
-    widenfn(rm_64, rm);
-    tcg_temp_free_i32(rm);
     opfn(rn0_64, rn0_64, rm_64);
 
     /*
      * Load second pass inputs before storing the first pass result, to
      * avoid incorrect results if a narrow input overlaps with the result.
      */
-    if (src1_wide) {
-        read_neon_element64(rn1_64, a->vn, 1, MO_64);
+    if (src1_mop >= 0) {
+        read_neon_element64(rn1_64, a->vn, 1, src1_mop);
     } else {
         TCGv_i32 tmp = tcg_temp_new_i32();
         read_neon_element32(tmp, a->vn, 1, MO_32);
         widenfn(rn1_64, tmp);
         tcg_temp_free_i32(tmp);
     }
-    rm = tcg_temp_new_i32();
-    read_neon_element32(rm, a->vm, 1, MO_32);
+    if (src2_mop >= 0) {
+        read_neon_element64(rm_64, a->vm, 1, src2_mop);
+    } else {
+        TCGv_i32 tmp = tcg_temp_new_i32();
+        read_neon_element32(tmp, a->vm, 1, MO_32);
+        widenfn(rm_64, tmp);
+        tcg_temp_free_i32(tmp);
+    }
 
     write_neon_element64(rn0_64, a->vd, 0, MO_64);
 
-    widenfn(rm_64, rm);
-    tcg_temp_free_i32(rm);
     opfn(rn1_64, rn1_64, rm_64);
     write_neon_element64(rn1_64, a->vd, 1, MO_64);
 
@@ -1865,14 +1872,13 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
     return true;
 }
 
-#define DO_PREWIDEN(INSN, S, EXT, OP, SRC1WIDE)                         \
+#define DO_PREWIDEN(INSN, S, OP, SRC1WIDE, SIGN)                        \
     static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
     {                                                                   \
         static NeonGenWidenFn * const widenfn[] = {                     \
             gen_helper_neon_widen_##S##8,                               \
             gen_helper_neon_widen_##S##16,                              \
-            tcg_gen_##EXT##_i32_i64,                                    \
-            NULL,                                                       \
+            NULL, NULL,                                                 \
         };                                                              \
         static NeonGenTwo64OpFn * const addfn[] = {                     \
             gen_helper_neon_##OP##l_u16,                                \
@@ -1880,18 +1886,20 @@ static bool do_prewiden_3d(DisasContext *s, arg_3diff *a,
             tcg_gen_##OP##_i64,                                         \
             NULL,                                                       \
         };                                                              \
-        return do_prewiden_3d(s, a, widenfn[a->size],                   \
-                              addfn[a->size], SRC1WIDE);                \
+        int narrow_mop = a->size == MO_32 ? MO_32 | SIGN : -1;          \
+        return do_prewiden_3d(s, a, widenfn[a->size], addfn[a->size],   \
+                              SRC1WIDE ? MO_Q : narrow_mop,             \
+                              narrow_mop);                              \
     }
 
-DO_PREWIDEN(VADDL_S, s, ext, add, false)
-DO_PREWIDEN(VADDL_U, u, extu, add, false)
-DO_PREWIDEN(VSUBL_S, s, ext, sub, false)
-DO_PREWIDEN(VSUBL_U, u, extu, sub, false)
-DO_PREWIDEN(VADDW_S, s, ext, add, true)
-DO_PREWIDEN(VADDW_U, u, extu, add, true)
-DO_PREWIDEN(VSUBW_S, s, ext, sub, true)
-DO_PREWIDEN(VSUBW_U, u, extu, sub, true)
+DO_PREWIDEN(VADDL_S, s, add, false, MO_SIGN)
+DO_PREWIDEN(VADDL_U, u, add, false, 0)
+DO_PREWIDEN(VSUBL_S, s, sub, false, MO_SIGN)
+DO_PREWIDEN(VSUBL_U, u, sub, false, 0)
+DO_PREWIDEN(VADDW_S, s, add, true, MO_SIGN)
+DO_PREWIDEN(VADDW_U, u, add, true, 0)
+DO_PREWIDEN(VSUBW_S, s, sub, true, MO_SIGN)
+DO_PREWIDEN(VSUBW_U, u, sub, true, 0)
 
 static bool do_narrow_3d(DisasContext *s, arg_3diff *a,
                          NeonGenTwo64OpFn *opfn, NeonGenNarrowFn *narrowfn)
-- 
2.20.1


