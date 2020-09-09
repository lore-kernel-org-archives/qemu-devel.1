Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C769C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0F12145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoKMSKGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0F12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnux-0000IP-Pk
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnh-0000Bg-GV
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:25 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:36389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnne-0002H5-Ed
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:25 -0400
Received: by mail-pg1-x544.google.com with SMTP id m8so742300pgi.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HakP3QzMMgoP+5PWHWKQnZl86G7xrmBYKlGdyeWSyq0=;
 b=xoKMSKGBBrzkocv2yaAhmwCE0q6iGgV8X8NY+ks19Y4gWDeLEgo+uZa6Hh7UPuU56x
 0xdxFFgvlR/vgAe6FRijyA/EmqCmy0VfZ3N937GlSjzsk1FvGK3ZCQFae6bUoqdWWpYM
 DeDH/OIJ7JCGUARvE9KP9mWADfCwtb+ugNyq5RyE83dwcnhp1R2naNOn3OD8pThk0CXq
 zD0u1RHqvawY50fVKEGam6o6pDd3la5uj8fUgAz8XxJokdOVQr0N1umBGvqP9xRx+xmO
 NQSpWyz+0+4IMPmcLIfw9iqjhsgCmDscXZI2x/pn36DWcgj5nICQ8V7mk/eY3Mj8vINA
 w4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HakP3QzMMgoP+5PWHWKQnZl86G7xrmBYKlGdyeWSyq0=;
 b=oblKJoE/efxoUIM2hpRHJaksffXRB0Zo+Ki2cu9z6iMDrKe6nC2e4TMvK7T2lo7XRX
 +uCBRNZCAvoKvrwO89LQYmagjGdsn+aPzBuFZef/lDCnA0r1OW5DtXVcCd+jvNmBNyQf
 cEvRzCvHw0LJPztxf5tOwO1RSDD1OIreGLtp/dbmeAnblBF+V18lBX75H6F/8aGfv9bs
 xs61NGfUC+qxfzjtJ+iJXJwb5uKqGuUoP9H/VRR49L3CZ5ITMnLbw7fcsByLuJTtmpQj
 NYk2r5hHDo5sEYqmEbtEsBSnaye7FKQOEwlGo0AXRJ0WbPn1Lxncydt+I/TVUI5NECwP
 Mc8g==
X-Gm-Message-State: AOAM531D0khTq6TVOWWc6n1Kp2xhE3pNSoc/BUYoUrrqA3V9D6OtYMdi
 P6NbBvoiFYoasvO78ezVHuhruDyKV9W0tQ==
X-Google-Smtp-Source: ABdhPJykYQNFJB7d5YNaDf608r1SUT5Ph0y5UYW81xfdYC0krPi3UAC52+0mk644Qf9yIc+8IH2wXg==
X-Received: by 2002:a63:413:: with SMTP id 19mr983735pge.310.1599610640740;
 Tue, 08 Sep 2020 17:17:20 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/43] tcg: Use tcg_constant_{i32,i64} with tcg plugins
Date: Tue,  8 Sep 2020 17:16:29 -0700
Message-Id: <20200909001647.532249-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 49 +++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 51580d51a0..e5dc9d0ca9 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -284,8 +284,8 @@ static TCGOp *copy_extu_i32_i64(TCGOp **begin_op, TCGOp *op)
     if (TCG_TARGET_REG_BITS == 32) {
         /* mov_i32 */
         op = copy_op(begin_op, op, INDEX_op_mov_i32);
-        /* movi_i32 */
-        op = copy_op(begin_op, op, INDEX_op_movi_i32);
+        /* mov_i32 w/ $0 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
     } else {
         /* extu_i32_i64 */
         op = copy_op(begin_op, op, INDEX_op_extu_i32_i64);
@@ -306,39 +306,34 @@ static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op)
     return op;
 }
 
-static TCGOp *copy_movi_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* 2x movi_i32 */
-        op = copy_op(begin_op, op, INDEX_op_movi_i32);
-        op->args[1] = v;
-
-        op = copy_op(begin_op, op, INDEX_op_movi_i32);
-        op->args[1] = v >> 32;
-    } else {
-        /* movi_i64 */
-        op = copy_op(begin_op, op, INDEX_op_movi_i64);
-        op->args[1] = v;
-    }
-    return op;
-}
-
 static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
 {
     if (UINTPTR_MAX == UINT32_MAX) {
-        /* movi_i32 */
-        op = copy_op(begin_op, op, INDEX_op_movi_i32);
-        op->args[1] = (uintptr_t)ptr;
+        /* mov_i32 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(tcg_constant_i32((uintptr_t)ptr));
     } else {
-        /* movi_i64 */
-        op = copy_movi_i64(begin_op, op, (uint64_t)(uintptr_t)ptr);
+        /* mov_i64 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i64);
+        op->args[1] = tcgv_i64_arg(tcg_constant_i64((uintptr_t)ptr));
     }
     return op;
 }
 
 static TCGOp *copy_const_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
 {
-    return copy_movi_i64(begin_op, op, v);
+    if (TCG_TARGET_REG_BITS == 32) {
+        /* 2x mov_i32 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(tcg_constant_i32(v));
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+        op->args[1] = tcgv_i32_arg(tcg_constant_i32(v >> 32));
+    } else {
+        /* mov_i64 */
+        op = copy_op(begin_op, op, INDEX_op_mov_i64);
+        op->args[1] = tcgv_i64_arg(tcg_constant_i64(v));
+    }
+    return op;
 }
 
 static TCGOp *copy_extu_tl_i64(TCGOp **begin_op, TCGOp *op)
@@ -486,8 +481,8 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
 
     tcg_debug_assert(type == PLUGIN_GEN_CB_MEM);
 
-    /* const_i32 == movi_i32 ("info", so it remains as is) */
-    op = copy_op(&begin_op, op, INDEX_op_movi_i32);
+    /* const_i32 == mov_i32 ("info", so it remains as is) */
+    op = copy_op(&begin_op, op, INDEX_op_mov_i32);
 
     /* const_ptr */
     op = copy_const_ptr(&begin_op, op, cb->userp);
-- 
2.25.1


