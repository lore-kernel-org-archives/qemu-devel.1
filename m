Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA336C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8F920658
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 01:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tLUVZZU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8F920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iy3jP-0000Ir-LN
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 20:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h7-0003s7-3q
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iy3h5-0002IX-P5
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:05:00 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iy3h5-0002BY-IE
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 20:04:59 -0500
Received: by mail-pg1-x542.google.com with SMTP id k25so5732601pgt.7
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2020 17:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KjwTFN6CUEBdRUTSe2tL6jsQUXS+xcPxOv/fxUl6Yjg=;
 b=tLUVZZU3IiiE6c+5+O4zKdTjjhqk32qAsYhjCgSlU2qPJ4+SAtvDTcOUTA7gYMQdw/
 JySPSXKxxi8OQY4RGzyDOxrD/IX8hzHhOIFYY+klJwrtqAcG0VXMjHHEaL+7M6Z1BiiD
 o6to0uWzasSzUItfAwLibSJL4G8k7E9ZASb7Gtx2X/2cV01GwWf9SrzmegM/KWsyHAai
 I6hXCoN04zFRv6yaIEu5ycEUEYEkB2ZdAz4FC2Tnh8plaJrsoNTSnZl/aKytptbbSJn+
 ztLwjaLbecxXWoQcJv99d9d4bzw+UEYO9ybfCnsnZf0ovwfNcJvzAne8xW69YxZ28bv/
 VfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KjwTFN6CUEBdRUTSe2tL6jsQUXS+xcPxOv/fxUl6Yjg=;
 b=Ocq2JbLz6td/XrqnLI+lNNxBIwCMJ3d0IFxNhurYfeHdSoropDC0yJmbvWcK/Hh33x
 f1mybl8bZGCouNVzozWhW42F0eawE6ripBYASp/Gm33cs4FxF1BF6M+5QRnp64xlgl/3
 8ErO2NveUU8WtOuO5TfhN9rksiTCWqPetNQq4Lap8oIXhciD6aS3WrfR4eRI1x+nGjML
 G+nSZMjSgA9PCkVfGINoVaht7FA7LaxCKDyCP83WQM1kt7aDAwM/RjzYL8JURJ5JEglb
 nH5CmiYlKdmdICwVqO8ifbzwZd1v/iyv0SBBfMRigjIpbwaf6psMnWQUKdlz2sqiP0er
 j0ZA==
X-Gm-Message-State: APjAAAUHoPx3qpxv/V+tGP4dlgRB1YxkOtTMUAx8FjJDoEV7Lmxq1nYJ
 YYeIDbeq3UM34VpV6QGPE4GtsaaIX90=
X-Google-Smtp-Source: APXvYqztXIAe2oOhow9VHUAT9LMCyXEx+MGAfUAOG1C5a+LVOpewkfs/E0xTo9gsIz5n2oTZHq4/5g==
X-Received: by 2002:a63:4b24:: with SMTP id y36mr17665182pga.176.1580605494507; 
 Sat, 01 Feb 2020 17:04:54 -0800 (PST)
Received: from cloudburst.WiFi.IPv4InfoBelow
 (h210.212.133.40.static.ip.windstream.net. [40.133.212.210])
 by smtp.gmail.com with ESMTPSA id 13sm14678975pfi.78.2020.02.01.17.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2020 17:04:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/14] target/arm: Add ID_AA64MMFR2_EL1
Date: Sat,  1 Feb 2020 17:04:36 -0800
Message-Id: <20200202010439.6410-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200202010439.6410-1-richard.henderson@linaro.org>
References: <20200202010439.6410-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
index b11fdc3001..a6a8f74be8 100644
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
@@ -1816,6 +1817,22 @@ FIELD(ID_AA64MMFR1, PAN, 20, 4)
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


