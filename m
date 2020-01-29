Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F5CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:06:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BA062064C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e5udKOgH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BA062064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxLR-0001eo-H8
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC5-0003c4-2C
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxC4-0006vf-1Z
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:24 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxC3-0006tT-SB
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:23 -0500
Received: by mail-pf1-x443.google.com with SMTP id w62so486450pfw.8
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QOmO6ZsE3LQMtWFwohSrFylZgkA3stKDr6742fL9gX0=;
 b=e5udKOgHlkctbgDPhLnQcUsKI+9BS9UKqr3s4KI4JXH3qpDyEFarq4lG4Z5Nib+lDQ
 dNgLfoFYnELPG7mvC011BA77bhikhXim6geTbsrD5R7UzFUtT77YJkdO7Zagx7LiXDu1
 Ks2H0fBcLnivhsRvGbcYoD+kbdeBnQxZxmaIdGFkKcS24lW0Bhz2fch5L2zBuSN5MMVo
 BQSHXFBXTiEEoegBDEbIoPpP7Mu2AIK3K3vPaZ6Zq+ZS/akjPMnPKBsAYW8ajHB5MmxU
 gInPLV9RTc528HSJkFT6mvrdZXBG11NKi2sj8oJoC/QKxaYlCMn7b5j0wxZ/8W6nOkIm
 KGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QOmO6ZsE3LQMtWFwohSrFylZgkA3stKDr6742fL9gX0=;
 b=jomlTkPABKetiR1yCCdwXDj8Y66T3xMCDPdGFgWF1WDQGy4IkjF4v0rJl3nDh1tqSs
 JootysvyG0+xppmvrZPFnKHCQDdVeJv6kZ7GGV8aeKS86SnO6N3wJJFSdfPusHVRmbPF
 woavVZ5E84H1Y7gnuI0/Cqxp3j0v/B7Dd031VKShyeO6veYUGoSYTP8xeKwZd4LyEN6V
 2YkA+8ek9wGOtIk0vAZ7quG99aFDEF5Ol6yQ4AF0GsGOUHyYL6u6Riqp8rQJIw0PmG/O
 wUdl6waNlU/nc6QRhaScPkJ3YO5aJ89b9G0PO8Omx39zznOFJURYZeGCJo73OqTCv/Lw
 jfHg==
X-Gm-Message-State: APjAAAXj6ft47mG2y+O7pX45KGte7PF/oN0E56WqhDKPO7pUk3kHOe0D
 WFB7hT+1Odp0hFFkqW8TRIvjJJ0S/g0=
X-Google-Smtp-Source: APXvYqw7KvkNaBuUD+0Ig7chtPFZfNIDYEJ2FC0cCP2HBqgosLfNz502iZbloduev2rPg2MJlf+pHQ==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr1643343pgi.448.1580342182537; 
 Wed, 29 Jan 2020 15:56:22 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/41] target/arm: Update CNTVCT_EL0 for VHE
Date: Wed, 29 Jan 2020 15:55:38 -0800
Message-Id: <20200129235614.29829-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The virtual offset may be 0 depending on EL, E2H and TGE.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8b8d2213cf..830f83ae55 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2515,9 +2515,31 @@ static uint64_t gt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return gt_get_countervalue(env);
 }
 
+static uint64_t gt_virt_cnt_offset(CPUARMState *env)
+{
+    uint64_t hcr;
+
+    switch (arm_current_el(env)) {
+    case 2:
+        hcr = arm_hcr_el2_eff(env);
+        if (hcr & HCR_E2H) {
+            return 0;
+        }
+        break;
+    case 0:
+        hcr = arm_hcr_el2_eff(env);
+        if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
+            return 0;
+        }
+        break;
+    }
+
+    return env->cp15.cntvoff_el2;
+}
+
 static uint64_t gt_virt_cnt_read(CPUARMState *env, const ARMCPRegInfo *ri)
 {
-    return gt_get_countervalue(env) - env->cp15.cntvoff_el2;
+    return gt_get_countervalue(env) - gt_virt_cnt_offset(env);
 }
 
 static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -2532,7 +2554,13 @@ static void gt_cval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
                              int timeridx)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     return (uint32_t)(env->cp15.c14_timer[timeridx].cval -
                       (gt_get_countervalue(env) - offset));
@@ -2542,7 +2570,13 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           int timeridx,
                           uint64_t value)
 {
-    uint64_t offset = timeridx == GTIMER_VIRT ? env->cp15.cntvoff_el2 : 0;
+    uint64_t offset = 0;
+
+    switch (timeridx) {
+    case GTIMER_VIRT:
+        offset = gt_virt_cnt_offset(env);
+        break;
+    }
 
     trace_arm_gt_tval_write(timeridx, value);
     env->cp15.c14_timer[timeridx].cval = gt_get_countervalue(env) - offset +
-- 
2.20.1


