Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287E3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:31:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B582145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iap+ptFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B582145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFo1b-0007Pg-Nr
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38056)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFno0-00012p-Bb
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:44 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:53977)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnny-0002M2-Cd
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:44 -0400
Received: by mail-pj1-x1035.google.com with SMTP id t7so429341pjd.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=E/+IbLkuc88o8W2y0bJXVmWsi6CUPEMwbQDPjSqv7So=;
 b=Iap+ptFIl1CDEjjohXB+PEi7PSbcCFYOhS5YRYGdltd4W/WUbn8AawP8p9Aiz1mdz8
 1fsjJO/VZFWGZTvYm1mYga5ryRCdbzYIyt+mN7A/UoDifzEjvYop8+03re5/DGk7qIZl
 wxfQO4qgVphmoBTdrimg6tlQJ7D/XMxcoYQ8lET6R9W/IP5jJ0DOdrPEMm4tw2ElgGXk
 KCp501QsfIbO53L8x6q2hu6sVpGsWrozoMzBY5a+KTH9K9UOxqkK/gZEY86PMd0jKL8X
 u41T7N8JZ+86kg7vOpUzvQ/b99wpkXOebT9IzwXmINDmmZvArK39ZtKHH/T+nuVhTIgG
 lURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E/+IbLkuc88o8W2y0bJXVmWsi6CUPEMwbQDPjSqv7So=;
 b=SO23C3XbNIvZ4uS8tdIq62jTloR9Bce0nZv6Ky6qmPxExtJVQgkKRnpDS2pucObE7g
 N/48tTeu2IISlSvxfqrZ8rwMZaDr7ZutYEM1Sn5nJsKadzxqtwLYKNwmmXsozmCY3Akg
 TDg2i+bfWml847LZoxtNfx6sla2CW2rrLsO6ijwnNuyFBxVldCM9lskU+yZHPXKN9r87
 wuUh+0wj6iPf0LLiLlMOwNL/zUZZ3Z6f98wfpd5bJoVNX971j2ijpzVOqufWq6ntPeB3
 5Xn7zmhQB/x7Cz0w0/3gb+frsXfSbYOAtc7aCSIGkBSsp/Fh2VnirR6E6z1KXgV+e+1E
 GIpA==
X-Gm-Message-State: AOAM532AFtoXuHNZJdRbcEo0poTDSDN9lO1O6Ylbp80fejtKCg/c3yys
 s1v0SIeqvJoVvTkq3arhVZo4Wtq8pzy+Hw==
X-Google-Smtp-Source: ABdhPJwVSqQ3/4CmbELLLZqRoGlVfunAv+/6nZ7CsIozEqZTqD3nBKz8uTufHk6p5IOKuQZjgZ0eBg==
X-Received: by 2002:a17:90a:c907:: with SMTP id
 v7mr1194438pjt.204.1599610660596; 
 Tue, 08 Sep 2020 17:17:40 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 41/43] tcg/s390: Convert to tcg-constr.c.inc
Date: Tue,  8 Sep 2020 17:16:45 -0700
Message-Id: <20200909001647.532249-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
 tcg/s390/tcg-target-constr.h |  24 +++++++
 tcg/s390/tcg-target.c.inc    | 119 +++++++++++++++--------------------
 2 files changed, 76 insertions(+), 67 deletions(-)
 create mode 100644 tcg/s390/tcg-target-constr.h

diff --git a/tcg/s390/tcg-target-constr.h b/tcg/s390/tcg-target-constr.h
new file mode 100644
index 0000000000..06c1f4a944
--- /dev/null
+++ b/tcg/s390/tcg-target-constr.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * S390 target-specific operand constaints.
+ * Copyright (c) 2020 Linaro
+ */
+
+C_O0_I1(r)
+C_O0_I2(L, L)
+C_O0_I2(r, r)
+C_O0_I2(r, ri)
+C_O1_I1(r, L)
+C_O1_I1(r, r)
+C_O1_I2(r, 0, ri)
+C_O1_I2(r, 0, rI)
+C_O1_I2(r, 0, rJ)
+C_O1_I2(r, r, ri)
+C_O1_I2(r, rZ, r)
+C_O1_I4(r, r, ri, r, 0)
+C_O1_I4(r, r, ri, rI, 0)
+C_O2_I2(b, a, 0, r)
+C_O2_I3(b, a, 0, 1, r)
+C_O2_I4(r, r, 0, 1, rA, r)
+C_O2_I4(r, r, 0, 1, ri, r)
+C_O2_I4(r, r, 0, 1, r, r)
diff --git a/tcg/s390/tcg-target.c.inc b/tcg/s390/tcg-target.c.inc
index 824a07aa7a..c628194421 100644
--- a/tcg/s390/tcg-target.c.inc
+++ b/tcg/s390/tcg-target.c.inc
@@ -2312,27 +2312,14 @@ static inline void tcg_out_op(TCGContext *s, TCGOpcode opc,
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
-    static const TCGTargetOpDef L_L = { .args_ct_str = { "L", "L" } };
-    static const TCGTargetOpDef r_ri = { .args_ct_str = { "r", "ri" } };
-    static const TCGTargetOpDef r_r_ri = { .args_ct_str = { "r", "r", "ri" } };
-    static const TCGTargetOpDef r_0_ri = { .args_ct_str = { "r", "0", "ri" } };
-    static const TCGTargetOpDef r_0_rI = { .args_ct_str = { "r", "0", "rI" } };
-    static const TCGTargetOpDef r_0_rJ = { .args_ct_str = { "r", "0", "rJ" } };
-    static const TCGTargetOpDef a2_r
-        = { .args_ct_str = { "r", "r", "0", "1", "r", "r" } };
-    static const TCGTargetOpDef a2_ri
-        = { .args_ct_str = { "r", "r", "0", "1", "ri", "r" } };
-    static const TCGTargetOpDef a2_rA
-        = { .args_ct_str = { "r", "r", "0", "1", "rA", "r" } };
-
     switch (op) {
     case INDEX_op_goto_ptr:
-        return &r;
+        return C_O0_I1(r);
 
     case INDEX_op_ld8u_i32:
     case INDEX_op_ld8u_i64:
@@ -2346,6 +2333,8 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_ld32u_i64:
     case INDEX_op_ld32s_i64:
     case INDEX_op_ld_i64:
+        return C_O1_I1(r, r);
+
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
     case INDEX_op_st16_i32:
@@ -2353,11 +2342,22 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_i32:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return &r_r;
+        return C_O0_I2(r, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
-        return &r_r_ri;
+    case INDEX_op_shl_i64:
+    case INDEX_op_shr_i64:
+    case INDEX_op_sar_i64:
+    case INDEX_op_rotl_i32:
+    case INDEX_op_rotl_i64:
+    case INDEX_op_rotr_i32:
+    case INDEX_op_rotr_i64:
+    case INDEX_op_clz_i64:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
+        return C_O1_I2(r, r, ri);
+
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_and_i32:
@@ -2366,35 +2366,33 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_or_i64:
     case INDEX_op_xor_i32:
     case INDEX_op_xor_i64:
-        return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
+        return (s390_facilities & FACILITY_DISTINCT_OPS
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, 0, ri));
 
     case INDEX_op_mul_i32:
         /* If we have the general-instruction-extensions, then we have
            MULTIPLY SINGLE IMMEDIATE with a signed 32-bit, otherwise we
            have only MULTIPLY HALFWORD IMMEDIATE, with a signed 16-bit.  */
-        return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_ri : &r_0_rI);
+        return (s390_facilities & FACILITY_GEN_INST_EXT
+                ? C_O1_I2(r, 0, ri)
+                : C_O1_I2(r, 0, rI));
+
     case INDEX_op_mul_i64:
-        return (s390_facilities & FACILITY_GEN_INST_EXT ? &r_0_rJ : &r_0_rI);
+        return (s390_facilities & FACILITY_GEN_INST_EXT
+                ? C_O1_I2(r, 0, rJ)
+                : C_O1_I2(r, 0, rI));
 
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
-        return (s390_facilities & FACILITY_DISTINCT_OPS ? &r_r_ri : &r_0_ri);
-
-    case INDEX_op_shl_i64:
-    case INDEX_op_shr_i64:
-    case INDEX_op_sar_i64:
-        return &r_r_ri;
-
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
-        return &r_r_ri;
+        return (s390_facilities & FACILITY_DISTINCT_OPS
+                ? C_O1_I2(r, r, ri)
+                : C_O1_I2(r, 0, ri));
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return &r_ri;
+        return C_O0_I2(r, ri);
 
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
@@ -2417,58 +2415,45 @@ static const TCGTargetOpDef *tcg_target_op_def(TCGOpcode op)
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extract_i32:
     case INDEX_op_extract_i64:
-        return &r_r;
-
-    case INDEX_op_clz_i64:
-    case INDEX_op_setcond_i32:
-    case INDEX_op_setcond_i64:
-        return &r_r_ri;
+        return C_O1_I1(r, r);
 
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
-        return &r_L;
+        return C_O1_I1(r, L);
     case INDEX_op_qemu_st_i64:
     case INDEX_op_qemu_st_i32:
-        return &L_L;
+        return C_O0_I2(L, L);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        {
-            static const TCGTargetOpDef dep
-                = { .args_ct_str = { "r", "rZ", "r" } };
-            return &dep;
-        }
+        return C_O1_I2(r, rZ, r);
+
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        {
-            static const TCGTargetOpDef movc
-                = { .args_ct_str = { "r", "r", "ri", "r", "0" } };
-            static const TCGTargetOpDef movc_l
-                = { .args_ct_str = { "r", "r", "ri", "rI", "0" } };
-            return (s390_facilities & FACILITY_LOAD_ON_COND2 ? &movc_l : &movc);
-        }
+        return (s390_facilities & FACILITY_LOAD_ON_COND2
+                ? C_O1_I4(r, r, ri, rI, 0)
+                : C_O1_I4(r, r, ri, r, 0));
+
     case INDEX_op_div2_i32:
     case INDEX_op_div2_i64:
     case INDEX_op_divu2_i32:
     case INDEX_op_divu2_i64:
-        {
-            static const TCGTargetOpDef div2
-                = { .args_ct_str = { "b", "a", "0", "1", "r" } };
-            return &div2;
-        }
+        return C_O2_I3(b, a, 0, 1, r);
+
     case INDEX_op_mulu2_i64:
-        {
-            static const TCGTargetOpDef mul2
-                = { .args_ct_str = { "b", "a", "0", "r" } };
-            return &mul2;
-        }
+        return C_O2_I2(b, a, 0, r);
 
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return (s390_facilities & FACILITY_EXT_IMM ? &a2_ri : &a2_r);
+        return (s390_facilities & FACILITY_EXT_IMM
+                ? C_O2_I4(r, r, 0, 1, ri, r)
+                : C_O2_I4(r, r, 0, 1, r, r));
+
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i64:
-        return (s390_facilities & FACILITY_EXT_IMM ? &a2_rA : &a2_r);
+        return (s390_facilities & FACILITY_EXT_IMM
+                ? C_O2_I4(r, r, 0, 1, rA, r)
+                : C_O2_I4(r, r, 0, 1, r, r));
 
     default:
         break;
-- 
2.25.1


