Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57068C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 250C120726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LWk7/n+p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 250C120726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41073 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Plz-0001xa-6C
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgm-0000OW-8V
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgl-0004cL-4q
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:24 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43667)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgk-0004bd-VC
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:23 -0500
Received: by mail-wr1-x443.google.com with SMTP id z9so2005071wrs.10
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xngl1cCVNWBf5Cw2CDK8Z2YQwTs9m5X5G+obWGPZ0QA=;
 b=LWk7/n+pQ2K9hZ6tRT6LiceM3s6pSMhAvCYxDFMThl1whClL/r76NN8WLMhL2iVhc9
 0ACHrMdAj9QrNNldc2fwWnR6B6ozWr7/yWznfyjnpuv5EnGHoXP/4YJreiW06u7Dif9X
 vG5ya3O3SiUlyIlo3NxFhnEqPTtvh/6EhKoMzn8EV2Bb2jELNgfhCUYReP0OtVqVH2wP
 E9njuPVvrP8E4lvB+j1LUZ2jQ1kRtdWu95vcZLxZ/TBHiiSu81e1VbiqWpzu1YL8JL5a
 R78IAEchsbjYHBD1/KsPqyKe+xJ6MeYK2Wnek9cGaQ8OKijVEOYr6k9MAryJW2qEpRB+
 vztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xngl1cCVNWBf5Cw2CDK8Z2YQwTs9m5X5G+obWGPZ0QA=;
 b=VxqkYJw3UnxNKcNITemFv1j5aeanvcSrynB2LNBnJL2eyoF8Lx++frhrqueOIOO9IZ
 MVRG8mLOIkwOhDlrV9N5O+T/56QBnm/E7opEAzPAGKCbEFaFCA28AmDkRaGgih7PMbRh
 wPtbSvvZIvq82hIv2mSsNfQ9xd7k9IHN+pwSIQFUkaJsnTDC5UOgnVdJfuGfeAzn6Feq
 SWDYUuJSSWCjPdJs5TLf2F/nHeplWBea0sH8EFYZpQtE9++8L+r+n5ds/pN+NMilsl3D
 LxObe2jEW17Vr0bKkU+zPiFBxWsEmVLrY3dy5bsZj2EwnCXcCQNPmSRLfsdxZHy8b2Ic
 OMEQ==
X-Gm-Message-State: APjAAAVZk/gmKFHeDuka9uIXaIcfEsHhFxKwOjHjN43phcUlqAkhVetT
 hJShjyenbHM0rdaaK4AxVKW6BF8aIblaXw==
X-Google-Smtp-Source: APXvYqxH+4Fl2E4r0Ui/u+sEBiyCOfEnuHWOOhBzBuSYNk0Fb9sqpYh64Re/fnD1FawttHKf+R8KKw==
X-Received: by 2002:a5d:6ac4:: with SMTP id u4mr5299408wrw.318.1581166701812; 
 Sat, 08 Feb 2020 04:58:21 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 04/20] target/arm: Move LOR regdefs to file scope
Date: Sat,  8 Feb 2020 12:58:00 +0000
Message-Id: <20200208125816.14954-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

For static const regdefs, file scope is preferred.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 57 +++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index bfd6c0d04b..e4f17c7e83 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6334,6 +6334,35 @@ static CPAccessResult access_lor_other(CPUARMState *env,
     return access_lor_ns(env);
 }
 
+/*
+ * A trivial implementation of ARMv8.1-LOR leaves all of these
+ * registers fixed at 0, which indicates that there are zero
+ * supported Limited Ordering regions.
+ */
+static const ARMCPRegInfo lor_reginfo[] = {
+    { .name = "LORSA_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 0,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
+      .access = PL1_RW, .accessfn = access_lor_other,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
+      .access = PL1_R, .accessfn = access_lorid,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
+    REGINFO_SENTINEL
+};
+
 #ifdef TARGET_AARCH64
 static CPAccessResult access_pauth(CPUARMState *env, const ARMCPRegInfo *ri,
                                    bool isread)
@@ -7568,34 +7597,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
     }
 
     if (cpu_isar_feature(aa64_lor, cpu)) {
-        /*
-         * A trivial implementation of ARMv8.1-LOR leaves all of these
-         * registers fixed at 0, which indicates that there are zero
-         * supported Limited Ordering regions.
-         */
-        static const ARMCPRegInfo lor_reginfo[] = {
-            { .name = "LORSA_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 0,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LOREA_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 1,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORN_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 2,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORC_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 3,
-              .access = PL1_RW, .accessfn = access_lor_other,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            { .name = "LORID_EL1", .state = ARM_CP_STATE_AA64,
-              .opc0 = 3, .opc1 = 0, .crn = 10, .crm = 4, .opc2 = 7,
-              .access = PL1_R, .accessfn = access_lorid,
-              .type = ARM_CP_CONST, .resetvalue = 0 },
-            REGINFO_SENTINEL
-        };
         define_arm_cp_regs(cpu, lor_reginfo);
     }
 
-- 
2.20.1


