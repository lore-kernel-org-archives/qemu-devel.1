Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833CBC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:34:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEDD2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtGZHGVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEDD2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo4O-00042v-BR
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnw-0000sX-N9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:40 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:43708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnu-0002L5-Mf
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:40 -0400
Received: by mail-pg1-x52d.google.com with SMTP id t14so714713pgl.10
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=VHMzWfhySbeDoxJTEYjQPiFuY5RLIdMHbneN2NIax7E=;
 b=xtGZHGVHfOGg8YcX546Ot3ctbU1jHIP324nNFhLMZ9nMiXFa7rw/f0onnEs9Mei5MT
 jvHndI9aJT3pE4kEsDUtVN3euJwgYYZKDr7Mn51UIHHv92oXZALyTOryUgIIq8gUyvmm
 T6qEps/ikV7WKy9YqthH+85iA43PVZxqq2TP5h21XyaEizLigeuGqYSPo32ZhFssISWf
 r6fMQ1Chi1+VDKD5g2I5z4jOguMnJE4AUiwOz1p8lyQ/VLHAZ9uLz4FgAoXe3xAfWraS
 6fhp8SHwGjRUJlmyfIRRDjCs6CJC+08dCrTn596hGHIXz1qWgTDDBUeo+o8UKVHRgs4C
 dPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VHMzWfhySbeDoxJTEYjQPiFuY5RLIdMHbneN2NIax7E=;
 b=B556REgS83i7HCiDIfyOLlDRPeDnlvNJ/ONRWyjrw928HKNaPyJBRCDzA39+l8DwGU
 fTwra6U8QdiLh/tOSE3NfzyHPNupjueBuiHy6e4ODMxZkak5bpWWo+J9x1itWWcWIlTN
 M+RxMO8bdwTeu6wjQvRTi/qKB/boEQvkN1dh+V4a1u+BAXt0XNCBnOlqShsEbURDld07
 Wo1ptJNDDOrjLh2EcEZaiBfzor2m0vInuRzsZHMkO9vlvXizuIliNVXNFKNNjXgMt4DT
 SZUSGL4KjJlUTzBiVjsJFW6Q7iSuFryzoAA7Vv6epcPr9MlUzTiwm0yCHeoTfFYMwizG
 uaRg==
X-Gm-Message-State: AOAM533T1nPAoQRGcPkRqKs+XaSGBqQmgKzfiwo9uPrNTJDtpi36mvwo
 rL8BXyq0bItEdE1ib93FD9U9sGAaQAEfvg==
X-Google-Smtp-Source: ABdhPJxfjZBeEkme6v59E2z5wkfUC3688ftmhWA5dbo77kpffJGql/iStFMZLgeJXohgGjhGIv7gSg==
X-Received: by 2002:a65:6706:: with SMTP id u6mr940313pgf.404.1599610656727;
 Tue, 08 Sep 2020 17:17:36 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 38/43] tcg/mips: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:42 -0700
Message-Id: <20200909001647.532249-39-richard.henderson@linaro.org>
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
 tcg/mips/tcg-target-constr.h | 31 ++++++++++++
 tcg/mips/tcg-target.c.inc    | 95 ++++++++++++------------------------
 2 files changed, 61 insertions(+), 65 deletions(-)
 create mode 100644 tcg/mips/tcg-target-constr.h

diff --git a/tcg/mips/tcg-target-constr.h b/tcg/mips/tcg-target-constr.h
new file mode 100644
index 0000000000..831e2d8a01
--- /dev/null
+++ b/tcg/mips/tcg-target-constr.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * MIPS target-specific operand constaints.
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I1(r)
+C_O0_I2(rZ, r)
+C_O0_I2(rZ, rZ)
+C_O0_I2(SZ, S)
+C_O0_I3(SZ, S, S)
+C_O0_I3(SZ, SZ, S)
+C_O0_I4(rZ, rZ, rZ, rZ)
+C_O0_I4(SZ, SZ, S, S)
+C_O1_I1(r, L)
+C_O1_I1(r, r)
+C_O1_I2(r, 0, rZ)
+C_O1_I2(r, L, L)
+C_O1_I2(r, r, ri)
+C_O1_I2(r, r, rI)
+C_O1_I2(r, r, rIK)
+C_O1_I2(r, r, rJ)
+C_O1_I2(r, r, rWZ)
+C_O1_I2(r, rZ, rN)
+C_O1_I2(r, rZ, rZ)
+C_O1_I4(r, rZ, rZ, rZ, 0)
+C_O1_I4(r, rZ, rZ, rZ, rZ)
+C_O2_I1(r, r, L)
+C_O2_I2(r, r, L, L)
+C_O2_I2(r, r, r, r)
+C_O2_I4(r, r, rZ, rZ, rN, rN)
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 3e282c1bde..9e78a79eb6 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2158,52 +2158,14 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+/* Define all constraint sets. */
+#include "../tcg-constr.c.inc"
+
 static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
 {
-    static const TCGTargetOpDef r = { .args_ct_str = { "r" } };
-    static const TCGTargetOpDef r_r = { .args_ct_str = { "r", "r" } };
-    static const TCGTargetOpDef r_L = { .args_ct_str = { "r", "L" } };
-    static const TCGTargetOpDef rZ_r = { .args_ct_str = { "rZ", "r" } };
-    static const TCGTargetOpDef SZ_S = { .args_ct_str = { "SZ", "S" } };
-    static const TCGTargetOpDef rZ_rZ = { .args_ct_str = { "rZ", "rZ" } };
-    static const TCGTargetOpDef r_r_L = { .args_ct_str = { "r", "r", "L" } };
-    static const TCGTargetOpDef r_L_L = { .args_ct_str = { "r", "L", "L" } };
-    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
-    static const TCGTargetOpDef r_r_rI = { .args_ct_str = { "r", "r", "rI" } };
-    static const TCGTargetOpDef r_r_rJ = { .args_ct_str = { "r", "r", "rJ" } };
-    static const TCGTargetOpDef SZ_S_S = { .args_ct_str = { "SZ", "S", "S" } };
-    static const TCGTargetOpDef SZ_SZ_S
-        = { .args_ct_str = { "SZ", "SZ", "S" } };
-    static const TCGTargetOpDef SZ_SZ_S_S
-        = { .args_ct_str = { "SZ", "SZ", "S", "S" } };
-    static const TCGTargetOpDef r_rZ_rN
-        = { .args_ct_str = { "r", "rZ", "rN" } };
-    static const TCGTargetOpDef r_rZ_rZ
-        = { .args_ct_str = { "r", "rZ", "rZ" } };
-    static const TCGTargetOpDef r_r_rIK
-        = { .args_ct_str = { "r", "r", "rIK" } };
-    static const TCGTargetOpDef r_r_rWZ
-        = { .args_ct_str = { "r", "r", "rWZ" } };
-    static const TCGTargetOpDef r_r_r_r
-        = { .args_ct_str = { "r", "r", "r", "r" } };
-    static const TCGTargetOpDef r_r_L_L
-        = { .args_ct_str = { "r", "r", "L", "L" } };
-    static const TCGTargetOpDef dep
-        = { .args_ct_str = { "r", "0", "rZ" } };
-    static const TCGTargetOpDef movc
-        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "0" } };
-    static const TCGTargetOpDef movc_r6
-        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "rZ" } };
-    static const TCGTargetOpDef add2
-        = { .args_ct_str = { "r", "r", "rZ", "rZ", "rN", "rN" } };
-    static const TCGTargetOpDef br2
-        = { .args_ct_str = { "rZ", "rZ", "rZ", "rZ" } };
-    static const TCGTargetOpDef setc2
-        = { .args_ct_str = { "r", "rZ", "rZ", "rZ", "rZ" } };
-
     switch (op) {
     case INDEX_op_goto_ptr:
-        return &r;
+        return C_O0_I1(r);
 
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8s_i32:
@@ -2236,7 +2198,7 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
     case INDEX_op_extract_i64:
-        return &r_r;
+        return C_O1_I1(r, r);
 
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
@@ -2245,14 +2207,14 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return &rZ_r;
+        return C_O0_I2(rZ, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
-        return &r_r_rJ;
+        return C_O1_I2(r, r, rJ);
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return &r_rZ_rN;
+        return C_O1_I2(r, rZ, rN);
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
@@ -2271,20 +2233,20 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_remu_i64:
     case INDEX_op_nor_i64:
     case INDEX_op_setcond_i64:
-        return &r_rZ_rZ;
+        return C_O1_I2(r, rZ, rZ);
     case INDEX_op_muls2_i32:
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
-        return &r_r_r_r;
+        return C_O2_I2(r, r, r, r);
     case INDEX_op_and_i32:
     case INDEX_op_and_i64:
-        return &r_r_rIK;
+        return C_O1_I2(r, r, rIK);
     case INDEX_op_or_i32:
     case INDEX_op_xor_i32:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
-        return &r_r_rI;
+        return C_O1_I2(r, r, rI);
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
@@ -2295,41 +2257,44 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sar_i64:
     case INDEX_op_rotr_i64:
     case INDEX_op_rotl_i64:
-        return &r_r_ri;
+        return C_O1_I2(r, r, ri);
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-        return &r_r_rWZ;
+        return C_O1_I2(r, r, rWZ);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return &dep;
+        return C_O1_I2(r, 0, rZ);
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return &rZ_rZ;
+        return C_O0_I2(rZ, rZ);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return use_mips32r6_instructions ? &movc_r6 : &movc;
-
+        return (use_mips32r6_instructions
+                ? C_O1_I4(r, rZ, rZ, rZ, rZ)
+                : C_O1_I4(r, rZ, rZ, rZ, 0));
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return &add2;
+        return C_O2_I4(r, r, rZ, rZ, rN, rN);
     case INDEX_op_setcond2_i32:
-        return &setc2;
+        return C_O1_I4(r, rZ, rZ, rZ, rZ);
     case INDEX_op_brcond2_i32:
-        return &br2;
+        return C_O0_I4(rZ, rZ, rZ, rZ);
 
     case INDEX_op_qemu_ld_i32:
         return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
-                ? &r_L : &r_L_L);
+                ? C_O1_I1(r, L) : C_O1_I2(r, L, L));
     case INDEX_op_qemu_st_i32:
         return (TCG_TARGET_REG_BITS == 64 || TARGET_LONG_BITS == 32
-                ? &SZ_S : &SZ_S_S);
+                ? C_O0_I2(SZ, S) : C_O0_I3(SZ, S, S));
     case INDEX_op_qemu_ld_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &r_L
-                : TARGET_LONG_BITS == 32 ? &r_r_L : &r_r_L_L);
+        return (TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, L)
+                : TARGET_LONG_BITS == 32 ? C_O2_I1(r, r, L)
+                : C_O2_I2(r, r, L, L));
     case INDEX_op_qemu_st_i64:
-        return (TCG_TARGET_REG_BITS == 64 ? &SZ_S
-                : TARGET_LONG_BITS == 32 ? &SZ_SZ_S : &SZ_SZ_S_S);
+        return (TCG_TARGET_REG_BITS == 64 ? C_O0_I2(SZ, S)
+                : TARGET_LONG_BITS == 32 ? C_O0_I3(SZ, SZ, S)
+                : C_O0_I4(SZ, SZ, S, S));
 
     default:
         return NULL;
-- 
2.25.1


