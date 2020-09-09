Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35645C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B26182145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oe27fSa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B26182145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo3V-0002dP-NP
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnv-0000pM-Iy
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:39 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:37151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnt-0002Kl-B0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:39 -0400
Received: by mail-pg1-x52d.google.com with SMTP id 5so739664pgl.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mbwoCZONuDBg3/F4OxaRMIur4lzY+flU6Zf0/YA/B+0=;
 b=oe27fSa0eO63mtiWVmDiQCLCyFtdYfgXoB18oE2bIs8Y8WNxIBjvmebr31++NYLhIo
 HAR8iltrcvbinFj6+PIgn4kz2f95JGicyWh0RkfIdXQ4FqHKoekyEYXKtkk9ymuP/kV4
 xbdtQGdzkes/HCQrtSUxS89AoSwSH9SAEf++oShtgkcDqJajaMSofmch/gXhVQO9faV4
 FVpUpHYUGbuF17C6UCDawOUu5fAnHMVYgqeVkimiP+VoazITtNftOgoI7VZzthbzNRHz
 JmVYHfLT1ETFxhvQ2XgiqYKVxoAFgogb/kl3XU1dToKYz5IOpetx1ghi/ctJT7Ed/E4t
 H4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mbwoCZONuDBg3/F4OxaRMIur4lzY+flU6Zf0/YA/B+0=;
 b=FWV6G8CqJ2KK2vqh2ouZ7Q/IPTesvNnyqUn6L6DwLWITDGGV9fFylDStFLc0hmvAX0
 85DfCU6Lynn3leRwHtl5lIu3L5nbQ5yYtz+tY7zdkIXucBHK7PKhSR9gw95vCxLQCzKM
 TJY1A5U3etF7RBoR8BfF690Al7qrST0RGp7cyVI/l1s0Dn1LNrsiiMmmZxocKNxIIhR7
 LBh/1SENol57HzAJh45KLtBVn4VKxkAUDB64176FL364314k5VULQLpPpu9+WpfK8saZ
 F234JQ8+CdMPTBFv2sljJznMH+Q7N/qZEopYCHIluE7VPB8Yc5HsokizIBiDkQBvHkjv
 q1rA==
X-Gm-Message-State: AOAM530PnVSpkpENDVD1YyvBX7IVet+oa/G5XinScFlAqpQxga/bdmFJ
 MX7EnzmN25JteaZjVM9SudqJ37Q0u3KiJw==
X-Google-Smtp-Source: ABdhPJyYcXrC5JAr3AbnV1DvSV+FJi27HOukGDXjFPjmeZn/NsHOm1e6HWa89M3flOcA9Wz6wWGFgQ==
X-Received: by 2002:a65:6282:: with SMTP id f2mr979461pgv.163.1599610655515;
 Tue, 08 Sep 2020 17:17:35 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/43] tcg/arm: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:41 -0700
Message-Id: <20200909001647.532249-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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
 tcg/arm/tcg-target-constr.h | 30 ++++++++++++
 tcg/arm/tcg-target.c.inc    | 93 +++++++++++++------------------------
 2 files changed, 63 insertions(+), 60 deletions(-)
 create mode 100644 tcg/arm/tcg-target-constr.h

diff --git a/tcg/arm/tcg-target-constr.h b/tcg/arm/tcg-target-constr.h
new file mode 100644
index 0000000000..c59be2da11
--- /dev/null
+++ b/tcg/arm/tcg-target-constr.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * ARM32 target-specific operand constaints. 
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I1(r)
+C_O0_I2(r, r)
+C_O0_I2(r, rIN)
+C_O0_I2(s, s)
+C_O0_I3(s, s, s)
+C_O0_I4(r, r, rI, rI)
+C_O0_I4(s, s, s, s)
+C_O1_I1(r, l)
+C_O1_I1(r, r)
+C_O1_I2(r, 0, rZ)
+C_O1_I2(r, l, l)
+C_O1_I2(r, r, r)
+C_O1_I2(r, r, rI)
+C_O1_I2(r, r, rIK)
+C_O1_I2(r, r, rIN)
+C_O1_I2(r, r, ri)
+C_O1_I2(r, rZ, rZ)
+C_O1_I4(r, r, r, rI, rI)
+C_O1_I4(r, r, rIN, rIK, 0)
+C_O2_I1(r, r, l)
+C_O2_I2(r, r, l, l)
+C_O2_I2(r, r, r, r)
+C_O2_I4(r, r, r, r, rIN, rIK)
+C_O2_I4(r, r, rI, rI, rIN, rIK)
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 30d30874c7..70a9e798e3 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2071,57 +2071,20 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+/* Define all constraint sets. */
+#include "../tcg-constr.c.inc"
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
-    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef s_s = { .args_ct_str = { "s", "s" } };
-    static const TCGTargetOpDef r_l = { .args_ct_str = { "r", "l" } };
-    static const TCGTargetOpDef r_r_r = { .args_ct_str = { "r", "r", "r" } };
-    static const TCGTargetOpDef r_r_l = { .args_ct_str = { "r", "r", "l" } };
-    static const TCGTargetOpDef r_l_l = { .args_ct_str = { "r", "l", "l" } };
-    static const TCGTargetOpDef s_s_s = { .args_ct_str = { "s", "s", "s" } };
-    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
-    static const TCGTargetOpDef r_r_rI = { .args_ct_str = { "r", "r", "rI" } };
-    static const TCGTargetOpDef r_r_rIN
-        = { .args_ct_str = { "r", "r", "rIN" } };
-    static const TCGTargetOpDef r_r_rIK
-        = { .args_ct_str = { "r", "r", "rIK" } };
-    static const TCGTargetOpDef r_r_r_r
-        = { .args_ct_str = { "r", "r", "r", "r" } };
-    static const TCGTargetOpDef r_r_l_l
-        = { .args_ct_str = { "r", "r", "l", "l" } };
-    static const TCGTargetOpDef s_s_s_s
-        = { .args_ct_str = { "s", "s", "s", "s" } };
-    static const TCGTargetOpDef br
-        = { .args_ct_str = { "r", "rIN" } };
-    static const TCGTargetOpDef ext2
-        = { .args_ct_str = { "r", "rZ", "rZ" } };
-    static const TCGTargetOpDef dep
-        = { .args_ct_str = { "r", "0", "rZ" } };
-    static const TCGTargetOpDef movc
-        = { .args_ct_str = { "r", "r", "rIN", "rIK", "0" } };
-    static const TCGTargetOpDef add2
-        = { .args_ct_str = { "r", "r", "r", "r", "rIN", "rIK" } };
-    static const TCGTargetOpDef sub2
-        = { .args_ct_str = { "r", "r", "rI", "rI", "rIN", "rIK" } };
-    static const TCGTargetOpDef br2
-        = { .args_ct_str = { "r", "r", "rI", "rI" } };
-    static const TCGTargetOpDef setc2
-        = { .args_ct_str = { "r", "r", "r", "rI", "rI" } };
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
     case INDEX_op_neg_i32:
     case INDEX_op_not_i32:
     case INDEX_op_bswap16_i32:
@@ -2131,59 +2094,69 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ext16u_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
-        return &r_r;
+        return C_O1_I1(r, r);
+
+    case INDEX_op_st8_i32:
+    case INDEX_op_st16_i32:
+    case INDEX_op_st_i32:
+        return C_O0_I2(r, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
-        return &r_r_rIN;
+        return C_O1_I2(r, r, rIN);
+
     case INDEX_op_and_i32:
     case INDEX_op_andc_i32:
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
-        return &r_r_rIK;
+        return C_O1_I2(r, r, rIK);
+
     case INDEX_op_mul_i32:
     case INDEX_op_div_i32:
     case INDEX_op_divu_i32:
-        return &r_r_r;
+        return C_O1_I2(r, r, r);
+
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
-        return &r_r_r_r;
+        return C_O2_I2(r, r, r, r);
+
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
-        return &r_r_rI;
+        return C_O1_I2(r, r, rI);
+
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-        return &r_r_ri;
+        return C_O1_I2(r, r, ri);
 
     case INDEX_op_brcond_i32:
-        return &br;
+        return C_O0_I2(r, rIN);
     case INDEX_op_deposit_i32:
-        return &dep;
+        return C_O1_I2(r, 0, rZ);
     case INDEX_op_extract2_i32:
-        return &ext2;
+        return C_O1_I2(r, rZ, rZ);
     case INDEX_op_movcond_i32:
-        return &movc;
+        return C_O1_I4(r, r, rIN, rIK, 0);
     case INDEX_op_add2_i32:
-        return &add2;
+        return C_O2_I4(r, r, r, r, rIN, rIK);
     case INDEX_op_sub2_i32:
-        return &sub2;
+        return C_O2_I4(r, r, rI, rI, rIN, rIK);
     case INDEX_op_brcond2_i32:
-        return &br2;
+        return C_O0_I4(r, r, rI, rI);
     case INDEX_op_setcond2_i32:
-        return &setc2;
+        return C_O1_I4(r, r, r, rI, rI);
 
     case INDEX_op_qemu_ld_i32:
-        return TARGET_LONG_BITS == 32 ? &r_l : &r_l_l;
+        return TARGET_LONG_BITS == 32 ? C_O1_I1(r, l) : C_O1_I2(r, l, l);
     case INDEX_op_qemu_ld_i64:
-        return TARGET_LONG_BITS == 32 ? &r_r_l : &r_r_l_l;
+        return TARGET_LONG_BITS == 32 ? C_O2_I1(r, r, l) : C_O2_I2(r, r, l, l);
     case INDEX_op_qemu_st_i32:
-        return TARGET_LONG_BITS == 32 ? &s_s : &s_s_s;
+        return TARGET_LONG_BITS == 32 ? C_O0_I2(s, s) : C_O0_I3(s, s, s);
     case INDEX_op_qemu_st_i64:
-        return TARGET_LONG_BITS == 32 ? &s_s_s : &s_s_s_s;
+        return TARGET_LONG_BITS == 32 ? C_O0_I3(s, s, s) : C_O0_I4(s, s, s, s);
 
     default:
         return NULL;
-- 
2.25.1


