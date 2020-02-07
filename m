Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D1CC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8DDE20720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eOM3OIX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DDE20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04tW-00083O-TG
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hr-0000Jh-DH
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04hq-0002qy-8p
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:07 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04hq-0002pI-26
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:06 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so2954711wrt.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+7+Ixs7QmaR6uOEHjOzoEs2YwYAR1dd5H/bLNl8eCSk=;
 b=eOM3OIX+2bDB14hbGycd7e19LhWEAv/vtAOkh8m52imwV7P9sCglkaJ9T0IYjoE/Vi
 1hydJkTh04HRNFlv72fAkCYjEag97F0ezDVTfIGsPFY4HOc3l+uSy25xmbhm1ESyoFoi
 7xv+fCN9r+k6wlj1XKz9JcB2vT4qzrTgYpLsDyrKqpbjomD5Eg90xhL/endcdgJ+FYqj
 Bff+kEPQ32dqb1h43PNURIrWYsMDmJXBHxRmGjNFIXFoGsfIlE6aDohgCKMN3ucC/VBY
 Xtzf5IKfmfrbCbTLZwe3iV4NkwOX0woAY3Nbej9PNdaWCaMyv/DjYaA3aQjIf4l48zOI
 C+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+7+Ixs7QmaR6uOEHjOzoEs2YwYAR1dd5H/bLNl8eCSk=;
 b=VRsfEfwBQkDKKOwXGvumSK9LXRX2CQh1Bm/wu2r+KKPC6aPAr4lPrOL0jYkxaluLOg
 tpXgOHPxGsq88qwoYzIpN4VeIHRvr1EntLcCidVt12B1UPxIPYHN5lFpKvGmxhnza56i
 HImC1wqwdIOKZXnhjxnOKgeHTg3a7xoi126OVAzWxdFmrxTQmNlHk69UZHTNALhWXWVW
 edvH1j+6oernlfp1hBU18WPaOeFgY2JiR1gCaRjbzzmly+XxDRaJ3uRjRxSMGs+ceX7j
 i7nPaHxstJ/EOIp/KxH95+KQM7gMNQ7H9RFqTJdlJW6KtSyogd4rJ2bjkul+IzgKoFDE
 jXfw==
X-Gm-Message-State: APjAAAUWvr6qK7fkAG2lqDKpLgTCIks/1ywM6ZUEruPdzYovYecz/701
 x5SrdvGFckzBEa0h7SmAo904dkG500U=
X-Google-Smtp-Source: APXvYqy9xiNd31d7M8XxvtriiJO1j+ekFlZQPciQZu+R9bcC9fnnsjlW4b5gmHr7hlbEPTgqU5s9FQ==
X-Received: by 2002:adf:e542:: with SMTP id z2mr5040847wrm.346.1581086044825; 
 Fri, 07 Feb 2020 06:34:04 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:04 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/48] target/arm: Rearrange ARMMMUIdxBit
Date: Fri,  7 Feb 2020 14:33:13 +0000
Message-Id: <20200207143343.30322-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Define via macro expansion, so that renumbering of the base ARMMMUIdx
symbols is automatically reflected in the bit definitions.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index aa9728cff62..aa121cd9d0a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2927,27 +2927,34 @@ typedef enum ARMMMUIdx {
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
-    ARMMMUIdxBit_E10_0 = 1 << 0,
-    ARMMMUIdxBit_E10_1 = 1 << 1,
-    ARMMMUIdxBit_E2 = 1 << 2,
-    ARMMMUIdxBit_SE3 = 1 << 3,
-    ARMMMUIdxBit_SE10_0 = 1 << 4,
-    ARMMMUIdxBit_SE10_1 = 1 << 5,
-    ARMMMUIdxBit_Stage2 = 1 << 6,
-    ARMMMUIdxBit_MUser = 1 << 0,
-    ARMMMUIdxBit_MPriv = 1 << 1,
-    ARMMMUIdxBit_MUserNegPri = 1 << 2,
-    ARMMMUIdxBit_MPrivNegPri = 1 << 3,
-    ARMMMUIdxBit_MSUser = 1 << 4,
-    ARMMMUIdxBit_MSPriv = 1 << 5,
-    ARMMMUIdxBit_MSUserNegPri = 1 << 6,
-    ARMMMUIdxBit_MSPrivNegPri = 1 << 7,
+    TO_CORE_BIT(E10_0),
+    TO_CORE_BIT(E10_1),
+    TO_CORE_BIT(E2),
+    TO_CORE_BIT(SE10_0),
+    TO_CORE_BIT(SE10_1),
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
2.20.1


