Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E854FC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:14:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69B120663
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFmMIelk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69B120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgHz8-0005IK-Sf
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy8-0003JJ-Ko
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:24 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHy8-0003W6-0o
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:24 -0400
Received: by mail-pf1-x444.google.com with SMTP id j1so258215pfe.4
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w0iAAPJiPUMN5WMvx91TGcplu0Afl0eDKA3EhLW5gNo=;
 b=PFmMIelkaLMfRJ69igouLY4t2p0h6QeXvGx/htpKH8meFoeZa6CHwBtSs8fnerkGZi
 1Ip6W5CFanpbjzkUSueDx7t5yRm9nYJ4X/ekZZZBskew3VrMo/5tS1/C+hYtH7NmBZw0
 pLK04b01a4DazOrnUcyaZVwnwXmzf7omD5n+/CPR9DEenRrHGCNo1RG6sTRP39s4R1Pj
 sXiDeJHCGeFS0PVSZ7HRY4wotTlvApfdsvQwOD+B3twvbdVLydn0CVfBl9dKUq0BUlou
 vKc72Lhjg100ZorDtU1rqVT8CYAgjg5Lwwri4fh/z3zQ9f1ph/yXG25dRtQlsP9Jrg9c
 foTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w0iAAPJiPUMN5WMvx91TGcplu0Afl0eDKA3EhLW5gNo=;
 b=C0QS7wbbWiG8MB9GYQCp9lyfmdhj8ulNDWt5iTFNsxb6JqU7Z/IJDbU82fLWf9yKWg
 FEyM3kLSSjwmRipzQSAjeMLdHQZqR38uzKwRMKgpE6Geo+JqTscgSfl+DlZHsIyWQWn3
 02P4K/gZ0Y2KtvlfGVyb8Z/ZeiVHJQFja+6byxmm9JAqBX64jIgfQj30pGtoxmhK0mBO
 ECv58HFMo0rkYyRDskM4omfctLOxBLOy2hF/GtwkcWBNvXdO75vorL1cQHmhAKpHrx7c
 5urMjtVPIKgsL8WPk2x9LO8v2D4jSp6U7uZ3AkrslsPPNokVE0fPvHSB4cBnH5qkI+YP
 k0pg==
X-Gm-Message-State: AOAM530xxnQxGeXY1k3AWvC2+DshbTZ4iLbrrsIFB7IfzHcxRyj3cRfp
 HjSqjg+wTU5UD6Twkvrxd1gqJkpP378=
X-Google-Smtp-Source: ABdhPJz9o+tWaxHAagWadiaRxHwzrSu56FFTyg6CSpbysvfdiAs5/YXa7rfM3nbQ9azSmm+XQ2VLIg==
X-Received: by 2002:a17:90a:5806:: with SMTP id
 h6mr2442263pji.66.1591146802500; 
 Tue, 02 Jun 2020 18:13:22 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 03/42] target/arm: Add support for MTE to SCTLR_ELx
Date: Tue,  2 Jun 2020 18:12:38 -0700
Message-Id: <20200603011317.473934-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does not attempt to rectify all of the res0 bits, but does
clear the mte bits when not enabled.  Since there is no high-part
mapping of SCTLR, aa32 mode cannot write to these bits.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2ec49c1a55..7862bf502d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -4698,6 +4698,22 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
 
+    if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
+        /* M bit is RAZ/WI for PMSA with no MPU implemented */
+        value &= ~SCTLR_M;
+    }
+
+    /* ??? Lots of these bits are not implemented.  */
+
+    if (ri->state == ARM_CP_STATE_AA64 && !cpu_isar_feature(aa64_mte, cpu)) {
+        if (ri->opc1 == 6) { /* SCTLR_EL3 */
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF | SCTLR_ATA);
+        } else {
+            value &= ~(SCTLR_ITFSB | SCTLR_TCF0 | SCTLR_TCF |
+                       SCTLR_ATA0 | SCTLR_ATA);
+        }
+    }
+
     if (raw_read(env, ri) == value) {
         /* Skip the TLB flush if nothing actually changed; Linux likes
          * to do a lot of pointless SCTLR writes.
@@ -4705,13 +4721,8 @@ static void sctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         return;
     }
 
-    if (arm_feature(env, ARM_FEATURE_PMSA) && !cpu->has_mpu) {
-        /* M bit is RAZ/WI for PMSA with no MPU implemented */
-        value &= ~SCTLR_M;
-    }
-
     raw_write(env, ri, value);
-    /* ??? Lots of these bits are not implemented.  */
+
     /* This may enable/disable the MMU, so do a TLB flush.  */
     tlb_flush(CPU(cpu));
 
-- 
2.25.1


