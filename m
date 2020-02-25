Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6489C35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:15:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82946206E6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gyUb2bdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82946206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Qh5-0004IT-JQ
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 22:15:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfq-0002td-QO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6Qfp-0005KO-Rr
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:18 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6Qfp-0005K5-NH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:14:17 -0500
Received: by mail-pj1-x1043.google.com with SMTP id m13so656554pjb.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 19:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A2W1ZRYZOUSzamV5z535LWD+FZ9UxwYNyg0dvNAaos0=;
 b=gyUb2bdFAPWdiid3Y/8AxYSkDxXGe0LXMIQFRcQgaF1trTiRUAgnCeXQ9s52dmyifi
 x51DoPH6Wz5I4vvc1QQnVEuRD8w1lf/dmsNM7T+uRcr1KgucfjGVbSZx2AcGZkoLAKw8
 /hAXE6KUyV96lHVNIOrGcl3Kg95qaY4r0k/wawIYi3JU1uWO0WjjIYfGv5I8eoIesWTZ
 iRpkwKAkcpHCBQjw3EBCWOw2zpCM1ok1pipUncgeSAF5Eaxkp/G/ygih2RTni8PO96RS
 Y3KgmzW8O9bhqnMXrxWVrxzmPB0m3AO570p4OEQPfgvutYfRWEUeWMexL1cl06x9WH/O
 kmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A2W1ZRYZOUSzamV5z535LWD+FZ9UxwYNyg0dvNAaos0=;
 b=tvzlJ9IBeFyTWGPoSyaZfrGmV+7F0KUFLc+eKRIXlq8+XL/GJTPT18Rzl8rVS/qHJC
 TRgd1kBKvroDYY21hZionRpWDJ3M0fSLFZK1S991YxJPbM6M+W8lty+a7H+2l8nokv4m
 6yWk1RjB+6VYFVTVo8n9TiMxTgiihHw3z5ijQKbYiSomKd67344Y1doj+mk1mVYo9Sfr
 ry9IdsFdFXwKsiUbpy82CRErdO3rsLe/7tgo1J2GQJDv6uw9v5o9SZk1ojau6+8GSqZF
 P3p16/V+OyPaD8RwtRxhdY5R+niygcr6pWr2FoZhazGsGPXbPTZ2VONRTWXglu8fBqHC
 TaRw==
X-Gm-Message-State: APjAAAVs11o4xsFBSuqzVUv37VELbmwv4O3q0frWfgQoAR5iI/ck07/O
 y3UdBhSHRptWi1njxn0nqNzbXX88yfs=
X-Google-Smtp-Source: APXvYqyp8gkmigpqibr93ucZH6Sijvi6S5ZzJpzQlW0/MbZxb3ArYBlj+3IUBf/YZRqle9wdgDvOGQ==
X-Received: by 2002:a17:90a:b30b:: with SMTP id
 d11mr2644397pjr.22.1582600456350; 
 Mon, 24 Feb 2020 19:14:16 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id q66sm14975242pfq.27.2020.02.24.19.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 19:14:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/8] target/arm: Optimize cpu_mmu_index
Date: Mon, 24 Feb 2020 19:14:08 -0800
Message-Id: <20200225031414.15649-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225031222.15434-1-richard.henderson@linaro.org>
References: <20200225031222.15434-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We now cache the core mmu_idx in env->hflags.  Rather than recompute
from scratch, extract the field.  All of the uses of cpu_mmu_index
within target/arm are within helpers where env->hflags is stable.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 23 +++++++++++++----------
 target/arm/helper.c |  5 -----
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65171cb30e..0e53cc255e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2939,16 +2939,6 @@ typedef enum ARMMMUIdxBit {
 
 #define MMU_USER_IDX 0
 
-/**
- * cpu_mmu_index:
- * @env: The cpu environment
- * @ifetch: True for code access, false for data access.
- *
- * Return the core mmu index for the current translation regime.
- * This function is used by generic TCG code paths.
- */
-int cpu_mmu_index(CPUARMState *env, bool ifetch);
-
 /* Indexes used when registering address spaces with cpu_address_space_init */
 typedef enum ARMASIdx {
     ARMASIdx_NS = 0,
@@ -3228,6 +3218,19 @@ FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
 FIELD(TBFLAG_A64, TBID, 12, 2)
 FIELD(TBFLAG_A64, UNPRIV, 14, 1)
 
+/**
+ * cpu_mmu_index:
+ * @env: The cpu environment
+ * @ifetch: True for code access, false for data access.
+ *
+ * Return the core mmu index for the current translation regime.
+ * This function is used by generic TCG code paths.
+ */
+static inline int cpu_mmu_index(CPUARMState *env, bool ifetch)
+{
+    return FIELD_EX32(env->hflags, TBFLAG_ANY, MMUIDX);
+}
+
 static inline bool bswap_code(bool sctlr_b)
 {
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c1dae83700..7cf6642210 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12109,11 +12109,6 @@ ARMMMUIdx arm_mmu_idx(CPUARMState *env)
     return arm_mmu_idx_el(env, arm_current_el(env));
 }
 
-int cpu_mmu_index(CPUARMState *env, bool ifetch)
-{
-    return arm_to_core_mmu_idx(arm_mmu_idx(env));
-}
-
 #ifndef CONFIG_USER_ONLY
 ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
 {
-- 
2.20.1


