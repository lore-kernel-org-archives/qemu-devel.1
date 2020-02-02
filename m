Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32ADC35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:07:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B111620658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvUjZoa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B111620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3jL-00008e-R2
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gu-0003VD-Nm
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3gt-0001wa-IE
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:48 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:39811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3gt-0001vK-Cc
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:47 -0500
Received: by mail-pj1-x1041.google.com with SMTP id e9so4737566pjr.4
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DvbJD7vPe2BsG6TgBfcVzI1uqZumbSEbIYT2NtMlLpk=;
 b=vvUjZoa+/LL0C/AN/0AGL5eMsk6DVxcaSHoBItCQCW5gHaov7jExUmTE812xO1cHSu
 63jS4MAump+2TtJrxusWlT+8gsdJVg1s0Mgq/f0bcPegmF2z46PA6JF67T9dfEzM0p7Q
 yhX2iMVqjyMatd6teaCrxBkmNF3mwmfYElC6w5uozqmC7hGrZAcT32e0grGcy8B07T2Z
 imkHvxr+NULmUE4Wvap4WH2bG9ZcEN/Bes7RIY8EhMg4TF5bAuxS17Duil+cnqyyRdDh
 NXgoiqNdALlB04Ofvin0KEUk4OY5AeooFjMiUvetvheNMpNo4F3+oi/92tXQl97II51w
 AEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DvbJD7vPe2BsG6TgBfcVzI1uqZumbSEbIYT2NtMlLpk=;
 b=IOd81TI473HBBhuk/54ehsXuvCmoSGTvQq81B40ndvJ2wp2ohcKMy4ExRs1mnj4sw3
 zSSU1SkNgg+uZfVjCzetQbKLZ1hO3jIIVCRoKvpyY9v7jVERhSzZEvhIV/yt0oO74X6J
 Nrw5fyIv8TLLvVDo93bXukc94bKAPVr+QWu4oS8XOKmooTF73zAEagt+KcMBcxV3FDph
 F0b47SVAEdxjX8rw61/TDjvzC2mzbb3bxwq4HpW4IbcCuwl8xkYsgNt0Z5RDPDds11zR
 NMekt7w8By7WwqasDdzNGoAOfwJTlUXoTaEcdC15hOcRqav+2d74zf5jwZoedwzQ1tC8
 Dmwg==
X-Gm-Message-State: APjAAAUefvmkb0AsAqEcU5xOI7YspH+/qWNuAg8XOQZP/YOlltdf/ETD
 5bhLKPbKvCM8YHzP73y9Hps3Q8Oarnc=
X-Google-Smtp-Source: APXvYqxvmmrktTn4csSReixRmwT3RVqVomIOIz08EHe9EsVyAXTq8UZlaAcNBogtWE/3Gkr4JePYzg==
X-Received: by 2002:a17:90a:a08e:: with SMTP id
 r14mr3673544pjp.120.1580605486112; 
 Sat, 01 Feb 2020 17:04:46 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/14] target/arm: Move LOR regdefs to file scope
Date: Sat,  1 Feb 2020 17:04:29 -0800
Message-Id: <20200202010439.6410-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 57 +++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 739d2d4cc5..795ef727d0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6343,6 +6343,35 @@ static CPAccessResult access_lor_other(CPUARMState *env,
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
@@ -7577,34 +7606,6 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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


