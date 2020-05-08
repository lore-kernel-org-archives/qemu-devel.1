Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6842DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:27:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E6C2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMH6bPWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7io-0008GN-Ag
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hY-0006co-Ec
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:24 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hW-0005GD-Pj
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:24 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a7so4658725pju.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lWkulx8CoF0cSLWK7D7tlMYLSyKx6Hnk2sQWr9PjIsk=;
 b=gMH6bPWcNjNkkIuild7UgMkMf1MBex+9M9HzjZAFCHrWL2r4gQqTqWfEVHLhJ61Xvz
 +Oj6ZQxxFby/njrxGlv5/4YcJY/SVBF/fQzTm/sXEFKfmkc8p29eFZ/ILuPZivvbhoe8
 aNdx5uuSs6rBSETb3oAraMueCyZRKtx2+mzsuj2NBYCaUs9xaYYEgeMLoBLG8ncHS4c2
 sFIRrVlfnYPHIG+w5QNA9jl81IUJPHmgPO3GYEsrqB9+WJS0POfbV8SlpM92YUUzfAnC
 T/Yi1V7nIuBSvuE+rtGemERpGe0ZwXakbAo0thAZmKDx2OfFagmXq8HCbIusw0qxU56g
 drkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lWkulx8CoF0cSLWK7D7tlMYLSyKx6Hnk2sQWr9PjIsk=;
 b=izrb8EhaRdd2HN0RsztF1juhDhs2rWu+/kGurNQ1FfHkLwJMtQ4PwMeFH6VYi3j56B
 l3TOqKtZIAYsFAMbqOeVmHd2YG9UqdsQKgJkXNIwmtgCFzSSbyixyGwltfLaFNm6xvEI
 q+kFh+5E1OZlXUFlH8yhjh4qzJcnQQTaZ9f9a+kK4tzoCcpxunH9qy30in8hooax6Zrc
 ItHDPEG6gzWdvSiZxtsLPuXvPHXgz5wV+SqiDcFb6opV/oQwiJQNBYRt0uquaOm3QA0N
 qHqiwH3XFaexdhs2RWIU77ibchPKvZHb6l3ItEksx3d8Lciv4C/GCvtwv+hY8HrfvgcI
 4Y7g==
X-Gm-Message-State: AGi0PubjUeZWP0eNgAIauNen7syDQI/Qctu8LZ4IIWzh+vLMPPBUNLE7
 3BFW9+eZrDGhGTchiVp6kaOynpVB48o=
X-Google-Smtp-Source: APiQypJEHRjZboI2kV0bBNzZVwNvTLMUBWa6FSbtxeJXNHb/2gkoWh5WTkj1fvl069v7Zwk7ngcBDg==
X-Received: by 2002:a17:902:b417:: with SMTP id
 x23mr3462293plr.51.1588962380810; 
 Fri, 08 May 2020 11:26:20 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/19] tcg: Add temp_readonly
Date: Fri,  8 May 2020 11:25:59 -0700
Message-Id: <20200508182616.18318-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In most, but not all, places that we check for TEMP_FIXED,
we are really testing that we do not modify the temporary.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  5 +++++
 tcg/tcg.c         | 21 ++++++++++-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 06486635e6..0d09ea7822 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -681,6 +681,11 @@ struct TCGContext {
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
 };
 
+static inline bool temp_readonly(TCGTemp *ts)
+{
+    return ts->kind == TEMP_FIXED;
+}
+
 extern TCGContext tcg_init_ctx;
 extern __thread TCGContext *tcg_ctx;
 extern TCGv_env cpu_env;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2c022c9621..a529166026 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3173,7 +3173,7 @@ static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet, TCGRegSet);
    mark it free; otherwise mark it dead.  */
 static void temp_free_or_dead(TCGContext *s, TCGTemp *ts, int free_or_dead)
 {
-    if (ts->kind == TEMP_FIXED) {
+    if (temp_readonly(ts)) {
         return;
     }
     if (ts->val_type == TEMP_VAL_REG) {
@@ -3197,7 +3197,7 @@ static inline void temp_dead(TCGContext *s, TCGTemp *ts)
 static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
                       TCGRegSet preferred_regs, int free_or_dead)
 {
-    if (ts->kind == TEMP_FIXED) {
+    if (temp_readonly(ts)) {
         return;
     }
     if (!ts->mem_coherent) {
@@ -3355,8 +3355,7 @@ static void temp_save(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs)
 {
     /* The liveness analysis already ensures that globals are back
        in memory. Keep an tcg_debug_assert for safety. */
-    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM
-                     || ts->kind == TEMP_FIXED);
+    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM || temp_readonly(ts));
 }
 
 /* save globals to their canonical location and assume they can be
@@ -3414,7 +3413,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
                                   TCGRegSet preferred_regs)
 {
     /* ENV should not be modified.  */
-    tcg_debug_assert(ots->kind != TEMP_FIXED);
+    tcg_debug_assert(!temp_readonly(ots));
 
     /* The movi is not explicitly generated here.  */
     if (ots->val_type == TEMP_VAL_REG) {
@@ -3454,7 +3453,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     ts = arg_temp(op->args[1]);
 
     /* ENV should not be modified.  */
-    tcg_debug_assert(ots->kind != TEMP_FIXED);
+    tcg_debug_assert(!temp_readonly(ots));
 
     /* Note that otype != itype for no-op truncation.  */
     otype = ots->type;
@@ -3515,7 +3514,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                  * Store the source register into the destination slot
                  * and leave the destination temp as TEMP_VAL_MEM.
                  */
-                assert(ots->kind != TEMP_FIXED);
+                assert(!temp_readonly(ots));
                 if (!ts->mem_allocated) {
                     temp_allocate_frame(s, ots);
                 }
@@ -3552,7 +3551,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
     its = arg_temp(op->args[1]);
 
     /* ENV should not be modified.  */
-    tcg_debug_assert(ots->kind != TEMP_FIXED);
+    tcg_debug_assert(!temp_readonly(ots));
 
     itype = its->type;
     vece = TCGOP_VECE(op);
@@ -3783,7 +3782,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             ts = arg_temp(arg);
 
             /* ENV should not be modified.  */
-            tcg_debug_assert(ts->kind != TEMP_FIXED);
+            tcg_debug_assert(!temp_readonly(ts));
 
             if ((arg_ct->ct & TCG_CT_ALIAS)
                 && !const_args[arg_ct->alias_index]) {
@@ -3825,7 +3824,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         ts = arg_temp(op->args[i]);
 
         /* ENV should not be modified.  */
-        tcg_debug_assert(ts->kind != TEMP_FIXED);
+        tcg_debug_assert(!temp_readonly(ts));
 
         if (NEED_SYNC_ARG(i)) {
             temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
@@ -3957,7 +3956,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
         ts = arg_temp(arg);
 
         /* ENV should not be modified.  */
-        tcg_debug_assert(ts->kind != TEMP_FIXED);
+        tcg_debug_assert(!temp_readonly(ts));
 
         reg = tcg_target_call_oarg_regs[i];
         tcg_debug_assert(s->reg_to_temp[reg] == NULL);
-- 
2.20.1


