Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3F1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B435820656
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 23:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwwIjJ/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B435820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icHql-0005WO-NS
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 18:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1icHol-00048l-I6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1icHoh-0006U2-KF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:53 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38792)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1icHof-0006Rm-S6
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 18:42:51 -0500
Received: by mail-pg1-x541.google.com with SMTP id t3so2383166pgl.5
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 15:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/dG0vms7SBwlzTpS1M8Jc87zaIsx5MqGFuBibUfxWTI=;
 b=EwwIjJ/oQT7jo5Ss3LX74mBDgAu2q4DysQI3E4xOCJan5lGbN2Fd+Vcc79UCC6//O2
 k6ZLwSK3rDnIUssYKzifUaGPafsC9m+ZhZzfdd2+6DgD5dTwB/uPFHNAV3Sb/P2VRKtk
 g/g6+5u4kum5h/BF2de/Z5fdi5aYd72bav6kyZXD5DpYUPNiSxowsSgKW1SGqQ4hPxVw
 AegURwrDSgzWt3bbELQqY+hDTtTCYj0KNOiZk0Bg6Pic2dAdoaRg1lQGWEQKQ3hmBfFz
 /10AZdAlVqUgeRp9O+aZwl5nqpR0Va1LwzYG+xZCitolkQ4Ui5XI43uewcfD5xgjfw8n
 ZY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/dG0vms7SBwlzTpS1M8Jc87zaIsx5MqGFuBibUfxWTI=;
 b=eLeTQ+mHVaP+o4RWRTB5nGRzAZxTgvWrt8nPcEnuvhhW84ZvOzrjjwjKQtWTWDDjfy
 oAfDdKRA3QL5OXvaubVBN9e0cGChpBm7iESPh9tAnS47TEQN9D6jp8GLTA1UloZHnQU2
 rhw2zVmHahVJ2cafQ0/MYZstgVzvqjGTNZRU+5OWGr62gr6wYHiI3nqrC8BLQ59Qh9b1
 alrPx+raFixeq5iMV1b3FZSV11BOsYj+zGMbTQ1YFkhrpkwmgGFCNoOYQBJDwPx4lhSd
 O/g4NvZijl0/NJsyQXbeXWfQ4vJwnfF5FWC4tySHa5KCsY1lFu1Fzurm6er3CBcuEqKr
 YmBg==
X-Gm-Message-State: APjAAAUJNfkJkOV7QoHO8UD5+va4xCq+HyNvNyYZZmF76s3fukkyiPRE
 pBIiTOl3tYM40ajAq6uluMQWpBkbJCI=
X-Google-Smtp-Source: APXvYqyAIWoESinunuq9ntkMExsoYYGL6m3FKTgxKGcDyjDaXeGZEVLhFdcZGJg9fZgXaEvhwGNnGQ==
X-Received: by 2002:a63:4e0e:: with SMTP id c14mr271849pgb.237.1575416567822; 
 Tue, 03 Dec 2019 15:42:47 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k5sm4128256pju.14.2019.12.03.15.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 15:42:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] target/arm: Add ID_AA64MMFR2_EL1
Date: Tue,  3 Dec 2019 15:42:41 -0800
Message-Id: <20191203234244.9124-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203234244.9124-1-richard.henderson@linaro.org>
References: <20191203234244.9124-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add definitions for all of the fields, up to ARMv8.5.
Convert the existing RESERVED register to a full register.
Query KVM for the value of the register for the host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 17 +++++++++++++++++
 target/arm/helper.c |  4 ++--
 target/arm/kvm64.c  |  2 ++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d403dc5947..cdf6caf869 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -864,6 +864,7 @@ struct ARMCPU {
         uint64_t id_aa64pfr1;
         uint64_t id_aa64mmfr0;
         uint64_t id_aa64mmfr1;
+        uint64_t id_aa64mmfr2;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -1778,6 +1779,22 @@ FIELD(ID_AA64MMFR1, PAN, 20, 4)
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
index f1eab4fb28..70f2db5447 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6825,11 +6825,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
index 876184b8fe..482e7fdfbb 100644
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
2.17.1


