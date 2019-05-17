Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19BDC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA3A20848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 17:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsNKYk4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA3A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRgvN-0002mq-VH
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 13:45:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgqy-00082T-Ld
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRgqu-0003IO-J4
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRgqq-0002v2-T9
	for qemu-devel@nongnu.org; Fri, 17 May 2019 13:41:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id m3so7832342wrv.2
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=Qyh9QRofBjuXAYy2j4FsTuWpdCj9fZJCXoA469HqUHk=;
	b=bsNKYk4R/MBsNaGj2AZlQYTfBpoUNo5zdvxpGcorOY1dyNNvio7yaB1xh0wzIcsFgZ
	jznO5LYvWDwPEVPj5laOBYeSlGGT41fRcgJuB9g5NHTpHVjn9nvR8x2nMb5TFES/2bON
	hS51k/R3yPtK9ctNACuvio1IipK7cEuMdBtB9ZaY7ym1uJSjuVB5Isb7HLQ8aKcGH2Cj
	FENbFRGDS0YaAxe5fvYrawgxXg20IyjfOxDT37ab+T7dmtw8tC5IAhNoob7ot5Lv9d6q
	i+WtZwLj7C7iWBQU+ldSOv9PxkehKGK5K24Qw5OvrpPaY7MKD4tJZe+FTIBVu1ke76qZ
	OEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Qyh9QRofBjuXAYy2j4FsTuWpdCj9fZJCXoA469HqUHk=;
	b=kfqQvpekh4sp8MtRsa/kRH9GmvS9wXlpwyVsvirnQT9kAWlyaiawpi3udvrM/8AX9q
	lyBRd8VpJI6Vm1w0UJoVfqNQSWzsvi8ShcBGAOyvIlqcINtr0ML7QMFtbTPq/waoR8He
	Sd6pE710jXrixCWyfHiP2HoAZj5QgqmAuHrWqOBXNDEHEbCk3Oyt2IxcWhrnA31jnxQo
	Et+12ZBMoRvCQ58/Rrhe0p7Ycd1xeIA5l1EQWS8g/Sc/H1bXvQRhmUO1OxXHmfhnhkld
	UYb/epASWdcWzK2KAl9+vM3Zlktr8JA6MIi/DPq24XVBS3J4euc3QLJ8Wn4VFkQeAH6P
	1t/w==
X-Gm-Message-State: APjAAAWk/wlViYBQHIZOgNWFZrpA8iYN4lOEe8AyrrAzevvYAVPXa8FC
	Mak+EKK71HafvrPl1WixDN+XLLmquP0=
X-Google-Smtp-Source: APXvYqwAdqenrWcdn82f3UQlbUEWBKxBHQ5/rEHOmikuBbywOXn436fHisoalMSo39kD2d+g35TsOg==
X-Received: by 2002:a5d:534b:: with SMTP id t11mr19267565wrv.297.1558114850121;
	Fri, 17 May 2019 10:40:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	y18sm5418641wmd.29.2019.05.17.10.40.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 10:40:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:40:43 +0100
Message-Id: <20190517174046.11146-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517174046.11146-1-peter.maydell@linaro.org>
References: <20190517174046.11146-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH 1/4] target/arm: Allow VFP and Neon to be
 disabled via a CPU property
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow VFP and neon to be disabled via a CPU property. As with
the "pmu" property, we only allow these features to be removed
from CPUs which have it by default, not added to CPUs which
don't have it.

The primary motivation here is to be able to optionally
create Cortex-M33 CPUs with no FPU, but we provide switches
for both VFP and Neon because the two interact:
 * AArch64 can't have one without the other
 * Some ID register fields only change if both are disabled

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h |   4 ++
 target/arm/cpu.c | 150 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 148 insertions(+), 6 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 733b840a712..778fb293e7c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -797,6 +797,10 @@ struct ARMCPU {
     bool has_el3;
     /* CPU has PMU (Performance Monitor Unit) */
     bool has_pmu;
+    /* CPU has VFP */
+    bool has_vfp;
+    /* CPU has Neon */
+    bool has_neon;
 
     /* CPU has memory protection unit */
     bool has_mpu;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 8eee1d8c59a..406fd360a2a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -763,6 +763,12 @@ static Property arm_cpu_cfgend_property =
 static Property arm_cpu_has_pmu_property =
             DEFINE_PROP_BOOL("pmu", ARMCPU, has_pmu, true);
 
+static Property arm_cpu_has_vfp_property =
+            DEFINE_PROP_BOOL("vfp", ARMCPU, has_vfp, true);
+
+static Property arm_cpu_has_neon_property =
+            DEFINE_PROP_BOOL("neon", ARMCPU, has_neon, true);
+
 static Property arm_cpu_has_mpu_property =
             DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
 
@@ -803,6 +809,13 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_M)) {
         set_feature(&cpu->env, ARM_FEATURE_PMSA);
     }
+    /* Similarly for the VFP feature bits */
+    if (arm_feature(&cpu->env, ARM_FEATURE_VFP4)) {
+        set_feature(&cpu->env, ARM_FEATURE_VFP3);
+    }
+    if (arm_feature(&cpu->env, ARM_FEATURE_VFP3)) {
+        set_feature(&cpu->env, ARM_FEATURE_VFP);
+    }
 
     if (arm_feature(&cpu->env, ARM_FEATURE_CBAR) ||
         arm_feature(&cpu->env, ARM_FEATURE_CBAR_RO)) {
@@ -847,6 +860,27 @@ void arm_cpu_post_init(Object *obj)
                                  &error_abort);
     }
 
+    /*
+     * Allow user to turn off VFP and Neon support, but only for TCG --
+     * KVM does not currently allow us to lie to the guest about its
+     * ID/feature registers, so the guest always sees what the host has.
+     */
+    if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+        cpu->has_vfp = true;
+        if (!kvm_enabled()) {
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property,
+                                     &error_abort);
+        }
+    }
+
+    if (arm_feature(&cpu->env, ARM_FEATURE_NEON)) {
+        cpu->has_neon = true;
+        if (!kvm_enabled()) {
+            qdev_property_add_static(DEVICE(obj), &arm_cpu_has_neon_property,
+                                     &error_abort);
+        }
+    }
+
     if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property,
                                  &error_abort);
@@ -956,6 +990,116 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
+        cpu->has_vfp != cpu->has_neon) {
+        /*
+         * This is an architectural requirement for AArch64; AArch32 is
+         * more flexible and permits VFP-no-Neon and Neon-no-VFP.
+         */
+        error_setg(errp,
+                   "AArch64 CPUs must have both VFP and Neon or neither");
+        return;
+    }
+
+    if (!cpu->has_vfp) {
+        uint64_t t;
+        uint32_t u;
+
+        unset_feature(env, ARM_FEATURE_VFP);
+        unset_feature(env, ARM_FEATURE_VFP3);
+        unset_feature(env, ARM_FEATURE_VFP4);
+
+        t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, JSCVT, 0);
+        cpu->isar.id_aa64isar1 = t;
+
+        t = cpu->isar.id_aa64pfr0;
+        t = FIELD_DP64(t, ID_AA64PFR0, FP, 0xf);
+        cpu->isar.id_aa64pfr0 = t;
+
+        u = cpu->isar.id_isar6;
+        u = FIELD_DP32(u, ID_ISAR6, JSCVT, 0);
+        cpu->isar.id_isar6 = u;
+
+        u = cpu->isar.mvfr0;
+        u = FIELD_DP32(u, MVFR0, FPSP, 0);
+        u = FIELD_DP32(u, MVFR0, FPDP, 0);
+        u = FIELD_DP32(u, MVFR0, FPTRAP, 0);
+        u = FIELD_DP32(u, MVFR0, FPDIVIDE, 0);
+        u = FIELD_DP32(u, MVFR0, FPSQRT, 0);
+        u = FIELD_DP32(u, MVFR0, FPSHVEC, 0);
+        u = FIELD_DP32(u, MVFR0, FPROUND, 0);
+        cpu->isar.mvfr0 = u;
+
+        u = cpu->isar.mvfr1;
+        u = FIELD_DP32(u, MVFR1, FPFTZ, 0);
+        u = FIELD_DP32(u, MVFR1, FPDNAN, 0);
+        u = FIELD_DP32(u, MVFR1, FPHP, 0);
+        cpu->isar.mvfr1 = u;
+
+        u = cpu->isar.mvfr2;
+        u = FIELD_DP32(u, MVFR2, FPMISC, 0);
+        cpu->isar.mvfr2 = u;
+    }
+
+    if (!cpu->has_neon) {
+        uint64_t t;
+        uint32_t u;
+
+        unset_feature(env, ARM_FEATURE_NEON);
+
+        t = cpu->isar.id_aa64isar0;
+        t = FIELD_DP64(t, ID_AA64ISAR0, DP, 0);
+        cpu->isar.id_aa64isar0 = t;
+
+        t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, FCMA, 0);
+        cpu->isar.id_aa64isar1 = t;
+
+        t = cpu->isar.id_aa64pfr0;
+        t = FIELD_DP64(t, ID_AA64PFR0, ADVSIMD, 0xf);
+        cpu->isar.id_aa64pfr0 = t;
+
+        u = cpu->isar.id_isar5;
+        u = FIELD_DP32(u, ID_ISAR5, RDM, 0);
+        u = FIELD_DP32(u, ID_ISAR5, VCMA, 0);
+        cpu->isar.id_isar5 = u;
+
+        u = cpu->isar.id_isar6;
+        u = FIELD_DP32(u, ID_ISAR6, DP, 0);
+        u = FIELD_DP32(u, ID_ISAR6, FHM, 0);
+        cpu->isar.id_isar6 = u;
+
+        u = cpu->isar.mvfr1;
+        u = FIELD_DP32(u, MVFR1, SIMDLS, 0);
+        u = FIELD_DP32(u, MVFR1, SIMDINT, 0);
+        u = FIELD_DP32(u, MVFR1, SIMDSP, 0);
+        u = FIELD_DP32(u, MVFR1, SIMDHP, 0);
+        u = FIELD_DP32(u, MVFR1, SIMDFMAC, 0);
+        cpu->isar.mvfr1 = u;
+
+        u = cpu->isar.mvfr2;
+        u = FIELD_DP32(u, MVFR2, SIMDMISC, 0);
+        cpu->isar.mvfr2 = u;
+    }
+
+    if (!cpu->has_neon && !cpu->has_vfp) {
+        uint64_t t;
+        uint32_t u;
+
+        t = cpu->isar.id_aa64isar0;
+        t = FIELD_DP64(t, ID_AA64ISAR0, FHM, 0);
+        cpu->isar.id_aa64isar0 = t;
+
+        t = cpu->isar.id_aa64isar1;
+        t = FIELD_DP64(t, ID_AA64ISAR1, FRINTTS, 0);
+        cpu->isar.id_aa64isar1 = t;
+
+        u = cpu->isar.mvfr0;
+        u = FIELD_DP32(u, MVFR0, SIMDREG, 0);
+        cpu->isar.mvfr0 = u;
+    }
+
     /* Some features automatically imply others: */
     if (arm_feature(env, ARM_FEATURE_V8)) {
         if (arm_feature(env, ARM_FEATURE_M)) {
@@ -1016,12 +1160,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     if (arm_feature(env, ARM_FEATURE_V5)) {
         set_feature(env, ARM_FEATURE_V4T);
     }
-    if (arm_feature(env, ARM_FEATURE_VFP4)) {
-        set_feature(env, ARM_FEATURE_VFP3);
-    }
-    if (arm_feature(env, ARM_FEATURE_VFP3)) {
-        set_feature(env, ARM_FEATURE_VFP);
-    }
     if (arm_feature(env, ARM_FEATURE_LPAE)) {
         set_feature(env, ARM_FEATURE_V7MP);
         set_feature(env, ARM_FEATURE_PXN);
-- 
2.20.1


