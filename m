Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681E5C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:31:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA80D2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PHf57HCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA80D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo1U-00077v-3l
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnt-0000iz-Bk
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:37 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:53160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnq-0002K5-SP
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:37 -0400
Received: by mail-pj1-x102b.google.com with SMTP id o16so432835pjr.2
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KiiHEmXlGV1VcjJy5syvlceWZPJvv12U3Hn3dF6mLHE=;
 b=PHf57HCZvvsXe2dBpbfUQsdf/47TJXnzpGrxd3zmK0ICZlyOQNH45IPalrOpIIktO5
 EOn+xz4jLbuV0pyePpCBiIBDEYqRT67KFBBHGEQczcf4LcJxtEOfuGQ2DvIoHlf9LiEI
 jmsRhFqH2g4fQWIXw71iTvFn03ZtOJsl9dBe3VhPf4je4mY9k+AXY3xeS4F3u3AVPJr6
 +KVo0v8UX8t72TI643472Cs9Y02fwNCoOYrjUYMGbkpn1k9vCWCI+o0InoL3i5I39StE
 y8zOcPmDdTf7ovwsEIAHiREWW3kNA3bbxiuD4e/8RKuc4CHFdtcDXZAg3r8k5huk35Gq
 OBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KiiHEmXlGV1VcjJy5syvlceWZPJvv12U3Hn3dF6mLHE=;
 b=uKIgWkZIyPd72DbSYClEoPUisvTsYHW7OihtsXeQBPLsqIpRnyPMz15hukciRKZfXG
 2aHMXWDdEhMbib6cd6gmh4vHdCvL9xT/+yKm6oQ17h4zVg9Rsou9g4BOKeEb4oZNvn0Q
 sn5KKFoKfSV8exMSea3PGbaMuMer7tCuyWw5eLsTW0RdYqlf0W51XIih9jQspH9Tgqow
 yEFJVe/9GqU0osB1ekaRwckfOfeWg2HCtXpS1ZLrri0Hc7bQZtaSu86cukqbBWmDnoXk
 TNX/Zb+4yNUVED3YETdbVMbGdEQ37c6bfu0LGwx90gA3VU5C/A8uVs5JGC4VzXcgFVmZ
 enlg==
X-Gm-Message-State: AOAM531/eVVoaDwhazF1KVlfMMlliA6wHLu7odTmD+IXe+0vK+mUy20l
 ETKBdrMnzClwg/TGXzmNS28jyCDnW4Jkgw==
X-Google-Smtp-Source: ABdhPJw9XMIeLarV+UK/xtLOE0SmbECuSM3rCsQx1V5wDcp3nD1CY0Ao3hqErfX62dXgwKHzIzRniA==
X-Received: by 2002:a17:90a:297:: with SMTP id
 w23mr1183047pja.44.1599610653020; 
 Tue, 08 Sep 2020 17:17:33 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 35/43] tcg/i386: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:39 -0700
Message-Id: <20200909001647.532249-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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
 tcg/i386/tcg-target-constr.h |  55 +++++++++++
 tcg/i386/tcg-target.c.inc    | 187 +++++++++++++----------------------
 2 files changed, 121 insertions(+), 121 deletions(-)
 create mode 100644 tcg/i386/tcg-target-constr.h

diff --git a/tcg/i386/tcg-target-constr.h b/tcg/i386/tcg-target-constr.h
new file mode 100644
index 0000000000..91d394612e
--- /dev/null
+++ b/tcg/i386/tcg-target-constr.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * i386 target-specific operand constaints.
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I1(r)
+
+C_O0_I2(qi, r)
+C_O0_I2(ri, r)
+C_O0_I2(re, r)
+C_O0_I2(r, re)
+C_O0_I2(L, L)
+C_O0_I2(x, r)
+
+C_O0_I3(L, L, L)
+
+C_O0_I4(L, L, L, L)
+C_O0_I4(r, r, ri, ri)
+
+C_O1_I1(r, 0)
+C_O1_I1(r, q)
+C_O1_I1(r, r)
+C_O1_I1(r, L)
+C_O1_I1(x, r)
+C_O1_I1(x, x)
+
+C_O1_I2(r, r, re)
+C_O1_I2(r, 0, r)
+C_O1_I2(r, 0, re)
+C_O1_I2(r, 0, reZ)
+C_O1_I2(r, 0, rI)
+C_O1_I2(r, 0, ri)
+C_O1_I2(r, 0, ci)
+C_O1_I2(r, r, ri)
+C_O1_I2(Q, 0, Q)
+C_O1_I2(q, r, re)
+C_O1_I2(r, L, L)
+C_O1_I2(x, x, x)
+C_N1_I2(r, r, r)
+C_N1_I2(r, r, rW)
+
+C_O1_I3(x, x, x, x)
+
+C_O1_I4(r, r, re, r, 0)
+C_O1_I4(r, r, r, ri, ri)
+
+C_O2_I1(r, r, L)
+
+C_O2_I2(r, r, L, L)
+C_O2_I2(a, d, a, r)
+
+C_O2_I3(a, d, 0, 1, r)
+
+C_O2_I4(r, r, 0, 1, re, re)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 36a90e7ef3..1dac1b33d1 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2983,39 +2983,14 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+/* Define all constraint sets. */
+#include "../tcg-constr.c.inc"
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
-    static const TCGTargetOpDef ri_r = { .args_ct_str = { "ri", "r" } };
-    static const TCGTargetOpDef re_r = { .args_ct_str = { "re", "r" } };
-    static const TCGTargetOpDef qi_r = { .args_ct_str = { "qi", "r" } };
-    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef r_q = { .args_ct_str = { "r", "q" } };
-    static const TCGTargetOpDef r_re = { .args_ct_str = { "r", "re" } };
-    static const TCGTargetOpDef r_0 = { .args_ct_str = { "r", "0" } };
-    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
-    static const TCGTargetOpDef r_r_re = { .args_ct_str = { "r", "r", "re" } };
-    static const TCGTargetOpDef r_0_r = { .args_ct_str = { "r", "0", "r" } };
-    static const TCGTargetOpDef r_0_re = { .args_ct_str = { "r", "0", "re" } };
-    static const TCGTargetOpDef r_0_ci = { .args_ct_str = { "r", "0", "ci" } };
-    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
-    static const TCGTargetOpDef L_L = { .args_ct_str = { "L", "L" } };
-    static const TCGTargetOpDef r_L_L = { .args_ct_str = { "r", "L", "L" } };
-    static const TCGTargetOpDef r_r_L = { .args_ct_str = { "r", "r", "L" } };
-    static const TCGTargetOpDef L_L_L = { .args_ct_str = { "L", "L", "L" } };
-    static const TCGTargetOpDef r_r_L_L
-        = { .args_ct_str = { "r", "r", "L", "L" } };
-    static const TCGTargetOpDef L_L_L_L
-        = { .args_ct_str = { "L", "L", "L", "L" } };
-    static const TCGTargetOpDef x_x = { .args_ct_str = { "x", "x" } };
-    static const TCGTargetOpDef x_x_x = { .args_ct_str = { "x", "x", "x" } };
-    static const TCGTargetOpDef x_x_x_x
-        = { .args_ct_str = { "x", "x", "x", "x" } };
-    static const TCGTargetOpDef x_r = { .args_ct_str = { "x", "r" } };
-
     switch (op) {
     case INDEX_op_goto_ptr:
-        return &r;
+        return C_O0_I1(r);
 
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
@@ -3029,22 +3004,25 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
-        return &r_r;
+        return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
-        return &qi_r;
+        return C_O0_I2(qi, r);
+
     case INDEX_op_st16_i32:
     case INDEX_op_st16_i64:
     case INDEX_op_st_i32:
     case INDEX_op_st32_i64:
-        return &ri_r;
+        return C_O0_I2(ri, r);
+
     case INDEX_op_st_i64:
-        return &re_r;
+        return C_O0_I2(re, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
-        return &r_r_re;
+        return C_O1_I2(r, r, re);
+
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
@@ -3053,24 +3031,15 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-        return &r_0_re;
+        return C_O1_I2(r, 0, re);
 
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
-        {
-            static const TCGTargetOpDef and
-                = { .args_ct_str = { "r", "0", "reZ" } };
-            return &and;
-        }
-        break;
+        return C_O1_I2(r, 0, reZ);
+
     case INDEX_op_andc_i32:
     case INDEX_op_andc_i64:
-        {
-            static const TCGTargetOpDef andc
-                = { .args_ct_str = { "r", "r", "rI" } };
-            return &andc;
-        }
-        break;
+        return C_O1_I2(r, 0, rI);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
@@ -3078,16 +3047,17 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
-        return have_bmi2 ? &r_r_ri : &r_0_ci;
+        return have_bmi2 ? C_O1_I2(r, r, ri) : C_O1_I2(r, 0, ci);
+
     case INDEX_op_rotl_i32:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i32:
     case INDEX_op_rotr_i64:
-        return &r_0_ci;
+        return C_O1_I2(r, 0, ci);
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return &r_re;
+        return C_O0_I2(r, re);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -3099,13 +3069,14 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
     case INDEX_op_extrh_i64_i32:
-        return &r_0;
+        return C_O1_I1(r, 0);
 
     case INDEX_op_ext8s_i32:
     case INDEX_op_ext8s_i64:
     case INDEX_op_ext8u_i32:
     case INDEX_op_ext8u_i64:
-        return &r_q;
+        return C_O1_I1(r, q);
+
     case INDEX_op_ext16s_i32:
     case INDEX_op_ext16s_i64:
     case INDEX_op_ext16u_i32:
@@ -3120,108 +3091,80 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sextract_i32:
     case INDEX_op_ctpop_i32:
     case INDEX_op_ctpop_i64:
-        return &r_r;
+        return C_O1_I1(r, r);
+
     case INDEX_op_extract2_i32:
     case INDEX_op_extract2_i64:
-        return &r_0_r;
+        return C_O1_I2(r, 0, r);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        {
-            static const TCGTargetOpDef dep
-                = { .args_ct_str = { "Q", "0", "Q" } };
-            return &dep;
-        }
+        return C_O1_I2(Q, 0, Q);
+
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
-        {
-            static const TCGTargetOpDef setc
-                = { .args_ct_str = { "q", "r", "re" } };
-            return &setc;
-        }
+        return C_O1_I2(q, r, re);
+
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        {
-            static const TCGTargetOpDef movc
-                = { .args_ct_str = { "r", "r", "re", "r", "0" } };
-            return &movc;
-        }
+        return C_O1_I4(r, r, re, r, 0);
+
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
     case INDEX_op_divu2_i32:
     case INDEX_op_divu2_i64:
-        {
-            static const TCGTargetOpDef div2
-                = { .args_ct_str = { "a", "d", "0", "1", "r" } };
-            return &div2;
-        }
+        return C_O2_I3(a, d, 0, 1, r);
+
     case INDEX_op_mulu2_i32:
     case INDEX_op_mulu2_i64:
     case INDEX_op_muls2_i32:
     case INDEX_op_muls2_i64:
-        {
-            static const TCGTargetOpDef mul2
-                = { .args_ct_str = { "a", "d", "a", "r" } };
-            return &mul2;
-        }
+        return C_O2_I2(a, d, a, r);
+
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        {
-            static const TCGTargetOpDef arith2
-                = { .args_ct_str = { "r", "r", "0", "1", "re", "re" } };
-            return &arith2;
-        }
+        return C_O2_I4(r, r, 0, 1, re, re);
+
     case INDEX_op_ctz_i32:
     case INDEX_op_ctz_i64:
-        {
-            static const TCGTargetOpDef ctz[2] = {
-                { .args_ct_str = { "&r", "r", "r" } },
-                { .args_ct_str = { "&r", "r", "rW" } },
-            };
-            return &ctz[have_bmi1];
-        }
+        return have_bmi1 ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
+
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-        {
-            static const TCGTargetOpDef clz[2] = {
-                { .args_ct_str = { "&r", "r", "r" } },
-                { .args_ct_str = { "&r", "r", "rW" } },
-            };
-            return &clz[have_lzcnt];
-        }
+        return have_lzcnt ? C_N1_I2(r, r, rW) : C_N1_I2(r, r, r);
 
     case INDEX_op_qemu_ld_i32:
-        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
+        return (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+                ? C_O1_I1(r, L) : C_O1_I2(r, L, L));
+
     case INDEX_op_qemu_st_i32:
-        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &L_L : &L_L_L;
+        return (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+                ? C_O0_I2(L, L) : C_O0_I3(L, L, L));
+
     case INDEX_op_qemu_ld_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &r_L
-                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_r_L
-                : &r_r_L_L);
+        return (TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L)
+                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? C_O2_I1(r, r, L)
+                : C_O2_I2(r, r, L, L));
+
     case INDEX_op_qemu_st_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &L_L
-                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &L_L_L
-                : &L_L_L_L);
+        return (TCG_TARGET_REG_BITS == 64 ? C_O0_I2(L, L)
+                : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? C_O0_I3(L, L, L)
+                : C_O0_I4(L, L, L, L));
 
     case INDEX_op_brcond2_i32:
-        {
-            static const TCGTargetOpDef b2
-                = { .args_ct_str = { "r", "r", "ri", "ri" } };
-            return &b2;
-        }
+        return C_O0_I4(r, r, ri, ri);
+
     case INDEX_op_setcond2_i32:
-        {
-            static const TCGTargetOpDef s2
-                = { .args_ct_str = { "r", "r", "r", "ri", "ri" } };
-            return &s2;
-        }
+        return C_O1_I4(r, r, r, ri, ri);
 
     case INDEX_op_ld_vec:
-    case INDEX_op_st_vec:
     case INDEX_op_dupm_vec:
-        return &x_r;
+        return C_O1_I1(x, r);
+
+    case INDEX_op_st_vec:
+        return C_O0_I2(x, r);
 
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
@@ -3256,16 +3199,18 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 #if TCG_TARGET_REG_BITS == 32
     case INDEX_op_dup2_vec:
 #endif
-        return &x_x_x;
+        return C_O1_I2(x, x, x);
+
     case INDEX_op_abs_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
     case INDEX_op_x86_psrldq_vec:
-        return &x_x;
+        return C_O1_I1(x, x);
+
     case INDEX_op_x86_vpblendvb_vec:
-        return &x_x_x_x;
+        return C_O1_I3(x, x, x, x);
 
     default:
         break;
-- 
2.25.1


