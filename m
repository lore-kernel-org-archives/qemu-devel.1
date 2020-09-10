Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CA4C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEE02067C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UzRA1BQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEE02067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQbb-0002Jr-5a
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQXO-0003zT-TM
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:39:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQXM-0002or-Cz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:39:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id c19so2367119wmd.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TGaZ8S9jCTIwlbnlsjzYIzfStZejwdYuXoamg2TI9as=;
 b=UzRA1BQf0o6Y1LDeUINMQgs3MPqkViM6s8XkifXfjoktbwOhaDXxNzzxCPWG/u+wrN
 j/p4y8Qj6siyz9u6l0h3wcqnLk+0Hr3A/XVXJH7nnma/bwWxqIPguf96y5RoD1eAGGlP
 O+hrQc2sUM7J78Mku9S3EYlVvn/oIRvyd0fUBNs2OiHbDcY+whIQU7ZyYbE22Hu+4TRl
 y6D9qlN/IMPGzS7HONOpYWrk6TEu2HctLyEUssAj/0kR8jb0UGfoF8FUyyjirHmu9XS2
 tyUiZTVuQEWX+Igd57fSX4wN/aCNV6PjXJDC6blXcc/Lek9lUUGRwrka3PzqDlqvfxbq
 3fBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TGaZ8S9jCTIwlbnlsjzYIzfStZejwdYuXoamg2TI9as=;
 b=hza7cTo7JPdrbBntrGn4m+8h7mPgjF+sq85cLiqRFQxqUaTDZwlqhiy2OHI5an/nqL
 B+1TNPlF731DOWwV8t/MTqhetAyrr6hge8EKj4Dn6mX2rv0JqnZv8Jfx9XagR2nfiA4d
 FVuRrQM/oFRwIpO6DuUY108czdEAcMRD7bmEmlTTQuTZskkwZv87Uq9N8Lo3IdmRNveF
 eYZBMFGUYW9s8rtbmI59aELNOutXFIVKWqnsPBqegz/qpXj9ZrvYM2fcgRpubzRJM82g
 CCTrIEJN+Kjfyn6kLlE0TdBGlzX4W8jz14yS+TBksCpOl9UEp1B6zvjVMGT6VjDR3Ntl
 XgiQ==
X-Gm-Message-State: AOAM531iEoG5y5YN6eUvags3Wz5LcDoOycKh8pR3O4OF/8lMXV/uLTEd
 T1yVrR6m8llAGhha3oQ/VJ+DEDsML7sfqn6l
X-Google-Smtp-Source: ABdhPJxIChppOT5/GesOMe6d4y5DK88fvU2htlst5nSn4gCCNg9rviAjxZaJRG3dJ72OSa6o23nEYA==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr1149719wmf.20.1599759547032; 
 Thu, 10 Sep 2020 10:39:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q186sm4603128wma.45.2020.09.10.10.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 10:39:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/5] target/arm: Make isar_feature_aa32_fp16_arith() handle
 M-profile
Date: Thu, 10 Sep 2020 18:38:55 +0100
Message-Id: <20200910173855.4068-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910173855.4068-1-peter.maydell@linaro.org>
References: <20200910173855.4068-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
---
 target/arm/cpu.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index de2ab41e2a0..8453808b36d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1802,6 +1802,15 @@ FIELD(ID_MMFR4, LSM, 20, 4)
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
@@ -1919,10 +1928,12 @@ FIELD(MVFR0, FPROUND, 28, 4)
 
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
 
@@ -3525,9 +3536,19 @@ static inline bool isar_feature_aa32_predinv(const ARMISARegisters *id)
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


