Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC913C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75A682145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pScfQrMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75A682145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFno9-0000xe-Hj
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnG-0007dK-3X
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:58 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnD-00029H-Uv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:16:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id 34so705346pgo.13
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2hOHW45ulVj15284ZrX31Jc4JgC7jvorBgpIK9v2dLM=;
 b=pScfQrMzrDKtwywYe59V1Gm0m6l/wVHCATy8pMh8aRBmG4B1cPBmklfHxW4WnBCYZb
 dkVrKbjpZ+EsiaCbnNJbP0h9yyYHswQqEvQQODNqJwS1EtSV18WHrxJ8LHXmAJEq9JEZ
 z/frepYuBRqGzC6HnK+L/vtpSLbLDAtq6DUanv3oFguRu9KAtAFgQwXYuu2NtDTXIbp+
 C5G8QbFiTc0sdHEC4cp132gJZyh0BeCOETQBXCqO/qgE7ya7MZvlUU9tfXaJQbrh1hV2
 B69gaaNrPEEErR62zc07Uta/wDmj17IDloO7xQir57sUBWI61JR44J+ALWh6LgunoipB
 /IUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2hOHW45ulVj15284ZrX31Jc4JgC7jvorBgpIK9v2dLM=;
 b=mChmM5uZ20/2LDzCgcmvcavb16XRld9+AoK8aIumeKkyBvOOdBhkoXye+pGC5bqXOc
 xuL+VjczU/M8mBBJUcMKuvx93h+Skyxs90qHJcdcbXsC6JdQqGaSSPktGQqexaAVxQ+t
 swZh1pILvgBWxXeEy+SHuxjbAGGwvQXuExB+NJYoP8nVjatDgQ20kZripzzXiRYZU4OG
 gOdgTL/BAWNcTD71NLCEDeBiEONRR5UoSrhbYCWqqziqvR9Lx84E1jdKubLnWTBAgnrC
 FpL851RsLkroVUwpnbf94kgGKUbQcTtY9RzlT6YcuGfyRDrylAHEDWKHPHpmybB6xcp1
 CaRQ==
X-Gm-Message-State: AOAM5324gUH2j7nDypbq0jmXAYWVJI6m5sw5m31/c1ojswHPvPbVNq/6
 5McdJakEJQkOE9grDVMPHYqgBMx69PIgvQ==
X-Google-Smtp-Source: ABdhPJxbQ2QJzXFPkqObHrjy92zgqVL9GjWSnq58h8eqxm6jm2Q+P7B7zYyrM52dGQpqpCbmDeuyPA==
X-Received: by 2002:a65:6706:: with SMTP id u6mr938619pgf.404.1599610613861;
 Tue, 08 Sep 2020 17:16:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:16:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/43] tcg: Move sorted_args into TCGArgConstraint.sort_index
Date: Tue,  8 Sep 2020 17:16:07 -0700
Message-Id: <20200909001647.532249-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
index dcb38bf1e0..0a04b6cbd9 100644
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


