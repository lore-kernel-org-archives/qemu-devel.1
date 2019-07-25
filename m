Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13542C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D651E22BF5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D651E22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeWw-0002fy-UM
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59881)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sbhat@linux.ibm.com>) id 1hqeWj-0002Bk-03
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1hqeWh-0000IO-JJ
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:15:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58554)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hqeWf-0000Gf-L8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:15:22 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6PEEMDA086108
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:15:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tyd6ptr5n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 10:15:16 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 25 Jul 2019 15:15:14 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 25 Jul 2019 15:15:11 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6PEFAUT13959222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jul 2019 14:15:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4265A46DA;
 Thu, 25 Jul 2019 14:15:09 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1CD27A46E3;
 Thu, 25 Jul 2019 14:15:09 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jul 2019 14:15:08 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Date: Thu, 25 Jul 2019 09:15:08 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072514-0008-0000-0000-00000300C85B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072514-0009-0000-0000-0000226E5D3A
Message-Id: <156406409479.19996.7606556689856621111.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-25_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250166
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v7] ppc: remove idle_timer logic
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
Cc: groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The logic is broken for multiple vcpu guests, also causing memory leak.
The logic is in place to handle kvm not having KVM_CAP_PPC_IRQ_LEVEL,
which is part of the kernel now since 2.6.37. Instead of fixing the
leak, drop the redundant logic which is not excercised on new kernels
anymore. Exit with error on older kernels.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
v6: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05378.html
Changes from v6:
   - switched to error_report instead of fprintf
---
 target/ppc/kvm.c |   75 ++++--------------------------------------------------
 1 file changed, 5 insertions(+), 70 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8a06d3171e..5ab5e6c6a9 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -56,7 +56,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
 };
 
 static int cap_interrupt_unset;
-static int cap_interrupt_level;
 static int cap_segstate;
 static int cap_booke_sregs;
 static int cap_ppc_smt;
@@ -87,25 +86,6 @@ static int cap_large_decr;
 
 static uint32_t debug_inst_opcode;
 
-/*
- * XXX We have a race condition where we actually have a level triggered
- *     interrupt, but the infrastructure can't expose that yet, so the guest
- *     takes but ignores it, goes to sleep and never gets notified that there's
- *     still an interrupt pending.
- *
- *     As a quick workaround, let's just wake up again 20 ms after we injected
- *     an interrupt. That way we can assure that we're always reinjecting
- *     interrupts in case the guest swallowed them.
- */
-static QEMUTimer *idle_timer;
-
-static void kvm_kick_cpu(void *opaque)
-{
-    PowerPCCPU *cpu = opaque;
-
-    qemu_cpu_kick(CPU(cpu));
-}
-
 /*
  * Check whether we are running with KVM-PR (instead of KVM-HV).  This
  * should only be used for fallback tests - generally we should use
@@ -125,7 +105,6 @@ static int kvmppc_get_dec_bits(void);
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     cap_interrupt_unset = kvm_check_extension(s, KVM_CAP_PPC_UNSET_IRQ);
-    cap_interrupt_level = kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL);
     cap_segstate = kvm_check_extension(s, KVM_CAP_PPC_SEGSTATE);
     cap_booke_sregs = kvm_check_extension(s, KVM_CAP_PPC_BOOKE_SREGS);
     cap_ppc_smt_possible = kvm_vm_check_extension(s, KVM_CAP_PPC_SMT_POSSIBLE);
@@ -161,9 +140,9 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      */
     cap_ppc_pvr_compat = false;
 
-    if (!cap_interrupt_level) {
-        fprintf(stderr, "KVM: Couldn't find level irq capability. Expect the "
-                        "VM to stall at times!\n");
+    if (!kvm_check_extension(s, KVM_CAP_PPC_IRQ_LEVEL)) {
+        error_report("KVM: Host kernel doesn't have level irq capability");
+        exit(1);
     }
 
     kvm_ppc_register_host_cpu_type(ms);
@@ -491,8 +470,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return ret;
     }
 
-    idle_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, kvm_kick_cpu, cpu);
-
     switch (cenv->mmu_model) {
     case POWERPC_MMU_BOOKE206:
         /* This target supports access to KVM's guest TLB */
@@ -1332,7 +1309,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
         return 0;
     }
 
-    if (!kvm_enabled() || !cap_interrupt_unset || !cap_interrupt_level) {
+    if (!kvm_enabled() || !cap_interrupt_unset) {
         return 0;
     }
 
@@ -1349,49 +1326,7 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
 
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
-    PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = &cpu->env;
-    int r;
-    unsigned irq;
-
-    qemu_mutex_lock_iothread();
-
-    /*
-     * PowerPC QEMU tracks the various core input pins (interrupt,
-     * critical interrupt, reset, etc) in PPC-specific
-     * env->irq_input_state.
-     */
-    if (!cap_interrupt_level &&
-        run->ready_for_interrupt_injection &&
-        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
-        (env->irq_input_state & (1 << PPC_INPUT_INT)))
-    {
-        /*
-         * For now KVM disregards the 'irq' argument. However, in the
-         * future KVM could cache it in-kernel to avoid a heavyweight
-         * exit when reading the UIC.
-         */
-        irq = KVM_INTERRUPT_SET;
-
-        trace_kvm_injected_interrupt(irq);
-        r = kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &irq);
-        if (r < 0) {
-            printf("cpu %d fail inject %x\n", cs->cpu_index, irq);
-        }
-
-        /* Always wake up soon in case the interrupt was level based */
-        timer_mod(idle_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-                       (NANOSECONDS_PER_SECOND / 50));
-    }
-
-    /*
-     * We don't know if there are more interrupts pending after
-     * this. However, the guest will return to userspace in the course
-     * of handling this one anyways, so we will get a chance to
-     * deliver the rest.
-     */
-
-    qemu_mutex_unlock_iothread();
+    return;
 }
 
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)


