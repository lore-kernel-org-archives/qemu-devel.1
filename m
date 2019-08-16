Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150EBC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56BC2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tb+48BBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56BC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycUC-0006s0-0b
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35449)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc75-0003Zv-75
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc71-0005jz-E6
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55968)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc71-0005is-6n
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:47 -0400
Received: by mail-wm1-x343.google.com with SMTP id f72so4029065wmf.5
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=yjLAbXFtKXx0083Aeg8KkwSsF2x8QfSQiu65gSb3dms=;
 b=Tb+48BBkeKNpA4jC1CP3l/bsYhg9SniWNyq4KfjU70vF2DkKbMH+KgKX/CpIEf523h
 lZqAePHsnXTSSco8Kia1l1pTcQ8Ta/hB+XlXJo8u6n5Q05zAaLkw6Yg20My2fRbuyr+V
 VQgLFd3GPGXoFH7VXjv5Q/xBCCmrg9lpaij3evLa4g4fCiQDc3LD2F2CptEzaVoN98dS
 aW7cC5xHw2EzxJeh8eIsRkyq8xOBXRkJ5XsqN12kkGMEF6wkXcetAvH99ctZH/eetEHX
 lQNTOf+ugyxVixj1zPMvswebOKE7RhBO4aV9H7t7x+A6y3T/i3TZOgCcX6PwB7DH3gCJ
 vAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yjLAbXFtKXx0083Aeg8KkwSsF2x8QfSQiu65gSb3dms=;
 b=FxFh+XaaeU9TaCQuwpbB7k0WzmZEUO0SrSXqqq6ASFYGwEnKElDNssfKtFdpvqdY86
 ELYTypJfQ0D9zWwiI2eDSRl2xWP2ZA9CPHtZjyOipwvqWbDU3POqGA7rsWlzMc3PaVYi
 K4Usb9wBrEaFR/IcHXPxWo3PT8zj/gODvcLijThcjc5GsPCP+9cSu9VKSdM1E656FvNe
 qJ6bjEJAlFz8aOtD21lWRPZvzwFUO6Dd5yxAR3ejw/cQ5kVLeO+uglquOfW5vnAdfNVe
 AoVEZD+ohVUcgjcfnHykZZWILRdqNC7oU6GntR1NxiEr7+lkWY/JVoHfX6iAD2sQrJmc
 O9ug==
X-Gm-Message-State: APjAAAXOMsek9Kv3dEXaeW+LqbkOGp15V2ZYeMeW4XkJSud015yEyAMi
 I1D6+E/h/Px59cGu7UVCWfNq0wdXb7flcw==
X-Google-Smtp-Source: APXvYqyOMXIO+3LcpMzHDTJwXFaiI1wf2etTQvnwW17OcFCCjFt8TEVzmG2HoHM01C8LxyVfB020XQ==
X-Received: by 2002:a1c:411:: with SMTP id 17mr2463791wme.34.1565961465584;
 Fri, 16 Aug 2019 06:17:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:12 +0100
Message-Id: <20190816131719.28244-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PULL 22/29] target/arm/kvm64: Move the get/put of
 fpsimd registers out
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

From: Andrew Jones <drjones@redhat.com>

Move the getting/putting of the fpsimd registers out of
kvm_arch_get/put_registers() into their own helper functions
to prepare for alternatively getting/putting SVE registers.

No functional change.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm64.c | 148 +++++++++++++++++++++++++++------------------
 1 file changed, 88 insertions(+), 60 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index ddde6268b9d..0b004d5d305 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -719,13 +719,53 @@ int kvm_arm_cpreg_level(uint64_t regidx)
 #define AARCH64_SIMD_CTRL_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U32 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
+static int kvm_arch_put_fpsimd(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    struct kvm_one_reg reg;
+    uint32_t fpr;
+    int i, ret;
+
+    for (i = 0; i < 32; i++) {
+        uint64_t *q = aa64_vfp_qreg(env, i);
+#ifdef HOST_WORDS_BIGENDIAN
+        uint64_t fp_val[2] = { q[1], q[0] };
+        reg.addr = (uintptr_t)fp_val;
+#else
+        reg.addr = (uintptr_t)q;
+#endif
+        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
+        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    reg.addr = (uintptr_t)(&fpr);
+    fpr = vfp_get_fpsr(env);
+    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    reg.addr = (uintptr_t)(&fpr);
+    fpr = vfp_get_fpcr(env);
+    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
+    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+
+    return 0;
+}
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     struct kvm_one_reg reg;
-    uint32_t fpr;
     uint64_t val;
-    int i;
-    int ret;
+    int i, ret;
     unsigned int el;
 
     ARMCPU *cpu = ARM_CPU(cs);
@@ -815,33 +855,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
 
-    /* Advanced SIMD and FP registers. */
-    for (i = 0; i < 32; i++) {
-        uint64_t *q = aa64_vfp_qreg(env, i);
-#ifdef HOST_WORDS_BIGENDIAN
-        uint64_t fp_val[2] = { q[1], q[0] };
-        reg.addr = (uintptr_t)fp_val;
-#else
-        reg.addr = (uintptr_t)q;
-#endif
-        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
-        if (ret) {
-            return ret;
-        }
-    }
-
-    reg.addr = (uintptr_t)(&fpr);
-    fpr = vfp_get_fpsr(env);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
-    if (ret) {
-        return ret;
-    }
-
-    fpr = vfp_get_fpcr(env);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+    ret = kvm_arch_put_fpsimd(cs);
     if (ret) {
         return ret;
     }
@@ -862,14 +876,54 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     return ret;
 }
 
+static int kvm_arch_get_fpsimd(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    struct kvm_one_reg reg;
+    uint32_t fpr;
+    int i, ret;
+
+    for (i = 0; i < 32; i++) {
+        uint64_t *q = aa64_vfp_qreg(env, i);
+        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
+        reg.addr = (uintptr_t)q;
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        } else {
+#ifdef HOST_WORDS_BIGENDIAN
+            uint64_t t;
+            t = q[0], q[0] = q[1], q[1] = t;
+#endif
+        }
+    }
+
+    reg.addr = (uintptr_t)(&fpr);
+    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
+    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+    vfp_set_fpsr(env, fpr);
+
+    reg.addr = (uintptr_t)(&fpr);
+    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
+    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    if (ret) {
+        return ret;
+    }
+    vfp_set_fpcr(env, fpr);
+
+    return 0;
+}
+
 int kvm_arch_get_registers(CPUState *cs)
 {
     struct kvm_one_reg reg;
     uint64_t val;
-    uint32_t fpr;
     unsigned int el;
-    int i;
-    int ret;
+    int i, ret;
 
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
@@ -958,36 +1012,10 @@ int kvm_arch_get_registers(CPUState *cs)
         env->spsr = env->banked_spsr[i];
     }
 
-    /* Advanced SIMD and FP registers */
-    for (i = 0; i < 32; i++) {
-        uint64_t *q = aa64_vfp_qreg(env, i);
-        reg.id = AARCH64_SIMD_CORE_REG(fp_regs.vregs[i]);
-        reg.addr = (uintptr_t)q;
-        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
-        if (ret) {
-            return ret;
-        } else {
-#ifdef HOST_WORDS_BIGENDIAN
-            uint64_t t;
-            t = q[0], q[0] = q[1], q[1] = t;
-#endif
-        }
-    }
-
-    reg.addr = (uintptr_t)(&fpr);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+    ret = kvm_arch_get_fpsimd(cs);
     if (ret) {
         return ret;
     }
-    vfp_set_fpsr(env, fpr);
-
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
-    if (ret) {
-        return ret;
-    }
-    vfp_set_fpcr(env, fpr);
 
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
-- 
2.20.1


