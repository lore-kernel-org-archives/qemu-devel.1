Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E629FCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B23EE20650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="urvci2Ek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23EE20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgfV-000676-4h
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyH-0008GL-U6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfyE-00011r-CZ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfyE-00011K-5a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id v6so3232377wmj.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=hCsDjq3BTh1CFQ3xfAyc1h9/b/i1zEMVd9NMkBRbhe0=;
 b=urvci2Ek75Us14Ux8a0Fel60EcvAW/I50Da19obMkQH+Zyq+SjsIR0gIvOW4h7Voot
 veCLi53Dv/eKHn9z9tYExVcTF/eorhHeAsYNlZgjYpmATnA9CMIylrFooeAiiXzPfaa4
 h4ridaGV6W6dTBac1tm+xVVx19K2AKi0iHlsrRKGWj7viQU/fWAegP9QPtYWT6draRDQ
 qV3Ppqvm9fu64vJ2q2ZVDst7NCLE+8We8Ld9D3tQHwF1c+Lab/Gq6ZWjWiKRszstjeHA
 Jry9ObaaXOa+CwWV36deWFLxteFYKb7ZoodGJmAjdwZ1KpQV5ZH5UU/BemdE5irOrnFS
 2ADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hCsDjq3BTh1CFQ3xfAyc1h9/b/i1zEMVd9NMkBRbhe0=;
 b=fO8aIFKBhmzzgMAfffsUvmw7oUgEjl1UPiXHGV9fGpcncWdfNJu5DuDzlLU4D4CwAx
 7cohtLWF8GMFg0GVA7AZCAMidCCPSFrn93QYX8a62Y6o73LMj4D8akljYCPwR1MQ5cF+
 e5QBvow+lK7cy/17o4UXquUlt6yvs92r6fT2YBa+NNUt7sAd/eSoIy3W2NnWqSshhpju
 ymEyahuvKAYlQoY4zeFGa0eGVrghCjxlj0H64F2hKyma9J75icfHQGGq4k0tKGxbBC4n
 tckb1hS6H6qMmDk45+0XarnZiQ3cwTP1Rq8u1sNcHWblfC0jQlDrhrdkNQWq0lVklkj5
 mnGQ==
X-Gm-Message-State: APjAAAV9AqeH46QggRFOfrQyJmLhMwtMpKTPqHtg+4vKbLWOnq21VxJm
 A7oEzSnhWwc0Xw5mBi87TqyzBVdYvTE=
X-Google-Smtp-Source: APXvYqxr6P3RJgLYPjEzexq3KGYytDLGSs/zDf/emXawPeFwJa9NIW6+0mTFJgHdD8scnH3iJRUS1A==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr5740556wme.53.1571934495721;
 Thu, 24 Oct 2019 09:28:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/51] target/arm/kvm64: Add kvm_arch_get/put_sve
Date: Thu, 24 Oct 2019 17:27:12 +0100
Message-Id: <20191024162724.31675-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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

These are the SVE equivalents to kvm_arch_get/put_fpsimd. Note, the
swabbing is different than it is for fpsmid because the vector format
is a little-endian stream of words.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Message-id: 20191024121808.9612-6-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm64.c | 185 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 156 insertions(+), 29 deletions(-)

diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 28f6db57d5e..4c0b11d105a 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -671,11 +671,12 @@ int kvm_arch_destroy_vcpu(CPUState *cs)
 bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
 {
     /* Return true if the regidx is a register we should synchronize
-     * via the cpreg_tuples array (ie is not a core reg we sync by
-     * hand in kvm_arch_get/put_registers())
+     * via the cpreg_tuples array (ie is not a core or sve reg that
+     * we sync by hand in kvm_arch_get/put_registers())
      */
     switch (regidx & KVM_REG_ARM_COPROC_MASK) {
     case KVM_REG_ARM_CORE:
+    case KVM_REG_ARM64_SVE:
         return false;
     default:
         return true;
@@ -721,10 +722,8 @@ int kvm_arm_cpreg_level(uint64_t regidx)
 
 static int kvm_arch_put_fpsimd(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = &ARM_CPU(cs)->env;
     struct kvm_one_reg reg;
-    uint32_t fpr;
     int i, ret;
 
     for (i = 0; i < 32; i++) {
@@ -742,17 +741,73 @@ static int kvm_arch_put_fpsimd(CPUState *cs)
         }
     }
 
-    reg.addr = (uintptr_t)(&fpr);
-    fpr = vfp_get_fpsr(env);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
-    if (ret) {
-        return ret;
+    return 0;
+}
+
+/*
+ * SVE registers are encoded in KVM's memory in an endianness-invariant format.
+ * The byte at offset i from the start of the in-memory representation contains
+ * the bits [(7 + 8 * i) : (8 * i)] of the register value. As this means the
+ * lowest offsets are stored in the lowest memory addresses, then that nearly
+ * matches QEMU's representation, which is to use an array of host-endian
+ * uint64_t's, where the lower offsets are at the lower indices. To complete
+ * the translation we just need to byte swap the uint64_t's on big-endian hosts.
+ */
+static uint64_t *sve_bswap64(uint64_t *dst, uint64_t *src, int nr)
+{
+#ifdef HOST_WORDS_BIGENDIAN
+    int i;
+
+    for (i = 0; i < nr; ++i) {
+        dst[i] = bswap64(src[i]);
     }
 
-    reg.addr = (uintptr_t)(&fpr);
-    fpr = vfp_get_fpcr(env);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
+    return dst;
+#else
+    return src;
+#endif
+}
+
+/*
+ * KVM SVE registers come in slices where ZREGs have a slice size of 2048 bits
+ * and PREGS and the FFR have a slice size of 256 bits. However we simply hard
+ * code the slice index to zero for now as it's unlikely we'll need more than
+ * one slice for quite some time.
+ */
+static int kvm_arch_put_sve(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    uint64_t tmp[ARM_MAX_VQ * 2];
+    uint64_t *r;
+    struct kvm_one_reg reg;
+    int n, ret;
+
+    for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
+        r = sve_bswap64(tmp, &env->vfp.zregs[n].d[0], cpu->sve_max_vq * 2);
+        reg.addr = (uintptr_t)r;
+        reg.id = KVM_REG_ARM64_SVE_ZREG(n, 0);
+        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
+        r = sve_bswap64(tmp, r = &env->vfp.pregs[n].p[0],
+                        DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+        reg.addr = (uintptr_t)r;
+        reg.id = KVM_REG_ARM64_SVE_PREG(n, 0);
+        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+    }
+
+    r = sve_bswap64(tmp, &env->vfp.pregs[FFR_PRED_NUM].p[0],
+                    DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+    reg.addr = (uintptr_t)r;
+    reg.id = KVM_REG_ARM64_SVE_FFR(0);
     ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &reg);
     if (ret) {
         return ret;
@@ -765,6 +820,7 @@ int kvm_arch_put_registers(CPUState *cs, int level)
 {
     struct kvm_one_reg reg;
     uint64_t val;
+    uint32_t fpr;
     int i, ret;
     unsigned int el;
 
@@ -855,7 +911,27 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
 
-    ret = kvm_arch_put_fpsimd(cs);
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        ret = kvm_arch_put_sve(cs);
+    } else {
+        ret = kvm_arch_put_fpsimd(cs);
+    }
+    if (ret) {
+        return ret;
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
     if (ret) {
         return ret;
     }
@@ -878,10 +954,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
 
 static int kvm_arch_get_fpsimd(CPUState *cs)
 {
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
+    CPUARMState *env = &ARM_CPU(cs)->env;
     struct kvm_one_reg reg;
-    uint32_t fpr;
     int i, ret;
 
     for (i = 0; i < 32; i++) {
@@ -899,21 +973,53 @@ static int kvm_arch_get_fpsimd(CPUState *cs)
         }
     }
 
-    reg.addr = (uintptr_t)(&fpr);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpsr);
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
-    if (ret) {
-        return ret;
-    }
-    vfp_set_fpsr(env, fpr);
+    return 0;
+}
 
-    reg.addr = (uintptr_t)(&fpr);
-    reg.id = AARCH64_SIMD_CTRL_REG(fp_regs.fpcr);
+/*
+ * KVM SVE registers come in slices where ZREGs have a slice size of 2048 bits
+ * and PREGS and the FFR have a slice size of 256 bits. However we simply hard
+ * code the slice index to zero for now as it's unlikely we'll need more than
+ * one slice for quite some time.
+ */
+static int kvm_arch_get_sve(CPUState *cs)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    struct kvm_one_reg reg;
+    uint64_t *r;
+    int n, ret;
+
+    for (n = 0; n < KVM_ARM64_SVE_NUM_ZREGS; ++n) {
+        r = &env->vfp.zregs[n].d[0];
+        reg.addr = (uintptr_t)r;
+        reg.id = KVM_REG_ARM64_SVE_ZREG(n, 0);
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+        sve_bswap64(r, r, cpu->sve_max_vq * 2);
+    }
+
+    for (n = 0; n < KVM_ARM64_SVE_NUM_PREGS; ++n) {
+        r = &env->vfp.pregs[n].p[0];
+        reg.addr = (uintptr_t)r;
+        reg.id = KVM_REG_ARM64_SVE_PREG(n, 0);
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
+        if (ret) {
+            return ret;
+        }
+        sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
+    }
+
+    r = &env->vfp.pregs[FFR_PRED_NUM].p[0];
+    reg.addr = (uintptr_t)r;
+    reg.id = KVM_REG_ARM64_SVE_FFR(0);
     ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &reg);
     if (ret) {
         return ret;
     }
-    vfp_set_fpcr(env, fpr);
+    sve_bswap64(r, r, DIV_ROUND_UP(cpu->sve_max_vq * 2, 8));
 
     return 0;
 }
@@ -923,6 +1029,7 @@ int kvm_arch_get_registers(CPUState *cs)
     struct kvm_one_reg reg;
     uint64_t val;
     unsigned int el;
+    uint32_t fpr;
     int i, ret;
 
     ARMCPU *cpu = ARM_CPU(cs);
@@ -1012,11 +1119,31 @@ int kvm_arch_get_registers(CPUState *cs)
         env->spsr = env->banked_spsr[i];
     }
 
-    ret = kvm_arch_get_fpsimd(cs);
+    if (cpu_isar_feature(aa64_sve, cpu)) {
+        ret = kvm_arch_get_sve(cs);
+    } else {
+        ret = kvm_arch_get_fpsimd(cs);
+    }
     if (ret) {
         return ret;
     }
 
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
     ret = kvm_get_vcpu_events(cpu);
     if (ret) {
         return ret;
-- 
2.20.1


