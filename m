Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB17DC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A472192A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G45/dllQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A472192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7pP-0002aN-RM
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hl-0006va-Ji
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:41947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hj-0006q9-JH
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id u10so1097085pls.8
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OZxI+BJNGGc8i+fpWnheFUkcs37pG3uUWAB+Zp0TZ/I=;
 b=G45/dllQ96UvzA8IhBj8jgM5T1/gOepRHgHohzY3mZDKF5jpdeG7W9/CVxafspBUp1
 7EuHobCWSl8K/RWt5d5glEOgFJngXLeSZQj8c9h8Vv3bMGxqekQTb0KjT4oqGI0qpCa2
 L72hclxMgLtI1s+egV5ixFbtrfskYFRyMY6A0JBHq2P6VKYfpHnNrIDNYQEc99h9NQpQ
 uifE9MfzA15OGf2DCYNuEHU/BFqMgvwURBpmLlr/hfq1QYC0Nj2MFS4iMVdM7eHKMyHZ
 u0fGKyqUIEdESttwNN4mgdOIfCKZx/HPUVXc0cNr+xIxuU1f9cLdhQ1EjAr4jZrI8CmD
 Kq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OZxI+BJNGGc8i+fpWnheFUkcs37pG3uUWAB+Zp0TZ/I=;
 b=KFNstkn7ATLwaQZRc/bYOGEL/XF2dQgAIJw5AJ2xdB1IUWgfxP1w5EhkIrIP+8u5co
 q8ndZ2Jyp0kI63daKuvDTNVXAnD7cdx0PyO1Ezb8X+CiR7acszNlMmKTSxz3Ok3iblT5
 Eoe7hNJJV8EUk+o4uA0jisNs+3yBGDkqWvAXIon2Del+IOkUMzj1Oqh8Fg/duZCv7cI6
 ykROjPii8IfstVyT0oR/vtu5HzKWKzpr8CV5fY5F4hQI5L0h5wSxx7Yi/OMktH5KkrOu
 SOmwuE1RVfN5Ghyt1KPgrQBuidj25ZZd4uwFc9ESvNIkS3jG1Ff1GedQO3+sHUED0Zey
 nbEg==
X-Gm-Message-State: AGi0PubIQELC6zoGIX71+/SH4KPFZkI+bHsvgqXPzb0IgNREpcHPaexy
 63W8M+B0XYfnRyc6odrBLAZGwV4FVgM=
X-Google-Smtp-Source: APiQypKfV3OdyVEpHJE5mpyn3/JCiAAVdx1U2n7VXTEXKwqouzzIPAkaVjel3OdLQ942UfbXt9/6cQ==
X-Received: by 2002:a17:90a:77c6:: with SMTP id
 e6mr7503123pjs.84.1588962393379; 
 Fri, 08 May 2020 11:26:33 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/19] tcg/optimize: Adjust TempOptInfo allocation
Date: Fri,  8 May 2020 11:26:08 -0700
Message-Id: <20200508182616.18318-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Do not allocate a large block for indexing.  Instead, allocate
for each temporary as they are seen.

In general, this will use less memory, if we consider that most
TBs do not touch every target register.  This also allows us to
allocate TempOptInfo for new temps created during optimization.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 60 ++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index b86bf3d707..d36d7e1d7f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -89,35 +89,41 @@ static void reset_temp(TCGArg arg)
 }
 
 /* Initialize and activate a temporary.  */
-static void init_ts_info(TempOptInfo *infos,
-                         TCGTempSet *temps_used, TCGTemp *ts)
+static void init_ts_info(TCGTempSet *temps_used, TCGTemp *ts)
 {
     size_t idx = temp_idx(ts);
-    if (!test_bit(idx, temps_used->l)) {
-        TempOptInfo *ti = &infos[idx];
+    TempOptInfo *ti;
 
+    if (test_bit(idx, temps_used->l)) {
+        return;
+    }
+    set_bit(idx, temps_used->l);
+
+    ti = ts->state_ptr;
+    if (ti == NULL) {
+        ti = tcg_malloc(sizeof(TempOptInfo));
         ts->state_ptr = ti;
-        ti->next_copy = ts;
-        ti->prev_copy = ts;
-        if (ts->kind == TEMP_CONST) {
-            ti->is_const = true;
-            ti->val = ti->mask = ts->val;
-            if (TCG_TARGET_REG_BITS > 32 && ts->type == TCG_TYPE_I32) {
-                /* High bits of a 32-bit quantity are garbage.  */
-                ti->mask |= ~0xffffffffull;
-            }
-        } else {
-            ti->is_const = false;
-            ti->mask = -1;
+    }
+
+    ti->next_copy = ts;
+    ti->prev_copy = ts;
+    if (ts->kind == TEMP_CONST) {
+        ti->is_const = true;
+        ti->val = ts->val;
+        ti->mask = ts->val;
+        if (TCG_TARGET_REG_BITS > 32 && ts->type == TCG_TYPE_I32) {
+            /* High bits of a 32-bit quantity are garbage.  */
+            ti->mask |= ~0xffffffffull;
         }
-        set_bit(idx, temps_used->l);
+    } else {
+        ti->is_const = false;
+        ti->mask = -1;
     }
 }
 
-static void init_arg_info(TempOptInfo *infos,
-                          TCGTempSet *temps_used, TCGArg arg)
+static void init_arg_info(TCGTempSet *temps_used, TCGArg arg)
 {
-    init_ts_info(infos, temps_used, arg_temp(arg));
+    init_ts_info(temps_used, arg_temp(arg));
 }
 
 static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
@@ -603,9 +609,8 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
-    int nb_temps, nb_globals;
+    int nb_temps, nb_globals, i;
     TCGOp *op, *op_next, *prev_mb = NULL;
-    TempOptInfo *infos;
     TCGTempSet temps_used;
 
     /* Array VALS has an element for each temp.
@@ -615,12 +620,15 @@ void tcg_optimize(TCGContext *s)
 
     nb_temps = s->nb_temps;
     nb_globals = s->nb_globals;
+
     bitmap_zero(temps_used.l, nb_temps);
-    infos = tcg_malloc(sizeof(TempOptInfo) * nb_temps);
+    for (i = 0; i < nb_temps; ++i) {
+        s->temps[i].state_ptr = NULL;
+    }
 
     QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
         tcg_target_ulong mask, partmask, affected;
-        int nb_oargs, nb_iargs, i;
+        int nb_oargs, nb_iargs;
         TCGArg tmp;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
@@ -633,14 +641,14 @@ void tcg_optimize(TCGContext *s)
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
                 TCGTemp *ts = arg_temp(op->args[i]);
                 if (ts) {
-                    init_ts_info(infos, &temps_used, ts);
+                    init_ts_info(&temps_used, ts);
                 }
             }
         } else {
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
-                init_arg_info(infos, &temps_used, op->args[i]);
+                init_arg_info(&temps_used, op->args[i]);
             }
         }
 
-- 
2.20.1


