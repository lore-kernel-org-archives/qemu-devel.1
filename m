Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214AEC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E559C24649
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8Mm/N4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E559C24649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2G1h-0006fO-20
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgx-0004Mj-8W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgt-0001os-0G
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:11 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:39374)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgs-0001nQ-QW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:06 -0500
Received: by mail-wr1-x429.google.com with SMTP id y11so6975643wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=qM64BUtAr1z/gzsTM4GBdk2IcG0HXVAZX8dYXOH96BA=;
 b=u8Mm/N4hZAl7gR3keulCxy1dyGb85TerAxIlKCGkr2IB5Y1unMbOBN0GZGEdmGDcq+
 cosGMYRLAk+Uwa2ryQhFssnZybaQrI99GCaXQWI5rO0MvZq/tYUkMfpJpzBtmbqrsm7M
 40Qg4gA/2Iz+2tkNWVXXqgz80yX9BJQ5rD8MHVHdeeuLFBLD4e2Zt+IOAMUHZRL93d3N
 6kmse1eTAlKT8HLrFpHuDMAwUE+JAquhaIa3/gIDt+HWC0q3PM1xkDsAOE6v1MyyYRf6
 1icvjRzdUf4LMAe6h+nQwQTtcd8K6m6eIHR9GqOz2AwoWpsHrZB0D/en5rE4WtdomCLH
 9jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qM64BUtAr1z/gzsTM4GBdk2IcG0HXVAZX8dYXOH96BA=;
 b=ELstgiutbkY16pnJAgQiNd4Pc57xnASUDllAPoiJBgp2Oag30g0SZEiJ5Hcp0WqltY
 W8DwM+yaHLo/EWz3WwAhYExUAfP0sADc8zV3sAj2rBiNnX6lDp2AqHZ5h1HEXKIQS04F
 POa9fIuWlQhUGiSQLLFCIJO7tAFSRorvoZEVwlPiurQrjhRUa+zbEk+NiNTMg62X+hH6
 8hLH2FMlCA4TJoxZveXw9vHiwPJcHxZr9RQD8HhB5oHhfpNCkIhWzTUyQ7/bSQdIjKQf
 jk2vhWGlE099iaYaHBDF5BmSx2iX2guEuWw9osFDBfgVznUB+f8PPLenJ7Z/2LR2LGkH
 bVkA==
X-Gm-Message-State: APjAAAXPnMjDf/0B2Z22f41mDJyqplsgKXYW5E/YnUI3/PIShDc4wQhJ
 +Hi5BbxS0Yt6wtjEcLff6b/KOBlN/x4=
X-Google-Smtp-Source: APXvYqwqUbpX6PPHB0K9/5wXy3zMloZ19RB8C0BLOWDYrkejCReBbhBvEVYigW8YoF/RfQNpTwtaqw==
X-Received: by 2002:a5d:638f:: with SMTP id p15mr21851653wru.402.1581604925465; 
 Thu, 13 Feb 2020 06:42:05 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/46] target/arm: Split out aarch32_cpsr_valid_mask
Date: Thu, 13 Feb 2020 14:41:13 +0000
Message-Id: <20200213144145.818-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
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

From: Richard Henderson <richard.henderson@linaro.org>

Split this helper out of msr_mask in translate.c.  At the same time,
transform the negative reductive logic to positive accumulative logic.
It will be usable along the exception paths.

While touching msr_mask, fix up formatting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200208125816.14954-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 21 +++++++++++++++++++++
 target/arm/translate.c | 40 +++++++++++++++++-----------------------
 2 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6be8b2d1a9b..4d4896fcdcf 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1061,6 +1061,27 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
     }
 }
 
+static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
+                                               const ARMISARegisters *id)
+{
+    uint32_t valid = CPSR_M | CPSR_AIF | CPSR_IL | CPSR_NZCV | CPSR_J;
+
+    if ((features >> ARM_FEATURE_V4T) & 1) {
+        valid |= CPSR_T;
+    }
+    if ((features >> ARM_FEATURE_V5) & 1) {
+        valid |= CPSR_Q; /* V5TE in reality*/
+    }
+    if ((features >> ARM_FEATURE_V6) & 1) {
+        valid |= CPSR_E | CPSR_GE;
+    }
+    if ((features >> ARM_FEATURE_THUMB2) & 1) {
+        valid |= CPSR_IT;
+    }
+
+    return valid;
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d58c328e08e..20f89ace2fd 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2734,39 +2734,33 @@ static inline void gen_mulxy(TCGv_i32 t0, TCGv_i32 t1, int x, int y)
 /* Return the mask of PSR bits set by a MSR instruction.  */
 static uint32_t msr_mask(DisasContext *s, int flags, int spsr)
 {
-    uint32_t mask;
+    uint32_t mask = 0;
 
-    mask = 0;
-    if (flags & (1 << 0))
+    if (flags & (1 << 0)) {
         mask |= 0xff;
-    if (flags & (1 << 1))
+    }
+    if (flags & (1 << 1)) {
         mask |= 0xff00;
-    if (flags & (1 << 2))
+    }
+    if (flags & (1 << 2)) {
         mask |= 0xff0000;
-    if (flags & (1 << 3))
+    }
+    if (flags & (1 << 3)) {
         mask |= 0xff000000;
+    }
 
-    /* Mask out undefined bits.  */
-    mask &= ~CPSR_RESERVED;
-    if (!arm_dc_feature(s, ARM_FEATURE_V4T)) {
-        mask &= ~CPSR_T;
-    }
-    if (!arm_dc_feature(s, ARM_FEATURE_V5)) {
-        mask &= ~CPSR_Q; /* V5TE in reality*/
-    }
-    if (!arm_dc_feature(s, ARM_FEATURE_V6)) {
-        mask &= ~(CPSR_E | CPSR_GE);
-    }
-    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
-        mask &= ~CPSR_IT;
-    }
-    /* Mask out execution state and reserved bits.  */
+    /* Mask out undefined and reserved bits.  */
+    mask &= aarch32_cpsr_valid_mask(s->features, s->isar);
+
+    /* Mask out execution state.  */
     if (!spsr) {
-        mask &= ~(CPSR_EXEC | CPSR_RESERVED);
+        mask &= ~CPSR_EXEC;
     }
+
     /* Mask out privileged bits.  */
-    if (IS_USER(s))
+    if (IS_USER(s)) {
         mask &= CPSR_USER;
+    }
     return mask;
 }
 
-- 
2.20.1


