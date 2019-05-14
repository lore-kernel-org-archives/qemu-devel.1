Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A39AC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0591B20862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 19:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmvaCxP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0591B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53142 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQdBJ-000874-77
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 15:33:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvZ-0002kz-92
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQcvX-0007BA-Cy
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:29 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:32870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQcvV-00077v-Cq
	for qemu-devel@nongnu.org; Tue, 14 May 2019 15:17:27 -0400
Received: by mail-pg1-x544.google.com with SMTP id h17so59151pgv.0
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 12:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ztXvGPgxsfNQ6iDCN/IIJ1leMuVNwtZhgkaITTqSNbM=;
	b=NmvaCxP8/NUxTJKhpruWGlr0tMYYMFV7E7HC63sZmEEcWQ5JGtCxZreUnu9lYonhW7
	/K7oFc6yW/a9VEBSpMdrmJAX24RhNvvE8fv571LcPkSoGrBt6X8Og/+k+fZ41aeceObD
	7oezAV1fuN9v/LA7twFpZMwhYmu5ZEr3vSp4kXROofKFKPITjvrR+mE8R9CksiqIrASw
	ZZWeLt90GsGZfQScLtBs9gZfNwnaU5g6i//jfa3+f2AZo29kQs57paMLs7Ap083MsesS
	Beng3oXl1G+NxMd49SQLb2+vJN3zgdNH2/WF5tJ52jyF3vCSVl/h+3c8gleQLrld+ime
	PHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ztXvGPgxsfNQ6iDCN/IIJ1leMuVNwtZhgkaITTqSNbM=;
	b=lklb3/H3FX4Wn0P+LzSMhzAfFkzn34sbvgg+AIXdxtBBLv7G7u5BVwV9o9k8gbyD5g
	feUIXXx1X9jnJNaWLRaV/8kf49APaJqidO2AUNWys3MnM4RNaXv2ITQJ2NBwr5f6Q+1X
	fpQMDEQo3taKhfl40OcEnmBc6pZipvMuKkIj7l5WfVW5R076oNPmJd8hCDjESjPZ9WHw
	WbaQI13jGZFUWgj0ycdGpuytQEyhogqpe3Gu5oBB81hRqqbT8GyI7uxPcpU0xOSWOR6r
	L+fwMIj/WPa1rSgKdHCs7/GSG8XHpeonSloL0VaawkiqF2dIKOG+6mZupwtNmQRhbKAT
	tmNA==
X-Gm-Message-State: APjAAAW1bPCJ/OlxMbExLvoVk1K46ErAhbDLYZ2MOc2R2FevgX021cJf
	05QClEVyRLV7BSeC8D8Iadox1OWgcKs=
X-Google-Smtp-Source: APXvYqyg8Fw8K84BSlQ2CnlrHqcDrdZ5jDnHzOIxwshQItivEDX4dQ4oXeimKS6wROThOvgq2CVofA==
X-Received: by 2002:a63:6fcf:: with SMTP id
	k198mr39296225pgc.158.1557861443281; 
	Tue, 14 May 2019 12:17:23 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	o6sm18682982pfa.88.2019.05.14.12.17.22
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 May 2019 12:17:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:16:50 -0700
Message-Id: <20190514191653.31488-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514191653.31488-1-richard.henderson@linaro.org>
References: <20190514191653.31488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH v7 21/24] target/arm: Implement ARMv8.5-RNG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, berrange@redhat.com, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use the newly introduced infrastructure for guest random numbers.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  5 +++++
 target/arm/cpu64.c  |  1 +
 target/arm/helper.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 892f9a4ad2..c34207611b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3521,6 +3521,11 @@ static inline bool isar_feature_aa64_condm_5(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, TS) >= 2;
 }
 
+static inline bool isar_feature_aa64_rndr(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64isar0, ID_AA64ISAR0, RNDR) != 0;
+}
+
 static inline bool isar_feature_aa64_jscvt(const ARMISARegisters *id)
 {
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, JSCVT) != 0;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 228906f267..835f73cceb 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -310,6 +310,7 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64ISAR0, DP, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 1);
         t = FIELD_DP64(t, ID_AA64ISAR0, TS, 2); /* v8.5-CondM */
+        t = FIELD_DP64(t, ID_AA64ISAR0, RNDR, 1);
         cpu->isar.id_aa64isar0 = t;
 
         t = cpu->isar.id_aa64isar1;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7e88b2cadd..1e90f4d722 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -22,6 +22,8 @@
 #include "fpu/softfloat.h"
 #include "qemu/range.h"
 #include "qapi/qapi-commands-target.h"
+#include "qapi/error.h"
+#include "qemu/guest-random.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -5746,6 +5748,45 @@ static const ARMCPRegInfo pauth_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, keys.apib.hi) },
     REGINFO_SENTINEL
 };
+
+static uint64_t rndr_readfn(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    Error *err = NULL;
+    uint64_t ret;
+
+    /* Success sets NZCV = 0000.  */
+    env->NF = env->CF = env->VF = 0, env->ZF = 1;
+
+    if (qemu_guest_getrandom(&ret, sizeof(ret), &err) < 0) {
+        /*
+         * ??? Failed, for unknown reasons in the crypto subsystem.
+         * The best we can do is log the reason and return the
+         * timed-out indication to the guest.  There is no reason
+         * we know to expect this failure to be transitory, so the
+         * guest may well hang retrying the operation.
+         */
+        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
+                      ri->name, error_get_pretty(err));
+        error_free(err);
+
+        env->ZF = 0; /* NZCF = 0100 */
+        return 0;
+    }
+    return ret;
+}
+
+/* We do not support re-seeding, so the two registers operate the same.  */
+static const ARMCPRegInfo rndr_reginfo[] = {
+    { .name = "RNDR", .state = ARM_CP_STATE_AA64,
+      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
+      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 0,
+      .access = PL0_R, .readfn = rndr_readfn },
+    { .name = "RNDRRS", .state = ARM_CP_STATE_AA64,
+      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END | ARM_CP_IO,
+      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 1,
+      .access = PL0_R, .readfn = rndr_readfn },
+    REGINFO_SENTINEL
+};
 #endif
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6690,6 +6731,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     if (cpu_isar_feature(aa64_pauth, cpu)) {
         define_arm_cp_regs(cpu, pauth_reginfo);
     }
+    if (cpu_isar_feature(aa64_rndr, cpu)) {
+        define_arm_cp_regs(cpu, rndr_reginfo);
+    }
 #endif
 
     /*
-- 
2.17.1


