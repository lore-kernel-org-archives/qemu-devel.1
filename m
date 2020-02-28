Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E772C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17AE424697
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0qzKoRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AE424697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7ipB-0001Wx-6m
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifA-0007Ni-PX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7if9-0001rk-Hf
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:56 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7if9-0001rJ-B7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:38:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id m10so9731111wmc.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FqRxxLEQXMGLzTCr1Km31hEFtk/Wttk51AWGftp156w=;
 b=D0qzKoRkWufzFqZ/ywCCwKPngc2k/lUTSsrXhS9O4hFyTLwkUTKTKsUDB6AW7P8R5r
 f3NTZBf+r7zkV9F9PkL5YsPKTiKCJidii9WI/Y+JtOAfrBKXLbvfMDHHf+tjLRP0QF8U
 Vs43t5/n7zgET3K30QndNKQJdOnkybjcvCYntaZ1T4z+SsV/mZu8g3J7Bc/+I6n3ZDRW
 CGdrRpM9nRk1MszNeca1xLKEsoo9OC6pz8rwV0mPCIkB8jJqXZFs6jUw22ojwmxwY84G
 yawyU+CX06gtAgQWBdiqDc7YZJb6+6dQ2p3PqWVgtz+ZhjpEpSeP85ux02V992kEmaNW
 VnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FqRxxLEQXMGLzTCr1Km31hEFtk/Wttk51AWGftp156w=;
 b=qXVno9tqjPgUMf0w+QHP5rL+0vAXaQ8EpVC5jPio9kHXzZcx7NbJkPHNYSdW31B7GY
 GYgb7t5n1o9gtcRpkdaYtBU1zcjeFTwPNCHVzC/UmJUAWr5SipvbRJkNB8lYsUGb2iWx
 tBHVcXvffblOA3HazzFDDPjD34UDdLJPRbOsJ1axrEmoxl1DrAyoV4EkRBifGst1VAgA
 dI9wdZhZrKluursQCYV7MczEnSUOKFTNUdW15f3kCumV09r0PIXQYzi8XxzEeZLPY6ik
 jXr8a+nLoGQluislx3TnzI7MyrdhI9NMf+RPyQ0SL7gIN/GPTQp0v1i0WTgcOK7rEZ3V
 14ZA==
X-Gm-Message-State: APjAAAX+aN1Fusr2SVR0HmzRQNVjdivnsbElfDxNUJnZXhwfl4QhRCnI
 8U4noLo7dMF0TcyRPcbzI3Ea6tXECBucAw==
X-Google-Smtp-Source: APXvYqy/f7K0zEXQRYsVebUz6YYXk2qHTbuhvFP/g5kI5Xlroj3SE5ofoZBr7aPdXG8Jv5OHL7FV+A==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr5725644wmc.4.1582907933842;
 Fri, 28 Feb 2020 08:38:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/33] target/arm: Add isar_feature_aa64_fp_simd,
 isar_feature_aa32_vfp
Date: Fri, 28 Feb 2020 16:38:17 +0000
Message-Id: <20200228163840.23585-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

We cannot easily create "any" functions for these, because the
ID_AA64PFR0 fields for FP and SIMD signal "enabled" with zero.
Which means that an aarch32-only cpu will return incorrect results
when testing the aarch64 registers.

To use these, we must either have context or additionally test
vs ARM_FEATURE_AARCH64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200224222232.13807-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     | 11 +++++++++++
 target/arm/cpu.c     |  9 ++++++---
 target/arm/machine.c |  5 +++--
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f7a90f512e3..b94d2a5ace4 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3494,6 +3494,11 @@ static inline bool isar_feature_aa32_fpdp_v3(const ARMISARegisters *id)
     return FIELD_EX32(id->mvfr0, MVFR0, FPDP) >= 2;
 }
 
+static inline bool isar_feature_aa32_vfp(const ARMISARegisters *id)
+{
+    return isar_feature_aa32_fpsp_v2(id) || isar_feature_aa32_fpdp_v2(id);
+}
+
 /*
  * We always set the FP and SIMD FP16 fields to indicate identical
  * levels of support (assuming SIMD is implemented at all), so
@@ -3696,6 +3701,12 @@ static inline bool isar_feature_aa64_dcpodp(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, DPB) >= 2;
 }
 
+static inline bool isar_feature_aa64_fp_simd(const ARMISARegisters *id)
+{
+    /* We always set the AdvSIMD and FP fields identically.  */
+    return FIELD_EX64(id->id_aa64pfr0, ID_AA64PFR0, FP) != 0xf;
+}
+
 static inline bool isar_feature_aa64_fp16(const ARMISARegisters *id)
 {
     /* We always set the AdvSIMD and FP fields identically wrt FP16.  */
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index be4c2a1253d..5be4c258096 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1260,7 +1260,9 @@ void arm_cpu_post_init(Object *obj)
      * KVM does not currently allow us to lie to the guest about its
      * ID/feature registers, so the guest always sees what the host has.
      */
-    if (arm_feature(&cpu->env, ARM_FEATURE_VFP)) {
+    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
+        ? cpu_isar_feature(aa64_fp_simd, cpu)
+        : cpu_isar_feature(aa32_vfp, cpu)) {
         cpu->has_vfp = true;
         if (!kvm_enabled()) {
             qdev_property_add_static(DEVICE(obj), &arm_cpu_has_vfp_property);
@@ -1636,8 +1638,9 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * We rely on no XScale CPU having VFP so we can use the same bits in the
      * TB flags field for VECSTRIDE and XSCALE_CPAR.
      */
-    assert(!(arm_feature(env, ARM_FEATURE_VFP) &&
-             arm_feature(env, ARM_FEATURE_XSCALE)));
+    assert(arm_feature(&cpu->env, ARM_FEATURE_AARCH64) ||
+           !cpu_isar_feature(aa32_vfp_simd, cpu) ||
+           !arm_feature(env, ARM_FEATURE_XSCALE));
 
     if (arm_feature(env, ARM_FEATURE_V7) &&
         !arm_feature(env, ARM_FEATURE_M) &&
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 241890ac8cf..c5a2114f51c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -9,9 +9,10 @@
 static bool vfp_needed(void *opaque)
 {
     ARMCPU *cpu = opaque;
-    CPUARMState *env = &cpu->env;
 
-    return arm_feature(env, ARM_FEATURE_VFP);
+    return (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)
+            ? cpu_isar_feature(aa64_fp_simd, cpu)
+            : cpu_isar_feature(aa32_vfp_simd, cpu));
 }
 
 static int get_fpscr(QEMUFile *f, void *opaque, size_t size,
-- 
2.20.1


