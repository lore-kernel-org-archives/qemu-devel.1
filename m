Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD56CC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A99F20732
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IPzfUrC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A99F20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo5I-0004xk-9Q
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnny-0000wc-62
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:42 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:36114)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnv-0002LR-Vs
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:41 -0400
Received: by mail-pg1-x532.google.com with SMTP id m8so742805pgi.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7BiS9+5sMvbJcaQD+6Dpdr+95svEiwirFL2XKd2vVDQ=;
 b=IPzfUrC+98/fB2UKVbyS0klL9yrRRZRQeP+OevwsYrYvmHXTfezFq81oZ1+NfMPrdf
 QI/v5Hy4DIGGBf2YGJNkj51kwdozevuAk1pTADC3UC73z50GCpJEHD72pIUb0UmVmUY9
 M8Q5rM5B8BLwHf+AKLl1rWXIYrLOn6jZH3MChLBnDMXoaEJH8ox4Mk/Tn5Wf+TcuwoJK
 0kyE++kz3dKv2GrRf8mQW9blWyZ/dzBgLqpJvBNjNtt1YmJgnnxNn95qn111pPSgTv9L
 CYm/Frcb/TCFxCCa9ebiP+hd0/QqzxNCQevPZgRzgcUEicavjf6PK7Oli2SM0h0G0Qwn
 Wofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7BiS9+5sMvbJcaQD+6Dpdr+95svEiwirFL2XKd2vVDQ=;
 b=bS+2AsEMddQm5ARUwB8fl00S0fyVqgWSXPq5Koe2W/3btw4tf7DCF/kzjuFGVzeqlQ
 mB4opwarg3e/VMENASgB+UDsj42LwhGwo+aZmFzOxbT8g7syFlmNjE8mSlITkrVTS5l3
 0JARLyVdVHC9qBQclsq9YcD8OUUayuNyd7MP1staynFvXkQk/MPLcqwH/tZ0fiVb8bUS
 jVf1h4wwKig9Gk2tWDik0wOoJh5UVZJnAzGslIxYbf8eVPO5/dilPdAS9FIu48ytPwoc
 nYSCsuM6v/gyKOwp6iWcDDjtIyJkNT2TGvBAX7CxQZSNQTwrFuGs50LILfHvd4spa92x
 SQPw==
X-Gm-Message-State: AOAM530VkfkOwscY/I2ItmZp9YEu154U6RX6W5Rrd7BxHJqCqYu3M1Ef
 hVPZgVUIl3E745lfOUMP+b+3VxNppwvjmg==
X-Google-Smtp-Source: ABdhPJxH7OLlNtDaOJk2eB10/bagsRvsKU2puUeo1ZJyRHRIM/wop0ns88asjfzrVH45wMOTO4Disw==
X-Received: by 2002:a63:2d0:: with SMTP id 199mr941193pgc.408.1599610658161;
 Tue, 08 Sep 2020 17:17:38 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/43] tcg/ppc: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:43 -0700
Message-Id: <20200909001647.532249-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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
 tcg/ppc/tcg-target-constr.h |  37 ++++++++++
 tcg/ppc/tcg-target.c.inc    | 135 +++++++++++++++---------------------
 2 files changed, 94 insertions(+), 78 deletions(-)
 create mode 100644 tcg/ppc/tcg-target-constr.h

diff --git a/tcg/ppc/tcg-target-constr.h b/tcg/ppc/tcg-target-constr.h
new file mode 100644
index 0000000000..9a38f8ed89
--- /dev/null
+++ b/tcg/ppc/tcg-target-constr.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * PowerPC target-specific operand constaints. 
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I1(r)
+C_O0_I2(r, r)
+C_O0_I2(r, ri)
+C_O0_I2(S, S)
+C_O0_I2(v, r)
+C_O0_I3(S, S, S)
+C_O0_I4(r, r, ri, ri)
+C_O0_I4(S, S, S, S)
+C_O1_I1(r, L)
+C_O1_I1(r, r)
+C_O1_I1(v, r)
+C_O1_I1(v, v)
+C_O1_I1(v, vr)
+C_O1_I2(r, 0, rZ)
+C_O1_I2(r, L, L)
+C_O1_I2(r, rI, ri)
+C_O1_I2(r, rI, rT)
+C_O1_I2(r, r, r)
+C_O1_I2(r, r, ri)
+C_O1_I2(r, r, rI)
+C_O1_I2(r, r, rT)
+C_O1_I2(r, r, rU)
+C_O1_I2(r, r, rZW)
+C_O1_I2(v, v, v)
+C_O1_I3(v, v, v, v)
+C_O1_I4(r, r, ri, rZ, rZ)
+C_O1_I4(r, r, r, ri, ri)
+C_O2_I1(L, L, L)
+C_O2_I2(L, L, L, L)
+C_O2_I4(r, r, rI, rZM, r, r)
+C_O2_I4(r, r, r, r, rI, rZM)
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 155c42ed24..e34a02ee04 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3495,62 +3495,20 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     va_end(va);
 }
 
+/* Define all constraint sets. */
+#include "../tcg-constr.c.inc"
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
-    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
-    static const TCGTargetOpDef S_S = { .args_ct_str = { "S", "S" } };
-    static const TCGTargetOpDef r_ri = { .args_ct_str = { "r", "ri" } };
-    static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
-    static const TCGTargetOpDef r_L_L = { .args_ct_str = { "r", "L", "L" } };
-    static const TCGTargetOpDef L_L_L = { .args_ct_str = { "L", "L", "L" } };
-    static const TCGTargetOpDef S_S_S = { .args_ct_str = { "S", "S", "S" } };
-    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
-    static const TCGTargetOpDef r_r_rI = { .args_ct_str = { "r", "r", "rI" } };
-    static const TCGTargetOpDef r_r_rT = { .args_ct_str = { "r", "r", "rT" } };
-    static const TCGTargetOpDef r_r_rU = { .args_ct_str = { "r", "r", "rU" } };
-    static const TCGTargetOpDef r_rI_ri
-        = { .args_ct_str = { "r", "rI", "ri" } };
-    static const TCGTargetOpDef r_rI_rT
-        = { .args_ct_str = { "r", "rI", "rT" } };
-    static const TCGTargetOpDef r_r_rZW
-        = { .args_ct_str = { "r", "r", "rZW" } };
-    static const TCGTargetOpDef L_L_L_L
-        = { .args_ct_str = { "L", "L", "L", "L" } };
-    static const TCGTargetOpDef S_S_S_S
-        = { .args_ct_str = { "S", "S", "S", "S" } };
-    static const TCGTargetOpDef movc
-        = { .args_ct_str = { "r", "r", "ri", "rZ", "rZ" } };
-    static const TCGTargetOpDef dep
-        = { .args_ct_str = { "r", "0", "rZ" } };
-    static const TCGTargetOpDef br2
-        = { .args_ct_str = { "r", "r", "ri", "ri" } };
-    static const TCGTargetOpDef setc2
-        = { .args_ct_str = { "r", "r", "r", "ri", "ri" } };
-    static const TCGTargetOpDef add2
-        = { .args_ct_str = { "r", "r", "r", "r", "rI", "rZM" } };
-    static const TCGTargetOpDef sub2
-        = { .args_ct_str = { "r", "r", "rI", "rZM", "r", "r" } };
-    static const TCGTargetOpDef v_r = { .args_ct_str = { "v", "r" } };
-    static const TCGTargetOpDef v_vr = { .args_ct_str = { "v", "vr" } };
-    static const TCGTargetOpDef v_v = { .args_ct_str = { "v", "v" } };
-    static const TCGTargetOpDef v_v_v = { .args_ct_str = { "v", "v", "v" } };
-    static const TCGTargetOpDef v_v_v_v
-        = { .args_ct_str = { "v", "v", "v", "v" } };
-
     switch (op) {
     case INDEX_op_goto_ptr:
-        return &r;
+        return C_O0_I1(r);
 
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
     case INDEX_op_ld16u_i32:
     case INDEX_op_ld16s_i32:
     case INDEX_op_ld_i32:
-    case INDEX_op_st8_i32:
-    case INDEX_op_st16_i32:
-    case INDEX_op_st_i32:
     case INDEX_op_ctpop_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
@@ -3566,10 +3524,6 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-    case INDEX_op_st8_i64:
-    case INDEX_op_st16_i64:
-    case INDEX_op_st32_i64:
-    case INDEX_op_st_i64:
     case INDEX_op_ctpop_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_not_i64:
@@ -3582,7 +3536,16 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bswap32_i64:
     case INDEX_op_bswap64_i64:
     case INDEX_op_extract_i64:
-        return &r_r;
+        return C_O1_I1(r, r);
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+    case INDEX_op_st8_i64:
+    case INDEX_op_st16_i64:
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i64:
+        return C_O0_I2(r, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_and_i32:
@@ -3605,10 +3568,12 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
     case INDEX_op_setcond_i64:
-        return &r_r_ri;
+        return C_O1_I2(r, r, ri);
+
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-        return &r_r_rI;
+        return C_O1_I2(r, r, rI);
+
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
     case INDEX_op_nand_i32:
@@ -3623,55 +3588,63 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_divu_i64:
     case INDEX_op_mulsh_i64:
     case INDEX_op_muluh_i64:
-        return &r_r_r;
+        return C_O1_I2(r, r, r);
+
     case INDEX_op_sub_i32:
-        return &r_rI_ri;
+        return C_O1_I2(r, rI, ri);
     case INDEX_op_add_i64:
-        return &r_r_rT;
+        return C_O1_I2(r, r, rT);
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
-        return &r_r_rU;
+        return C_O1_I2(r, r, rU);
     case INDEX_op_sub_i64:
-        return &r_rI_rT;
+        return C_O1_I2(r, rI, rT);
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i64:
-        return &r_r_rZW;
+        return C_O1_I2(r, r, rZW);
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return &r_ri;
+        return C_O0_I2(r, ri);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return &movc;
+        return C_O1_I4(r, r, ri, rZ, rZ);
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return &dep;
+        return C_O1_I2(r, 0, rZ);
     case INDEX_op_brcond2_i32:
-        return &br2;
+        return C_O0_I4(r, r, ri, ri);
     case INDEX_op_setcond2_i32:
-        return &setc2;
+        return C_O1_I4(r, r, r, ri, ri);
     case INDEX_op_add2_i64:
     case INDEX_op_add2_i32:
-        return &add2;
+        return C_O2_I4(r, r, r, r, rI, rZM);
     case INDEX_op_sub2_i64:
     case INDEX_op_sub2_i32:
-        return &sub2;
+        return C_O2_I4(r, r, rI, rZM, r, r);
 
     case INDEX_op_qemu_ld_i32:
         return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
-                ? &r_L : &r_L_L);
+                ? C_O1_I1(r, L)
+                : C_O1_I2(r, L, L));
+
     case INDEX_op_qemu_st_i32:
         return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
-                ? &S_S : &S_S_S);
+                ? C_O0_I2(S, S)
+                : C_O0_I3(S, S, S));
+
     case INDEX_op_qemu_ld_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &r_L
-                : TARGET_LONG_BITS == 32 ? &L_L_L : &L_L_L_L);
+        return (TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L)
+                : TARGET_LONG_BITS == 32 ? C_O2_I1(L, L, L)
+                : C_O2_I2(L, L, L, L));
+
     case INDEX_op_qemu_st_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &S_S
-                : TARGET_LONG_BITS == 32 ? &S_S_S : &S_S_S_S);
+        return (TCG_TARGET_REG_BITS == 64 ? C_O0_I2(S, S)
+                : TARGET_LONG_BITS == 32 ? C_O0_I3(S, S, S)
+                : C_O0_I4(S, S, S, S));
 
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
@@ -3701,19 +3674,25 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ppc_mulou_vec:
     case INDEX_op_ppc_pkum_vec:
     case INDEX_op_dup2_vec:
-        return &v_v_v;
+        return C_O1_I2(v, v, v);
+
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
-        return &v_v;
+        return C_O1_I1(v, v);
+
     case INDEX_op_dup_vec:
-        return have_isa_3_00 ? &v_vr : &v_v;
+        return have_isa_3_00 ? C_O1_I1(v, vr) : C_O1_I1(v, v);
+
     case INDEX_op_ld_vec:
-    case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
-        return &v_r;
+        return C_O1_I1(v, r);
+
+    case INDEX_op_st_vec:
+        return C_O0_I2(v, r);
+
     case INDEX_op_bitsel_vec:
     case INDEX_op_ppc_msum_vec:
-        return &v_v_v_v;
+        return C_O1_I3(v, v, v, v);
 
     default:
         return NULL;
-- 
2.25.1


