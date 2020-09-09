Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663B7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D547421556
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kObbtB/n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D547421556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnst-0003VB-Nz
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37690)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnng-00009I-NH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:38242)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnd-0002Gs-Ry
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id l126so561418pfd.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=aEQok0/L5FX5jAQIApgNcuA+gqvYfIDMod+uDV+LrZA=;
 b=kObbtB/nmTOKltsUb1bI5AJlLK0rG4aZtIa6trKBK32e8G7+L2gQvwwpn3H26XHI6G
 2rRBlLYPL/cf+HDLLfafcON2t8iEYpIQrMAtpYNvbDBR6+OA3CqhcvusPzNY3WMULuVM
 S1JF/dk8g6bU/rr1bpef8+AwWloj9lPJ7PFglVnThhPoB5NE9w+RKwj4nIl096VW4wz1
 /JMcD+9AtEDjrxQK3/ctMQNAKVnrBUQQA9v8na8JxPKRNkdJHsh2lrX+fPe+JtMeFfcw
 ApymJZbvFr9oTXCBfnMrznGn8BqCo9Dd/VB4UoxAeLCjEfBB83KFqqrit2xtO6panowL
 z4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aEQok0/L5FX5jAQIApgNcuA+gqvYfIDMod+uDV+LrZA=;
 b=P28JZvrC2qAHv1oowKPPEdA1pAl6i0Cp5e7po+kpQSGNiDp4Zm0SXpPWySXQH2D0H6
 sfBZuUlDoBZPQYS3lDaQTlPQU4UwBZryh1iCRU6arv9lIEuEfRJBDMey+BdBgdWfV83r
 93v1xUfY4YYlRjBexW/8sYDetLYAxvesY/Z5g5cZlC7fDsAyTDm/+8KbW6Ixd51VSoaT
 JSovSkxr201Csmjq+kdOtmx5p0B7rYpY2PeXmNaFX0JuEpEvXle4kWGB/SmF+3fCzTm/
 z6wvkoOIgWSltkA8ydIksxEnXuOznE0J2mT8KlIHq1jtzjqk2oYfQetqrmDAzS9LTeK5
 KWxg==
X-Gm-Message-State: AOAM531ZkJjqd5Si5JD57vX6Pqmar0F1Y9f9l02ZPXSxmRCjjUR3O/5x
 adAAEUIiWR9Pk9xqc1Zs4Qjn8EfN+vdUbg==
X-Google-Smtp-Source: ABdhPJyFh5rG5hV3w//TGlgSB3M+6mNeUNRrgr7smtpK8Zh79KTUH/UkK5cuAO5kuC5c8ARgtR+raQ==
X-Received: by 2002:aa7:8e85:: with SMTP id a5mr1178486pfr.96.1599610639552;
 Tue, 08 Sep 2020 17:17:19 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/43] tcg: Use tcg_constant_{i32,i64} with tcg int expanders
Date: Tue,  8 Sep 2020 17:16:28 -0700
Message-Id: <20200909001647.532249-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 include/tcg/tcg-op.h |  13 +--
 tcg/tcg-op.c         | 227 ++++++++++++++++++++-----------------------
 2 files changed, 109 insertions(+), 131 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 5abf17fecc..b4fba35e87 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -271,6 +271,7 @@ void tcg_gen_mb(TCGBar);
 
 /* 32 bit ops */
 
+void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -349,11 +350,6 @@ static inline void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-static inline void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-{
-    tcg_gen_op2i_i32(INDEX_op_movi_i32, ret, arg);
-}
-
 static inline void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2,
                                     tcg_target_long offset)
 {
@@ -467,6 +463,7 @@ static inline void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
 
 /* 64 bit ops */
 
+void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
@@ -550,11 +547,6 @@ static inline void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-static inline void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_op2i_i64(INDEX_op_movi_i64, ret, arg);
-}
-
 static inline void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2,
                                     tcg_target_long offset)
 {
@@ -698,7 +690,6 @@ static inline void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_discard_i64(TCGv_i64 arg);
 void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4b8a473fad..e2d8ae3234 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -104,15 +104,18 @@ void tcg_gen_mb(TCGBar mb_type)
 
 /* 32 bit ops */
 
+void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
+{
+    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
+}
+
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_add_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -122,9 +125,7 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
         /* Don't recurse with tcg_gen_neg_i32.  */
         tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg2);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg1);
-        tcg_gen_sub_i32(ret, t0, arg2);
-        tcg_temp_free_i32(t0);
+        tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
     }
 }
 
@@ -134,15 +135,12 @@ void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_sub_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
-    TCGv_i32 t0;
     /* Some cases can be optimized here.  */
     switch (arg2) {
     case 0:
@@ -165,9 +163,8 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
         }
         break;
     }
-    t0 = tcg_const_i32(arg2);
-    tcg_gen_and_i32(ret, arg1, t0);
-    tcg_temp_free_i32(t0);
+
+    tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -178,9 +175,7 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -193,9 +188,7 @@ void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
         /* Don't recurse with tcg_gen_not_i32.  */
         tcg_gen_op2_i32(INDEX_op_not_i32, ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_xor_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_xor_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -205,9 +198,7 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_shl_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -217,9 +208,7 @@ void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_shr_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -229,9 +218,7 @@ void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_sar_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -250,9 +237,7 @@ void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_brcond_i32(cond, arg1, t0, l);
-        tcg_temp_free_i32(t0);
+        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
     }
 }
 
@@ -271,9 +256,7 @@ void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
-    TCGv_i32 t0 = tcg_const_i32(arg2);
-    tcg_gen_setcond_i32(cond, ret, arg1, t0);
-    tcg_temp_free_i32(t0);
+    tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -283,9 +266,7 @@ void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     } else if (is_power_of_2(arg2)) {
         tcg_gen_shli_i32(ret, arg1, ctz32(arg2));
     } else {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_mul_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_mul_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -433,9 +414,7 @@ void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
-    TCGv_i32 t = tcg_const_i32(arg2);
-    tcg_gen_clz_i32(ret, arg1, t);
-    tcg_temp_free_i32(t);
+    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
@@ -468,10 +447,9 @@ void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
             tcg_gen_clzi_i32(t, t, 32);
             tcg_gen_xori_i32(t, t, 31);
         }
-        z = tcg_const_i32(0);
+        z = tcg_constant_i32(0);
         tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
         tcg_temp_free_i32(t);
-        tcg_temp_free_i32(z);
     } else {
         gen_helper_ctz_i32(ret, arg1, arg2);
     }
@@ -487,9 +465,7 @@ void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
         tcg_gen_ctpop_i32(ret, t);
         tcg_temp_free_i32(t);
     } else {
-        TCGv_i32 t = tcg_const_i32(arg2);
-        tcg_gen_ctz_i32(ret, arg1, t);
-        tcg_temp_free_i32(t);
+        tcg_gen_ctz_i32(ret, arg1, tcg_constant_i32(arg2));
     }
 }
 
@@ -547,9 +523,7 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
     } else if (TCG_TARGET_HAS_rot_i32) {
-        TCGv_i32 t0 = tcg_const_i32(arg2);
-        tcg_gen_rotl_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
+        tcg_gen_rotl_i32(ret, arg1, tcg_constant_i32(arg2));
     } else {
         TCGv_i32 t0, t1;
         t0 = tcg_temp_new_i32();
@@ -653,9 +627,8 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
     } else if (TCG_TARGET_HAS_deposit_i32
                && TCG_TARGET_deposit_i32_valid(ofs, len)) {
-        TCGv_i32 zero = tcg_const_i32(0);
+        TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
-        tcg_temp_free_i32(zero);
     } else {
         /* To help two-operand hosts we prefer to zero-extend first,
            which allows ARG to stay live.  */
@@ -1052,7 +1025,7 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
     } else {
         TCGv_i32 t0 = tcg_temp_new_i32();
         TCGv_i32 t1 = tcg_temp_new_i32();
-        TCGv_i32 t2 = tcg_const_i32(0x00ff00ff);
+        TCGv_i32 t2 = tcg_constant_i32(0x00ff00ff);
 
                                         /* arg = abcd */
         tcg_gen_shri_i32(t0, arg, 8);   /*  t0 = .abc */
@@ -1067,7 +1040,6 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
-        tcg_temp_free_i32(t2);
     }
 }
 
@@ -1114,8 +1086,15 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
 
 void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
-    tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
+    TCGTemp *ts = tcgv_i64_temp(arg);
+
+    /* Canonicalize TCGv_i64 TEMP_CONST into TCGv_i32 TEMP_CONST. */
+    if (ts->kind == TEMP_CONST) {
+        tcg_gen_movi_i64(ret, ts->val);
+    } else {
+        tcg_gen_mov_i32(TCGV_LOW(ret), TCGV_LOW(arg));
+        tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_HIGH(arg));
+    }
 }
 
 void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
@@ -1237,6 +1216,14 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t0);
     tcg_temp_free_i32(t1);
 }
+
+#else
+
+void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
+{
+    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
+}
+
 #endif /* TCG_TARGET_REG_SIZE == 32 */
 
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
@@ -1244,10 +1231,12 @@ void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_add_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_add2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >> 32));
     }
 }
 
@@ -1256,10 +1245,12 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     if (arg1 == 0 && TCG_TARGET_HAS_neg_i64) {
         /* Don't recurse with tcg_gen_neg_i64.  */
         tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg2);
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg1);
-        tcg_gen_sub_i64(ret, t0, arg2);
-        tcg_temp_free_i64(t0);
+        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                         tcg_constant_i32(arg1), tcg_constant_i32(arg1 >> 32),
+                         TCGV_LOW(arg2), TCGV_HIGH(arg2));
     }
 }
 
@@ -1268,17 +1259,17 @@ void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
+    } else if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_sub_i64(ret, arg1, tcg_constant_i64(arg2));
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret),
+                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                         tcg_constant_i32(arg2), tcg_constant_i32(arg2 >> 32));
     }
 }
 
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
-    TCGv_i64 t0;
-
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_gen_andi_i32(TCGV_LOW(ret), TCGV_LOW(arg1), arg2);
         tcg_gen_andi_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), arg2 >> 32);
@@ -1313,9 +1304,8 @@ void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
         }
         break;
     }
-    t0 = tcg_const_i64(arg2);
-    tcg_gen_and_i64(ret, arg1, t0);
-    tcg_temp_free_i64(t0);
+
+    tcg_gen_and_i64(ret, arg1, tcg_constant_i64(arg2));
 }
 
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
@@ -1331,9 +1321,7 @@ void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1351,9 +1339,7 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
         /* Don't recurse with tcg_gen_not_i64.  */
         tcg_gen_op2_i64(INDEX_op_not_i64, ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_xor_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_xor_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1415,9 +1401,7 @@ void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_shl_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1429,9 +1413,7 @@ void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_shr_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1443,9 +1425,7 @@ void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     } else if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_sar_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
     }
 }
 
@@ -1468,12 +1448,17 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
 {
-    if (cond == TCG_COND_ALWAYS) {
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
+    } else if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_brcond_i64(cond, arg1, t0, l);
-        tcg_temp_free_i64(t0);
+        l->refs++;
+        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
+                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                          tcg_constant_i32(arg2),
+                          tcg_constant_i32(arg2 >> 32),
+                          cond, label_arg(l));
     }
 }
 
@@ -1499,9 +1484,19 @@ void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-    TCGv_i64 t0 = tcg_const_i64(arg2);
-    tcg_gen_setcond_i64(cond, ret, arg1, t0);
-    tcg_temp_free_i64(t0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
+    } else if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi_i64(ret, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi_i64(ret, 0);
+    } else {
+        tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
+                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                         tcg_constant_i32(arg2),
+                         tcg_constant_i32(arg2 >> 32), cond);
+        tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
+    }
 }
 
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
@@ -1690,7 +1685,7 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg)
     } else {
         TCGv_i64 t0 = tcg_temp_new_i64();
         TCGv_i64 t1 = tcg_temp_new_i64();
-        TCGv_i64 t2 = tcg_const_i64(0x00ff00ff);
+        TCGv_i64 t2 = tcg_constant_i64(0x00ff00ff);
 
                                         /* arg = ....abcd */
         tcg_gen_shri_i64(t0, arg, 8);   /*  t0 = .....abc */
@@ -1706,7 +1701,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg)
 
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
     }
 }
 
@@ -1850,16 +1844,16 @@ void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
     if (TCG_TARGET_REG_BITS == 32
         && TCG_TARGET_HAS_clz_i32
         && arg2 <= 0xffffffffu) {
-        TCGv_i32 t = tcg_const_i32((uint32_t)arg2 - 32);
-        tcg_gen_clz_i32(t, TCGV_LOW(arg1), t);
+        TCGv_i32 t = tcg_temp_new_i32();
+        tcg_gen_clzi_i32(t, TCGV_LOW(arg1), arg2 - 32);
         tcg_gen_addi_i32(t, t, 32);
         tcg_gen_clz_i32(TCGV_LOW(ret), TCGV_HIGH(arg1), t);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
         tcg_temp_free_i32(t);
     } else {
-        TCGv_i64 t = tcg_const_i64(arg2);
-        tcg_gen_clz_i64(ret, arg1, t);
-        tcg_temp_free_i64(t);
+        TCGv_i64 t0 = tcg_const_i64(arg2);
+        tcg_gen_clz_i64(ret, arg1, t0);
+        tcg_temp_free_i64(t0);
     }
 }
 
@@ -1881,7 +1875,7 @@ void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
             tcg_gen_clzi_i64(t, t, 64);
             tcg_gen_xori_i64(t, t, 63);
         }
-        z = tcg_const_i64(0);
+        z = tcg_constant_i64(0);
         tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
         tcg_temp_free_i64(t);
         tcg_temp_free_i64(z);
@@ -1895,8 +1889,8 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
     if (TCG_TARGET_REG_BITS == 32
         && TCG_TARGET_HAS_ctz_i32
         && arg2 <= 0xffffffffu) {
-        TCGv_i32 t32 = tcg_const_i32((uint32_t)arg2 - 32);
-        tcg_gen_ctz_i32(t32, TCGV_HIGH(arg1), t32);
+        TCGv_i32 t32 = tcg_temp_new_i32();
+        tcg_gen_ctzi_i32(t32, TCGV_HIGH(arg1), arg2 - 32);
         tcg_gen_addi_i32(t32, t32, 32);
         tcg_gen_ctz_i32(TCGV_LOW(ret), TCGV_LOW(arg1), t32);
         tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
@@ -1911,9 +1905,9 @@ void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
         tcg_gen_ctpop_i64(ret, t);
         tcg_temp_free_i64(t);
     } else {
-        TCGv_i64 t64 = tcg_const_i64(arg2);
-        tcg_gen_ctz_i64(ret, arg1, t64);
-        tcg_temp_free_i64(t64);
+        TCGv_i64 t0 = tcg_const_i64(arg2);
+        tcg_gen_ctz_i64(ret, arg1, t0);
+        tcg_temp_free_i64(t0);
     }
 }
 
@@ -1969,9 +1963,7 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
     } else if (TCG_TARGET_HAS_rot_i64) {
-        TCGv_i64 t0 = tcg_const_i64(arg2);
-        tcg_gen_rotl_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
+        tcg_gen_rotl_i64(ret, arg1, tcg_constant_i64(arg2));
     } else {
         TCGv_i64 t0, t1;
         t0 = tcg_temp_new_i64();
@@ -2089,9 +2081,8 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
     } else if (TCG_TARGET_HAS_deposit_i64
                && TCG_TARGET_deposit_i64_valid(ofs, len)) {
-        TCGv_i64 zero = tcg_const_i64(0);
+        TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
-        tcg_temp_free_i64(zero);
     } else {
         if (TCG_TARGET_REG_BITS == 32) {
             if (ofs >= 32) {
@@ -3102,9 +3093,8 @@ void tcg_gen_atomic_cmpxchg_i32(TCGv_i32 retv, TCGv addr, TCGv_i32 cmpv,
 
 #ifdef CONFIG_SOFTMMU
         {
-            TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-            gen(retv, cpu_env, addr, cmpv, newv, oi);
-            tcg_temp_free_i32(oi);
+            TCGMemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
+            gen(retv, cpu_env, addr, cmpv, newv, tcg_constant_i32(oi));
         }
 #else
         gen(retv, cpu_env, addr, cmpv, newv);
@@ -3147,9 +3137,8 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 
 #ifdef CONFIG_SOFTMMU
         {
-            TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop, idx));
-            gen(retv, cpu_env, addr, cmpv, newv, oi);
-            tcg_temp_free_i32(oi);
+            TCGMemOpIdx oi = make_memop_idx(memop, idx);
+            gen(retv, cpu_env, addr, cmpv, newv, tcg_constant_i32(oi));
         }
 #else
         gen(retv, cpu_env, addr, cmpv, newv);
@@ -3211,9 +3200,8 @@ static void do_atomic_op_i32(TCGv_i32 ret, TCGv addr, TCGv_i32 val,
 
 #ifdef CONFIG_SOFTMMU
     {
-        TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-        gen(ret, cpu_env, addr, val, oi);
-        tcg_temp_free_i32(oi);
+        TCGMemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
+        gen(ret, cpu_env, addr, val, tcg_constant_i32(oi));
     }
 #else
     gen(ret, cpu_env, addr, val);
@@ -3257,9 +3245,8 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
 
 #ifdef CONFIG_SOFTMMU
         {
-            TCGv_i32 oi = tcg_const_i32(make_memop_idx(memop & ~MO_SIGN, idx));
-            gen(ret, cpu_env, addr, val, oi);
-            tcg_temp_free_i32(oi);
+            TCGMemOpIdx oi = make_memop_idx(memop & ~MO_SIGN, idx);
+            gen(ret, cpu_env, addr, val, tcg_constant_i32(oi));
         }
 #else
         gen(ret, cpu_env, addr, val);
-- 
2.25.1


