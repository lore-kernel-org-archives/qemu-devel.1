Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E450C432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3B720684
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 02:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kipn0Vqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3B720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iby8p-0008EV-RD
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 21:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxxC-0003HS-Ae
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibxx2-0008Id-TX
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:13 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38384)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibxwv-0008Df-Lb
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 21:30:01 -0500
Received: by mail-pl1-x641.google.com with SMTP id o8so1006940pls.5
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 18:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=V6eJMgEVwwwLTOsUaAZFgTn7D/MmDBjIMWbldPsAU4M=;
 b=Kipn0Vqk3WbSdKRivLTyZ9SdBjOwGpI5MWlNzXmJxrYHZFev0iXfWCwTlwviruhC0W
 avq3pHuLS6uAdmEELtYoh8AKFLCcUEw9oONpGM4v+w5+L6yjXXYNCmYEP/BZG1SQEqwh
 QwhrYtM++brPiAreSh/Wj3K3P+LzSxC0xRYpJZbgzKdABSQhNjNWMIhXQICLxisED4xE
 mTzgHkTLebcKzBFItNDGOS9v3xpPES1/z9nOP26L4WIXCnEJAsyrnO5NSPGd2C0LI9Gs
 S7xeVmc2ProIdsZcNu9Gl1yqxfzo0e3PubYjrytbiTQEaeR4NNlfVVefI15ad3R1tKs2
 HXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=V6eJMgEVwwwLTOsUaAZFgTn7D/MmDBjIMWbldPsAU4M=;
 b=aHdVBJ0YPzhhuWr9D8YCvZAyiM/23R5kAjLAQH4VMGV0GagRlEtNDMyhIz+DDpPvYP
 RkEbOm5eLmHDSvldvijGu1FjZFN0fUy6dZQYGAF2zID7A+z3eZDWwwe41jbdnHGx3wbo
 nl3WFSS72h9GIx+88OFU+bVOvo4ZFe9kfIcOwOyiTdDEwfs272IaW5VqJ7i2Jx440DoX
 0aLfgrRhG083DwxCGvSoELAXXnosZAH+xc+G33PrTDtK4+oQ6j1pHJnG9bEsjU8mTvuK
 SyyekB34PNWlun4Dibszp/mjjK/HWoN1Hwc0LsPRHfTlaxvFVAYOr86XHOGdY1K0UFj2
 3EPg==
X-Gm-Message-State: APjAAAVme3qkQE+ZAWBeNAs8kxjOUAXlGfWVoVuJSczBt0yT2wwB6bUq
 hPjIUWcMggORB5lZmfiJFwkEjww8SnI=
X-Google-Smtp-Source: APXvYqwKrM6643N2ZGeJSGw/Ipf/VUhHsDQZfcJT0WaOilx+SLLJpBTM08kdCXLF/vOjO3OpuuOFsw==
X-Received: by 2002:a17:902:9b85:: with SMTP id
 y5mr2633984plp.334.1575340199965; 
 Mon, 02 Dec 2019 18:29:59 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q22sm873695pfg.170.2019.12.02.18.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 18:29:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/40] target/arm: Rearrange ARMMMUIdxBit
Date: Mon,  2 Dec 2019 18:29:13 -0800
Message-Id: <20191203022937.1474-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203022937.1474-1-richard.henderson@linaro.org>
References: <20191203022937.1474-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

Define via macro expansion, so that renumbering of the base ARMMMUIdx
symbols is automatically reflexed in the bit definitions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5f295c7e60..6ba5126852 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2886,27 +2886,34 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
 } ARMMMUIdx;
 
-/* Bit macros for the core-mmu-index values for each index,
+/*
+ * Bit macros for the core-mmu-index values for each index,
  * for use when calling tlb_flush_by_mmuidx() and friends.
  */
+#define TO_CORE_BIT(NAME) \
+    ARMMMUIdxBit_##NAME = 1 << (ARMMMUIdx_##NAME & ARM_MMU_IDX_COREIDX_MASK)
+
 typedef enum ARMMMUIdxBit {
-    ARMMMUIdxBit_EL10_0 = 1 << 0,
-    ARMMMUIdxBit_EL10_1 = 1 << 1,
-    ARMMMUIdxBit_E2 = 1 << 2,
-    ARMMMUIdxBit_SE3 = 1 << 3,
-    ARMMMUIdxBit_SE0 = 1 << 4,
-    ARMMMUIdxBit_SE1 = 1 << 5,
-    ARMMMUIdxBit_Stage2 = 1 << 6,
-    ARMMMUIdxBit_MUser = 1 << 0,
-    ARMMMUIdxBit_MPriv = 1 << 1,
-    ARMMMUIdxBit_MUserNegPri = 1 << 2,
-    ARMMMUIdxBit_MPrivNegPri = 1 << 3,
-    ARMMMUIdxBit_MSUser = 1 << 4,
-    ARMMMUIdxBit_MSPriv = 1 << 5,
-    ARMMMUIdxBit_MSUserNegPri = 1 << 6,
-    ARMMMUIdxBit_MSPrivNegPri = 1 << 7,
+    TO_CORE_BIT(EL10_0),
+    TO_CORE_BIT(EL10_1),
+    TO_CORE_BIT(E2),
+    TO_CORE_BIT(SE0),
+    TO_CORE_BIT(SE1),
+    TO_CORE_BIT(SE3),
+    TO_CORE_BIT(Stage2),
+
+    TO_CORE_BIT(MUser),
+    TO_CORE_BIT(MPriv),
+    TO_CORE_BIT(MUserNegPri),
+    TO_CORE_BIT(MPrivNegPri),
+    TO_CORE_BIT(MSUser),
+    TO_CORE_BIT(MSPriv),
+    TO_CORE_BIT(MSUserNegPri),
+    TO_CORE_BIT(MSPrivNegPri),
 } ARMMMUIdxBit;
 
+#undef TO_CORE_BIT
+
 #define MMU_USER_IDX 0
 
 static inline int arm_to_core_mmu_idx(ARMMMUIdx mmu_idx)
-- 
2.17.1


