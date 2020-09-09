Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA3C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:30:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3B692145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tRqWUiD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B692145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo01-0004in-QW
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnz-0000zQ-4Z
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:43498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnx-0002Ld-3Q
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id f18so541092pfa.10
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hCBX2cyLM5KyoJd9ZdINXW9/beVmBc7hH0uzic/OGPU=;
 b=tRqWUiD6VvdM0wUXJWOvMKasCRsfgr6u2rv8JKTjDRahO9BtDFqm8zWjD+vlfVbqTT
 HuLCr14LjTOF7lisaVJK2c2CxJDa/M9eIW3cdgIU/TmskkTnKwREX+sL5PGWCVA7hwBY
 XflfLcQOQuKIXpIukVPAnwUGLDL9e9ktODbi0mf7EGzL3pNPdd4AIorL0+H+Sb3/Zz2q
 5znx3XatcwwUeP+XnEolih+N0YXx88QBFhom+bGSa1yJ3Ua6NJYQuvbMy/AsIcwY7Es9
 jFLuqFhB7AxqMF7eqbMD9twJ7/0ck7nGZO1hhzorY8CC/vFgz7jB9hKD7J9yyeVrR5tQ
 IJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hCBX2cyLM5KyoJd9ZdINXW9/beVmBc7hH0uzic/OGPU=;
 b=cwLAHx3sC8lMiuEeUcMoXWeIhPW2nYnTzd1+Am/zy0gDEAsn+U65VL8KVwApMkqi58
 Q+LXNGRDkPvsOCOeTjdf8AsnXuPnwUif3/0tuDZZIMnd2JJB73iYW/2kWcRmTK2dA93i
 40gsSqCv1As/dCQmwEqXfMocDoe4rPWcRSujv/WL5oOTR91GMb3UuWGN0crUl7CNrvQT
 xLBH+KLD/mQknfXSMsGFK6SVjJcz7qZaVpzwooCSOgAnJxsJeKZSW6L7I2tlbT5y8dMP
 idAXdBurVrfOOxzAmm7lmdu+vV0UW+S3L6rWzFe718bFDRewEOKdro1txh2WWXg3LYrq
 j99w==
X-Gm-Message-State: AOAM533EK8tff8fbLID+z54Nl41odoVSaDI3NxC+d+Gfsq+i9CSExZT7
 fHNWSAZER9UgEgDP2O7VX8jenpa2Q08g/Q==
X-Google-Smtp-Source: ABdhPJxebWIuSf+dL4gz+T0pBI+R+5VYPY9NqPzcJGfxXN5OCbGwqnsqsQooKFp9Okq1ZyRbfrmYIQ==
X-Received: by 2002:a63:5656:: with SMTP id g22mr956636pgm.44.1599610659332;
 Tue, 08 Sep 2020 17:17:39 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 40/43] tcg/riscv: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:44 -0700
Message-Id: <20200909001647.532249-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 tcg/riscv/tcg-target-constr.h | 25 +++++++++++
 tcg/riscv/tcg-target.c.inc    | 82 ++++++++++-------------------------
 2 files changed, 49 insertions(+), 58 deletions(-)
 create mode 100644 tcg/riscv/tcg-target-constr.h

diff --git a/tcg/riscv/tcg-target-constr.h b/tcg/riscv/tcg-target-constr.h
new file mode 100644
index 0000000000..aeff74034c
--- /dev/null
+++ b/tcg/riscv/tcg-target-constr.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * RISC-V target-specific operand constaints.
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I1(r)
+C_O0_I2(LZ, L)
+C_O0_I2(rZ, r)
+C_O0_I2(rZ, rZ)
+C_O0_I3(LZ, L, L)
+C_O0_I3(LZ, LZ, L)
+C_O0_I4(LZ, LZ, L, L)
+C_O0_I4(rZ, rZ, rZ, rZ)
+C_O1_I1(r, L)
+C_O1_I1(r, r)
+C_O1_I2(r, L, L)
+C_O1_I2(r, r, ri)
+C_O1_I2(r, r, rI)
+C_O1_I2(r, rZ, rN)
+C_O1_I2(r, rZ, rZ)
+C_O1_I4(r, rZ, rZ, rZ, rZ)
+C_O2_I1(r, r, L)
+C_O2_I2(r, r, L, L)
+C_O2_I4(r, r, rZ, rZ, rM, rM)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index aaef1c5eed..042a41e1f4 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1608,50 +1608,14 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+/* Define all constraint sets. */
+#include "../tcg-constr.c.inc"
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    static const TCGTargetOpDef r
-        = { .args_ct_str = { "r" } };
-    static const TCGTargetOpDef r_r
-        = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef rZ_r
-        = { .args_ct_str = { "rZ", "r" } };
-    static const TCGTargetOpDef rZ_rZ
-        = { .args_ct_str = { "rZ", "rZ" } };
-    static const TCGTargetOpDef rZ_rZ_rZ_rZ
-        = { .args_ct_str = { "rZ", "rZ", "rZ", "rZ" } };
-    static const TCGTargetOpDef r_r_ri
-        = { .args_ct_str = { "r", "r", "ri" } };
-    static const TCGTargetOpDef r_r_rI
-        = { .args_ct_str = { "r", "r", "rI" } };
-    static const TCGTargetOpDef r_rZ_rN
-        = { .args_ct_str = { "r", "rZ", "rN" } };
-    static const TCGTargetOpDef r_rZ_rZ
-        = { .args_ct_str = { "r", "rZ", "rZ" } };
-    static const TCGTargetOpDef r_rZ_rZ_rZ_rZ
-        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "rZ" } };
-    static const TCGTargetOpDef r_L
-        = { .args_ct_str = { "r", "L" } };
-    static const TCGTargetOpDef r_r_L
-        = { .args_ct_str = { "r", "r", "L" } };
-    static const TCGTargetOpDef r_L_L
-        = { .args_ct_str = { "r", "L", "L" } };
-    static const TCGTargetOpDef r_r_L_L
-        = { .args_ct_str = { "r", "r", "L", "L" } };
-    static const TCGTargetOpDef LZ_L
-        = { .args_ct_str = { "LZ", "L" } };
-    static const TCGTargetOpDef LZ_L_L
-        = { .args_ct_str = { "LZ", "L", "L" } };
-    static const TCGTargetOpDef LZ_LZ_L
-        = { .args_ct_str = { "LZ", "LZ", "L" } };
-    static const TCGTargetOpDef LZ_LZ_L_L
-        = { .args_ct_str = { "LZ", "LZ", "L", "L" } };
-    static const TCGTargetOpDef r_r_rZ_rZ_rM_rM
-        = { .args_ct_str = { "r", "r", "rZ", "rZ", "rM", "rM" } };
-
     switch (op) {
     case INDEX_op_goto_ptr:
-        return &r;
+        return C_O0_I1(r);
 
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
@@ -1683,7 +1647,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_ext_i32_i64:
-        return &r_r;
+        return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
@@ -1692,7 +1656,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return &rZ_r;
+        return C_O0_I2(rZ, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_and_i32:
@@ -1702,11 +1666,11 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_and_i64:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
-        return &r_r_rI;
+        return C_O1_I2(r, r, rI);
 
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return &r_rZ_rN;
+        return C_O1_I2(r, rZ, rN);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
@@ -1724,7 +1688,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
     case INDEX_op_setcond_i64:
-        return &r_rZ_rZ;
+        return C_O1_I2(r, rZ, rZ);
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
@@ -1732,36 +1696,38 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
-        return &r_r_ri;
+        return C_O1_I2(r, r, ri);
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return &rZ_rZ;
+        return C_O0_I2(rZ, rZ);
 
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return &r_r_rZ_rZ_rM_rM;
+        return C_O2_I4(r, r, rZ, rZ, rM, rM);
 
     case INDEX_op_brcond2_i32:
-        return &rZ_rZ_rZ_rZ;
+        return C_O0_I4(rZ, rZ, rZ, rZ);
 
     case INDEX_op_setcond2_i32:
-        return &r_rZ_rZ_rZ_rZ;
+        return C_O1_I4(r, rZ, rZ, rZ, rZ);
 
     case INDEX_op_qemu_ld_i32:
-        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_L : &r_L_L;
+        return (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+                ? C_O1_I1(r, L) : C_O1_I2(r, L, L));
     case INDEX_op_qemu_st_i32:
-        return TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &LZ_L : &LZ_L_L;
+        return (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+                ? C_O0_I2(LZ, L) : C_O0_I3(LZ, L, L));
     case INDEX_op_qemu_ld_i64:
-        return TCG_TARGET_REG_BITS == 64 ? &r_L
-               : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &r_r_L
-               : &r_r_L_L;
+        return (TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L)
+               : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? C_O2_I1(r, r, L)
+               : C_O2_I2(r, r, L, L));
     case INDEX_op_qemu_st_i64:
-        return TCG_TARGET_REG_BITS == 64 ? &LZ_L
-               : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? &LZ_LZ_L
-               : &LZ_LZ_L_L;
+        return (TCG_TARGET_REG_BITS == 64 ? C_O0_I2(LZ, L)
+               : TARGET_LONG_BITS <= TCG_TARGET_REG_BITS ? C_O0_I3(LZ, LZ, L)
+               : C_O0_I4(LZ, LZ, L, L));
 
     default:
         return NULL;
-- 
2.25.1


