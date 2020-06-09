Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB649C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FDD20760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="plqyZ/e/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FDD20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigos-0004Si-O0
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighj-0003Mx-28
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighh-0003RW-5G
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id l26so3351709wme.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dFdsf0awDgnbeOkGxCbfVxPQlEMuI1Pc0StnYKQsJXk=;
 b=plqyZ/e/j8vvVISc9MRbUHnO3fEOPdZJAGOUPm1tHiKt7qBZthaswMskYZ46g71KW7
 9DRH1UqQA+BZ+pXc1EiY0kczgX3belM+1gR/sOKYO1cn1AxgEkEI5IBeCN0pa5dhbTRA
 Fb5ksXAOs695+9/mDpneAOtU05AyF062hIRcTkBd6FTDnqAeFkVYQFRB09pymjQLzU90
 f02HOAF/847889wDg6ZXB7KDDGBiNn6nnI54dtn2iH0BoWFjibgDDFjc2tcIqrylRZc/
 BZs6DcqUAVzyOFOzdtn+0w70P8sGEHd4PsZvEt4l9yf2UMIIjUrBMuASHX/YfmxSHEYl
 3Ncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dFdsf0awDgnbeOkGxCbfVxPQlEMuI1Pc0StnYKQsJXk=;
 b=KBGkMD1BjRM6kBAkgKBVMS3iAGSXT9a+ncBxHnQ6vsaGaUq8xJMkxlT10dh1ieHPvG
 bmOwPQBw7LLAH34ADiFsM77mKGfoV/f8iU0VZmIS9gvfJ+qLNZOQwndnHGrXFeqRRnK0
 iWGK2jOjVAaOYrLPKp3FMcOi08vRFxN10T0uT2hgcA8JqMkkHhaClLdcqugAUTzWCajT
 KsKqamv/JjN5njb36xdldmOS43as69NlDciKQMTV47TKzcLMTC0Mn2t/cELxrtSWS1Po
 /Nmf41/KuQBVgqu/kCrryJ6H8n09Zf5NinnKeXjhAg+Cr40Fz3kJdaiW9St4ydRAS9Y6
 JhNA==
X-Gm-Message-State: AOAM532cJf1EsakxbDuNLWRcWrKG0Fah56ArvbX8n8VxBrHcUWv5S7gk
 iQk3dGeHQIWeFtUm7Z0JyqSX9A==
X-Google-Smtp-Source: ABdhPJzbM/H5/OcfIe4DhDUQ6J+Ez9QrasSyusRi9/HBZsuJfeKHaTM39AyNTEyzxRW8KqQmaIfBOg==
X-Received: by 2002:a05:600c:2110:: with SMTP id
 u16mr4694096wml.26.1591718539489; 
 Tue, 09 Jun 2020 09:02:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b81sm3699867wmc.5.2020.06.09.09.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:02:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/7] target/arm: Convert Neon 3-reg-diff long multiplies
Date: Tue,  9 Jun 2020 17:02:07 +0100
Message-Id: <20200609160209.29960-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
References: <20200609160209.29960-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the Neon 3-reg-diff insns VMULL, VMLAL and VMLSL; these perform
a 32x32->64 multiply with possible accumulate.

Note that for VMLSL we do the accumulate directly with a subtraction
rather than doing a negate-then-add as the old code did.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/neon-dp.decode       |  9 +++++
 target/arm/translate-neon.inc.c | 71 +++++++++++++++++++++++++++++++++
 target/arm/translate.c          | 21 +++-------
 3 files changed, 86 insertions(+), 15 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index 4f0aaaf6bb2..1da492df146 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -450,5 +450,14 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
 
     VABDL_S_3d   1111 001 0 1 . .. .... .... 0111 . 0 . 0 .... @3diff
     VABDL_U_3d   1111 001 1 1 . .. .... .... 0111 . 0 . 0 .... @3diff
+
+    VMLAL_S_3d   1111 001 0 1 . .. .... .... 1000 . 0 . 0 .... @3diff
+    VMLAL_U_3d   1111 001 1 1 . .. .... .... 1000 . 0 . 0 .... @3diff
+
+    VMLSL_S_3d   1111 001 0 1 . .. .... .... 1010 . 0 . 0 .... @3diff
+    VMLSL_U_3d   1111 001 1 1 . .. .... .... 1010 . 0 . 0 .... @3diff
+
+    VMULL_S_3d   1111 001 0 1 . .. .... .... 1100 . 0 . 0 .... @3diff
+    VMULL_U_3d   1111 001 1 1 . .. .... .... 1100 . 0 . 0 .... @3diff
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index fd85ff5ea50..00a779c65a0 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2151,3 +2151,74 @@ static bool trans_VABAL_U_3d(DisasContext *s, arg_3diff *a)
 
     return do_long_3d(s, a, opfn[a->size], addfn[a->size]);
 }
+
+static void gen_mull_s32(TCGv_i64 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    TCGv_i32 lo = tcg_temp_new_i32();
+    TCGv_i32 hi = tcg_temp_new_i32();
+
+    tcg_gen_muls2_i32(lo, hi, rn, rm);
+    tcg_gen_concat_i32_i64(rd, lo, hi);
+
+    tcg_temp_free_i32(lo);
+    tcg_temp_free_i32(hi);
+}
+
+static void gen_mull_u32(TCGv_i64 rd, TCGv_i32 rn, TCGv_i32 rm)
+{
+    TCGv_i32 lo = tcg_temp_new_i32();
+    TCGv_i32 hi = tcg_temp_new_i32();
+
+    tcg_gen_mulu2_i32(lo, hi, rn, rm);
+    tcg_gen_concat_i32_i64(rd, lo, hi);
+
+    tcg_temp_free_i32(lo);
+    tcg_temp_free_i32(hi);
+}
+
+static bool trans_VMULL_S_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        gen_helper_neon_mull_s8,
+        gen_helper_neon_mull_s16,
+        gen_mull_s32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VMULL_U_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        gen_helper_neon_mull_u8,
+        gen_helper_neon_mull_u16,
+        gen_mull_u32,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+#define DO_VMLAL(INSN,MULL,ACC)                                         \
+    static bool trans_##INSN##_3d(DisasContext *s, arg_3diff *a)        \
+    {                                                                   \
+        NeonGenTwoOpWidenFn *opfn[] = {                                 \
+            gen_helper_neon_##MULL##8,                                  \
+            gen_helper_neon_##MULL##16,                                 \
+            gen_##MULL##32,                                             \
+            NULL,                                                       \
+        };                                                              \
+        NeonGenTwo64OpFn *accfn[] = {                                   \
+            gen_helper_neon_##ACC##l_u16,                               \
+            gen_helper_neon_##ACC##l_u32,                               \
+            tcg_gen_##ACC##_i64,                                        \
+            NULL,                                                       \
+        };                                                              \
+        return do_long_3d(s, a, opfn[a->size], accfn[a->size]);         \
+    }
+
+DO_VMLAL(VMLAL_S,mull_s,add)
+DO_VMLAL(VMLAL_U,mull_u,add)
+DO_VMLAL(VMLSL_S,mull_s,sub)
+DO_VMLAL(VMLSL_U,mull_u,sub)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 37fe9d46e0b..a2c47d19f21 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5246,11 +5246,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* VABAL */
                     {0, 0, 0, 7}, /* VSUBHN: handled by decodetree */
                     {0, 0, 0, 7}, /* VABDL */
-                    {0, 0, 0, 0}, /* VMLAL */
+                    {0, 0, 0, 7}, /* VMLAL */
                     {0, 0, 0, 9}, /* VQDMLAL */
-                    {0, 0, 0, 0}, /* VMLSL */
+                    {0, 0, 0, 7}, /* VMLSL */
                     {0, 0, 0, 9}, /* VQDMLSL */
-                    {0, 0, 0, 0}, /* Integer VMULL */
+                    {0, 0, 0, 7}, /* Integer VMULL */
                     {0, 0, 0, 9}, /* VQDMULL */
                     {0, 0, 0, 0xa}, /* Polynomial VMULL */
                     {0, 0, 0, 7}, /* Reserved: always UNDEF */
@@ -5306,8 +5306,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         tmp2 = neon_load_reg(rm, pass);
                     }
                     switch (op) {
-                    case 8: case 9: case 10: case 11: case 12: case 13:
-                        /* VMLAL, VQDMLAL, VMLSL, VQDMLSL, VMULL, VQDMULL */
+                    case 9: case 11: case 13:
+                        /* VQDMLAL, VQDMLSL, VQDMULL */
                         gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
                         break;
                     default: /* 15 is RESERVED: caught earlier  */
@@ -5317,16 +5317,10 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         /* VQDMULL */
                         gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
                         neon_store_reg64(cpu_V0, rd + pass);
-                    } else if (op == 5 || (op >= 8 && op <= 11)) {
+                    } else {
                         /* Accumulate.  */
                         neon_load_reg64(cpu_V1, rd + pass);
                         switch (op) {
-                        case 10: /* VMLSL */
-                            gen_neon_negl(cpu_V0, size);
-                            /* Fall through */
-                        case 8: /* VABAL, VMLAL */
-                            gen_neon_addl(size);
-                            break;
                         case 9: case 11: /* VQDMLAL, VQDMLSL */
                             gen_neon_addl_saturate(cpu_V0, cpu_V0, size);
                             if (op == 11) {
@@ -5338,9 +5332,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                             abort();
                         }
                         neon_store_reg64(cpu_V0, rd + pass);
-                    } else {
-                        /* Write back the result.  */
-                        neon_store_reg64(cpu_V0, rd + pass);
                     }
                 }
             } else {
-- 
2.20.1


