Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F12FC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADE12073C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 14:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rICVMN3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADE12073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Fvz-0007ej-8o
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 09:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh7-0004bH-JC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh5-00027L-EE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:21 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fh5-00025b-80
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:19 -0500
Received: by mail-wm1-x341.google.com with SMTP id c84so7036127wme.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=N9w9WsTEsHScx6Q0FxeHvpCacb1yD684WDvTiuzngFQ=;
 b=rICVMN3cUr/atWeFQ7ovy9eS31ccvpKGwuPsMiH9PfGbktUYfn8rI3NRRErNtHssx0
 yLyGMqb+qDuMutJVPKfiUU9eGN6dkwc3PYMR7PjbMRzJ8RJhPT1quD25vT+7dT0OUntw
 9+3Z5WqqnO7Ice/C5hohOcqwPHiGXzsIFi2uI8jsOSP2tA94u8bs/T2ecXNDXEO07jdS
 KeGfVh3a7fg1D+uxU14aFZa3A0gA6aObuOLTh+XP9VA/R1gIXXL1TX6FLhz0Um7hOlpI
 ZFuL6Bmhk+OY3LqVL4iwqvPazHTj8bZdiDRauy/NgsXZeca/2CL5BKPhWI0mdL4O13Rh
 IIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N9w9WsTEsHScx6Q0FxeHvpCacb1yD684WDvTiuzngFQ=;
 b=TTKslvFKpMF5LR4jHiTcDXzKjqjmo2JSYP0Fwe9sThrGN6eljJAgqTWHeDCyJMRSqg
 tfbK4AVIfEV1prNFHsJ2ayERd+C7KYyLmJC4T2JliRu4ZL+tUOwrFRsJGkVtD80JJk/j
 vqaleSoq7QOk2UcDC5jrL7f9zlC+xxHuWOPbJyx2a7/gvNY7NTjybjg0aRQ/fqTe00pf
 mAli3cgd3LwytHgO2XfZZiE9KrbzWi78HYoDjyh8LgBYFzejdk9QwPf0kamxrsHBVQjb
 gaTqNsNMjFZNq4ynzgw+7/TdWRz1/GEADRaDPsQrb5Dgn9jmRbk+zVHovf20rEOaQWCY
 iRhg==
X-Gm-Message-State: APjAAAXG9WbXVhD1A4fGzKMwGNJCNIJazVeIgHSa1DbAv2Snedd4roml
 vwb98Xn97aD8uufojHNqUcsQGc3suHk=
X-Google-Smtp-Source: APXvYqwc8dWuhKvDVwB/q0X+842iRlYTcz3jFdPWd+zJZ6+lyvxmf4JBkrXSgjEg125+UITxMo1SSg==
X-Received: by 2002:a05:600c:2150:: with SMTP id
 v16mr6091508wml.156.1581604937925; 
 Thu, 13 Feb 2020 06:42:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/46] target/arm: Add ID_AA64MMFR2_EL1
Date: Thu, 13 Feb 2020 14:41:25 +0000
Message-Id: <20200213144145.818-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Add definitions for all of the fields, up to ARMv8.5.
Convert the existing RESERVED register to a full register.
Query KVM for the value of the register for the host.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200208125816.14954-18-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 17 +++++++++++++++++
 target/arm/helper.c |  4 ++--
 target/arm/kvm64.c  |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65a0ef8cd6b..71879393c22 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -871,6 +871,7 @@ struct ARMCPU {
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
+        uint64_t id_aa64mmfr2;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -1803,6 +1804,22 @@ FIELD(ID_AA64MMFR1, PAN, 20, 4)
 FIELD(ID_AA64MMFR1, SPECSEI, 24, 4)
 FIELD(ID_AA64MMFR1, XNX, 28, 4)
 
+FIELD(ID_AA64MMFR2, CNP, 0, 4)
+FIELD(ID_AA64MMFR2, UAO, 4, 4)
+FIELD(ID_AA64MMFR2, LSM, 8, 4)
+FIELD(ID_AA64MMFR2, IESB, 12, 4)
+FIELD(ID_AA64MMFR2, VARANGE, 16, 4)
+FIELD(ID_AA64MMFR2, CCIDX, 20, 4)
+FIELD(ID_AA64MMFR2, NV, 24, 4)
+FIELD(ID_AA64MMFR2, ST, 28, 4)
+FIELD(ID_AA64MMFR2, AT, 32, 4)
+FIELD(ID_AA64MMFR2, IDS, 36, 4)
+FIELD(ID_AA64MMFR2, FWB, 40, 4)
+FIELD(ID_AA64MMFR2, TTL, 48, 4)
+FIELD(ID_AA64MMFR2, BBM, 52, 4)
+FIELD(ID_AA64MMFR2, EVT, 56, 4)
+FIELD(ID_AA64MMFR2, E0PD, 60, 4)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index d99661d4ea5..d29722d8acb 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7073,11 +7073,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = cpu->isar.id_aa64mmfr1 },
-            { .name = "ID_AA64MMFR2_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR2_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 2,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64mmfr2 },
             { .name = "ID_AA64MMFR3_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 3,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index fb21ab9e737..3bae9e4a663 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -549,6 +549,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 7, 0));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr1,
                               ARM64_SYS_REG(3, 0, 0, 7, 1));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
+                              ARM64_SYS_REG(3, 0, 0, 7, 2));
 
         /*
          * Note that if AArch32 support is not present in the host,
-- 
2.20.1


