Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA244C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:58:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A8020663
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 15:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKxYRIIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A8020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPSsL-0006NL-BQ
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 11:58:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSpC-0003I4-LQ; Mon, 05 Oct 2020 11:54:54 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41701)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPSp9-0001GK-24; Mon, 05 Oct 2020 11:54:54 -0400
Received: by mail-pg1-x544.google.com with SMTP id g9so5739512pgh.8;
 Mon, 05 Oct 2020 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GR5hGE0KSIO84u9/hWu+owpD5iDglpDluS9WybhO4pU=;
 b=EKxYRIIZMH2pGEktTAr76V00owp9Pw+WuDSvxzgMH2s4kqB96Zeuv1i8TY4MtC9k5C
 9zzJ5g2O99907WW/1G24zyLA7ySJCddVK2/+cSfrcMCBJiQdjGJyVzi2dx0+aYdh5497
 9gIZQDvclkWnded2MfBz8SMabIMNRx0NCB65jZNvLv3KoQCHZPoRDEHRIBbs+XLH7o7l
 on7rhFOAQI4rMJirkoA4yPhGH3ezQ04OQHAFtHd3U9/th9GpsV/Ksin9ZQaHjMY0T5dc
 5ldqraCp8hNkxd7mnVqOQib2A21e2P1hzOHIpzLkiTqKjdMZ+ihdnh1cvwPlTTrpz4TR
 a+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GR5hGE0KSIO84u9/hWu+owpD5iDglpDluS9WybhO4pU=;
 b=Z9Phga/Mmt1GVwKQQIJxZGMc3ILpn+rPheRFpON8KSOoElmlJSchEw2UGYhsiZOM6f
 SVw1ZDY+o1P0VUE8MRbpbX+xc/RP3xf6x00fRM6PeNzfKrY6LfeBWHq0/ZzyxMvZZmUD
 pM4UrmCwbmImIKqhuypJKpXYF03O4UwtOBxrNgtmJbzSlTOC+T5leUJL/doztNFo9Dsh
 pJ2TvHXabu/SVP11Y5eCFQjhFC5SiNPOdo/YgngvUzHdvS1wgjGBi804Lscm3Ksug10B
 hT8F+wWpqABeXH7M4U2bCO/KlFnAdMiZQQrRNMRwJw34SYpVp4UvRjWqVdOWuhu89SQT
 AYEg==
X-Gm-Message-State: AOAM530TYhrVZnTYQxE/DdTn7A6zUtc9Uagu0Ohwx05vmGZj0bj5X2mc
 ql8VrFyvG/sya3WOyufQwIWi4we/2ZboYg==
X-Google-Smtp-Source: ABdhPJxP3bDa+Sm3q5CbBo7HfUAPMWQzknpdP8AD/p82z8mzUZlbFSLaFMp5tdqOE8NcRfzkkdiuZA==
X-Received: by 2002:aa7:9583:0:b029:142:2501:39dc with SMTP id
 z3-20020aa795830000b0290142250139dcmr115834pfj.43.1601913288598; 
 Mon, 05 Oct 2020 08:54:48 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id z18sm311873pfn.158.2020.10.05.08.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 08:54:47 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v8 001/133] target/arm: Replace ARM_FEATURE_PXN with
 ID_MMFR0.VMSA check
Date: Mon,  5 Oct 2020 23:52:14 +0800
Message-Id: <20201005155426.413-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201005155426.413-1-luoyonggang@gmail.com>
References: <20201005155426.413-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

The ARM_FEATURE_PXN bit indicates whether the CPU supports the PXN
bit in short-descriptor translation table format descriptors.  This
is indicated by ID_MMFR0.VMSA being at least 0b0100.  Replace the
feature bit with an ID register check, in line with our preference
for ID register checks over feature bits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200910173855.4068-2-peter.maydell@linaro.org
---
 target/arm/cpu.c    |  1 -
 target/arm/cpu.h    | 15 ++++++++++++++-
 target/arm/helper.c |  5 +++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a7643deab4..d13a7b8717 100644
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
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 6036f61d60..14a673d8e9 100644
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
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88bd9dd35d..ab6ca23b64 100644
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
2.28.0.windows.1


