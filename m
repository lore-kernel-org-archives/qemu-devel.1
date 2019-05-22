Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0512CC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73DA21473
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 19:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSh2u8/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73DA21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49844 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTWdm-0005VS-Un
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 15:11:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWOn-0008Ga-BX
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTWCU-0008Ch-8E
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:55 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:40638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTWCU-0008Bk-3l
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:42:54 -0400
Received: by mail-yw1-xc41.google.com with SMTP id 18so1241479ywe.7
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=eQF1EgwSKdQ+jEilzLu3oc5jnuWVHN3zq38+Bl8lFmE=;
	b=HSh2u8/DWaOXOeGfFCromNcDpKZGo42mmhKZKJaXRRO2/rWdn+CJvChECQ2ZfKCKTH
	PDGdHY9cmkTnRh51F2vzo81xvDADZ9FjjGUmjZUFtFPklj46UBr0X43fQdcXYcGmv9XW
	QtAH4L+rb4MIDhni+4BqQfOeA3d+FRWPWfeY38rU4WWtuRlwvZ9f/4obucFjb3zkKtgK
	exC/i22lcCBGQ0FymOqMLL1R/XpQZeGL8USh4adZ4Q158ZGsVLS3ynsr+3qL8QeWtgze
	cg4qjoOH6VVj4bCJJlIZaC+81BZlyDAnd0YE50kTZ94+q/qasfyyF3Dtni/pf9xpODAR
	qBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=eQF1EgwSKdQ+jEilzLu3oc5jnuWVHN3zq38+Bl8lFmE=;
	b=UOFas/ZbtpitvZTI/OJNFtwGL+8L3n0Lnx6GPIvCZIrcWpNhennUujM02tOxGilHh+
	lNddCNEWg2BJVxlU4AzYXa4fRfw/pzfI14ZX40wdX9H45MWJNGoyQlPqI9PzSwO/Kf60
	fJFgpUfA9WZQeGiLLwYEkxIDp8Y4v0DXdWigjf5sCUcNHL1NgbdfYFosTLaxjuuchMSJ
	GUKFivNlE4LKuoLpTLu4NRc7GmYG5CAg/PjNPB7zjp3rgyalSXcVM6G7+rFNzmmZE+xj
	KBcn2mRwf6sW3TZdRP6R7rZXVZLgP3LXgnqlUy8JbegTKqXlQ6LPSOIHZRcdIvYJB9fS
	+sCA==
X-Gm-Message-State: APjAAAUr5RC6T98kabJFd6Yj7sRlRSN8FZco4fgo/Atc2Lgbi2+DCMF1
	eYbFL8rnT4TEqtfZlhK+6hCGAMsQzkE=
X-Google-Smtp-Source: APXvYqyRWCOt7YHiFYBoRECfARfPBlPSJ26LvmXQ6mvctwRg7XLms79+Ce0gqocBF92Wy/R+xzFqhA==
X-Received: by 2002:a81:1ecd:: with SMTP id
	e196mr40520973ywe.356.1558550571662; 
	Wed, 22 May 2019 11:42:51 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id
	206sm1299445ywq.74.2019.05.22.11.42.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 11:42:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 14:42:23 -0400
Message-Id: <20190522184226.17871-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522184226.17871-1-richard.henderson@linaro.org>
References: <20190522184226.17871-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::c41
Subject: [Qemu-devel] [PULL 22/25] target/arm: Implement ARMv8.5-RNG
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
Cc: peter.maydell@linaro.org
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
index 6b91082b8b..acd23c53ca 100644
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


