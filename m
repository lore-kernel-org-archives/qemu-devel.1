Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93975C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F00C206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 17:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aRJZoQEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F00C206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQYP-0005mV-7T
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 13:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQXM-0003tj-6H
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:39:08 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGQXJ-0002nJ-Lg
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 13:39:07 -0400
Received: by mail-wr1-x441.google.com with SMTP id t10so7738343wrv.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yrb435SyHhRGm1EucboctVOMgvMxS5WyjB6BP+Kvcd0=;
 b=aRJZoQECV3V+9Om8kMKrD61gHhCIOwhhv4/7pKpind93deQArKPxJZHSDyByWCwL2m
 Z1kf8ohN3bJnOw+9sDlIJDZsYgLAFH8bVQN+Qc2VxkGB61iaEo2xmNE+uJkytJwr/qDC
 C/1YDTVAdG7JhyMcuCeOa3C1HuZmd71WTFFHkEd/6HOHRaSakLgz/p14TTxOTkdBNduJ
 LmjNnKMGeb5owvIhtzZHu5sL6SpURvkhx9kCidu51+1ox0IFE+kZCsE0l7G0uCtaPtY0
 Bdn8bUiVWJ3HsXFmm8vLd1/VpfR4UcY6nQKK+UROroeC9WkAw9hkyZiF+za2D0DxZRcg
 ZiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yrb435SyHhRGm1EucboctVOMgvMxS5WyjB6BP+Kvcd0=;
 b=a971Tz6q9wC3XPUWb71ly7QMl6WuGVF3FPHK4gOtIXP1s+XS78e/ZFwFBSeV7Ion2E
 y3ppstZ5dHhI+o7/2w6zhN1Qv6nrs8tGpHs/ium2DHwMLCyPrJjrjc5gF+zLqhZskRib
 lmwxFNqLSrS371SzTF14CK90Mqd5L8o2QnkGIdJZnzE7AywpJv7v+tPK0hw3yEdh3XdD
 1d5x1jUdfO5xp5Tv+m1y/RusQmfB7uBYK87WoRF3M+TK9BtkNv6IZpLLG1i3zfYgiorD
 wmSWZR7KqQrnNNHQG7h0Apthfb4EimW3axWqLlptZ6LOJO+6X4EiUyoVyQd14fTYGq6q
 OSYg==
X-Gm-Message-State: AOAM533LgkFBHoyO4LVku2meQcYujbmzARp7buZ5/ynyLHmLCjfxauws
 qywpRJr11IBjGk85m2YW3JaIU1Gml59CNC2A
X-Google-Smtp-Source: ABdhPJwysux6giTy3tYdt7Z2nZVkEgydjb+8D1NYocjIh9+yP//sp5gssNrUxfvnhqGcCMQo7PPkzg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr9983889wrt.32.1599759541467; 
 Thu, 10 Sep 2020 10:39:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q186sm4603128wma.45.2020.09.10.10.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 10:39:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/5] target/arm: Replace ARM_FEATURE_PXN with ID_MMFR0.VMSA
 check
Date: Thu, 10 Sep 2020 18:38:51 +0100
Message-Id: <20200910173855.4068-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200910173855.4068-1-peter.maydell@linaro.org>
References: <20200910173855.4068-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ARM_FEATURE_PXN bit indicates whether the CPU supports the PXN
bit in short-descriptor translation table format descriptors.  This
is indicated by ID_MMFR0.VMSA being at least 0b0100.  Replace the
feature bit with an ID register check, in line with our preference
for ID register checks over feature bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 15 ++++++++++++++-
 target/arm/cpu.c    |  1 -
 target/arm/helper.c |  5 +++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index a1c7d8ebae5..b7c2615b2fe 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1775,6 +1775,15 @@ FIELD(ID_ISAR6, FHM, 8, 4)
 FIELD(ID_ISAR6, SB, 12, 4)
 FIELD(ID_ISAR6, SPECRES, 16, 4)
 
+FIELD(ID_MMFR0, VMSA, 0, 4)
+FIELD(ID_MMFR0, PMSA, 4, 4)
+FIELD(ID_MMFR0, OUTERSHR, 8, 4)
+FIELD(ID_MMFR0, SHARELVL, 12, 4)
+FIELD(ID_MMFR0, TCM, 16, 4)
+FIELD(ID_MMFR0, AUXREG, 20, 4)
+FIELD(ID_MMFR0, FCSE, 24, 4)
+FIELD(ID_MMFR0, INNERSHR, 28, 4)
+
 FIELD(ID_MMFR3, CMAINTVA, 0, 4)
 FIELD(ID_MMFR3, CMAINTSW, 4, 4)
 FIELD(ID_MMFR3, BPMAINT, 8, 4)
@@ -1952,7 +1961,6 @@ enum arm_features {
     ARM_FEATURE_CACHE_DIRTY_REG, /* 1136/1176 cache dirty status register */
     ARM_FEATURE_CACHE_BLOCK_OPS, /* v6 optional cache block operations */
     ARM_FEATURE_MPIDR, /* has cp15 MPIDR */
-    ARM_FEATURE_PXN, /* has Privileged Execute Never bit */
     ARM_FEATURE_LPAE, /* has Large Physical Address Extension */
     ARM_FEATURE_V8,
     ARM_FEATURE_AARCH64, /* supports 64 bit mode */
@@ -3618,6 +3626,11 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr2, MVFR2, FPMISC) >= 4;
 }
 
+static inline bool isar_feature_aa32_pxn(const ARMISARegisters *id)
+{
+    return FIELD_EX32(id->id_mmfr0, ID_MMFR0, VMSA) >= 4;
+}
+
 static inline bool isar_feature_aa32_pan(const ARMISARegisters *id)
 {
     return FIELD_EX32(id->id_mmfr3, ID_MMFR3, PAN) != 0;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index c179e0752da..c5e86ce50af 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1589,7 +1589,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         set_feature(env, ARM_FEATURE_V7MP);
-        set_feature(env, ARM_FEATURE_PXN);
     }
     if (arm_feature(env, ARM_FEATURE_CBAR_RO)) {
         set_feature(env, ARM_FEATURE_CBAR);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 44d666627a8..ef6eaf6450f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10537,6 +10537,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
                              target_ulong *page_size, ARMMMUFaultInfo *fi)
 {
     CPUState *cs = env_cpu(env);
+    ARMCPU *cpu = env_archcpu(env);
     int level = 1;
     uint32_t table;
     uint32_t desc;
@@ -10563,7 +10564,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         goto do_fault;
     }
     type = (desc & 3);
-    if (type == 0 || (type == 3 && !arm_feature(env, ARM_FEATURE_PXN))) {
+    if (type == 0 || (type == 3 && !cpu_isar_feature(aa32_pxn, cpu))) {
         /* Section translation fault, or attempt to use the encoding
          * which is Reserved on implementations without PXN.
          */
@@ -10605,7 +10606,7 @@ static bool get_phys_addr_v6(CPUARMState *env, uint32_t address,
         pxn = desc & 1;
         ns = extract32(desc, 19, 1);
     } else {
-        if (arm_feature(env, ARM_FEATURE_PXN)) {
+        if (cpu_isar_feature(aa32_pxn, cpu)) {
             pxn = (desc >> 2) & 1;
         }
         ns = extract32(desc, 3, 1);
-- 
2.20.1


