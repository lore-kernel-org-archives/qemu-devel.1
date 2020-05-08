Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86580C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520B121582
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TnCj1xMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520B121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4s7-0000r2-Dp
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lG-0005x5-Hr
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:02 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lE-0002yL-9X
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:02 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a5so4398688pjh.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UBTvpXnQhX/NB3BncFrtFDo86VAuYzf/XHrJqnCZIJI=;
 b=TnCj1xMJY4IE2Ybc4amV58DvRB4eizBZO6b2h7x++IVoMj4Y9hIEQWhJFXYDrBrBZE
 p4wOc5+N0tiV+MJxEEPp1BO87fQqDtNdGIRgCKyI/8Y5zHnDxYpVaoMyCONp0x2gUmm0
 U0wMxZnSZzRyuVJ9VbV//3xkBb08Vd1KrGOBCmdDk5Swb8wJduWj5X2bz+4mIfHyR3Rs
 vGvN51Xz1nMt6omnXm3BOaD+yPIKX9X1tLZF31XOPt6RYHwHmv/hW+t1y39AsnIkADLd
 JhmMkQXj4LC+mZ1k39DUFtAzE7/tAloOlt0BzI10LtyEbDtJu+B15pZk4wrrdUpnEyJ+
 6Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UBTvpXnQhX/NB3BncFrtFDo86VAuYzf/XHrJqnCZIJI=;
 b=Dqho/z98CH6xfcEC1Wspv9SpOojM0dQFNlSa4baONUdJePvFS1sdsigTj85Xaz199Y
 UFNtgDq9TumRpRC7Q/etiWnrLYbeNUJmxG1NjxzmoB6wzXSG6Ri4QG2kg3x8h/zoNDoh
 eYO0KtTJ3JvcI96PIRpgGCMZBOXAUNE1gyLw2ARCa5KmmoiRNK4KNNupyhPchnjQf1et
 9rJNayNqeYlAf2FFnr/erxBD77QOjNCNdpdM+xQ0CVRd5slJ6/3mvv5cThVhx4Q6N94h
 Xsn5lGjChyGlXK8w2bGF5ExIfGJUGmfLgsJubAZ4edabZ4pQjAIqC04WZGaT/azOT+GC
 FQSw==
X-Gm-Message-State: AGi0Pub6XGFA5pKM9BLjweEXgGO2jRucZIDoXqXVCj1dX0snLXnfC3JW
 igjJs81hqp963WYYBCvHMJZ7nBgVjto=
X-Google-Smtp-Source: APiQypLM+qPjyGq3+0x+QjP1ZPxZgoTBJBBQm1X60QjHByiwE0TGh2m54v64KXkoJiNwjy40J4+t7g==
X-Received: by 2002:a17:902:bd87:: with SMTP id
 q7mr2944156pls.92.1588951078580; 
 Fri, 08 May 2020 08:17:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:17:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/19] tcg: Use tcg_constant_{i32,i64} with tcg plugins
Date: Fri,  8 May 2020 08:17:36 -0700
Message-Id: <20200508151747.6166-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
2.20.1


