Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A002C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABBA20EDD
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZM3lXx+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABBA20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpDD-0002Yr-JL
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45904)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8F-0002Nd-Ux
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:59 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:40795)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHp8C-0007ZX-P5
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:06:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id j2so18905128wrx.7
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xfBPb+F6f4tQ7PqFT2gujvSX4f8FZJltVXmD6OiZOeY=;
 b=ZM3lXx+//h7PVRaKrGZwmwIbFYA8MH13aDCo2rVG/b0goxV1LXB2SflYFz5Ndlt4iw
 CS0SzsW2YPXnvrVBOV09jDMOj0brrPqA6xTqWDJUq0zp2sHyC8LmY5Ieaa8LxXZ8Tnff
 nfyhIGf538ui4Js2ckYFkk0oCWEAUpVltxE/klkFqgO5BYFBs/01OA4UJYxQSDGk3osC
 ILPXWAx13Xw47xIitEeRwpi9NKBComlr25vvg69eogjpiHuZCVOSUAd9ejwmmqwlVw+u
 KnSzyACBmTbtCksF6dgjsU2HS6IuDNrqdH6HKvIE28J4xPmXwL68GBTT+nVrU/76JUK9
 dI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xfBPb+F6f4tQ7PqFT2gujvSX4f8FZJltVXmD6OiZOeY=;
 b=GzjeKqPi3BQmBXZq+oNI6kRhYIS1cXmKliPetmY0sE8j92jAXmJOF3K05+6LGN6CJZ
 pcaWhNS1odiFnGY6TSguBsTGigUm31FszYohkO2Kadl6Idll3BcDOu2DQnsEserfWCtS
 WnLyWMh6MCnMq8K7P98TweEcCpfX02N0/gsrGFQPzmCRSYU0jYxWfkMKacHBP1ZNxOJj
 +kjpiA8B1pjQk8PKVbcT/m9HfEtpV1KUj2at1VXPxAI1m2i65IfEindhYLYnBwZx0fRW
 Yu3TMTuDsYlE0xBlNlDReqK56P4e+XtKxTc2rjQN1kdgKzUep8I2uqrzs6NmkIVxYYsV
 RLiw==
X-Gm-Message-State: AOAM530sd2Tp0DLLA4Npkat8L/LSNnrmKj9dIr48XmSOt9CHoPoooI3P
 /R957VCrmaSXZXUwrco8kz/rIi3Mrato9FcK
X-Google-Smtp-Source: ABdhPJykplBfcxQ12qy1dL2vXaNLcZwdxrOahA5rW1yEa5INThPPPLpAFVjDIP6YvtBLR36IcAOa3A==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr15907592wrc.193.1600092414489; 
 Mon, 14 Sep 2020 07:06:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x16sm20834041wrq.62.2020.09.14.07.06.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 07:06:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/36] target/arm: Remove KVM support for 32-bit Arm hosts
Date: Mon, 14 Sep 2020 15:06:15 +0100
Message-Id: <20200914140641.21369-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914140641.21369-1-peter.maydell@linaro.org>
References: <20200914140641.21369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

We deprecated the support for KVM on 32-bit Arm hosts in time
for release 5.0, which means that our deprecation policy allows
us to drop it in release 5.2. Remove the code.

To repeat the rationale from the deprecation note: the Linux
kernel dropped support for 32-bit Arm KVM hosts in 5.7.

Running 32-bit guests on a 64-bit Arm host remains supported.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200904154156.31943-2-peter.maydell@linaro.org
---
 docs/system/deprecated.rst |  16 +-
 configure                  |   2 +-
 target/arm/kvm32.c         | 595 -------------------------------------
 target/arm/meson.build     |   5 +-
 4 files changed, 10 insertions(+), 608 deletions(-)
 delete mode 100644 target/arm/kvm32.c

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index a158e765c33..b633fb3ef05 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -329,14 +329,6 @@ The ``compat`` property used to set backwards compatibility modes for
 the processor has been deprecated. The ``max-cpu-compat`` property of
 the ``pseries`` machine type should be used instead.
 
-KVM guest support on 32-bit Arm hosts (since 5.0)
-'''''''''''''''''''''''''''''''''''''''''''''''''
-
-The Linux kernel has dropped support for allowing 32-bit Arm systems
-to host KVM guests as of the 5.7 kernel. Accordingly, QEMU is deprecating
-its support for this configuration and will remove it in a future version.
-Running 32-bit guests on a 64-bit Arm host remains supported.
-
 System emulator devices
 -----------------------
 
@@ -543,6 +535,14 @@ should be used instead of the 1.09.1 version.
 System emulator CPUS
 --------------------
 
+KVM guest support on 32-bit Arm hosts (removed in 5.2)
+''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The Linux kernel has dropped support for allowing 32-bit Arm systems
+to host KVM guests as of the 5.7 kernel. Accordingly, QEMU is deprecating
+its support for this configuration and will remove it in a future version.
+Running 32-bit guests on a 64-bit Arm host remains supported.
+
 RISC-V ISA Specific CPUs (removed in 5.1)
 '''''''''''''''''''''''''''''''''''''''''
 
diff --git a/configure b/configure
index 2b6a1196da5..ce27eafb0a9 100755
--- a/configure
+++ b/configure
@@ -234,7 +234,7 @@ supported_kvm_target() {
     test "$kvm" = "yes" || return 1
     glob "$1" "*-softmmu" || return 1
     case "${1%-softmmu}:$cpu" in
-        arm:arm | aarch64:aarch64 | \
+        aarch64:aarch64 | \
         i386:i386 | i386:x86_64 | i386:x32 | \
         x86_64:i386 | x86_64:x86_64 | x86_64:x32 | \
         mips:mips | mipsel:mips | mips64:mips | mips64el:mips | \
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
deleted file mode 100644
index 1f2b8f8b7a5..00000000000
--- a/target/arm/kvm32.c
+++ /dev/null
@@ -1,595 +0,0 @@
-/*
- * ARM implementation of KVM hooks, 32 bit specific code.
- *
- * Copyright Christoffer Dall 2009-2010
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include <sys/ioctl.h>
-
-#include <linux/kvm.h>
-
-#include "qemu-common.h"
-#include "cpu.h"
-#include "qemu/timer.h"
-#include "sysemu/runstate.h"
-#include "sysemu/kvm.h"
-#include "kvm_arm.h"
-#include "internals.h"
-#include "qemu/log.h"
-
-static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
-{
-    struct kvm_one_reg idreg = { .id = id, .addr = (uintptr_t)pret };
-
-    assert((id & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32);
-    return ioctl(fd, KVM_GET_ONE_REG, &idreg);
-}
-
-bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
-{
-    /* Identify the feature bits corresponding to the host CPU, and
-     * fill out the ARMHostCPUClass fields accordingly. To do this
-     * we have to create a scratch VM, create a single CPU inside it,
-     * and then query that CPU for the relevant ID registers.
-     */
-    int err = 0, fdarray[3];
-    uint32_t midr, id_pfr0;
-    uint64_t features = 0;
-
-    /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
-     * we know these will only support creating one kind of guest CPU,
-     * which is its preferred CPU type.
-     */
-    static const uint32_t cpus_to_try[] = {
-        QEMU_KVM_ARM_TARGET_CORTEX_A15,
-        QEMU_KVM_ARM_TARGET_NONE
-    };
-    /*
-     * target = -1 informs kvm_arm_create_scratch_host_vcpu()
-     * to use the preferred target
-     */
-    struct kvm_vcpu_init init = { .target = -1, };
-
-    if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
-        return false;
-    }
-
-    ahcf->target = init.target;
-
-    /* This is not strictly blessed by the device tree binding docs yet,
-     * but in practice the kernel does not care about this string so
-     * there is no point maintaining an KVM_ARM_TARGET_* -> string table.
-     */
-    ahcf->dtb_compatible = "arm,arm-v7";
-
-    err |= read_sys_reg32(fdarray[2], &midr, ARM_CP15_REG32(0, 0, 0, 0));
-    err |= read_sys_reg32(fdarray[2], &id_pfr0, ARM_CP15_REG32(0, 0, 1, 0));
-
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
-                          ARM_CP15_REG32(0, 0, 2, 0));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
-                          ARM_CP15_REG32(0, 0, 2, 1));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar2,
-                          ARM_CP15_REG32(0, 0, 2, 2));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar3,
-                          ARM_CP15_REG32(0, 0, 2, 3));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar4,
-                          ARM_CP15_REG32(0, 0, 2, 4));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
-                          ARM_CP15_REG32(0, 0, 2, 5));
-    if (read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
-                       ARM_CP15_REG32(0, 0, 2, 7))) {
-        /*
-         * Older kernels don't support reading ID_ISAR6. This register was
-         * only introduced in ARMv8, so we can assume that it is zero on a
-         * CPU that a kernel this old is running on.
-         */
-        ahcf->isar.id_isar6 = 0;
-    }
-
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_dfr0,
-                          ARM_CP15_REG32(0, 0, 1, 2));
-
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
-                          KVM_REG_ARM | KVM_REG_SIZE_U32 |
-                          KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR0);
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
-                          KVM_REG_ARM | KVM_REG_SIZE_U32 |
-                          KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1);
-    /*
-     * FIXME: There is not yet a way to read MVFR2.
-     * Fortunately there is not yet anything in there that affects migration.
-     */
-
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr0,
-                          ARM_CP15_REG32(0, 0, 1, 4));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr1,
-                          ARM_CP15_REG32(0, 0, 1, 5));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr2,
-                          ARM_CP15_REG32(0, 0, 1, 6));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr3,
-                          ARM_CP15_REG32(0, 0, 1, 7));
-    if (read_sys_reg32(fdarray[2], &ahcf->isar.id_mmfr4,
-                       ARM_CP15_REG32(0, 0, 2, 6))) {
-        /*
-         * Older kernels don't support reading ID_MMFR4 (a new in v8
-         * register); assume it's zero.
-         */
-        ahcf->isar.id_mmfr4 = 0;
-    }
-
-    /*
-     * There is no way to read DBGDIDR, because currently 32-bit KVM
-     * doesn't implement debug at all. Leave it at zero.
-     */
-
-    kvm_arm_destroy_scratch_host_vcpu(fdarray);
-
-    if (err < 0) {
-        return false;
-    }
-
-    /* Now we've retrieved all the register information we can
-     * set the feature bits based on the ID register fields.
-     * We can assume any KVM supporting CPU is at least a v7
-     * with VFPv3, virtualization extensions, and the generic
-     * timers; this in turn implies most of the other feature
-     * bits, but a few must be tested.
-     */
-    features |= 1ULL << ARM_FEATURE_V7VE;
-    features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
-
-    if (extract32(id_pfr0, 12, 4) == 1) {
-        features |= 1ULL << ARM_FEATURE_THUMB2EE;
-    }
-    if (extract32(ahcf->isar.mvfr1, 12, 4) == 1) {
-        features |= 1ULL << ARM_FEATURE_NEON;
-    }
-
-    ahcf->features = features;
-
-    return true;
-}
-
-bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
-{
-    /* Return true if the regidx is a register we should synchronize
-     * via the cpreg_tuples array (ie is not a core reg we sync by
-     * hand in kvm_arch_get/put_registers())
-     */
-    switch (regidx & KVM_REG_ARM_COPROC_MASK) {
-    case KVM_REG_ARM_CORE:
-    case KVM_REG_ARM_VFP:
-        return false;
-    default:
-        return true;
-    }
-}
-
-typedef struct CPRegStateLevel {
-    uint64_t regidx;
-    int level;
-} CPRegStateLevel;
-
-/* All coprocessor registers not listed in the following table are assumed to
- * be of the level KVM_PUT_RUNTIME_STATE. If a register should be written less
- * often, you must add it to this table with a state of either
- * KVM_PUT_RESET_STATE or KVM_PUT_FULL_STATE.
- */
-static const CPRegStateLevel non_runtime_cpregs[] = {
-    { KVM_REG_ARM_TIMER_CNT, KVM_PUT_FULL_STATE },
-};
-
-int kvm_arm_cpreg_level(uint64_t regidx)
-{
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(non_runtime_cpregs); i++) {
-        const CPRegStateLevel *l = &non_runtime_cpregs[i];
-        if (l->regidx == regidx) {
-            return l->level;
-        }
-    }
-
-    return KVM_PUT_RUNTIME_STATE;
-}
-
-#define ARM_CPU_ID_MPIDR       0, 0, 0, 5
-
-int kvm_arch_init_vcpu(CPUState *cs)
-{
-    int ret;
-    uint64_t v;
-    uint32_t mpidr;
-    struct kvm_one_reg r;
-    ARMCPU *cpu = ARM_CPU(cs);
-
-    if (cpu->kvm_target == QEMU_KVM_ARM_TARGET_NONE) {
-        fprintf(stderr, "KVM is not supported for this guest CPU type\n");
-        return -EINVAL;
-    }
-
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
-
-    /* Determine init features for this CPU */
-    memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
-    if (cs->start_powered_off) {
-        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_POWER_OFF;
-    }
-    if (kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PSCI_0_2)) {
-        cpu->psci_version = 2;
-        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
-    }
-
-    /* Do KVM_ARM_VCPU_INIT ioctl */
-    ret = kvm_arm_vcpu_init(cs);
-    if (ret) {
-        return ret;
-    }
-
-    /* Query the kernel to make sure it supports 32 VFP
-     * registers: QEMU's "cortex-a15" CPU is always a
-     * VFP-D32 core. The simplest way to do this is just
-     * to attempt to read register d31.
-     */
-    r.id = KVM_REG_ARM | KVM_REG_SIZE_U64 | KVM_REG_ARM_VFP | 31;
-    r.addr = (uintptr_t)(&v);
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
-    if (ret == -ENOENT) {
-        return -EINVAL;
-    }
-
-    /*
-     * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
-     * Currently KVM has its own idea about MPIDR assignment, so we
-     * override our defaults with what we get from KVM.
-     */
-    ret = kvm_get_one_reg(cs, ARM_CP15_REG32(ARM_CPU_ID_MPIDR), &mpidr);
-    if (ret) {
-        return ret;
-    }
-    cpu->mp_affinity = mpidr & ARM32_AFFINITY_MASK;
-
-    /* Check whether userspace can specify guest syndrome value */
-    kvm_arm_init_serror_injection(cs);
-
-    return kvm_arm_init_cpreg_list(cpu);
-}
-
-int kvm_arch_destroy_vcpu(CPUState *cs)
-{
-	return 0;
-}
-
-typedef struct Reg {
-    uint64_t id;
-    int offset;
-} Reg;
-
-#define COREREG(KERNELNAME, QEMUFIELD)                       \
-    {                                                        \
-        KVM_REG_ARM | KVM_REG_SIZE_U32 |                     \
-        KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(KERNELNAME), \
-        offsetof(CPUARMState, QEMUFIELD)                     \
-    }
-
-#define VFPSYSREG(R)                                       \
-    {                                                      \
-        KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_VFP | \
-        KVM_REG_ARM_VFP_##R,                               \
-        offsetof(CPUARMState, vfp.xregs[ARM_VFP_##R])      \
-    }
-
-/* Like COREREG, but handle fields which are in a uint64_t in CPUARMState. */
-#define COREREG64(KERNELNAME, QEMUFIELD)                     \
-    {                                                        \
-        KVM_REG_ARM | KVM_REG_SIZE_U32 |                     \
-        KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(KERNELNAME), \
-        offsetoflow32(CPUARMState, QEMUFIELD)                \
-    }
-
-static const Reg regs[] = {
-    /* R0_usr .. R14_usr */
-    COREREG(usr_regs.uregs[0], regs[0]),
-    COREREG(usr_regs.uregs[1], regs[1]),
-    COREREG(usr_regs.uregs[2], regs[2]),
-    COREREG(usr_regs.uregs[3], regs[3]),
-    COREREG(usr_regs.uregs[4], regs[4]),
-    COREREG(usr_regs.uregs[5], regs[5]),
-    COREREG(usr_regs.uregs[6], regs[6]),
-    COREREG(usr_regs.uregs[7], regs[7]),
-    COREREG(usr_regs.uregs[8], usr_regs[0]),
-    COREREG(usr_regs.uregs[9], usr_regs[1]),
-    COREREG(usr_regs.uregs[10], usr_regs[2]),
-    COREREG(usr_regs.uregs[11], usr_regs[3]),
-    COREREG(usr_regs.uregs[12], usr_regs[4]),
-    COREREG(usr_regs.uregs[13], banked_r13[BANK_USRSYS]),
-    COREREG(usr_regs.uregs[14], banked_r14[BANK_USRSYS]),
-    /* R13, R14, SPSR for SVC, ABT, UND, IRQ banks */
-    COREREG(svc_regs[0], banked_r13[BANK_SVC]),
-    COREREG(svc_regs[1], banked_r14[BANK_SVC]),
-    COREREG64(svc_regs[2], banked_spsr[BANK_SVC]),
-    COREREG(abt_regs[0], banked_r13[BANK_ABT]),
-    COREREG(abt_regs[1], banked_r14[BANK_ABT]),
-    COREREG64(abt_regs[2], banked_spsr[BANK_ABT]),
-    COREREG(und_regs[0], banked_r13[BANK_UND]),
-    COREREG(und_regs[1], banked_r14[BANK_UND]),
-    COREREG64(und_regs[2], banked_spsr[BANK_UND]),
-    COREREG(irq_regs[0], banked_r13[BANK_IRQ]),
-    COREREG(irq_regs[1], banked_r14[BANK_IRQ]),
-    COREREG64(irq_regs[2], banked_spsr[BANK_IRQ]),
-    /* R8_fiq .. R14_fiq and SPSR_fiq */
-    COREREG(fiq_regs[0], fiq_regs[0]),
-    COREREG(fiq_regs[1], fiq_regs[1]),
-    COREREG(fiq_regs[2], fiq_regs[2]),
-    COREREG(fiq_regs[3], fiq_regs[3]),
-    COREREG(fiq_regs[4], fiq_regs[4]),
-    COREREG(fiq_regs[5], banked_r13[BANK_FIQ]),
-    COREREG(fiq_regs[6], banked_r14[BANK_FIQ]),
-    COREREG64(fiq_regs[7], banked_spsr[BANK_FIQ]),
-    /* R15 */
-    COREREG(usr_regs.uregs[15], regs[15]),
-    /* VFP system registers */
-    VFPSYSREG(FPSID),
-    VFPSYSREG(MVFR1),
-    VFPSYSREG(MVFR0),
-    VFPSYSREG(FPEXC),
-    VFPSYSREG(FPINST),
-    VFPSYSREG(FPINST2),
-};
-
-int kvm_arch_put_registers(CPUState *cs, int level)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    struct kvm_one_reg r;
-    int mode, bn;
-    int ret, i;
-    uint32_t cpsr, fpscr;
-
-    /* Make sure the banked regs are properly set */
-    mode = env->uncached_cpsr & CPSR_M;
-    bn = bank_number(mode);
-    if (mode == ARM_CPU_MODE_FIQ) {
-        memcpy(env->fiq_regs, env->regs + 8, 5 * sizeof(uint32_t));
-    } else {
-        memcpy(env->usr_regs, env->regs + 8, 5 * sizeof(uint32_t));
-    }
-    env->banked_r13[bn] = env->regs[13];
-    env->banked_spsr[bn] = env->spsr;
-    env->banked_r14[r14_bank_number(mode)] = env->regs[14];
-
-    /* Now we can safely copy stuff down to the kernel */
-    for (i = 0; i < ARRAY_SIZE(regs); i++) {
-        r.id = regs[i].id;
-        r.addr = (uintptr_t)(env) + regs[i].offset;
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
-        if (ret) {
-            return ret;
-        }
-    }
-
-    /* Special cases which aren't a single CPUARMState field */
-    cpsr = cpsr_read(env);
-    r.id = KVM_REG_ARM | KVM_REG_SIZE_U32 |
-        KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(usr_regs.ARM_cpsr);
-    r.addr = (uintptr_t)(&cpsr);
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
-    if (ret) {
-        return ret;
-    }
-
-    /* VFP registers */
-    r.id = KVM_REG_ARM | KVM_REG_SIZE_U64 | KVM_REG_ARM_VFP;
-    for (i = 0; i < 32; i++) {
-        r.addr = (uintptr_t)aa32_vfp_dreg(env, i);
-        ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
-        if (ret) {
-            return ret;
-        }
-        r.id++;
-    }
-
-    r.id = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_VFP |
-        KVM_REG_ARM_VFP_FPSCR;
-    fpscr = vfp_get_fpscr(env);
-    r.addr = (uintptr_t)&fpscr;
-    ret = kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
-    if (ret) {
-        return ret;
-    }
-
-    write_cpustate_to_list(cpu, true);
-
-    if (!write_list_to_kvmstate(cpu, level)) {
-        return EINVAL;
-    }
-
-    /*
-     * Setting VCPU events should be triggered after syncing the registers
-     * to avoid overwriting potential changes made by KVM upon calling
-     * KVM_SET_VCPU_EVENTS ioctl
-     */
-    ret = kvm_put_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
-    kvm_arm_sync_mpstate_to_kvm(cpu);
-
-    return ret;
-}
-
-int kvm_arch_get_registers(CPUState *cs)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    struct kvm_one_reg r;
-    int mode, bn;
-    int ret, i;
-    uint32_t cpsr, fpscr;
-
-    for (i = 0; i < ARRAY_SIZE(regs); i++) {
-        r.id = regs[i].id;
-        r.addr = (uintptr_t)(env) + regs[i].offset;
-        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
-        if (ret) {
-            return ret;
-        }
-    }
-
-    /* Special cases which aren't a single CPUARMState field */
-    r.id = KVM_REG_ARM | KVM_REG_SIZE_U32 |
-        KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(usr_regs.ARM_cpsr);
-    r.addr = (uintptr_t)(&cpsr);
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
-    if (ret) {
-        return ret;
-    }
-    cpsr_write(env, cpsr, 0xffffffff, CPSRWriteRaw);
-
-    /* Make sure the current mode regs are properly set */
-    mode = env->uncached_cpsr & CPSR_M;
-    bn = bank_number(mode);
-    if (mode == ARM_CPU_MODE_FIQ) {
-        memcpy(env->regs + 8, env->fiq_regs, 5 * sizeof(uint32_t));
-    } else {
-        memcpy(env->regs + 8, env->usr_regs, 5 * sizeof(uint32_t));
-    }
-    env->regs[13] = env->banked_r13[bn];
-    env->spsr = env->banked_spsr[bn];
-    env->regs[14] = env->banked_r14[r14_bank_number(mode)];
-
-    /* VFP registers */
-    r.id = KVM_REG_ARM | KVM_REG_SIZE_U64 | KVM_REG_ARM_VFP;
-    for (i = 0; i < 32; i++) {
-        r.addr = (uintptr_t)aa32_vfp_dreg(env, i);
-        ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
-        if (ret) {
-            return ret;
-        }
-        r.id++;
-    }
-
-    r.id = KVM_REG_ARM | KVM_REG_SIZE_U32 | KVM_REG_ARM_VFP |
-        KVM_REG_ARM_VFP_FPSCR;
-    r.addr = (uintptr_t)&fpscr;
-    ret = kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
-    if (ret) {
-        return ret;
-    }
-    vfp_set_fpscr(env, fpscr);
-
-    ret = kvm_get_vcpu_events(cpu);
-    if (ret) {
-        return ret;
-    }
-
-    if (!write_kvmstate_to_list(cpu)) {
-        return EINVAL;
-    }
-    /* Note that it's OK to have registers which aren't in CPUState,
-     * so we can ignore a failure return here.
-     */
-    write_list_to_cpustate(cpu);
-
-    kvm_arm_sync_mpstate_to_qemu(cpu);
-
-    return 0;
-}
-
-int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: guest debug not yet implemented\n", __func__);
-    return -EINVAL;
-}
-
-int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: guest debug not yet implemented\n", __func__);
-    return -EINVAL;
-}
-
-bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: guest debug not yet implemented\n", __func__);
-    return false;
-}
-
-int kvm_arch_insert_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-    return -EINVAL;
-}
-
-int kvm_arch_remove_hw_breakpoint(target_ulong addr,
-                                  target_ulong len, int type)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-    return -EINVAL;
-}
-
-void kvm_arch_remove_all_hw_breakpoints(void)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-}
-
-void kvm_arm_copy_hw_debug_data(struct kvm_guest_debug_arch *ptr)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-}
-
-bool kvm_arm_hw_debug_active(CPUState *cs)
-{
-    return false;
-}
-
-void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-}
-
-void kvm_arm_pmu_init(CPUState *cs)
-{
-    qemu_log_mask(LOG_UNIMP, "%s: not implemented\n", __func__);
-}
-
-#define ARM_REG_DFSR  ARM_CP15_REG32(0, 5, 0, 0)
-#define ARM_REG_TTBCR ARM_CP15_REG32(0, 2, 0, 2)
-/*
- *DFSR:
- *      TTBCR.EAE == 0
- *          FS[4]   - DFSR[10]
- *          FS[3:0] - DFSR[3:0]
- *      TTBCR.EAE == 1
- *          FS, bits [5:0]
- */
-#define DFSR_FSC(lpae, v) \
-    ((lpae) ? ((v) & 0x3F) : (((v) >> 6) | ((v) & 0x1F)))
-
-#define DFSC_EXTABT(lpae) ((lpae) ? 0x10 : 0x08)
-
-bool kvm_arm_verify_ext_dabt_pending(CPUState *cs)
-{
-    uint32_t dfsr_val;
-
-    if (!kvm_get_one_reg(cs, ARM_REG_DFSR, &dfsr_val)) {
-        ARMCPU *cpu = ARM_CPU(cs);
-        CPUARMState *env = &cpu->env;
-        uint32_t ttbcr;
-        int lpae = 0;
-
-        if (!kvm_get_one_reg(cs, ARM_REG_TTBCR, &ttbcr)) {
-            lpae = arm_feature(env, ARM_FEATURE_LPAE) && (ttbcr & TTBCR_EAE);
-        }
-        /* The verification is based on FS filed of the DFSR reg only*/
-        return (DFSR_FSC(lpae, dfsr_val) == DFSC_EXTABT(lpae));
-    }
-    return false;
-}
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 89900907125..f5de2a77b89 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -34,10 +34,7 @@ arm_ss.add(zlib)
 
 arm_ss.add(when: 'CONFIG_TCG', if_true: files('arm-semi.c'))
 
-kvm_ss = ss.source_set()
-kvm_ss.add(when: 'TARGET_AARCH64', if_true: files('kvm64.c'), if_false: files('kvm32.c'))
-arm_ss.add_all(when: 'CONFIG_KVM', if_true: kvm_ss)
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'), if_false: files('kvm-stub.c'))
+arm_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c', 'kvm64.c'), if_false: files('kvm-stub.c'))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
-- 
2.20.1


