Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEF6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5F421852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S44Ds6b0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5F421852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmFy-0008DB-Hq
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9N-0003FW-Ur
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:41 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm9K-0002Sl-Az
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:41 -0400
Received: by mail-pj1-x1042.google.com with SMTP id u8so1956471pje.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nrIaSFnyyPMIbXqZiRuw109mXnGYvmTKpfGMlwgvLXw=;
 b=S44Ds6b0BUwJkjjV8t3/mW55UuB5vYhdLWEWdX1ljAh7sBpxt+5anQnc1RrSqZfvJE
 5NmzqDEaT2RAhgb3Y08MSVdxtJ1gmDi6VsFSAF4hAnZQ/mbUU1PSCruyRgenONyGbL81
 fzYrQD038R1zrSitOBROFu3LajMmbrOobhn+uYEDkEXVTyOlWOjEGz1u6WVnu2ztB4ri
 nlNpPNB9cC+jAH/T++1VP/22dyYNuC2X/3InkFVvF8/0nqd2yRw0F0rAvBUiBGdfLgdA
 BoUsWO1WqeUtf41KtzRRNUjxSq+TNg29uTya++D6qXTivUeCgYZ16gxMwlfOgY9ws9aa
 PFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nrIaSFnyyPMIbXqZiRuw109mXnGYvmTKpfGMlwgvLXw=;
 b=R6zASJZbHRIyZhjsvXKp0dUT3TOLmQsi8w0lzsoClujwb/q0ie2taFQ1/AGEnYP/tO
 /Q7Gr4QODF/x2Qu2Zu9HRkAyl+9PVyS6luR6bQzgj8gM5Haa8IxthxJ+CODroOXECdlC
 1L+uPN4xuTfgMbLFybLeJwZohrthJAofY1UU5wT9MOEN/GdifFa+cM0lsw/g9iRVC0Yg
 YJNNhnC/4/u2plgwjBmcQPtKlvr2sLDr8gRY9VwfrppXhoLUR7DBEhVMaVkmL6ZQ7pik
 c34MpfhNdIuZsgJAbc3ECPvnhTEJZ3zs7IfX8A63AW+OrNkhbQ4oMYUyvolXe5KMBMWw
 9xtA==
X-Gm-Message-State: AOAM530/L5a+8tT1oxAyOZQio7idwdt0Zow/5HY8hanF92Yjylw9MN4J
 UjqxVpNDeuDy84JQk1Oeqso0jm5gez4=
X-Google-Smtp-Source: ABdhPJz+Oy1PTgvHHixiNZ8S3Ptd1cOHHq2TykD5I6YRJpOlwGYWCNkIPowj0HPSQo2og1qtot3g7g==
X-Received: by 2002:a17:902:102:: with SMTP id 2mr2122896plb.86.1592454455742; 
 Wed, 17 Jun 2020 21:27:35 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u61sm964897pjb.7.2020.06.17.21.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:27:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 014/100] target/arm: Add ID_AA64ZFR0 fields and
 isar_feature_aa64_sve2
Date: Wed, 17 Jun 2020 21:25:18 -0700
Message-Id: <20200618042644.1685561-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Will be used for SVE2 isa subset enablement.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Do not read zfr0 from kvm unless sve is available.
---
 target/arm/cpu.h    | 16 ++++++++++++++++
 target/arm/helper.c |  3 +--
 target/arm/kvm64.c  | 11 +++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 677584e5da..e9f56e67c7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -907,6 +907,7 @@ struct ARMCPU {
         uint64_t id_aa64mmfr2;
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
+        uint64_t id_aa64zfr0;
     } isar;
     uint64_t midr;
     uint32_t revidr;
@@ -1866,6 +1867,16 @@ FIELD(ID_AA64DFR0, PMSVER, 32, 4)
 FIELD(ID_AA64DFR0, DOUBLELOCK, 36, 4)
 FIELD(ID_AA64DFR0, TRACEFILT, 40, 4)
 
+FIELD(ID_AA64ZFR0, SVEVER, 0, 4)
+FIELD(ID_AA64ZFR0, AES, 4, 4)
+FIELD(ID_AA64ZFR0, BITPERM, 16, 4)
+FIELD(ID_AA64ZFR0, BFLOAT16, 20, 4)
+FIELD(ID_AA64ZFR0, SHA3, 32, 4)
+FIELD(ID_AA64ZFR0, SM4, 40, 4)
+FIELD(ID_AA64ZFR0, I8MM, 44, 4)
+FIELD(ID_AA64ZFR0, F32MM, 52, 4)
+FIELD(ID_AA64ZFR0, F64MM, 56, 4)
+
 FIELD(ID_DFR0, COPDBG, 0, 4)
 FIELD(ID_DFR0, COPSDBG, 4, 4)
 FIELD(ID_DFR0, MMAPDBG, 8, 4)
@@ -3846,6 +3857,11 @@ static inline bool isar_feature_aa64_tts2uxn(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr1, ID_AA64MMFR1, XNX) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 972a766730..51b97c2196 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7232,8 +7232,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              /* At present, only SVEver == 0 is defined anyway.  */
-              .resetvalue = 0 },
+              .resetvalue = cpu->isar.id_aa64zfr0 },
             { .name = "ID_AA64PFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 4, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index f09ed9f4df..ff46d8418d 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -549,6 +549,17 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
                               ARM64_SYS_REG(3, 0, 0, 7, 2));
 
+        /*
+         * Before v5.1, KVM did not support SVE and did not expose
+         * ID_AA64ZFR0_EL1 even as RAZ.  Afterward, KVM still does
+         * not expose the register to "user" requests like this
+         * unless the host supports SVE.
+         */
+        if (isar_feature_aa64_sve(&ahcf->isar)) {
+            err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64zfr0,
+                                  ARM64_SYS_REG(3, 0, 0, 4, 4));
+        }
+
         /*
          * Note that if AArch32 support is not present in the host,
          * the AArch32 sysregs are present to be read, but will
-- 
2.25.1


