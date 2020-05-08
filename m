Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C446C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB9C12192A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+Bj7CVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB9C12192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7mj-0007Nj-QV
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hd-0006kP-3A
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:29 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38460)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hc-00066D-4Q
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:28 -0400
Received: by mail-pj1-x1041.google.com with SMTP id t40so4650312pjb.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2L8f73fT7ql1FhEo7kgEnU/dvTfN8ScU6VGJ8RkN9ho=;
 b=V+Bj7CVosq2eG4zS6Hqyf0AUi7ZUopilqVX+4udg0NrjcaDCVK1d3g3QMdNrzxeJr+
 ensLSvxqLfoUMIKRXbVddQ8YpznWnpIX+qbFHUny/xC9qqpSKNNM37HfJzk6VS7IthX6
 Uc/2Au38UKjfMqOOLmmtCjTYdfGgwslO6EMeIq5Y5w3qwmVxsKtERyubqxfNHiKTHcbX
 AT5vOwU/RkCg4rranM6KRP2ISqTxFswsnbzhEfgBbbcqSLjLDYRWTRns7X2Ldq25zYq+
 ptfj9Sea1ALOrBnS1yLqyWJ8BX3F01G3G9y2jsVjUzpjXA5/NaunESpBtf/7wg0v8CQx
 L6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2L8f73fT7ql1FhEo7kgEnU/dvTfN8ScU6VGJ8RkN9ho=;
 b=Bh/N4z4scPVSFc4wkpGoTUDzr/drwKIAF5bkpDQDmaUulAiTCCozIQtKG8sdqTTccL
 d/qRH4KPJw9Z/Zu/GU4jzknMGFJpmRJa6QT978lQ7m67GEWZZpqsaQUNQOUsSXJDjN9Y
 WI4Ds/deiUQE3iU0V6xw5O23ljjXHGFMVNOuR/X9UPSaqLZugYjrpMVnjmZ4e9axSbhc
 sqiV29Mwl3uKoPeENN6GdsyJ3VUlpP5u6HxkQCR7kY5G9po782Qn6EMgcxtJE79hDNQs
 8VHrDkeqBQUkQ5oQSJ5rvf4mdD5nszgXFED56g2ivQXmlbq+Lo2NzFyGgCrOuYaBwnAl
 imsQ==
X-Gm-Message-State: AGi0PuZxAsaeoT1mCqpD2kyvAYc+tAmJ08sQAYKH1FYMED9T5ID4AGep
 iAKo/PS5UgHGEOvbndKhjMxvrbUibbI=
X-Google-Smtp-Source: APiQypIIVO1C23ZbC8FlufRk+qVr577bsj8PgXq1Mu8+pq31iXXWuqiuDmWKNyfa5bvEwc1BobOLiw==
X-Received: by 2002:a17:90a:362f:: with SMTP id
 s44mr8069851pjb.156.1588962386416; 
 Fri, 08 May 2020 11:26:26 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/19] tcg: Use tcg_constant_{i32,
 vec} with tcg vec expanders
Date: Fri,  8 May 2020 11:26:03 -0700
Message-Id: <20200508182616.18318-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 63 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 43101defe4..0e3e80a612 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -233,25 +233,17 @@ void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
     }
 }
 
-#define MO_REG  (TCG_TARGET_REG_BITS == 64 ? MO_64 : MO_32)
-
-static void do_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
-{
-    TCGTemp *rt = tcgv_vec_temp(r);
-    vec_gen_2(INDEX_op_dupi_vec, rt->base_type, vece, temp_arg(rt), a);
-}
-
 TCGv_vec tcg_const_zeros_vec(TCGType type)
 {
     TCGv_vec ret = tcg_temp_new_vec(type);
-    do_dupi_vec(ret, MO_REG, 0);
+    tcg_gen_mov_vec(ret, tcg_constant_vec(type, MO_8, 0));
     return ret;
 }
 
 TCGv_vec tcg_const_ones_vec(TCGType type)
 {
     TCGv_vec ret = tcg_temp_new_vec(type);
-    do_dupi_vec(ret, MO_REG, -1);
+    tcg_gen_mov_vec(ret, tcg_constant_vec(type, MO_8, -1));
     return ret;
 }
 
@@ -267,37 +259,50 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
     return tcg_const_ones_vec(t->base_type);
 }
 
-void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
+void tcg_gen_dupi_vec(unsigned vece, TCGv_vec dest, uint64_t val)
 {
-    if (TCG_TARGET_REG_BITS == 32 && a == deposit64(a, 32, 32, a)) {
-        do_dupi_vec(r, MO_32, a);
-    } else if (TCG_TARGET_REG_BITS == 64 || a == (uint64_t)(int32_t)a) {
-        do_dupi_vec(r, MO_64, a);
-    } else {
-        TCGv_i64 c = tcg_const_i64(a);
-        tcg_gen_dup_i64_vec(MO_64, r, c);
-        tcg_temp_free_i64(c);
+    TCGType type = tcgv_vec_temp(dest)->base_type;
+
+    /*
+     * For MO_64 constants that can't be represented in tcg_target_long,
+     * we must use INDEX_op_dup2_vec.
+     */
+    if (TCG_TARGET_REG_BITS == 32) {
+        val = dup_const(vece, val);
+        if (val != deposit64(val, 32, 32, val) &&
+            val != (uint64_t)(int32_t)val) {
+            uint32_t vl = extract64(val, 0, 32);
+            uint32_t vh = extract64(val, 32, 32);
+            TCGArg al = tcgv_i32_arg(tcg_constant_i32(vl));
+            TCGArg ah = tcgv_i32_arg(tcg_constant_i32(vh));
+            TCGArg di = tcgv_vec_arg(dest);
+
+            vec_gen_3(INDEX_op_dup2_vec, type, MO_64, di, al, ah);
+            return;
+        }
     }
+
+    tcg_gen_mov_vec(dest, tcg_constant_vec(type, vece, val));
 }
 
-void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup64i_vec(TCGv_vec dest, uint64_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_32, a));
+    tcg_gen_dupi_vec(MO_64, dest, val);
 }
 
-void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup32i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_16, a));
+    tcg_gen_dupi_vec(MO_32, dest, val);
 }
 
-void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup16i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_8, a));
+    tcg_gen_dupi_vec(MO_16, dest, val);
 }
 
-void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
+void tcg_gen_dup8i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(vece, a));
+    tcg_gen_dupi_vec(MO_8, dest, val);
 }
 
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
@@ -502,8 +507,8 @@ void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
             if (tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0) {
                 tcg_gen_sari_vec(vece, t, a, (8 << vece) - 1);
             } else {
-                do_dupi_vec(t, MO_REG, 0);
-                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a, t);
+                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a,
+                                tcg_constant_vec(type, vece, 0));
             }
             tcg_gen_xor_vec(vece, r, a, t);
             tcg_gen_sub_vec(vece, r, r, t);
-- 
2.20.1


