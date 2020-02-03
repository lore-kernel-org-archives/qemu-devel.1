Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06113C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:55:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C337C2082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgremrvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C337C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyd8G-0005Wa-V3
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0j-00079n-KQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyd0i-0003NN-FM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyd0i-0003Lr-7z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:47:36 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so16197249wmj.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 06:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wrkzS6FRdoEngMPC4+Uz0wTjeXPKrRoSSZpCbAQkd2I=;
 b=jgremrvH46XWHnkFF9TFiUtcMcONvE0F2XV8SUqEwKWzcDDgPWD7Z3duoxnST+vaJk
 bbFmpaCrdtikrFMCnJItFCFU2ES3CVOgivs/kRm4tP+bQM6V/OhxXlkte9W4gOfd01lU
 XgiMZ2JsnDlvFUP56atlBqjzrvjFPNgErOyycgIF9olKsNI2jYLyV/0s23BuL8oy8/uY
 KBNdKWrYIQNluk9OQSlo/EmNUD7hZZvxRtQ7uju4jbJwpWyTlKwW6EX8RRoErCLuULb5
 KFzQcWJurO0SZXQ8YveWRbmZCITjuTl3x6VUOx4/V8jtIxlXBcKykryEekOuUKnVUI8O
 0+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wrkzS6FRdoEngMPC4+Uz0wTjeXPKrRoSSZpCbAQkd2I=;
 b=FR4waD/ZDEKqnnKaOG5kZJz7WpSOBfTuqYu9KJSJJL4CzF7CvqRS5e00UX7NaA19v+
 zwOdoOG/f9ovHMd11phTDc+ZZpeN5jEDQOA88z+hE2dXoISENX9z0hbs5x6trNrRAQGv
 RpfVsYfFajE/Q8CEtHNJzK1LEhdkmFrFKlQmag8NMHMgBHgK/jIwVKyiOo2p9ErX4RJw
 tRyNeYq8CxolJDx0d6Bqq0EXt2K4iAhIuMj+MXNTd4Z3RwyxFUTjNLh5ai1MjvY0LQ2q
 xFpwLMJnG3J0JtnuMbFRuqLAOvRv/MNbgNB7WZJ9xeGZIMiRwtFi6Zn7HS5ICf5MYQVM
 2Mhw==
X-Gm-Message-State: APjAAAUlGjogU3rG2BI40j5gKtOvl6/4vOItliRVjL5VYgw/qWwOvqzD
 8lXcxcgpxbds+lPeJhvTP2D6bY5v45OjGQ==
X-Google-Smtp-Source: APXvYqxQfdoq4ol+peGQwPnJ0QtyheU7OJgee53HQrJ7Z4Vr+7MSEpG2gg3WVyu6qS5awcSv93qs8A==
X-Received: by 2002:a05:600c:2c13:: with SMTP id
 q19mr30318792wmg.144.1580741255001; 
 Mon, 03 Feb 2020 06:47:35 -0800 (PST)
Received: from cloudburst.c.hoisthospitality.com ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id h2sm26429739wrt.45.2020.02.03.06.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 06:47:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/20] target/arm: Add ID_AA64MMFR2_EL1
Date: Mon,  3 Feb 2020 14:47:13 +0000
Message-Id: <20200203144716.32204-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203144716.32204-1-richard.henderson@linaro.org>
References: <20200203144716.32204-1-richard.henderson@linaro.org>
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add definitions for all of the fields, up to ARMv8.5.
Convert the existing RESERVED register to a full register.
Query KVM for the value of the register for the host.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 17 +++++++++++++++++
 target/arm/helper.c |  4 ++--
 target/arm/kvm64.c  |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 65a0ef8cd6..71879393c2 100644
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
index e69cde801f..a48f37dc05 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7082,11 +7082,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
index fb21ab9e73..3bae9e4a66 100644
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


