Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D256C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385912145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TM37lqVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385912145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo2X-0000tW-Ay
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnu-0000lR-5W
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:38 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:35473)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnns-0002KK-1d
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:37 -0400
Received: by mail-pj1-x102f.google.com with SMTP id jw11so439361pjb.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5e04R8fqhgLE3g8fvUJRt06a4TS6ucpOGpQQp2jgtQI=;
 b=TM37lqVsY/FZSyQoNaKgevt1PsP621riNsNFk6K+hq6b5IchKTSRNVcJm/ozwxMplK
 uLNGeEVk1LW9KVNeP9NmyQqX0IVKwFPrPTIyoLMvm+81bw8xYtvztJIcbyDfanTR3j8/
 vgmHfpDpNeJk9rwqMQz7iP5orVormuNgSK0EqvuKv47eX/OvPYn9yppFBwXGfBRjOy4D
 ohZCIT1ZM91gYh5pABaiFpnlEixoib0crOzKvYfnO1LSMZeN1tamya8Z3Pl9PF/zw2M8
 DLUjwP+VnLWR/x/M6rY7Sug6AFv2haBFXWNeOlHiu+H/4MuANVkRMyUkHGju5E1t3Gor
 h1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5e04R8fqhgLE3g8fvUJRt06a4TS6ucpOGpQQp2jgtQI=;
 b=Kn+CYMknyi3Q12OtjtK4mmjGWHWz8ltFPxkqg+GT3V473KS/O3lyWhyhen3bvmlWO0
 IsILf5U8lswBH38xMrRHwmdzo4AyQhZS2/WodRzd70+QNrvjhhOfr6JJm4uwL20Jx4Ee
 t3Womi69BK8+G6Qkx3X76MaLZ7t0jdJlHI/6GlnpJXjx79/LOfV8CAoQtfjT8znVOmhM
 62GTjoWiJQSLWv1m57Yv+kr4ksTXLNEh0VRg9RuGPeuEGVtl6iLWJCAyVErYiBkeuMbv
 xMZv0J519onDttnAGbigf7IcrgoPuFlirSRVnNzt/raCRCfuKR/EnoidoDxCgDZ2peBu
 D5Ig==
X-Gm-Message-State: AOAM531fkXvUPMh7bokaNO2fMPMgGqiqpCIPxiqYTzXeEWZ7iZCDJvZ5
 l1Unau7vIALaGm7OfcjJn1nc6zQnEsHojw==
X-Google-Smtp-Source: ABdhPJxjzv1dxZqw2RHw4VW4P3OiUffAU4RbNinMsvnAT0xyWMUBrHM5GSzt0Vq50klKDe5OedXI0A==
X-Received: by 2002:a17:90b:1918:: with SMTP id
 mp24mr241616pjb.110.1599610654317; 
 Tue, 08 Sep 2020 17:17:34 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/43] tcg/aarch64: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:40 -0700
Message-Id: <20200909001647.532249-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-constr.h | 31 ++++++++++++
 tcg/aarch64/tcg-target.c.inc    | 85 +++++++++++----------------------
 2 files changed, 60 insertions(+), 56 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-constr.h

diff --git a/tcg/aarch64/tcg-target-constr.h b/tcg/aarch64/tcg-target-constr.h
new file mode 100644
index 0000000000..dcf46a7457
--- /dev/null
+++ b/tcg/aarch64/tcg-target-constr.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AArch64 target-specific operand constaints.
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I1(r)
+C_O0_I2(lZ, l)
+C_O0_I2(r, rA)
+C_O0_I2(rZ, r)
+C_O0_I2(w, r)
+C_O1_I1(r, l)
+C_O1_I1(r, r)
+C_O1_I1(w, r)
+C_O1_I1(w, w)
+C_O1_I1(w, wr)
+C_O1_I2(r, 0, rZ)
+C_O1_I2(r, r, r)
+C_O1_I2(r, r, rA)
+C_O1_I2(r, r, rAL)
+C_O1_I2(r, r, ri)
+C_O1_I2(r, r, rL)
+C_O1_I2(r, rZ, rZ)
+C_O1_I2(w, 0, w)
+C_O1_I2(w, w, w)
+C_O1_I2(w, w, wN)
+C_O1_I2(w, w, wO)
+C_O1_I2(w, w, wZ)
+C_O1_I3(w, w, w, w)
+C_O1_I4(r, r, rA, rZ, rZ)
+C_O2_I4(r, r, rZ, rZ, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index d9d397075a..e352f7f56b 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2577,42 +2577,14 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     va_end(va);
 }
 
+/* Define all constraint sets. */
+#include "../tcg-constr.c.inc"
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
-    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef w_w = { .args_ct_str = { "w", "w" } };
-    static const TCGTargetOpDef w_r = { .args_ct_str = { "w", "r" } };
-    static const TCGTargetOpDef w_wr = { .args_ct_str = { "w", "wr" } };
-    static const TCGTargetOpDef r_l = { .args_ct_str = { "r", "l" } };
-    static const TCGTargetOpDef r_rA = { .args_ct_str = { "r", "rA" } };
-    static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
-    static const TCGTargetOpDef lZ_l = { .args_ct_str = { "lZ", "l" } };
-    static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
-    static const TCGTargetOpDef w_w_w = { .args_ct_str = { "w", "w", "w" } };
-    static const TCGTargetOpDef w_0_w = { .args_ct_str = { "w", "0", "w" } };
-    static const TCGTargetOpDef w_w_wO = { .args_ct_str = { "w", "w", "wO" } };
-    static const TCGTargetOpDef w_w_wN = { .args_ct_str = { "w", "w", "wN" } };
-    static const TCGTargetOpDef w_w_wZ = { .args_ct_str = { "w", "w", "wZ" } };
-    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
-    static const TCGTargetOpDef r_r_rA = { .args_ct_str = { "r", "r", "rA" } };
-    static const TCGTargetOpDef r_r_rL = { .args_ct_str = { "r", "r", "rL" } };
-    static const TCGTargetOpDef r_r_rAL
-        = { .args_ct_str = { "r", "r", "rAL" } };
-    static const TCGTargetOpDef dep
-        = { .args_ct_str = { "r", "0", "rZ" } };
-    static const TCGTargetOpDef ext2
-        = { .args_ct_str = { "r", "rZ", "rZ" } };
-    static const TCGTargetOpDef movc
-        = { .args_ct_str = { "r", "r", "rA", "rZ", "rZ" } };
-    static const TCGTargetOpDef add2
-        = { .args_ct_str = { "r", "r", "rZ", "rZ", "rA", "rMZ" } };
-    static const TCGTargetOpDef w_w_w_w
-        = { .args_ct_str = { "w", "w", "w", "w" } };
-
     switch (op) {
     case INDEX_op_goto_ptr:
-        return &r;
+        return C_O0_I1(r);
 
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
@@ -2651,7 +2623,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extract_i64:
     case INDEX_op_sextract_i32:
     case INDEX_op_sextract_i64:
-        return &r_r;
+        return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
@@ -2660,7 +2632,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return &rZ_r;
+        return C_O0_I2(rZ, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
@@ -2668,7 +2640,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub_i64:
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
-        return &r_r_rA;
+        return C_O1_I2(r, r, rA);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
@@ -2682,7 +2654,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_remu_i64:
     case INDEX_op_muluh_i64:
     case INDEX_op_mulsh_i64:
-        return &r_r_r;
+        return C_O1_I2(r, r, r);
 
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
@@ -2696,7 +2668,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_orc_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
-        return &r_r_rL;
+        return C_O1_I2(r, r, rL);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -2708,42 +2680,42 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
-        return &r_r_ri;
+        return C_O1_I2(r, r, ri);
 
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i64:
-        return &r_r_rAL;
+        return C_O1_I2(r, r, rAL);
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return &r_rA;
+        return C_O0_I2(r, rA);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return &movc;
+        return C_O1_I4(r, r, rA, rZ, rZ);
 
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
-        return &r_l;
+        return C_O1_I1(r, l);
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return &lZ_l;
+        return C_O0_I2(lZ, l);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return &dep;
+        return C_O1_I2(r, 0, rZ);
 
     case INDEX_op_extract2_i32:
     case INDEX_op_extract2_i64:
-        return &ext2;
+        return C_O1_I2(r, rZ, rZ);
 
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return &add2;
+        return C_O2_I4(r, r, rZ, rZ, rA, rMZ);
 
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
@@ -2761,32 +2733,33 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
     case INDEX_op_aa64_sshl_vec:
-        return &w_w_w;
+        return C_O1_I2(w, w, w);
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
     case INDEX_op_abs_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-        return &w_w;
+        return C_O1_I1(w, w);
     case INDEX_op_ld_vec:
-    case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
-        return &w_r;
+        return C_O1_I1(w, r);
+    case INDEX_op_st_vec:
+        return C_O0_I2(w, r);
     case INDEX_op_dup_vec:
-        return &w_wr;
+        return C_O1_I1(w, wr);
     case INDEX_op_or_vec:
     case INDEX_op_andc_vec:
-        return &w_w_wO;
+        return C_O1_I2(w, w, wO);
     case INDEX_op_and_vec:
     case INDEX_op_orc_vec:
-        return &w_w_wN;
+        return C_O1_I2(w, w, wN);
     case INDEX_op_cmp_vec:
-        return &w_w_wZ;
+        return C_O1_I2(w, w, wZ);
     case INDEX_op_bitsel_vec:
-        return &w_w_w_w;
+        return C_O1_I3(w, w, w, w);
     case INDEX_op_aa64_sli_vec:
-        return &w_0_w;
+        return C_O1_I2(w, 0, w);
 
     default:
         return NULL;
-- 
2.25.1


