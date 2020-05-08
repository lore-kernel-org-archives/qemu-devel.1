Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12649C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:26:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE05121582
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NS7bJjkt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE05121582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4tE-0003Ms-W3
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lH-000606-ME
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:03 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lG-00030k-SI
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:03 -0400
Received: by mail-pl1-x641.google.com with SMTP id s10so856381plr.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hO8uxZGqqMIyQAAAtWPOJL9YxJXzGDQrOpnZTatzOw0=;
 b=NS7bJjktqhtzL1PkdRflvGXj5byWneMK4Ci4yARbZqfpjAPo74JVSS5ohOsga9MzHc
 t+YZw/BbQ3Vv0vi+mit349W0AgRuY/ZlQ7pgnzK2waUoXIkogl2H7VW6JC6yaNkf7vIy
 csacwc5sAeggkfjyiwPSWV4MIIfA3TUq8JhBurHdEZ+b0GKVKBkSA7LheBeCT/cUzbu4
 ebblC92Dm9/U6Od7gofN3+6We1zfcOfrS/ouR+9EcXNYd48rGS7Z6aa9jKeyIFa9FTQ4
 i4jxdCgZoScSXGYuiJEytwko3ImAoiNa8RUGHX8Qwo/weERHbtLVYpFTxqal4xv63Zpm
 hOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hO8uxZGqqMIyQAAAtWPOJL9YxJXzGDQrOpnZTatzOw0=;
 b=CPVES5gctxA9LQ3HlF2cVP13LujZlSChYDE6G/5JCto4jFGo2n/18/67zIbReTZ8jZ
 S8TmZflQU4LCQ+gAuzVY85ctPEFQ5yETm9rBJStS87IARz3CQqg5dZcEXssr9S0Eod/q
 JfYM+4hMeDEcyNibBZoSiWXZjI+KbjzFaiESSOVqHvMbqiV42q9bSgO0irlPg+MuWg1h
 vr67+wMef2HHinDAiS1EztNIt5yc1VJX0wj1m8IAtQX61z/INUdIoHS55aMFgq1GdyUr
 vqhUMigTgkuzjt+Ii7ZeQlOGjVaXs4pmVPX5nYsnKxt116Y/z/fq1OMVIxROfKopNKtH
 52Vw==
X-Gm-Message-State: AGi0PuZ/nwR0UeMe8DTfdeTaGl6B6vEoFTlhRKSPl6NUnn7Wdz5nIyPg
 0+GO/d9LuG3OnwDB5oW3WDpJPwYcMmM=
X-Google-Smtp-Source: APiQypJ3IqolJeSvS5zSAwSI0e/5fZSYmMC0s7sxIpDmrqez5KP3OLYp3ErE/f19ro4Yxqu3t2NN3Q==
X-Received: by 2002:a17:902:bd89:: with SMTP id
 q9mr2853923pls.161.1588951081004; 
 Fri, 08 May 2020 08:18:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:18:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/19] tcg/optimize: Improve find_better_copy
Date: Fri,  8 May 2020 08:17:38 -0700
Message-Id: <20200508151747.6166-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

Prefer TEMP_CONST over anything else.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c0fc5e3da6..b86bf3d707 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -122,31 +122,28 @@ static void init_arg_info(TempOptInfo *infos,
 
 static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
 {
-    TCGTemp *i;
+    TCGTemp *i, *g, *l;
 
-    /* If this is already a global, we can't do better. */
-    if (ts->kind >= TEMP_GLOBAL) {
+    /* If this is already readonly, we can't do better. */
+    if (temp_readonly(ts)) {
         return ts;
     }
 
-    /* Search for a global first. */
+    g = l = NULL;
     for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
-        if (i->kind >= TEMP_GLOBAL) {
+        if (temp_readonly(i)) {
             return i;
-        }
-    }
-
-    /* If it is a temp, search for a temp local. */
-    if (ts->kind == TEMP_NORMAL) {
-        for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
-            if (i->kind >= TEMP_LOCAL) {
-                return i;
+        } else if (i->kind > ts->kind) {
+            if (i->kind == TEMP_GLOBAL) {
+                g = i;
+            } else if (i->kind == TEMP_LOCAL) {
+                l = i;
             }
         }
     }
 
-    /* Failure to find a better representation, return the same temp. */
-    return ts;
+    /* If we didn't find a better representation, return the same temp. */
+    return g ? g : l ? l : ts;
 }
 
 static bool ts_are_copies(TCGTemp *ts1, TCGTemp *ts2)
-- 
2.20.1


