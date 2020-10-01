Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BC9C47425
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353852145D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PaJdwcNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353852145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO02F-0002EB-Bi
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsQ-0004hR-O4
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNzsO-0002wa-NF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:48:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id t17so3414216wmi.4
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=L8cGGYZF8QFptqVGM6K13/xYHxzFRTmMW7aqTuG9CB8=;
 b=PaJdwcNRDTZL4DkPlBTuOoU6dLh+Kr4iEKH20Dalf9KMgLRiftXX+EzkZ9Dak94pjY
 0eYMEtueNvpCxAY45zhNDBIUv08BSRTfpZgYK1xsaeGKVxQrGIKbef/2MKlpA7NzpbZU
 CdaULrvze5mltmlrimf75lMBnXRfNNq+ZsgG+XLHhuikK313a+seID6sQFSijOZCkpcW
 Ut79jDSESQPpGuG2KWDuGENF4lsDk6ql/TJcBuVfRZ01Wa2Uu5I7Doj4558gEERDo2Pl
 DqJiKAUKW9TmvNABPD59D2FrC1UWc7SbwD+vLyKbm4dFClk0/UUwg0hVtrvkFrSGE8AH
 zQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L8cGGYZF8QFptqVGM6K13/xYHxzFRTmMW7aqTuG9CB8=;
 b=eIpefoQ2rTSm6/NQJXCBnFYQ8MUheji4y+KjvkEPgBx5u2qDieCtfXf9c7BvkGLTtp
 tdfdnMXHzGUlQJ/C250vqNtSAI8Jqxob5fNjtVt8h64f9eBzkX6ULBixKfiF7AKmfIlv
 ykSkMZQAGr5LkxcRhHqWAMlGeEeDtAiFSx8EmmIVqpmMyeQ2jEGqfCV6SwgpcO/Rvieg
 UgRz/mSdQ5A8bEVnUh93N2KtewYPXAp37wRh8xr+IaOmx+faY/+se1PlTGVtWhZrzfXe
 s+9HeNG5VQj459fu14zDOkjiu2jFtY89PrFCNGfspCv1Qwo4b2u6uFteS1Gbaj32CHem
 NUhw==
X-Gm-Message-State: AOAM532LixeTb9dSZrLfC4Um3OIhuE3dBbKfu3zp4bVyHyAZEmAJBGQg
 lP77TAjbm5esX34+j1RdaSC6PU5WPPJi4qyj
X-Google-Smtp-Source: ABdhPJzniNscK/jFGugqtKDPfzbyQWhQcCr0A/P3Hcw2fDy506rquwoaaMQqFDE/wPkZcmKGEVNV7Q==
X-Received: by 2002:a1c:6055:: with SMTP id u82mr398835wmb.126.1601563686844; 
 Thu, 01 Oct 2020 07:48:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 70sm342052wme.15.2020.10.01.07.48.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:48:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/18] target/arm: Replace ARM_FEATURE_PXN with ID_MMFR0.VMSA
 check
Date: Thu,  1 Oct 2020 15:47:42 +0100
Message-Id: <20201001144759.5964-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001144759.5964-1-peter.maydell@linaro.org>
References: <20201001144759.5964-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

The ARM_FEATURE_PXN bit indicates whether the CPU supports the PXN
bit in short-descriptor translation table format descriptors.  This
is indicated by ID_MMFR0.VMSA being at least 0b0100.  Replace the
feature bit with an ID register check, in line with our preference
for ID register checks over feature bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200910173855.4068-2-peter.maydell@linaro.org
---
 target/arm/cpu.h    | 15 ++++++++++++++-
 target/arm/cpu.c    |  1 -
 target/arm/helper.c |  5 +++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6036f61d60b..14a673d8e9d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1772,6 +1772,15 @@ FIELD(ID_ISAR6, FHM, 8, 4)
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
@@ -1949,7 +1958,6 @@ enum arm_features {
     ARM_FEATURE_CACHE_DIRTY_REG, /* 1136/1176 cache dirty status register */
     ARM_FEATURE_CACHE_BLOCK_OPS, /* v6 optional cache block operations */
     ARM_FEATURE_MPIDR, /* has cp15 MPIDR */
-    ARM_FEATURE_PXN, /* has Privileged Execute Never bit */
     ARM_FEATURE_LPAE, /* has Large Physical Address Extension */
     ARM_FEATURE_V8,
     ARM_FEATURE_AARCH64, /* supports 64 bit mode */
@@ -3615,6 +3623,11 @@ static inline bool isar_feature_aa32_vminmaxnm(const ARMISARegisters *id)
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
index a7643deab41..d13a7b87175 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1588,7 +1588,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         set_feature(env, ARM_FEATURE_V7MP);
-        set_feature(env, ARM_FEATURE_PXN);
     }
     if (arm_feature(env, ARM_FEATURE_CBAR_RO)) {
         set_feature(env, ARM_FEATURE_CBAR);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88bd9dd35da..ab6ca23b64d 100644
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


