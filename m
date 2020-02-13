Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B80AC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:44:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170D42073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeGJqUI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170D42073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2FjD-0006Jc-8g
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:44:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60280)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgy-0004Pd-Gb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fgx-0001tw-Dd
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:12 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:39376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fgx-0001po-4x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:11 -0500
Received: by mail-wr1-x42b.google.com with SMTP id y11so6975711wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=e6on02dnrs5jFbqtts6LxryeASmr3K7bhWptuLVimw8=;
 b=UeGJqUI7wpuv1FObzUeoBLfEvl1ddgHcyQISgQsQtEzumcQK4j9gi5xtTvlD5eo9RX
 U3G24aqCVNYuDqaRguUGUgwK8wIsjPD4P2lMmB5c/fx2IBh9JFEHsYBINAEMogMVJfvv
 U45hlad7VoYj0FnlnZZBgSRRAqa/F+I2NTNB2MFF2ipoILPtLS5/9pcnmUZnsEbU6osO
 CtGT4v5LRQ/BWxjvlcKqInUBd6HvmmmndLUUHUSWjEPF1R7fy9u0Z1pCltxTdjw+5GNW
 noQw96kZkGhe42mXCAoxAnkVUE7W6awoW9ih0cdQlldHyDwDnkKDhtiBbR3cSjx06knX
 9tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e6on02dnrs5jFbqtts6LxryeASmr3K7bhWptuLVimw8=;
 b=EKlwcB4R0S4zw+iOG54gt94IKsHIrZQZ21qs0VLk0Q5LkrKM8j7rpf13MOPgVV3rBz
 q2QscgcXK0XqAtiQO1FfFMXXlDAAfaQM/LwOwpiBe75dAW2rmlw3fckLkFKz7D/3pgqA
 aTImDmbm70sJgHWbAUtMrzwT0Z0J8hVmn2RYmPPEn8P3uMLHZt36BpoGdL8jT7SEup1K
 TDjR11/VwcEntXeu8//HKGfekD7OMCGZXbjXJEEyiGqZLKGX+4nLmzUIlfQATfASm19E
 khIi0qJB8FdshWAsV1Al/navKB5MY90QOpcjlZdMuq7RPTDBKVf53dnNY+9NJBHFpfmM
 KJXg==
X-Gm-Message-State: APjAAAVuSbIWm+dFK/R1yFOV0SwbVCmU9eSJd7dgUgyHH+IWWErPlQnn
 ZdzXyPrLcWM4hBUCKKfF33TuUR/TM+E=
X-Google-Smtp-Source: APXvYqw2gzCgoo7maE7zT+Q7KuBG4BTnQ6YlF8/ULFoqQxoxMPui1Gpj5Z1eIAFYcBLfuHYaFpFFFg==
X-Received: by 2002:adf:8b54:: with SMTP id v20mr23157437wra.390.1581604926785; 
 Thu, 13 Feb 2020 06:42:06 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:06 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/46] target/arm: Mask CPSR_J when Jazelle is not enabled
Date: Thu, 13 Feb 2020 14:41:14 +0000
Message-Id: <20200213144145.818-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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

The J bit signals Jazelle mode, and so of course is RES0
when the feature is not enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200208125816.14954-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4d4896fcdcf..0569c96fd94 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1064,7 +1064,7 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
 static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
                                                const ARMISARegisters *id)
 {
-    uint32_t valid = CPSR_M | CPSR_AIF | CPSR_IL | CPSR_NZCV | CPSR_J;
+    uint32_t valid = CPSR_M | CPSR_AIF | CPSR_IL | CPSR_NZCV;
 
     if ((features >> ARM_FEATURE_V4T) & 1) {
         valid |= CPSR_T;
@@ -1078,6 +1078,9 @@ static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
     if ((features >> ARM_FEATURE_THUMB2) & 1) {
         valid |= CPSR_IT;
     }
+    if (isar_feature_jazelle(id)) {
+        valid |= CPSR_J;
+    }
 
     return valid;
 }
-- 
2.20.1


