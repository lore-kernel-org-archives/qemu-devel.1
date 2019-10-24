Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A412CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 07:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F84C2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 07:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F84C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNXt4-0005hf-Dt
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 03:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iNXn1-0006eN-PJ
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ganeshgr@linux.ibm.com>) id 1iNXn0-0007Zw-0r
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:44:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ganeshgr@linux.ibm.com>)
 id 1iNXmz-0007Zc-NU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 03:44:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9O7gmPB081311
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:44:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vu7kurg07-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 03:44:07 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <ganeshgr@linux.ibm.com>;
 Thu, 24 Oct 2019 08:44:05 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 24 Oct 2019 08:44:02 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9O7hSFb39125262
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 07:43:28 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93C2942047;
 Thu, 24 Oct 2019 07:44:01 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D5634203F;
 Thu, 24 Oct 2019 07:43:59 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.73.55])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 24 Oct 2019 07:43:59 +0000 (GMT)
From: Ganesh Goudar <ganeshgr@linux.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Subject: [PATCH v17 3/7] target/ppc: Handle NMI guest exit
Date: Thu, 24 Oct 2019 13:13:03 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
References: <20191024074307.22821-1-ganeshgr@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19102407-0016-0000-0000-000002BCA57E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102407-0017-0000-0000-0000331DE8D8
Message-Id: <20191024074307.22821-4-ganeshgr@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-24_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910240074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: paulus@ozlabs.org, arawinda.p@gmail.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aravinda Prasad <arawinda.p@gmail.com>

Memory error such as bit flips that cannot be corrected
by hardware are passed on to the kernel for handling.
If the memory address in error belongs to guest then
the guest kernel is responsible for taking suitable action.
Patch [1] enhances KVM to exit guest with exit reason
set to KVM_EXIT_NMI in such cases. This patch handles
KVM_EXIT_NMI exit.

[1] https://www.spinics.net/lists/kvm-ppc/msg12637.html
    (e20bbd3d and related commits)

Signed-off-by: Aravinda Prasad <arawinda.p@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c          |  8 ++++++++
 hw/ppc/spapr_events.c   | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h  | 10 ++++++++++
 target/ppc/kvm.c        | 14 ++++++++++++++
 target/ppc/kvm_ppc.h    |  2 ++
 target/ppc/trace-events |  1 +
 6 files changed, 72 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 31a3fb72d4..346ec5ba6c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1745,6 +1745,12 @@ static void spapr_machine_reset(MachineState *machine)
     first_ppc_cpu->env.gpr[5] = 0;
 
     spapr->cas_reboot = false;
+
+    spapr->mc_status = -1;
+    spapr->guest_machine_check_addr = -1;
+
+    /* Signal all vCPUs waiting on this condition */
+    qemu_cond_broadcast(&spapr->mc_delivery_cond);
 }
 
 static void spapr_create_nvram(SpaprMachineState *spapr)
@@ -3044,6 +3050,8 @@ static void spapr_machine_init(MachineState *machine)
 
         kvmppc_spapr_enable_inkernel_multitce();
     }
+
+    qemu_cond_init(&spapr->mc_delivery_cond);
 }
 
 static int spapr_kvm_type(MachineState *machine, const char *vm_type)
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 0e4c19523a..0ce96b86be 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -40,6 +40,7 @@
 #include "hw/ppc/spapr_drc.h"
 #include "qemu/help_option.h"
 #include "qemu/bcd.h"
+#include "qemu/main-loop.h"
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
 
@@ -621,6 +622,42 @@ void spapr_hotplug_req_remove_by_count_indexed(SpaprDrcType drc_type,
                             RTAS_LOG_V6_HP_ACTION_REMOVE, drc_type, &drc_id);
 }
 
+void spapr_mce_req_event(PowerPCCPU *cpu)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    CPUState *cs = CPU(cpu);
+
+    if (spapr->guest_machine_check_addr == -1) {
+        /*
+         * This implies that we have hit a machine check either when the
+         * guest has not registered FWNMI (i.e., "ibm,nmi-register" not
+         * called) or between system reset and "ibm,nmi-register".
+         * Fall back to the old machine check behavior in such cases.
+         */
+        cs->exception_index = POWERPC_EXCP_MCHECK;
+        ppc_cpu_do_interrupt(cs);
+        return;
+    }
+
+    while (spapr->mc_status != -1) {
+        /*
+         * Check whether the same CPU got machine check error
+         * while still handling the mc error (i.e., before
+         * that CPU called "ibm,nmi-interlock")
+         */
+        if (spapr->mc_status == cpu->vcpu_id) {
+            qemu_system_guest_panicked(NULL);
+            return;
+        }
+        qemu_cond_wait_iothread(&spapr->mc_delivery_cond);
+        /* Meanwhile if the system is reset, then just return */
+        if (spapr->guest_machine_check_addr == -1) {
+            return;
+        }
+    }
+    spapr->mc_status = cpu->vcpu_id;
+}
+
 static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
                             uint32_t token, uint32_t nargs,
                             target_ulong args,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index af9a9ce6f2..1f5eb8c856 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -190,6 +190,15 @@ struct SpaprMachineState {
      * occurs during the unplug process. */
     QTAILQ_HEAD(, SpaprDimmState) pending_dimm_unplugs;
 
+    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
+    target_ulong guest_machine_check_addr;
+    /*
+     * mc_status is set to -1 if mc is not in progress, else is set to the CPU
+     * handling the mc.
+     */
+    int mc_status;
+    QemuCond mc_delivery_cond;
+
     /*< public >*/
     char *kvm_type;
     char *host_model;
@@ -803,6 +812,7 @@ void spapr_clear_pending_events(SpaprMachineState *spapr);
 int spapr_max_server_number(SpaprMachineState *spapr);
 void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
                       uint64_t pte0, uint64_t pte1);
+void spapr_mce_req_event(PowerPCCPU *cpu);
 
 /* DRC callbacks. */
 void spapr_core_release(DeviceState *dev);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d56f11a883..2d8db6d832 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1708,6 +1708,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = 0;
         break;
 
+    case KVM_EXIT_NMI:
+        trace_kvm_handle_nmi_exception();
+        ret = kvm_handle_nmi(cpu, run);
+        break;
+
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
@@ -2798,6 +2803,15 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
     return data & 0xffff;
 }
 
+int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
+{
+    cpu_synchronize_state(CPU(cpu));
+
+    spapr_mce_req_event(cpu);
+
+    return 0;
+}
+
 int kvmppc_enable_hwrng(void)
 {
     if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_PPC_HWRNG)) {
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 5727a5025f..e88ee786a3 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -83,6 +83,8 @@ void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
 void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
 void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
 
+int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run);
+
 #else
 
 static inline uint32_t kvmppc_get_tbfreq(void)
diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index 3dc6740706..6d15aa90b4 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -28,3 +28,4 @@ kvm_handle_papr_hcall(void) "handle PAPR hypercall"
 kvm_handle_epr(void) "handle epr"
 kvm_handle_watchdog_expiry(void) "handle watchdog expiry"
 kvm_handle_debug_exception(void) "handle debug exception"
+kvm_handle_nmi_exception(void) "handle NMI exception"
-- 
2.17.2


