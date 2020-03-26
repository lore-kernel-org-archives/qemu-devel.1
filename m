Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE181C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39A320658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5jT5e3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39A320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbdE-0003ek-P1
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcC-0001q8-84
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcA-0001Eh-Vm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:44 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51267)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcA-0001EM-Qt
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:42 -0400
Received: by mail-pj1-x1041.google.com with SMTP id w9so3092401pjh.1
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xqsUthjNzD1OriitBStkzWbLURropgGL+K53ub9AoCo=;
 b=f5jT5e3okDqJogWU1nL0qewojI1O986GHmmoWkD+36Iq0ygFlCd1lPWdtKHDaePmwL
 Wf34+XObhZSN2sjEWcB/ptwoml1Tw8fkyPm+GWzPbaJbr31wNqudVgmMWrK4RMfkwjnC
 F5zf4Bl8+JhBKETgqYk5AY+kOW/jDUBrhqeI6Gn3jvBeMR+rPS2OwO86sViNtnnL3sVu
 J9s3+Wm/gLNnAnMiA2JJ0jZxYjHVfJa/2/o8EhHfD4FjmZBrUu+myegxJrRtexspMVnF
 pVcvbTlGEjqmqsk+5gmAGRCzL8B6PpjGuy5HVW73KnBtN7aeZmlmjrPwNugRoe0iVZ93
 5wMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xqsUthjNzD1OriitBStkzWbLURropgGL+K53ub9AoCo=;
 b=kmujAE205NGHC5iYmQhcLLCMRfj1wr9q5+Ng2K8lD2+IX50LIhQUF2Rk/brqdGEYbY
 KpD1Fx6goNy5eDisvHawJriH+vPiMt8eQCOO+f+jYrQfBC2Hi4zpzwG8GtScSG/a5Tpd
 TWngMc3ZjW/asRsMTRCporYkMF6FV55dapSh0ERKy04KD88ndfCKtHJYS9oh1feJE+JF
 HdSQ5RRIsPHjVpKN1EQvzxQyxIXYtsn+laTrBozFonDL/IVU3qWTcTyI41GJzl/5V67F
 GCI+jg+RYOc1F41GCphwgUOFt9jyhM8yjRx45gK2BlONwRW2pqNJRGBCsshAg/pXqhYW
 ecpw==
X-Gm-Message-State: ANhLgQ2G6V2jDaY1Q0ZjVfePw5VFNsbQzBIHR78BtNAORtJELwrga8tS
 R7DkfEFv4mCOO7uXxTMqNMA2mhklTMg=
X-Google-Smtp-Source: ADFU+vvDUm14Ygsr4QqimV3KgAH+PT9wIKmi9v9l6+fjj0Fz8SHHwfJp+uQ6+XpGO3Ht07D/LNx/vg==
X-Received: by 2002:a17:90a:2147:: with SMTP id
 a65mr2534859pje.176.1585264121421; 
 Thu, 26 Mar 2020 16:08:41 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:08:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/31] target/arm: Add ID_AA64ZFR0 fields and
 isar_feature_aa64_sve2
Date: Thu, 26 Mar 2020 16:08:08 -0700
Message-Id: <20200326230838.31112-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Will be used for SVE2 isa subset enablement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    | 16 ++++++++++++++++
 target/arm/helper.c |  3 +--
 target/arm/kvm64.c  |  2 ++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e9f049c8d8..2314e3c18c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -900,6 +900,7 @@ struct ARMCPU {
         uint64_t id_aa64mmfr2;
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
+        uint64_t id_aa64zfr0;
     } isar;
     uint32_t midr;
     uint32_t revidr;
@@ -1860,6 +1861,16 @@ FIELD(ID_AA64DFR0, PMSVER, 32, 4)
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
@@ -3839,6 +3850,11 @@ static inline bool isar_feature_aa64_ccidx(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64mmfr2, ID_AA64MMFR2, CCIDX) != 0;
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
index b3bc33db41..3767002995 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7500,8 +7500,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
index be5b31c2b0..eda4679fcd 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -555,6 +555,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                               ARM64_SYS_REG(3, 0, 0, 7, 1));
         err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64mmfr2,
                               ARM64_SYS_REG(3, 0, 0, 7, 2));
+        err |= read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64zfr0,
+                              ARM64_SYS_REG(3, 0, 0, 4, 4));
 
         /*
          * Note that if AArch32 support is not present in the host,
-- 
2.20.1


