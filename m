Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C67C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A012083B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 12:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MjIw66q+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A012083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQVVs-0005Lz-1w
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 08:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTs-0003Yw-Nc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:12 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:34387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kQVTq-0001x6-P2
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 08:57:12 -0400
Received: by mail-oo1-xc43.google.com with SMTP id o20so1442405ook.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 05:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DB9tU6r0brwFG1qFXqPktiK9xDRAnPwJJP/MTNU/UOw=;
 b=MjIw66q+tEL4/MV1cl8hDibP4DW9NmPc9X0glZfJATg+ItiCB7bXeMEFH2Au7P9nuS
 Bfwr70g6yQwKatURQTWoM0rQucMYbWTVGDCkGTpaGSvfWEHUBUREMB8uVU7Py0CL/yMO
 yQMyojQbXHdhjI3oYzNDfKwuoUMw1aJYDSYzeq6CmUTCmqy7U3e9WOtCpLKFL8AOVrYO
 wzDeBFZ+8woZiq1EFYNk2BOR+87A0IHSr0PtVGFd8M2rxgI/AIvqyBGiKo6yRDjrDvPC
 +8iG+wPDqcYg/9RtxG2kX3zIRIgicSWknfTfeZuTn20bX5O2zrWA5wRWX1HvCjLYa+cR
 js5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DB9tU6r0brwFG1qFXqPktiK9xDRAnPwJJP/MTNU/UOw=;
 b=XKFlbFGiZKzvhwAPTyYQImFn4ntTxY1zieRLIhq2bIBZTKK0RLYi97M7/ep3V4CGI0
 +bcOK12j9ngCowDsOqo9rhyNOFvjoi6A6r0Txskfc4rb3IpQ03FIJ0GPQ2cnPvWoTl0N
 xY0SHVkEOTVADMNsz85k2rr5KmVnQFIihfJCMO9l9/EsNs3S5G4fKwmBuGsd5o0YELA7
 ym0Q62D5V8VROTn14StvbmhopLfdXKyQYADoDeaOtNUdIhXGHE8Z+ZRTaENV+vf3ivlc
 W6ZCF36UpkTYfg45kNBP1WUk7yEPR4fnoVBGTkAZUMU9qt3rJyZz5+NAez6egd3sQB59
 XZrg==
X-Gm-Message-State: AOAM533LMLZsqOXH35lyDRBuWfUEeOxZlvqrhYObwRjK9WWhj6+WSPG+
 NqFF4VFAA3Nwryy+BCbB9muxnTt5G59ta5NS
X-Google-Smtp-Source: ABdhPJzwgVXAlV2oWLOpyn8dCpTI3Oaw5EYtJSf0cPulgUxJGTKx8WYyPOU0kONZhM426XZ1UC7P9g==
X-Received: by 2002:a4a:aec3:: with SMTP id v3mr5295418oon.66.1602161828346;
 Thu, 08 Oct 2020 05:57:08 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
 [189.204.159.168])
 by smtp.gmail.com with ESMTPSA id w64sm4701933oig.31.2020.10.08.05.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 05:57:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] tcg: Move sorted_args into TCGArgConstraint.sort_index
Date: Thu,  8 Oct 2020 07:56:51 -0500
Message-Id: <20201008125659.49857-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008125659.49857-1-richard.henderson@linaro.org>
References: <20201008125659.49857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc43.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This uses an existing hole in the TCGArgConstraint structure
and will be convenient for keeping the data in one place.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  2 +-
 tcg/tcg.c         | 35 +++++++++++++++++------------------
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index a5a0ea4ada..63955ac85b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -985,6 +985,7 @@ void tcg_dump_op_count(void);
 typedef struct TCGArgConstraint {
     uint16_t ct;
     uint8_t alias_index;
+    uint8_t sort_index;
     TCGRegSet regs;
 } TCGArgConstraint;
 
@@ -1015,7 +1016,6 @@ typedef struct TCGOpDef {
     uint8_t nb_oargs, nb_iargs, nb_cargs, nb_args;
     uint8_t flags;
     TCGArgConstraint *args_ct;
-    int *sorted_args;
 #if defined(CONFIG_DEBUG_TCG)
     int used;
 #endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8e0df353ec..da01e39fe4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -944,7 +944,6 @@ void tcg_context_init(TCGContext *s)
     int op, total_args, n, i;
     TCGOpDef *def;
     TCGArgConstraint *args_ct;
-    int *sorted_args;
     TCGTemp *ts;
 
     memset(s, 0, sizeof(*s));
@@ -960,14 +959,11 @@ void tcg_context_init(TCGContext *s)
     }
 
     args_ct = g_malloc(sizeof(TCGArgConstraint) * total_args);
-    sorted_args = g_malloc(sizeof(int) * total_args);
 
     for(op = 0; op < NB_OPS; op++) {
         def = &tcg_op_defs[op];
         def->args_ct = args_ct;
-        def->sorted_args = sorted_args;
         n = def->nb_iargs + def->nb_oargs;
-        sorted_args += n;
         args_ct += n;
     }
 
@@ -2220,20 +2216,23 @@ static int get_constraint_priority(const TCGOpDef *def, int k)
 /* sort from highest priority to lowest */
 static void sort_constraints(TCGOpDef *def, int start, int n)
 {
-    int i, j, p1, p2, tmp;
+    int i, j;
+    TCGArgConstraint *a = def->args_ct;
 
-    for(i = 0; i < n; i++)
-        def->sorted_args[start + i] = start + i;
-    if (n <= 1)
+    for (i = 0; i < n; i++) {
+        a[start + i].sort_index = start + i;
+    }
+    if (n <= 1) {
         return;
-    for(i = 0; i < n - 1; i++) {
-        for(j = i + 1; j < n; j++) {
-            p1 = get_constraint_priority(def, def->sorted_args[start + i]);
-            p2 = get_constraint_priority(def, def->sorted_args[start + j]);
+    }
+    for (i = 0; i < n - 1; i++) {
+        for (j = i + 1; j < n; j++) {
+            int p1 = get_constraint_priority(def, a[start + i].sort_index);
+            int p2 = get_constraint_priority(def, a[start + j].sort_index);
             if (p1 < p2) {
-                tmp = def->sorted_args[start + i];
-                def->sorted_args[start + i] = def->sorted_args[start + j];
-                def->sorted_args[start + j] = tmp;
+                int tmp = a[start + i].sort_index;
+                a[start + i].sort_index = a[start + j].sort_index;
+                a[start + j].sort_index = tmp;
             }
         }
     }
@@ -3659,7 +3658,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     for (k = 0; k < nb_iargs; k++) {
         TCGRegSet i_preferred_regs, o_preferred_regs;
 
-        i = def->sorted_args[nb_oargs + k];
+        i = def->args_ct[nb_oargs + k].sort_index;
         arg = op->args[i];
         arg_ct = &def->args_ct[i];
         ts = arg_temp(arg);
@@ -3695,7 +3694,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
                     int k2, i2;
                     reg = ts->reg;
                     for (k2 = 0 ; k2 < k ; k2++) {
-                        i2 = def->sorted_args[nb_oargs + k2];
+                        i2 = def->args_ct[nb_oargs + k2].sort_index;
                         if ((def->args_ct[i2].ct & TCG_CT_IALIAS) &&
                             reg == new_args[i2]) {
                             goto allocate_in_reg;
@@ -3760,7 +3759,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         
         /* satisfy the output constraints */
         for(k = 0; k < nb_oargs; k++) {
-            i = def->sorted_args[k];
+            i = def->args_ct[k].sort_index;
             arg = op->args[i];
             arg_ct = &def->args_ct[i];
             ts = arg_temp(arg);
-- 
2.25.1


