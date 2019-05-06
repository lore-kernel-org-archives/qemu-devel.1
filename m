Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E94C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A48622082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 17:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sHvcnbl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A48622082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60084 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNhiZ-00052L-Qc
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 13:47:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVV-0001P3-4Z
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNhVS-0001bn-7o
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:29 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNhVQ-0001Y1-C7
	for qemu-devel@nongnu.org; Mon, 06 May 2019 13:34:25 -0400
Received: by mail-pg1-x542.google.com with SMTP id h17so818712pgv.0
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 10:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=C88Ei/VihHBAOteN7bDmsYhjQHUxDozERJjKlZZiWa8=;
	b=sHvcnbl3E2ZWklsiprgp0xlEK/K7eAg6GixcuLtR3Tp/kBdNtfHYZsgPBZ+R3hSlfs
	qwvWwpIMH3mzRoU4wVKCaeW5d4UO+pd1ZCa+Yzr4P+QeglKYAceTB4aM8UxCH9IrD/CB
	F3kPQ4pH/tFyBrktkhjjTsEgk3Vgguy2jSNYsXoEnlXz0P61tgiYg/1hEdV3HIROB1o+
	UxnOsnwGphporYoystRo4lJk3w7NU43OAsWM/G3zRT5VWlVeNopuovWCbQkUGat3l7WS
	o+ucNAT65YDsTxN+MzFbqRaPSGpUsC4AbtvYA5vxN3C/YKKgJmE8amaBMtCU5Zb3a+Rc
	U8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=C88Ei/VihHBAOteN7bDmsYhjQHUxDozERJjKlZZiWa8=;
	b=UdQL6tJeRChz1APzVnFwVzYHdhlQeGPesXAri+VtKtYQJETg47ub9QWWW+mChB+3sE
	nHq50DvYojfarf8+K+teB4dvy9Z2tnoi60BBTgE7i9yO2CCh9yNx5Iem8GRb3YNnmn0J
	D8H3ptViplRie2+CB5xypt2S08wMzjCyzEBwDRbybMdgchvpRpirbjUx2Gzslbyoaamw
	xQ0lcOCLVfdrTci/ZSBraflz6EY9vnNo00Z/lxEkNH5Y8c5GwTaHZIvXICV9lshqEXUw
	U4UFAKZjRmVUqQzj7YaBFQAmckyHCKFZECHMcw4QdPU25VlHxgI25E82OFG/VMaSaq+K
	p5EQ==
X-Gm-Message-State: APjAAAUGCfzZMQkne8zFlIt15901YZ3ICs6zKY2xXWdBqefgW09ZT73y
	MSpF/vMw+WW1ufa3b7FQz8UxXRDBK3E=
X-Google-Smtp-Source: APXvYqwD+vvnkVZxdnKS6l/6N0i+a0Nk2m8JPwyPhqt0G/bb5nVSt3ygEePfIvvhC9jNGpTzbAblhA==
X-Received: by 2002:a63:ed4f:: with SMTP id m15mr33935349pgk.387.1557164061922;
	Mon, 06 May 2019 10:34:21 -0700 (PDT)
Received: from localhost.localdomain (97-113-189-189.tukw.qwest.net.
	[97.113.189.189]) by smtp.gmail.com with ESMTPSA id
	k9sm2268839pfa.180.2019.05.06.10.34.20
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 06 May 2019 10:34:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  6 May 2019 10:33:51 -0700
Message-Id: <20190506173353.32206-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506173353.32206-1-richard.henderson@linaro.org>
References: <20190506173353.32206-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v4 22/24] target/arm: Implement ARMv8.5-RNG
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v3: Log errors with -d unimp, for lack of a better flag.
---
 target/arm/cpu.h    |  5 +++++
 target/arm/cpu64.c  |  1 +
 target/arm/helper.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9448a76186..5c228fee8e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3510,6 +3510,11 @@ static inline bool isar_feature_aa64_condm_5(const ARMISARegisters *id)
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
index 658a5a9822..3824778dab 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -21,6 +21,8 @@
 #include "fpu/softfloat.h"
 #include "qemu/range.h"
 #include "qapi/qapi-commands-target.h"
+#include "qapi/error.h"
+#include "qemu/guest-random.h"
 
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
@@ -5722,6 +5724,45 @@ static const ARMCPRegInfo pauth_reginfo[] = {
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
+      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 0,
+      .access = PL0_R, .readfn = rndr_readfn },
+    { .name = "RNDRRS", .state = ARM_CP_STATE_AA64,
+      .type = ARM_CP_NO_RAW | ARM_CP_SUPPRESS_TB_END,
+      .opc0 = 3, .opc1 = 3, .crn = 2, .crm = 4, .opc2 = 1,
+      .access = PL0_R, .readfn = rndr_readfn },
+    REGINFO_SENTINEL
+};
 #endif
 
 static CPAccessResult access_predinv(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -6666,6 +6707,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


