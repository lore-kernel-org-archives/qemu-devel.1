Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE4EC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96313229FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 12:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96313229FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqGgj-0006pZ-Q2
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 08:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54878)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sbhat@linux.ibm.com>) id 1hqGgU-0006HA-Uj
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1hqGgT-0001Zi-KT
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:47:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49490
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hqGgT-0001Yr-Dp
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 08:47:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6OClEib087623
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 08:47:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2txnju5v95-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 08:47:50 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Wed, 24 Jul 2019 13:47:49 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 24 Jul 2019 13:47:47 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6OClkqI50397192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jul 2019 12:47:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 81ADE42047;
 Wed, 24 Jul 2019 12:47:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3B1B4203F;
 Wed, 24 Jul 2019 12:47:45 +0000 (GMT)
Received: from lep8c.aus.stglabs.ibm.com (unknown [9.40.192.207])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 24 Jul 2019 12:47:45 +0000 (GMT)
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Date: Wed, 24 Jul 2019 07:47:45 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072412-0016-0000-0000-00000295B0DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072412-0017-0000-0000-000032F3A5A0
Message-Id: <156397239821.79647.2790800099666109879.stgit@lep8c.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-24_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240144
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v6] ppc: remove idle_timer logic
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

The KVM_CAP_PPC_IRQ_LEVEL is part of the kernel now since 2.6.37.
Drop the redundant logic which is not excercised on new the kernels anymore.
Exit with error on older kernels.

Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
---
 v5: https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg05301.html
 Changes from v5:
   - exit with error if KVM_CAP_PPC_IRQ_LEVEL is not there.

 target/ppc/kvm.c |   75 ++++--------------------------------------------------
 1 file changed, 5 insertions(+), 70 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8a06d3171e..4a3f36f0d5 100644
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
+        fprintf(stderr, "KVM: Host kernel doesn't have level irq capability\n");
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


