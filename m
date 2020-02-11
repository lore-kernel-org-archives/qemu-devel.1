Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB13C3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:43:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BC224677
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 19:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcqKBNjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BC224677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1bRU-0003wM-FG
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 14:43:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j1bQX-000381-NQ
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j1bQW-00023w-La
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:33 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:51902)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j1bQW-0001y9-Fe
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 14:42:32 -0500
Received: by mail-pj1-x1043.google.com with SMTP id fa20so1795130pjb.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 11:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mkTZ+wCNqBwcUD+aN0bjpxQ/XJFdk1zV/Sm4bYszhRs=;
 b=JcqKBNjvIE9Tt3WfUpQnlCU8e2n9cGD4SP3/p14cQeobNXYwtc3BNl+78P2VFl88p3
 phFS2NrN1n4030GR8sUP6+/LL8y/8M5SsFoXToWMJucNcuHO6O8wK9nYf4S0Vao6zBK3
 6k43WhZPTAq05h/bFhZEeqJ0/oSt+GecM1h9uziFGEN6+/825B+0bqQekywYHtULOqoB
 JyiQBLdfS2WklsPaI0h8e8VZ9Oz0UBxtK+MY6UBSBlpWu/IMqk+c5/hIx4dYLoMJlhxN
 wfIzNroUChpQZeAeesenihWDlmac4UgAvveZlo75JbTSmNh9XUb3vMO2UsL7umTlhUgF
 xDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mkTZ+wCNqBwcUD+aN0bjpxQ/XJFdk1zV/Sm4bYszhRs=;
 b=a1HzoiMcCdP5SJozOz8LG4e1VzFtamXw25hdpO0t5zJSc6l5C3jMMHnBiWfafN4zC5
 DQxs9tczPjFr7c173GrZS+da3tz6aXgt80tLYh3DcsPxIjcjuAUopX6OosrOTpTBf8YE
 qwKAJlDUpH70nymvVj+swKig4is+RzWyjIx85x7mIMCVZ273VdUu6FJlYb3a9p2dbfUg
 W3YZFAVepk3LzUNovWw6dsyDl1V3ZJsJh3YQKBq12nVPCO+kB2YpHlfihlq4BITPNpam
 /tE2NwZruLfFQxYIii1Dz6q2aDj5d0lySuwAcTCZGCH40f8tlvSEE+eCt9cgU8y4BTRI
 NI4w==
X-Gm-Message-State: APjAAAWfxzwZT6CWekYWaxyjBQS5I2X1GcvizJJUhfSLt+PRiob2/7tm
 VfPRszaPbiSOrrhXAZWFmzStarZYhBk=
X-Google-Smtp-Source: APXvYqy2BNG5e+WTAes6FRx4JuB9xXFLVxGjSsCj6BmTkYFR+9HBQ5uXm6aLDj64T12hvGhAG6POpw==
X-Received: by 2002:a17:902:968c:: with SMTP id
 n12mr4736917plp.144.1581450150854; 
 Tue, 11 Feb 2020 11:42:30 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id b18sm5306281pfd.63.2020.02.11.11.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 11:42:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] target/arm: Fix select for aa64_va_parameters_both
Date: Tue, 11 Feb 2020 11:42:27 -0800
Message-Id: <20200211194228.16907-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211194228.16907-1-richard.henderson@linaro.org>
References: <20200211194228.16907-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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

Select should always be 0 for a regime with one range.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 46 +++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7d15d5c933..a008c70c87 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10074,13 +10074,8 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
     bool tbi, tbid, epd, hpd, using16k, using64k;
     int select, tsz;
 
-    /*
-     * Bit 55 is always between the two regions, and is canonical for
-     * determining if address tagging is enabled.
-     */
-    select = extract64(va, 55, 1);
-
     if (!regime_has_2_ranges(mmu_idx)) {
+        select = 0;
         tsz = extract32(tcr, 0, 6);
         using64k = extract32(tcr, 14, 1);
         using16k = extract32(tcr, 15, 1);
@@ -10093,23 +10088,30 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
             tbid = extract32(tcr, 29, 1);
         }
         epd = false;
-    } else if (!select) {
-        tsz = extract32(tcr, 0, 6);
-        epd = extract32(tcr, 7, 1);
-        using64k = extract32(tcr, 14, 1);
-        using16k = extract32(tcr, 15, 1);
-        tbi = extract64(tcr, 37, 1);
-        hpd = extract64(tcr, 41, 1);
-        tbid = extract64(tcr, 51, 1);
     } else {
-        int tg = extract32(tcr, 30, 2);
-        using16k = tg == 1;
-        using64k = tg == 3;
-        tsz = extract32(tcr, 16, 6);
-        epd = extract32(tcr, 23, 1);
-        tbi = extract64(tcr, 38, 1);
-        hpd = extract64(tcr, 42, 1);
-        tbid = extract64(tcr, 52, 1);
+        /*
+         * Bit 55 is always between the two regions, and is canonical for
+         * determining if address tagging is enabled.
+         */
+        select = extract64(va, 55, 1);
+        if (!select) {
+            tsz = extract32(tcr, 0, 6);
+            epd = extract32(tcr, 7, 1);
+            using64k = extract32(tcr, 14, 1);
+            using16k = extract32(tcr, 15, 1);
+            tbi = extract64(tcr, 37, 1);
+            hpd = extract64(tcr, 41, 1);
+            tbid = extract64(tcr, 51, 1);
+        } else {
+            int tg = extract32(tcr, 30, 2);
+            using16k = tg == 1;
+            using64k = tg == 3;
+            tsz = extract32(tcr, 16, 6);
+            epd = extract32(tcr, 23, 1);
+            tbi = extract64(tcr, 38, 1);
+            hpd = extract64(tcr, 42, 1);
+            tbid = extract64(tcr, 52, 1);
+        }
     }
     tsz = MIN(tsz, 39);  /* TODO: ARMv8.4-TTST */
     tsz = MAX(tsz, 16);  /* TODO: ARMv8.2-LVA  */
-- 
2.20.1


