Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E55C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:52:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A4D20780
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CpPoE5TK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A4D20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzw8-0000uD-PU
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsV-0004tC-JC
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:38541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsT-0002xW-KV
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id v12so3424182wmh.3
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hTO8btZSlaFpXoB+S1LGr70eAkhckSw0xm/svAQpL/0=;
 b=CpPoE5TKyiVyHonFVNtrXEsnMxnRJgrT/fEGqJwWCrLpMMhflBz7s3jerasJCuijiQ
 8TSMO7dRoMtxjID5HAzD4xBj765lN4uTWRKaGFkVANEjWUmiSMIBD1hDaP0D5NshKaL4
 BqXb6TP4R+w8D8EXjsI2BKSpHFJX5cDT4mD7s/2d2zwztefF5zgT7KP60y5MttOt+jiD
 F6VvTsTTqYPLuM+f5XEjncVcNh7EHDfGpHeZTbd1emjy1aTtiMxSkRCFdDb42vn2Lu/y
 4D6x4GGhSr478LkjMs1Un18gBe6TmZ/DtLPjz6lutV0d/HiC4F/6teZa4UufALr2o/Zh
 isTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hTO8btZSlaFpXoB+S1LGr70eAkhckSw0xm/svAQpL/0=;
 b=m1hCe44YTKlCOQIckyKwY7eoycPSzCazeZxptYr1NTgwkFO7BfNhWKPRxqcEau4csb
 1Zo95J5logpBj7nikYN5sNsGBxebLHATgkh7yytzD5sB9L1Yb0iC2Mu9eBu8jr6kqMgA
 GDKKpMvAbN/frRO2OzHWeBBjo1M3Me5RW1aF3shBoksEMxoECdX3ydp4OihwYBNmK4lr
 40Sla2EqR4J+O/lEv1+V7udaVHhRLH4IKnESZ68La7H7FNecnVED9aoItToaFqImGh8k
 4pSpuMbaFJ7KQPoleWuNY376LsStDZhMbokcFO3/Tg5mTzKD3iairyAMZUNkMKunw14/
 tVdg==
X-Gm-Message-State: AOAM530jT7vesJzJSKN0QvbPsh0ZVkUdI2reXnoPh6P7c/fac5AeBRYJ
 USg/Vz+rBWREOYca1I08Kc8RZEZoUiDI9dBw
X-Google-Smtp-Source: ABdhPJxSEw7uHN4iCaReYC20971KvBjpAp/w4QH2zCJ0j7B0lo5lve1PtkvN+80xwTESdeeeSWrmDA==
X-Received: by 2002:a05:600c:2103:: with SMTP id
 u3mr368022wml.132.1601563691871; 
 Thu, 01 Oct 2020 07:48:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/18] target/arm: Make isar_feature_aa32_fp16_arith() handle
 M-profile
Date: Thu,  1 Oct 2020 15:47:46 +0100
Message-Id: <20201001144759.5964-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

The M-profile definition of the MVFR1 ID register differs slightly
from the A-profile one, and in particular the check for "does the CPU
support fp16 arithmetic" is not the same.

We don't currently implement any M-profile CPUs with fp16 arithmetic,
so this is not yet a visible bug, but correcting the logic now
disarms this beartrap for when we eventually do.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200910173855.4068-6-peter.maydell@linaro.org
---
 target/arm/cpu.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a36edd2dc3d..e4549a8cc0c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1799,6 +1799,15 @@ FIELD(ID_MMFR4, LSM, 20, 4)
 FIELD(ID_MMFR4, CCIDX, 24, 4)
 FIELD(ID_MMFR4, EVT, 28, 4)
 
+FIELD(ID_PFR1, PROGMOD, 0, 4)
+FIELD(ID_PFR1, SECURITY, 4, 4)
+FIELD(ID_PFR1, MPROGMOD, 8, 4)
+FIELD(ID_PFR1, VIRTUALIZATION, 12, 4)
+FIELD(ID_PFR1, GENTIMER, 16, 4)
+FIELD(ID_PFR1, SEC_FRAC, 20, 4)
+FIELD(ID_PFR1, VIRT_FRAC, 24, 4)
+FIELD(ID_PFR1, GIC, 28, 4)
+
 FIELD(ID_AA64ISAR0, AES, 4, 4)
 FIELD(ID_AA64ISAR0, SHA1, 8, 4)
 FIELD(ID_AA64ISAR0, SHA2, 12, 4)
@@ -1916,10 +1925,12 @@ FIELD(MVFR0, FPROUND, 28, 4)
 
 FIELD(MVFR1, FPFTZ, 0, 4)
 FIELD(MVFR1, FPDNAN, 4, 4)
-FIELD(MVFR1, SIMDLS, 8, 4)
-FIELD(MVFR1, SIMDINT, 12, 4)
-FIELD(MVFR1, SIMDSP, 16, 4)
-FIELD(MVFR1, SIMDHP, 20, 4)
+FIELD(MVFR1, SIMDLS, 8, 4) /* A-profile only */
+FIELD(MVFR1, SIMDINT, 12, 4) /* A-profile only */
+FIELD(MVFR1, SIMDSP, 16, 4) /* A-profile only */
+FIELD(MVFR1, SIMDHP, 20, 4) /* A-profile only */
+FIELD(MVFR1, MVE, 8, 4) /* M-profile only */
+FIELD(MVFR1, FP16, 20, 4) /* M-profile only */
 FIELD(MVFR1, FPHP, 24, 4)
 FIELD(MVFR1, SIMDFMAC, 28, 4)
 
@@ -3522,9 +3533,19 @@ static inline bool isar_feature_aa32_predinv(const ARMISARegisters *id)
     return FIELD_EX32(id->id_isar6, ID_ISAR6, SPECRES) != 0;
 }
 
+static inline bool isar_feature_aa32_mprofile(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_pfr1, ID_PFR1, MPROGMOD) != 0;
+}
+
 static inline bool isar_feature_aa32_fp16_arith(const ARMISARegisters *id)
 {
-    return FIELD_EX32(id->mvfr1, MVFR1, FPHP) >= 3;
+    /* Sadly this is encoded differently for A-profile and M-profile */
+    if (isar_feature_aa32_mprofile(id)) {
+        return FIELD_EX32(id->mvfr1, MVFR1, FP16) > 0;
+    } else {
+        return FIELD_EX32(id->mvfr1, MVFR1, FPHP) >= 3;
+    }
 }
 
 static inline bool isar_feature_aa32_vfp_simd(const ARMISARegisters *id)
-- 
2.20.1


