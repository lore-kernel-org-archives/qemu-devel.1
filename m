Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DEEC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2752242B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 03:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LVWIXQLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2752242B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXcBp-0001p2-DU
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 23:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7U-00068L-2d
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:28 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kXc7R-0005s8-SS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 23:27:27 -0400
Received: by mail-pj1-x1042.google.com with SMTP id h4so1788370pjk.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 20:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2jgCpFX/4z4yxSfwQUBESL4YrVuNrEMYDdELf2CSHJQ=;
 b=LVWIXQLXlv3jW+42kNQLr4t6N1pm6Mo7MRjE6LyTOXsM6IiInyNqSekmameXLqMZK5
 fEWPJoFgO90Of2l/0j27UIWWvgnT0LTBOn8FpYS42jaic+ghLJb5WXvRViGr44Y1q6UY
 42Hlr05Bs5UK2pY9GV+lLq0Wb70hMRdvuJSDS/7iVfUmCeZywLORyQg7+/e5V4jbbdLc
 9vUj26WTCNGntBaRyibgzu3DSHsPe5HJGae+Ix3f1Qz9LMUILVSWqWHYtEtMqpH5TA5A
 q6cwJd6DMPjm8GkxhDGblr0IBDAdGOV3zFh0Cd5/8XIOX50GK1TqhFeFwSoynRd4+z/K
 0Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2jgCpFX/4z4yxSfwQUBESL4YrVuNrEMYDdELf2CSHJQ=;
 b=h9Zx8MmJmnns31/IGJirrei5iQ64UACEvnANkH8r7e3/Ng1g03gmsBQNeYpeWhb61I
 tdCjMfo1bmr/b23jelhgel/QbABinv38kd57HJ+k1XwCeRFQ9tTJMzDH23lSF7gGCe6n
 6aasGtOTuZvKveca9c8DDhu5NPCObt/jjgZf3bvXfwDMR7ZcYhMGFekSUKZnUjtyAlxK
 lavZ3MuVN33DjwIUgiGCwPEJPwgHa6HTQzHyAl9LRBAmWzISP5OF0/QJo5W2mLyBtnwh
 Hw1bXXew7EjySJq3JX9RofC112ada0JX4Q6lPG7VSRn5f+7RjjJxulJWfNHFUKesl0wx
 C6Ww==
X-Gm-Message-State: AOAM5313T/8SRXov4HzPYRT/O3bKEguNN1jNe/0O99OIKnbNEQzdPBAp
 uZzqkA7spy64ikEuUL6jeQA/nOgEqOzp9A==
X-Google-Smtp-Source: ABdhPJw6G7dJI7qO1FvtxuQ7hqI5OlTkfQZ1zck9UIYgyKEBb1akok8do+Et1JKcFpO1cAUyFbGd/w==
X-Received: by 2002:a17:90a:eac7:: with SMTP id
 ev7mr5075816pjb.55.1603855644033; 
 Tue, 27 Oct 2020 20:27:24 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d26sm3764413pfo.82.2020.10.27.20.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 20:27:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] target/arm: Improve do_prewiden_3d
Date: Tue, 27 Oct 2020 20:27:03 -0700
Message-Id: <20201028032703.201526-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028032703.201526-1-richard.henderson@linaro.org>
References: <20201028032703.201526-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can use proper widening loads to extend 32-bit inputs,
and skip the "widenfn" step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c          |  6 +++
 target/arm/translate-neon.c.inc | 66 ++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 29 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7611c1f0f1..29ea1eb781 100644
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
index 7cd41c79ec..8f33b54067 100644
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
2.25.1


