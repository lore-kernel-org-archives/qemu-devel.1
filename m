Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5203EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253E9206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253E9206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsuWl-0003xd-Fq
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jsuRk-0001Fe-9h; Tue, 07 Jul 2020 16:44:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bauerman@linux.ibm.com>)
 id 1jsuRg-0008Bc-S7; Tue, 07 Jul 2020 16:44:07 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 067Kbtsw008917; Tue, 7 Jul 2020 16:43:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 324yysrby7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 16:43:57 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 067KcJsh009800;
 Tue, 7 Jul 2020 16:43:56 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 324yysrbxy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 16:43:56 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067KegDW026330;
 Tue, 7 Jul 2020 20:43:56 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma04dal.us.ibm.com with ESMTP id 324bugsur1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2020 20:43:56 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 067Khtsa15729514
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2020 20:43:55 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 43947AE060;
 Tue,  7 Jul 2020 20:43:55 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CB32AE05C;
 Tue,  7 Jul 2020 20:43:53 +0000 (GMT)
Received: from morokweng.localdomain.com (unknown [9.211.127.86])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2020 20:43:52 +0000 (GMT)
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
To: qemu-ppc@nongnu.org
Subject: [PATCH] cpu: Add starts_halted() method
Date: Tue,  7 Jul 2020 17:43:33 -0300
Message-Id: <20200707204333.261506-1-bauerman@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-07_13:2020-07-07,
 2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 suspectscore=1 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 cotscore=-2147483648 malwarescore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007070134
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=bauerman@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 16:16:33
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PowerPC sPAPRs CPUs start in the halted state, but generic QEMU code
assumes that CPUs start in the non-halted state. spapr_reset_vcpu()
attempts to rectify this by setting CPUState::halted to 1. But that's too
late for hotplugged CPUs in a machine configured with 2 or mor threads per
core.

By then, other parts of QEMU have already caused the vCPU to run in an
unitialized state a couple of times. For example, ppc_cpu_reset() calls
ppc_tlb_invalidate_all(), which ends up calling async_run_on_cpu(). This
kicks the new vCPU while it has CPUState::halted = 0, causing QEMU to issue
a KVM_RUN ioctl on the new vCPU before the guest is able to make the
start-cpu RTAS call to initialize its register state.

This doesn't seem to cause visible issues for regular guests, but on a
secure guest running under the Ultravisor it does. The Ultravisor relies on
being able to snoop on the start-cpu RTAS call to map vCPUs to guests, and
this issue causes it to see a stray vCPU that doesn't belong to any guest.

Fix by adding a starts_halted() method to the CPUState class, and making it
return 1 if the machine is an sPAPR guest.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 hw/core/cpu.c                   |  8 +++++++-
 hw/ppc/spapr_cpu_core.c         |  5 -----
 include/hw/core/cpu.h           |  2 ++
 target/ppc/translate_init.inc.c | 16 ++++++++++++++++
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/hw/core/cpu.c b/hw/core/cpu.c
index 0f23409f1d..8f9a3335d5 100644
--- a/hw/core/cpu.c
+++ b/hw/core/cpu.c
@@ -259,7 +259,7 @@ static void cpu_common_reset(DeviceState *dev)
     }
 
     cpu->interrupt_request = 0;
-    cpu->halted = 0;
+    cpu->halted = cc->starts_halted();
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
     atomic_set(&cpu->icount_decr_ptr->u32, 0);
@@ -275,6 +275,11 @@ static void cpu_common_reset(DeviceState *dev)
     }
 }
 
+static uint32_t cpu_common_starts_halted(void)
+{
+    return 0;
+}
+
 static bool cpu_common_has_work(CPUState *cs)
 {
     return false;
@@ -428,6 +433,7 @@ static void cpu_class_init(ObjectClass *klass, void *data)
     k->cpu_exec_exit = cpu_common_noop;
     k->cpu_exec_interrupt = cpu_common_exec_interrupt;
     k->adjust_watchpoint_address = cpu_adjust_watchpoint_address;
+    k->starts_halted = cpu_common_starts_halted;
     set_bit(DEVICE_CATEGORY_CPU, dc->categories);
     dc->realize = cpu_common_realizefn;
     dc->unrealize = cpu_common_unrealizefn;
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 26ad566f42..d0ad92240c 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -36,11 +36,6 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
 
     cpu_reset(cs);
 
-    /* All CPUs start halted.  CPU0 is unhalted from the machine level
-     * reset code and the rest are explicitly started up by the guest
-     * using an RTAS call */
-    cs->halted = 1;
-
     env->spr[SPR_HIOR] = 0;
 
     lpcr = env->spr[SPR_LPCR];
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b3f4b79318..7c9cd67e8d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -219,6 +219,8 @@ typedef struct CPUClass {
     vaddr (*adjust_watchpoint_address)(CPUState *cpu, vaddr addr, int len);
     void (*tcg_initialize)(void);
 
+    uint32_t (*starts_halted)(void);
+
     /* Keep non-pointer data at the end to minimize holes.  */
     int gdb_num_core_regs;
     bool gdb_stop_before_watchpoint;
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 49212bfd90..1dc1ebbdaf 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -36,6 +36,7 @@
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/ppc.h"
+#include "hw/ppc/spapr.h"
 #include "mmu-book3s-v3.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
@@ -10646,6 +10647,20 @@ static void ppc_cpu_set_pc(CPUState *cs, vaddr value)
     cpu->env.nip = value;
 }
 
+static uint32_t ppc_cpu_starts_halted(void)
+{
+    SpaprMachineState *spapr =
+        (SpaprMachineState *) object_dynamic_cast(qdev_get_machine(),
+                                                  TYPE_SPAPR_MACHINE);
+
+    /*
+     * In sPAPR, all CPUs start halted. CPU0 is unhalted from the machine level
+     * reset code and the rest are explicitly started up by the guest using an
+     * RTAS call.
+     */
+    return spapr != NULL;
+}
+
 static bool ppc_cpu_has_work(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
@@ -10922,6 +10937,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
 #endif
 
     cc->disas_set_info = ppc_disas_set_info;
+    cc->starts_halted = ppc_cpu_starts_halted;
 
     dc->fw_name = "PowerPC,UNKNOWN";
 }

