Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F14AC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 597FD205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 12:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nExsMyhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 597FD205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45709 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNytM-0004xa-JN
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 08:08:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNyln-0007VU-8X
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hNyll-0003Xe-8c
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hNylk-0003S9-V0
	for qemu-devel@nongnu.org; Tue, 07 May 2019 08:00:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so11637022wrq.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 05:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=3D9o4lpLLG1z7/od2Fd1VLuk47xpnXC+UL6uQauoS3c=;
	b=nExsMyhPC7V7gwIkdr6kCCZ6ngSXCQXAhu0N2IDDhMQknGxR+cmCiP0vxuS5E8tTyw
	FDtSJfcR8LGEbb4rEWIuvmGEEs/A9y2ZhlpLwTFMBkNwyZIfNIQw7HrDrpG3cagWGcEf
	MTTwtUS8Mm7tdeNT9/iSYjBpQqgdK8udamw8fVCFOAsI/ztxmXqwTkqSsFFAwk2+gerZ
	xhMCh3hVSmkFofyobSIu3rn+zRt2wocXCqRL9N7gZ2NJl+EWeeno/+LvdiwR6EkZCTf2
	JL+Yd/ayHYeecTS4+XAyNo5n7Yb1afeKT8N3HpZpB/IJfcxonpR9BN7HH+7lu8uHYZ1E
	kSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=3D9o4lpLLG1z7/od2Fd1VLuk47xpnXC+UL6uQauoS3c=;
	b=YAZ7liikzuiWZfpRs3B0aUSliJ1HR1K2Xoj9kv+8ezrIAF0C0MHC6BZH+l8OS4TLYW
	Jcd1fxlD9SDjywjJnzEY6bLh1+lcH1ZjQlnaH5JBu1Hy2kWgc/xgOa38/KWI5eSr0te+
	4PulOYoGQzoPhtbYcf1ap3elPoTLkRAKxtYRXASWI5FEhaXMtp4R0ytbzru5v69Bcv+m
	8IbAaZEc5ftEY7X1BB/rp4Zsp0QvcrcgcjoJxDxRb3KMazxvWI2Y+tgRWgcagn+7ok6D
	T+ZAt1f8Sf3JzrK1Ggtw2DrhzlanhgTV2Os84OYM9PO5MW+o7D05CG1ZP3KUCAgUjERC
	KS/g==
X-Gm-Message-State: APjAAAXJNs7U0tVh7GNlFS0FMYeFtdSB2kyjnjmAOeTUu7BrptdWTJMb
	uy83WqInABuTK+0CMhmw++oVHeIOiBI=
X-Google-Smtp-Source: APXvYqyISecavTz0cYOlXGefqCCdh3dW/YIGtzg+5xgtaoMYePLchwAhWuEsuZ/QpRQzWGz7HQfWmg==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr21325283wrw.307.1557230421933; 
	Tue, 07 May 2019 05:00:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id g3sm12348596wmf.9.2019.05.07.05.00.20
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 07 May 2019 05:00:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 13:00:01 +0100
Message-Id: <20190507120011.18100-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507120011.18100-1-peter.maydell@linaro.org>
References: <20190507120011.18100-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 05/15] arm: Allow system registers for KVM
 guests to be changed by QEMU code
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

At the moment the Arm implementations of kvm_arch_{get,put}_registers()
don't support having QEMU change the values of system registers
(aka coprocessor registers for AArch32). This is because although
kvm_arch_get_registers() calls write_list_to_cpustate() to
update the CPU state struct fields (so QEMU code can read the
values in the usual way), kvm_arch_put_registers() does not
call write_cpustate_to_list(), meaning that any changes to
the CPU state struct fields will not be passed back to KVM.

The rationale for this design is documented in a comment in the
AArch32 kvm_arch_put_registers() -- writing the values in the
cpregs list into the CPU state struct is "lossy" because the
write of a register might not succeed, and so if we blindly
copy the CPU state values back again we will incorrectly
change register values for the guest. The assumption was that
no QEMU code would need to write to the registers.

However, when we implemented debug support for KVM guests, we
broke that assumption: the code to handle "set the guest up
to take a breakpoint exception" does so by updating various
guest registers including ESR_EL1.

Support this by making kvm_arch_put_registers() synchronize
CPU state back into the list. We sync only those registers
where the initial write succeeds, which should be sufficient.

This commit is the same as commit 823e1b3818f9b10b824ddc which we
had to revert in commit 942f99c825fc94c8b1a4, except that the bug
which was preventing EDK2 guest firmware running has been fixed:
kvm_arm_reset_vcpu() now calls write_list_to_cpustate().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.h     |  9 ++++++++-
 target/arm/helper.c  | 27 +++++++++++++++++++++++++--
 target/arm/kvm.c     |  8 ++++++++
 target/arm/kvm32.c   | 20 ++------------------
 target/arm/kvm64.c   |  2 ++
 target/arm/machine.c |  2 +-
 6 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 22bc6e00ab9..0304ddd9f11 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2610,18 +2610,25 @@ bool write_list_to_cpustate(ARMCPU *cpu);
 /**
  * write_cpustate_to_list:
  * @cpu: ARMCPU
+ * @kvm_sync: true if this is for syncing back to KVM
  *
  * For each register listed in the ARMCPU cpreg_indexes list, write
  * its value from the ARMCPUState structure into the cpreg_values list.
  * This is used to copy info from TCG's working data structures into
  * KVM or for outbound migration.
  *
+ * @kvm_sync is true if we are doing this in order to sync the
+ * register state back to KVM. In this case we will only update
+ * values in the list if the previous list->cpustate sync actually
+ * successfully wrote the CPU state. Otherwise we will keep the value
+ * that is in the list.
+ *
  * Returns: true if all register values were read correctly,
  * false if some register was unknown or could not be read.
  * Note that we do not stop early on failure -- we will attempt
  * reading all registers in the list.
  */
-bool write_cpustate_to_list(ARMCPU *cpu);
+bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync);
 
 #define ARM_CPUID_TI915T      0x54029152
 #define ARM_CPUID_TI925T      0x54029252
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 81a92ab4911..9b805d0e6bd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -266,7 +266,7 @@ static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
     return true;
 }
 
-bool write_cpustate_to_list(ARMCPU *cpu)
+bool write_cpustate_to_list(ARMCPU *cpu, bool kvm_sync)
 {
     /* Write the coprocessor state from cpu->env to the (index,value) list. */
     int i;
@@ -275,6 +275,7 @@ bool write_cpustate_to_list(ARMCPU *cpu)
     for (i = 0; i < cpu->cpreg_array_len; i++) {
         uint32_t regidx = kvm_to_cpreg_id(cpu->cpreg_indexes[i]);
         const ARMCPRegInfo *ri;
+        uint64_t newval;
 
         ri = get_arm_cp_reginfo(cpu->cp_regs, regidx);
         if (!ri) {
@@ -284,7 +285,29 @@ bool write_cpustate_to_list(ARMCPU *cpu)
         if (ri->type & ARM_CP_NO_RAW) {
             continue;
         }
-        cpu->cpreg_values[i] = read_raw_cp_reg(&cpu->env, ri);
+
+        newval = read_raw_cp_reg(&cpu->env, ri);
+        if (kvm_sync) {
+            /*
+             * Only sync if the previous list->cpustate sync succeeded.
+             * Rather than tracking the success/failure state for every
+             * item in the list, we just recheck "does the raw write we must
+             * have made in write_list_to_cpustate() read back OK" here.
+             */
+            uint64_t oldval = cpu->cpreg_values[i];
+
+            if (oldval == newval) {
+                continue;
+            }
+
+            write_raw_cp_reg(&cpu->env, ri, oldval);
+            if (read_raw_cp_reg(&cpu->env, ri) != oldval) {
+                continue;
+            }
+
+            write_raw_cp_reg(&cpu->env, ri, newval);
+        }
+        cpu->cpreg_values[i] = newval;
     }
     return ok;
 }
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 79a79f01905..59956346126 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -497,6 +497,14 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
         fprintf(stderr, "write_kvmstate_to_list failed\n");
         abort();
     }
+    /*
+     * Sync the reset values also into the CPUState. This is necessary
+     * because the next thing we do will be a kvm_arch_put_registers()
+     * which will update the list values from the CPUState before copying
+     * the list values back to KVM. It's OK to ignore failure returns here
+     * for the same reason we do so in kvm_arch_get_registers().
+     */
+    write_list_to_cpustate(cpu);
 }
 
 /*
diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 50327989dcc..327375f6252 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -384,24 +384,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    /* Note that we do not call write_cpustate_to_list()
-     * here, so we are only writing the tuple list back to
-     * KVM. This is safe because nothing can change the
-     * CPUARMState cp15 fields (in particular gdb accesses cannot)
-     * and so there are no changes to sync. In fact syncing would
-     * be wrong at this point: for a constant register where TCG and
-     * KVM disagree about its value, the preceding write_list_to_cpustate()
-     * would not have had any effect on the CPUARMState value (since the
-     * register is read-only), and a write_cpustate_to_list() here would
-     * then try to write the TCG value back into KVM -- this would either
-     * fail or incorrectly change the value the guest sees.
-     *
-     * If we ever want to allow the user to modify cp15 registers via
-     * the gdb stub, we would need to be more clever here (for instance
-     * tracking the set of registers kvm_arch_get_registers() successfully
-     * managed to update the CPUARMState with, and only allowing those
-     * to be written back up into the kernel).
-     */
+    write_cpustate_to_list(cpu, true);
+
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 089af9c5f02..e3ba1492482 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -838,6 +838,8 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
+    write_cpustate_to_list(cpu, true);
+
     if (!write_list_to_kvmstate(cpu, level)) {
         return EINVAL;
     }
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 09567d4fc66..96d032f2a7e 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -646,7 +646,7 @@ static int cpu_pre_save(void *opaque)
             abort();
         }
     } else {
-        if (!write_cpustate_to_list(cpu)) {
+        if (!write_cpustate_to_list(cpu, false)) {
             /* This should never fail. */
             abort();
         }
-- 
2.20.1


