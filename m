Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51101C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87882145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWrer79b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87882145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnvN-0001Nr-0e
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnY-0008ON-AY
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:16 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:37377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnW-0002FW-MK
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:15 -0400
Received: by mail-pf1-x441.google.com with SMTP id w7so565013pfi.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=x+s9W4S8X9df0AJnC/pFDE7SPPgT3/tOf2XSzgDEzSo=;
 b=LWrer79bKyuhjmzyncNJWLXkxJGTeDtW71v/dXDkZejqc3re+JH+4+kTrvE4k5vHgs
 K0Ze/HspxaLKlK9o5Miz/ba11e1YHZQxy6+Fs0p0Row87q9Zuq7Gw/sTVCCPC+yFSZiK
 UYeBsgdzspNa21PpUTz6Edu6y9ZuR5Jpl8bOosxV3+eNfvRd+pqdOewlW9WXOZ+EWkPU
 cnfT9tVDZQeqLaMbLbB3Sn9CVS86Wrd1ja6YeU63VJrNoGpKySdiF9bgXDeTWtw6PkWr
 F7YFWLmtsvfog8NB61c7G48vLCzyihC9bonQ9145xeuaE1GlcJ/6QQGlNDdy62w9+OvH
 bbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x+s9W4S8X9df0AJnC/pFDE7SPPgT3/tOf2XSzgDEzSo=;
 b=QSndHHKjonAZUOXCwWzd4GAF782xgi4y5vpJgFMOQa+C7oFQct3/JJdbib1x6NO/Nk
 PrduiQLVuP8o6YlKYs9iYI1Onq28ytpdXEjr/CZUeTEzP5mZPjpQ5WFr89pcxvujjiQT
 PxiKoyRLxpHqzRIhBDzMz6fy0GM7OTIHaNO/5QvGInHuZdQRcaFfog4U5gB1dS3wocTx
 K3XovagLSrx6/aXgfMSQmVxeSfErbHF8wazrgLzvI+nw0N5BnDSSTyA5PML+TJ0APh+G
 kKEaEZhOc2smgkqyjqWSWIERwYClJqUtEt8ytO5jig9BhRpQinEvBXOMD9yUABCBYMAE
 56rA==
X-Gm-Message-State: AOAM530M1BMpZT0i28kBrKYfgacIN2TUje6MYnfgddaeoFAgqvsMh/l5
 Wn9ErujL3pb7fzCD5980ePTx4keQJJ1JxQ==
X-Google-Smtp-Source: ABdhPJxM+MyHhH8f/z8ITkxXIvN41S1+HKioz3FjRpjfTEGdG7WxRtIjsz1zs8Lyz+sJa1F9EUy7RQ==
X-Received: by 2002:a17:902:788e:: with SMTP id
 q14mr1097753pll.140.1599610633108; 
 Tue, 08 Sep 2020 17:17:13 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/43] tcg/optimize: Improve find_better_copy
Date: Tue,  8 Sep 2020 17:16:23 -0700
Message-Id: <20200909001647.532249-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

Prefer TEMP_CONST over anything else.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c0fd65d2e4..bf2c2a3ce5 100644
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
2.25.1


