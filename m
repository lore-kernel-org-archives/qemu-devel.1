Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD20C3F68F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DEC92082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amx+EMl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEC92082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd5P-00076E-M0
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:52:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0X-0006dM-A5
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0W-00038Q-3d
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:25 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0V-00036z-Tc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:24 -0500
Received: by mail-wr1-x444.google.com with SMTP id u6so5256987wrt.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rcege1rdFln5muDzfVSDtjPu75r3ILD97R1ciS/AOgA=;
 b=amx+EMl5MXhSrDDM1ZFSxPxcO0+OkPK0A2scXiRGdXU3AVHs4ZBU9cWfSkR1jHsELM
 um+A1zkrcVRHPvbc2jAn+jYc59/v8PZSfPt0wQf3aTGpxOPyApdI9nRCWPv9bvsgEH7b
 FmYOyzhMhNNkgoJ9mBY1ctnq9oBBy2yDMITTF4kWXkr/Nyg8VPE7XPZBDZxkMiLmlSxB
 cqxJvnTvx70rIPrgWQLvSoSxgpgaK6OCJ1J7Ld8rtIJxfUz2y/P3TW748JFKJaXVEI/8
 8tRooDY8KpOGGrwQObxSVzHN3NdreyGu8wf1Yi2ajufvEA9qNzlj6pdIbth0tDrDkWs7
 NpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rcege1rdFln5muDzfVSDtjPu75r3ILD97R1ciS/AOgA=;
 b=nJ3Kfj6mS0RVYk9hqz+EdlfAe7UdIUn/hBFx8p/nivrS62Z4BEIQIhE2sIKVyvADE1
 sZPYh0h7LOb/8NhqNiRlogCNgIxq+1gk38qwtST8O4n+wiLlleZ3DzaT7koxzcSwJmsS
 pfUowIOfPS7cR9CbIsdGVgNzy2gQNG+raR8RDxKBLWHba44fkNkYFcrKxLqArr2Pn137
 YQn/dGKwZDoJpOhqhRC+lFia5U64+ZV/EV0k+zw5K9C4YdVrXX1/UALOBBJSyzy0J59P
 xQ4jLy5TD04HYBpNbW+0BUeSAp1q8ph8M5JAGDcF60q6v7Yh/pIWamPoH4xpsrqREXPx
 RzUw==
X-Gm-Message-State: APjAAAVvGxuZBw4XfTEQqjQ8px2L9+vWNTAAToM10F4+6N/z77KMoeYo
 kWQTZ9xoOOnn9It4N+KxiE2VUdj6431SKw==
X-Google-Smtp-Source: APXvYqzZrSn59xpf0uxJ72KCLFL1NvLd9x8bUMo8eRVFuT6gwtwwL/Wqad4zHkNqjq/3f6ZARGHvfQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr15580983wrq.51.1580741242760; 
 Mon, 03 Feb 2020 06:47:22 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/20] target/arm: Split out aarch32_cpsr_valid_mask
Date: Mon,  3 Feb 2020 14:47:01 +0000
Message-Id: <20200203144716.32204-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Split this helper out of msr_mask in translate.c.  At the same time,
transform the negative reductive logic to positive accumulative logic.
It will be usable along the exception paths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 24 ++++++++++++++++++++++++
 target/arm/translate.c | 17 +++--------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 6be8b2d1a9..0569c96fd9 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1061,6 +1061,30 @@ static inline bool arm_mmu_idx_is_stage1_of_2(ARMMMUIdx mmu_idx)
     }
 }
 
+static inline uint32_t aarch32_cpsr_valid_mask(uint64_t features,
+                                               const ARMISARegisters *id)
+{
+    uint32_t valid = CPSR_M | CPSR_AIF | CPSR_IL | CPSR_NZCV;
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
+    if (isar_feature_jazelle(id)) {
+        valid |= CPSR_J;
+    }
+
+    return valid;
+}
+
 /*
  * Parameters of a given virtual address, as extracted from the
  * translation control register (TCR) for a given regime.
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d58c328e08..032f7074cb 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2747,22 +2747,11 @@ static uint32_t msr_mask(DisasContext *s, int flags, int spsr)
         mask |= 0xff000000;
 
     /* Mask out undefined bits.  */
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
+    mask &= aarch32_cpsr_valid_mask(s->features, s->isar);
+
     /* Mask out execution state and reserved bits.  */
     if (!spsr) {
-        mask &= ~(CPSR_EXEC | CPSR_RESERVED);
+        mask &= ~CPSR_EXEC;
     }
     /* Mask out privileged bits.  */
     if (IS_USER(s))
-- 
2.20.1


