Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AAADC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BAF20760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nz2w1SWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BAF20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigov-0004YV-HI
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighj-0003O3-Gg
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:23 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45368)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jighh-0003R5-7e
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:02:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id c3so21894488wru.12
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yD3aBUk/yUeo1kZA43j/pO6AQgeHZtAwzYiFa/0q35M=;
 b=nz2w1SWQWHqYskpdJnxuaKFNq/XM9UEfBvJSk+evtr8QUe3UZl8YIhoeUv4zKjVIaN
 NmFFyrkKhL38gqjlJ4Yq/dkbzaY6ki+QJA0p69QVNs8cZMMbBrVr12olEHy/kIO7lgth
 0dwzF/QHa9eNcbdwS6tVsR1voSM9dOXYGh5t3WjIVGcZuZ7gzPb1mrry8urNMNC1Vv2j
 jzu2ng6LwQ8meSCijok+s4IyVCUMppE9wooRgI+OMCiFhmdTghaGJiEruqi3ATzgpjCq
 1HiyDmG7tQYQZGOJWWg81LboY2cutQnbgH3Tu1NvL16bzhO2S91n4aJUCw+Z09huktUY
 wt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yD3aBUk/yUeo1kZA43j/pO6AQgeHZtAwzYiFa/0q35M=;
 b=KyPa33FL5cCx3F/SuWNUvSDtchIDZCVL6JBDTlxDzFjYxYSe5BvQSMVPwRhklLEbFZ
 M8p+QdIT8VBsuGj5C5yM0/OG5nYoWQ0dWg/gCdw/y224DMbsvOGrW6JUxbglRpClObq3
 uAz/bU89fBkPvh1wPNQ9XUsbNTzj+NZ+aiFNJY2AzpDgJrQVPpBEJKvjz6XjhZZzAHsG
 EzzOybOomyqgWnrVMKkDihynI8ZqqVCEOXBu8CtP55Hjd7sh7Wel6Rc8ddITcdDmvHUp
 deWSktg85YAHyjP+p5CwYzy+N4pw4CzEZgdKJOgd+3zuRzJdOBuZcWCd2Tygxcx/+yhf
 eJfA==
X-Gm-Message-State: AOAM530X4m291C1AVqtve6QnPY/EIfNWiLV7Nehcu9hqNwunb+Bhek6h
 InX0ChWjcJ9vcHST7l++/mUBUw==
X-Google-Smtp-Source: ABdhPJxrg+e3DW2UpXAp8n+izM4KdVheBOMGF8JzLI2IDw8QKJC3sj+gU94uOZoYWMQpfgjLXnMxYg==
X-Received: by 2002:adf:e587:: with SMTP id l7mr5302455wrm.352.1591718538041; 
 Tue, 09 Jun 2020 09:02:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b81sm3699867wmc.5.2020.06.09.09.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:02:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/7] target/arm: Convert Neon 3-reg-diff VABAL,
 VABDL to decodetree
Date: Tue,  9 Jun 2020 17:02:06 +0100
Message-Id: <20200609160209.29960-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200609160209.29960-1-peter.maydell@linaro.org>
References: <20200609160209.29960-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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

Convert the Neon 3-reg-diff insns VABAL and VABDL to decodetree.
Like almost all the remaining insns in this group, these are
a combination of a two-input operation which returns a double width
result and then a possible accumulation of that double width
result into the destination.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.h          |   1 +
 target/arm/neon-dp.decode       |   6 ++
 target/arm/translate-neon.inc.c | 132 ++++++++++++++++++++++++++++++++
 target/arm/translate.c          |  31 +-------
 4 files changed, 142 insertions(+), 28 deletions(-)

diff --git a/target/arm/translate.h b/target/arm/translate.h
index c937dfe9bf0..62ed5c4780c 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -371,6 +371,7 @@ typedef void NeonGenTwo64OpEnvFn(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
 typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
 typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
 typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
+typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
 typedef void NeonGenTwoSingleOPFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoDoubleOPFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOneOpFn(TCGv_i64, TCGv_i64);
diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index a2234dfa4f3..4f0aaaf6bb2 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -442,7 +442,13 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VADDHN_3d    1111 001 0 1 . .. .... .... 0100 . 0 . 0 .... @3diff
     VRADDHN_3d   1111 001 1 1 . .. .... .... 0100 . 0 . 0 .... @3diff
 
+    VABAL_S_3d   1111 001 0 1 . .. .... .... 0101 . 0 . 0 .... @3diff
+    VABAL_U_3d   1111 001 1 1 . .. .... .... 0101 . 0 . 0 .... @3diff
+
     VSUBHN_3d    1111 001 0 1 . .. .... .... 0110 . 0 . 0 .... @3diff
     VRSUBHN_3d   1111 001 1 1 . .. .... .... 0110 . 0 . 0 .... @3diff
+
+    VABDL_S_3d   1111 001 0 1 . .. .... .... 0111 . 0 . 0 .... @3diff
+    VABDL_U_3d   1111 001 1 1 . .. .... .... 0111 . 0 . 0 .... @3diff
   ]
 }
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index 0033cb7eb25..fd85ff5ea50 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -2019,3 +2019,135 @@ DO_NARROW_3D(VADDHN, add, narrow, tcg_gen_extrh_i64_i32)
 DO_NARROW_3D(VSUBHN, sub, narrow, tcg_gen_extrh_i64_i32)
 DO_NARROW_3D(VRADDHN, add, narrow_round, gen_narrow_round_high_u32)
 DO_NARROW_3D(VRSUBHN, sub, narrow_round, gen_narrow_round_high_u32)
+
+static bool do_long_3d(DisasContext *s, arg_3diff *a,
+                       NeonGenTwoOpWidenFn *opfn,
+                       NeonGenTwo64OpFn *accfn)
+{
+    /*
+     * 3-regs different lengths, long operations.
+     * These perform an operation on two inputs that returns a double-width
+     * result, and then possibly perform an accumulation operation of
+     * that result into the double-width destination.
+     */
+    TCGv_i64 rd0, rd1, tmp;
+    TCGv_i32 rn, rm;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
+        return false;
+    }
+
+    /* UNDEF accesses to D16-D31 if they don't exist. */
+    if (!dc_isar_feature(aa32_simd_r32, s) &&
+        ((a->vd | a->vn | a->vm) & 0x10)) {
+        return false;
+    }
+
+    if (!opfn) {
+        /* size == 3 case, which is an entirely different insn group */
+        return false;
+    }
+
+    if (a->vd & 1) {
+        return false;
+    }
+
+    if (!vfp_access_check(s)) {
+        return true;
+    }
+
+    rd0 = tcg_temp_new_i64();
+    rd1 = tcg_temp_new_i64();
+
+    rn = neon_load_reg(a->vn, 0);
+    rm = neon_load_reg(a->vm, 0);
+    opfn(rd0, rn, rm);
+    tcg_temp_free_i32(rn);
+    tcg_temp_free_i32(rm);
+
+    rn = neon_load_reg(a->vn, 1);
+    rm = neon_load_reg(a->vm, 1);
+    opfn(rd1, rn, rm);
+    tcg_temp_free_i32(rn);
+    tcg_temp_free_i32(rm);
+
+    /* Don't store results until after all loads: they might overlap */
+    if (accfn) {
+        tmp = tcg_temp_new_i64();
+        neon_load_reg64(tmp, a->vd);
+        accfn(tmp, tmp, rd0);
+        neon_store_reg64(tmp, a->vd);
+        neon_load_reg64(tmp, a->vd + 1);
+        accfn(tmp, tmp, rd1);
+        neon_store_reg64(tmp, a->vd + 1);
+        tcg_temp_free_i64(tmp);
+    } else {
+        neon_store_reg64(rd0, a->vd);
+        neon_store_reg64(rd1, a->vd + 1);
+    }
+
+    tcg_temp_free_i64(rd0);
+    tcg_temp_free_i64(rd1);
+
+    return true;
+}
+
+static bool trans_VABDL_S_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        gen_helper_neon_abdl_s16,
+        gen_helper_neon_abdl_s32,
+        gen_helper_neon_abdl_s64,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VABDL_U_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        gen_helper_neon_abdl_u16,
+        gen_helper_neon_abdl_u32,
+        gen_helper_neon_abdl_u64,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], NULL);
+}
+
+static bool trans_VABAL_S_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        gen_helper_neon_abdl_s16,
+        gen_helper_neon_abdl_s32,
+        gen_helper_neon_abdl_s64,
+        NULL,
+    };
+    NeonGenTwo64OpFn *addfn[] = {
+        gen_helper_neon_addl_u16,
+        gen_helper_neon_addl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], addfn[a->size]);
+}
+
+static bool trans_VABAL_U_3d(DisasContext *s, arg_3diff *a)
+{
+    NeonGenTwoOpWidenFn *opfn[] = {
+        gen_helper_neon_abdl_u16,
+        gen_helper_neon_abdl_u32,
+        gen_helper_neon_abdl_u64,
+        NULL,
+    };
+    NeonGenTwo64OpFn *addfn[] = {
+        gen_helper_neon_addl_u16,
+        gen_helper_neon_addl_u32,
+        tcg_gen_add_i64,
+        NULL,
+    };
+
+    return do_long_3d(s, a, opfn[a->size], addfn[a->size]);
+}
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 3fe39cd4f49..37fe9d46e0b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5243,9 +5243,9 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     {0, 0, 0, 7}, /* VSUBL: handled by decodetree */
                     {0, 0, 0, 7}, /* VSUBW: handled by decodetree */
                     {0, 0, 0, 7}, /* VADDHN: handled by decodetree */
-                    {0, 0, 0, 0}, /* VABAL */
+                    {0, 0, 0, 7}, /* VABAL */
                     {0, 0, 0, 7}, /* VSUBHN: handled by decodetree */
-                    {0, 0, 0, 0}, /* VABDL */
+                    {0, 0, 0, 7}, /* VABDL */
                     {0, 0, 0, 0}, /* VMLAL */
                     {0, 0, 0, 9}, /* VQDMLAL */
                     {0, 0, 0, 0}, /* VMLSL */
@@ -5306,31 +5306,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         tmp2 = neon_load_reg(rm, pass);
                     }
                     switch (op) {
-                    case 5: case 7: /* VABAL, VABDL */
-                        switch ((size << 1) | u) {
-                        case 0:
-                            gen_helper_neon_abdl_s16(cpu_V0, tmp, tmp2);
-                            break;
-                        case 1:
-                            gen_helper_neon_abdl_u16(cpu_V0, tmp, tmp2);
-                            break;
-                        case 2:
-                            gen_helper_neon_abdl_s32(cpu_V0, tmp, tmp2);
-                            break;
-                        case 3:
-                            gen_helper_neon_abdl_u32(cpu_V0, tmp, tmp2);
-                            break;
-                        case 4:
-                            gen_helper_neon_abdl_s64(cpu_V0, tmp, tmp2);
-                            break;
-                        case 5:
-                            gen_helper_neon_abdl_u64(cpu_V0, tmp, tmp2);
-                            break;
-                        default: abort();
-                        }
-                        tcg_temp_free_i32(tmp2);
-                        tcg_temp_free_i32(tmp);
-                        break;
                     case 8: case 9: case 10: case 11: case 12: case 13:
                         /* VMLAL, VQDMLAL, VMLSL, VQDMLSL, VMULL, VQDMULL */
                         gen_neon_mull(cpu_V0, tmp, tmp2, size, u);
@@ -5349,7 +5324,7 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                         case 10: /* VMLSL */
                             gen_neon_negl(cpu_V0, size);
                             /* Fall through */
-                        case 5: case 8: /* VABAL, VMLAL */
+                        case 8: /* VABAL, VMLAL */
                             gen_neon_addl(size);
                             break;
                         case 9: case 11: /* VQDMLAL, VQDMLSL */
-- 
2.20.1


