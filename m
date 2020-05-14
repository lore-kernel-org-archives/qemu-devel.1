Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBE7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30C5205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 14:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiZrJr1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30C5205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZEyQ-0006B9-VV
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 10:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkf-0003Yg-H7
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZEkc-0005z0-FL
 for qemu-devel@nongnu.org; Thu, 14 May 2020 10:22:21 -0400
Received: by mail-wr1-x444.google.com with SMTP id e1so4371680wrt.5
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PdbtnFBj4P4Alg5nl63YohFr/opafjNp+aOt4l9R7OQ=;
 b=QiZrJr1CdTphCFAgwxmZE02CKsyW3OARGrfM7pMRoIYc3D7lrUgqXvEIsy4GoC++ek
 0g/B0Oy7i66WyYCPI1EoOYb5UOkzbdveHycqL0y03Nwayp/8UGZzM7keYDx6f3v0NeMh
 DSXnDBU4g1QYxYRhDnws1cUIOkJvmJhRT6DMxUhUkb2fE9Cb0K6kAczBxwTFDdsZWOob
 BKsUMH9netENamtq58w0LSjwc7p/sB5bL23kHMDomojQHEOnPid770HnPY6/TeNp3rPt
 vq5uIfcjylxxXupanWnViX0oBgAfyl2JSWU7+pJJAD1ESSlwE81faHCx7atbwdeoNpvq
 tcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PdbtnFBj4P4Alg5nl63YohFr/opafjNp+aOt4l9R7OQ=;
 b=CGjDTAN4EebeXmPEuqbczzZWyuuaVAjKmEpTf/jj15N7yfPXf2WU6KGGYae5aY0bn0
 UW8jayCWIcF/ufChPXqcBkEO0bRxaQ0mVBL0vNCC5vvN7weLZ/n3maoGjfftwGZjVHDQ
 mUymGkXFsRFUy1q/0LGns0O9kLvvRbkmz5+t8n9PO0k8cZOQtmRIcHEoYwkeMHcMn8sS
 YeA7fjehAYIjfN98qbJLkDK82KDmjXJyLBOThdV8keHhWMTh4BEjC9zKCs0PaV+ePo+v
 zFfl0RO6Ek5VGpqXE4zgLkOWt89dRwNRegGON/tfL4pIv7bJQYmfVM8vKN8JRK+80e9L
 OElw==
X-Gm-Message-State: AOAM532EOcukv9IQEN6yQcv/zxwx+XB2YYTPfnhjrGErHfSg0HzCgV8W
 8kh+V5hSLBucGdRi2qpvUrs7tW0xfKEC/Q==
X-Google-Smtp-Source: ABdhPJwVX0xtoie8qzNVZQKDbSIe7HKwUnt1cNGDJACuob4R3adgQbXw9VS9l9s87dNkH0iaoSTqdA==
X-Received: by 2002:a5d:6705:: with SMTP id o5mr5971557wru.426.1589466135961; 
 Thu, 14 May 2020 07:22:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 88sm4077443wrq.77.2020.05.14.07.22.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2020 07:22:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/45] target-arm: kvm64: handle SIGBUS signal from kernel or
 KVM
Date: Thu, 14 May 2020 15:21:20 +0100
Message-Id: <20200514142138.20875-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514142138.20875-1-peter.maydell@linaro.org>
References: <20200514142138.20875-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

From: Dongjiu Geng <gengdongjiu@huawei.com>

Add a SIGBUS signal handler. In this handler, it checks the SIGBUS type,
translates the host VA delivered by host to guest PA, then fills this PA
to guest APEI GHES memory, then notifies guest according to the SIGBUS
type.

When guest accesses the poisoned memory, it will generate a Synchronous
External Abort(SEA). Then host kernel gets an APEI notification and calls
memory_failure() to unmapped the affected page in stage 2, finally
returns to guest.

Guest continues to access the PG_hwpoison page, it will trap to KVM as
stage2 fault, then a SIGBUS_MCEERR_AR synchronous signal is delivered to
Qemu, Qemu records this error address into guest APEI GHES memory and
notifes guest using Synchronous-External-Abort(SEA).

In order to inject a vSEA, we introduce the kvm_inject_arm_sea() function
in which we can setup the type of exception and the syndrome information.
When switching to guest, the target vcpu will jump to the synchronous
external abort vector table entry.

The ESR_ELx.DFSC is set to synchronous external abort(0x10), and the
ESR_ELx.FnV is set to not valid(0x1), which will tell guest that FAR is
not valid and hold an UNKNOWN value. These values will be set to KVM
register structures through KVM_SET_ONE_REG IOCTL.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Xiang Zheng <zhengxiang9@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200512030609.19593-10-gengdongjiu@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/sysemu/kvm.h    |  3 +-
 target/arm/cpu.h        |  4 +++
 target/arm/internals.h  |  5 +--
 target/i386/cpu.h       |  2 ++
 target/arm/helper.c     |  2 +-
 target/arm/kvm64.c      | 77 +++++++++++++++++++++++++++++++++++++++++
 target/arm/tlb_helper.c |  2 +-
 7 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 141342de982..3b2250471ca 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -379,8 +379,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#ifdef TARGET_I386
-#define KVM_HAVE_MCE_INJECTION 1
+#ifdef KVM_HAVE_MCE_INJECTION
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 #endif
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 676f216b67c..5d995368d4f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -28,6 +28,10 @@
 /* ARM processors have a weak memory model */
 #define TCG_GUEST_DEFAULT_MO      (0)
 
+#ifdef TARGET_AARCH64
+#define KVM_HAVE_MCE_INJECTION 1
+#endif
+
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
 #define EXCP_PREFETCH_ABORT  3
diff --git a/target/arm/internals.h b/target/arm/internals.h
index a833e3941d3..4bdbc3a8ace 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -451,13 +451,14 @@ static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
         | ARM_EL_IL | (ea << 9) | (s1ptw << 7) | fsc;
 }
 
-static inline uint32_t syn_data_abort_no_iss(int same_el,
+static inline uint32_t syn_data_abort_no_iss(int same_el, int fnv,
                                              int ea, int cm, int s1ptw,
                                              int wnr, int fsc)
 {
     return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
            | ARM_EL_IL
-           | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
+           | (fnv << 10) | (ea << 9) | (cm << 8) | (s1ptw << 7)
+           | (wnr << 6) | fsc;
 }
 
 static inline uint32_t syn_data_abort_with_iss(int same_el,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e818fc712ac..408392dbf6f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -29,6 +29,8 @@
 /* The x86 has a strong memory model with some store-after-load re-ordering */
 #define TCG_GUEST_DEFAULT_MO      (TCG_MO_ALL & ~TCG_MO_ST_LD)
 
+#define KVM_HAVE_MCE_INJECTION 1
+
 /* Maximum instruction code size */
 #define TARGET_MAX_INSN_SIZE 16
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b88d27819d5..a92ae55672f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3465,7 +3465,7 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
              * Report exception with ESR indicating a fault due to a
              * translation table walk for a cache maintenance instruction.
              */
-            syn = syn_data_abort_no_iss(current_el == target_el,
+            syn = syn_data_abort_no_iss(current_el == target_el, 0,
                                         fi.ea, 1, fi.s1ptw, 1, fsc);
             env->exception.vaddress = value;
             env->exception.fsr = fsr;
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index cd8ab6b8aed..f09ed9f4df3 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -28,6 +28,9 @@
 #include "sysemu/kvm_int.h"
 #include "kvm_arm.h"
 #include "internals.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/ghes.h"
+#include "hw/arm/virt.h"
 
 static bool have_guest_debug;
 
@@ -883,6 +886,30 @@ int kvm_arm_cpreg_level(uint64_t regidx)
     return KVM_PUT_RUNTIME_STATE;
 }
 
+/* Callers must hold the iothread mutex lock */
+static void kvm_inject_arm_sea(CPUState *c)
+{
+    ARMCPU *cpu = ARM_CPU(c);
+    CPUARMState *env = &cpu->env;
+    CPUClass *cc = CPU_GET_CLASS(c);
+    uint32_t esr;
+    bool same_el;
+
+    c->exception_index = EXCP_DATA_ABORT;
+    env->exception.target_el = 1;
+
+    /*
+     * Set the DFSC to synchronous external abort and set FnV to not valid,
+     * this will tell guest the FAR_ELx is UNKNOWN for this abort.
+     */
+    same_el = arm_current_el(env) == env->exception.target_el;
+    esr = syn_data_abort_no_iss(same_el, 1, 0, 0, 0, 0, 0x10);
+
+    env->exception.syndrome = esr;
+
+    cc->do_interrupt(c);
+}
+
 #define AARCH64_CORE_REG(x)   (KVM_REG_ARM64 | KVM_REG_SIZE_U64 | \
                  KVM_REG_ARM_CORE | KVM_REG_ARM_CORE_REG(x))
 
@@ -1316,6 +1343,56 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+{
+    ram_addr_t ram_addr;
+    hwaddr paddr;
+    Object *obj = qdev_get_machine();
+    VirtMachineState *vms = VIRT_MACHINE(obj);
+    bool acpi_enabled = virt_is_acpi_enabled(vms);
+
+    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
+
+    if (acpi_enabled && addr &&
+            object_property_get_bool(obj, "ras", NULL)) {
+        ram_addr = qemu_ram_addr_from_host(addr);
+        if (ram_addr != RAM_ADDR_INVALID &&
+            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            kvm_hwpoison_page_add(ram_addr);
+            /*
+             * If this is a BUS_MCEERR_AR, we know we have been called
+             * synchronously from the vCPU thread, so we can easily
+             * synchronize the state and inject an error.
+             *
+             * TODO: we currently don't tell the guest at all about
+             * BUS_MCEERR_AO. In that case we might either be being
+             * called synchronously from the vCPU thread, or a bit
+             * later from the main thread, so doing the injection of
+             * the error would be more complicated.
+             */
+            if (code == BUS_MCEERR_AR) {
+                kvm_cpu_synchronize_state(c);
+                if (!acpi_ghes_record_errors(ACPI_HEST_SRC_ID_SEA, paddr)) {
+                    kvm_inject_arm_sea(c);
+                } else {
+                    error_report("failed to record the error");
+                    abort();
+                }
+            }
+            return;
+        }
+        if (code == BUS_MCEERR_AO) {
+            error_report("Hardware memory error at addr %p for memory used by "
+                "QEMU itself instead of guest system!", addr);
+        }
+    }
+
+    if (code == BUS_MCEERR_AR) {
+        error_report("Hardware memory error!");
+        exit(1);
+    }
+}
+
 /* C6.6.29 BRK instruction */
 static const uint32_t brk_insn = 0xd4200000;
 
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
index e63f8bda296..7388494a554 100644
--- a/target/arm/tlb_helper.c
+++ b/target/arm/tlb_helper.c
@@ -33,7 +33,7 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
      * ISV field.
      */
     if (!(template_syn & ARM_EL_ISV) || target_el != 2 || s1ptw) {
-        syn = syn_data_abort_no_iss(same_el,
+        syn = syn_data_abort_no_iss(same_el, 0,
                                     ea, 0, s1ptw, is_write, fsc);
     } else {
         /*
-- 
2.20.1


