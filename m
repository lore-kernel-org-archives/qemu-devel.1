Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E779C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455FB206A5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455FB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7QC-00039A-2H
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 14:13:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1if7NZ-0008Jv-3O
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1if7NX-00021b-GO
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:10:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31582
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1if7NX-0001yp-Aw; Wed, 11 Dec 2019 14:10:31 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBBJ1lRe059661; Wed, 11 Dec 2019 14:10:22 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc2mevc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 14:10:22 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBBJ3dsQ064832;
 Wed, 11 Dec 2019 14:10:21 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wsqc2mev3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 14:10:21 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBBIwAnZ000910;
 Wed, 11 Dec 2019 19:10:21 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma05wdc.us.ibm.com with ESMTP id 2wtdq7akwc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 19:10:21 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBBJAKPq60490076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2019 19:10:20 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD6ECC605B;
 Wed, 11 Dec 2019 19:10:19 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 82172C606E;
 Wed, 11 Dec 2019 19:10:18 +0000 (GMT)
Received: from farosas.linux.ibm.com.br.ibm.com (unknown [9.86.27.131])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2019 19:10:18 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 2/3] kvm-all: Introduce kvm_set_singlestep
Date: Wed, 11 Dec 2019 16:10:12 -0300
Message-Id: <20191211191013.454125-3-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211191013.454125-1-farosas@linux.ibm.com>
References: <20191211191013.454125-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_05:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 malwarescore=0 suspectscore=1 clxscore=1015 mlxscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110156
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For single stepping (via KVM) of a guest vcpu to work, KVM needs not
only to support the SET_GUEST_DEBUG ioctl but to also recognize the
KVM_GUESTDBG_SINGLESTEP bit in the control field of the
kvm_guest_debug struct.

This patch adds support for querying the single step capability so
that QEMU can decide what to do for the platforms that do not have
such support.

This will allow architecture-specific implementations of a fallback
mechanism for single stepping in cases where KVM does not support it.

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 accel/kvm/kvm-all.c         | 14 ++++++++++++++
 accel/stubs/kvm-stub.c      |  4 ++++
 exec.c                      |  2 +-
 include/sysemu/kvm.h        |  4 ++++
 stubs/Makefile.objs         |  1 +
 stubs/kvm-arch-singlestep.c | 14 ++++++++++++++
 target/ppc/kvm.c            | 14 ++++++++++++++
 7 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 stubs/kvm-arch-singlestep.c

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index ca00daa2f5..a61beb0b53 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2599,6 +2599,11 @@ bool kvm_arm_supports_user_irq(void)
 }
 
 #ifdef KVM_CAP_SET_GUEST_DEBUG
+bool kvm_has_guest_debug_singlestep(CPUState *cs)
+{
+    return kvm_arch_has_guest_debug_singlestep(cs);
+}
+
 struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu,
                                                  target_ulong pc)
 {
@@ -2647,6 +2652,15 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     return data.err;
 }
 
+void kvm_set_singlestep(CPUState *cs, int enabled)
+{
+    if (kvm_has_guest_debug_singlestep(cs)) {
+        kvm_update_guest_debug(cs, 0);
+    } else {
+        kvm_arch_set_singlestep(cs, enabled);
+    }
+}
+
 int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type)
 {
diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index 82f118d2df..b4df48b6f1 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -78,6 +78,10 @@ int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
     return -ENOSYS;
 }
 
+void kvm_set_singlestep(CPUState *cs, int enabled)
+{
+}
+
 int kvm_insert_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type)
 {
diff --git a/exec.c b/exec.c
index ffdb518535..ff46ea1846 100644
--- a/exec.c
+++ b/exec.c
@@ -1202,7 +1202,7 @@ void cpu_single_step(CPUState *cpu, int enabled)
     if (cpu->singlestep_enabled != enabled) {
         cpu->singlestep_enabled = enabled;
         if (kvm_enabled()) {
-            kvm_update_guest_debug(cpu, 0);
+            kvm_set_singlestep(cpu, enabled);
         } else {
             /* must flush all the translated code to avoid inconsistencies */
             /* XXX: only flush what is necessary */
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 9fe233b9bf..7a42978b11 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -215,6 +215,7 @@ int kvm_has_pit_state2(void);
 int kvm_has_many_ioeventfds(void);
 int kvm_has_gsi_routing(void);
 int kvm_has_intx_set_mask(void);
+bool kvm_has_guest_debug_singlestep(CPUState *cs);
 
 int kvm_init_vcpu(CPUState *cpu);
 int kvm_cpu_exec(CPUState *cpu);
@@ -247,6 +248,8 @@ bool kvm_memcrypt_enabled(void);
  */
 int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len);
 
+bool kvm_arch_has_guest_debug_singlestep(CPUState *cs);
+void kvm_arch_set_singlestep(CPUState *cpu, int enabled);
 
 #ifdef NEED_CPU_H
 #include "cpu.h"
@@ -259,6 +262,7 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type);
 void kvm_remove_all_breakpoints(CPUState *cpu);
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
+void kvm_set_singlestep(CPUState *cs, int enabled);
 
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 int kvm_on_sigbus(int code, void *addr);
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 4a50e95ec3..361f4088fa 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -12,6 +12,7 @@ stub-obj-y += get-vm-name.o
 stub-obj-y += iothread.o
 stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
+stub-obj-y += kvm-arch-singlestep.o
 stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
diff --git a/stubs/kvm-arch-singlestep.c b/stubs/kvm-arch-singlestep.c
new file mode 100644
index 0000000000..18bfba61f6
--- /dev/null
+++ b/stubs/kvm-arch-singlestep.c
@@ -0,0 +1,14 @@
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/kvm.h"
+
+bool kvm_arch_has_guest_debug_singlestep(CPUState *cs)
+{
+    /* for backwards compatibility assume the feature is present */
+    return true;
+}
+
+void kvm_arch_set_singlestep(CPUState *cpu, int enabled)
+{
+    warn_report("KVM does not support single stepping");
+}
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index c77f9848ec..3a2cfe883c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -85,6 +85,7 @@ static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_count_cache_flush_assist;
 static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
+static int cap_ppc_singlestep;
 
 static uint32_t debug_inst_opcode;
 
@@ -133,6 +134,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     kvmppc_get_cpu_characteristics(s);
     cap_ppc_nested_kvm_hv = kvm_vm_check_extension(s, KVM_CAP_PPC_NESTED_HV);
     cap_large_decr = kvmppc_get_dec_bits();
+    cap_ppc_singlestep = kvm_vm_check_extension(s, KVM_CAP_PPC_GUEST_DEBUG_SSTEP);
     /*
      * Note: setting it to false because there is not such capability
      * in KVM at this moment.
@@ -1380,6 +1382,18 @@ static int kvmppc_handle_dcr_write(CPUPPCState *env,
     return 0;
 }
 
+bool kvm_arch_has_guest_debug_singlestep(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    if (cap_ppc_singlestep) {
+        return true;
+    }
+
+    return env->excp_model == POWERPC_EXCP_BOOKE || kvmppc_is_pr(kvm_state);
+}
+
 int kvm_arch_insert_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
 {
     /* Mixed endian case is not handled */
-- 
2.23.0


