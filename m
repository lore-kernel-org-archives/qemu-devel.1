Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51305C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256C920640
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 08:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256C920640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAVCm-00038q-7N
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 04:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1iAV5K-0003Hx-DA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1iAV5I-0002Jc-Km
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 04:13:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1iAV5E-0002Fr-M3; Wed, 18 Sep 2019 04:13:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8I8C9Fh045867; Wed, 18 Sep 2019 04:12:57 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v3fva26cf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2019 04:12:56 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8I8AO2x027913;
 Wed, 18 Sep 2019 08:12:55 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03wdc.us.ibm.com with ESMTP id 2v37jvkphd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Sep 2019 08:12:55 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8I8Ctwh53281170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Sep 2019 08:12:55 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FAC912405A;
 Wed, 18 Sep 2019 08:12:55 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F170124053;
 Wed, 18 Sep 2019 08:12:53 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.199.61.50])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 18 Sep 2019 08:12:52 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Date: Wed, 18 Sep 2019 13:42:51 +0530
Message-ID: <156879437195.18368.2222030761877686909.stgit@aravinda>
In-Reply-To: <156879398718.18368.17640174821710157715.stgit@aravinda>
References: <156879398718.18368.17640174821710157715.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-18_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909180085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v14 6/7] migration: Include migration support
 for machine check handling
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
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch includes migration support for machine check
handling. Especially this patch blocks VM migration
requests until the machine check error handling is
complete as these errors are specific to the source
hardware and is irrelevant on the target hardware.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |   63 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_events.c  |   16 +++++++++++-
 hw/ppc/spapr_rtas.c    |    2 ++
 include/hw/ppc/spapr.h |    2 ++
 4 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6992b32..a72a4b1 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -46,6 +46,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/global_state.h"
 #include "migration/register.h"
+#include "migration/blocker.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 #include "cpu-models.h"
@@ -1829,6 +1830,8 @@ static void spapr_machine_reset(MachineState *machine)
 
     /* Signal all vCPUs waiting on this condition */
     qemu_cond_broadcast(&spapr->mc_delivery_cond);
+
+    migrate_del_blocker(spapr->fwnmi_migration_blocker);
 }
 
 static void spapr_create_nvram(SpaprMachineState *spapr)
@@ -2119,6 +2122,60 @@ static const VMStateDescription vmstate_spapr_dtb = {
     },
 };
 
+static bool spapr_fwnmi_needed(void *opaque)
+{
+    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
+
+    return spapr->guest_machine_check_addr != -1;
+}
+
+static int spapr_fwnmi_post_load(void *opaque, int version_id)
+{
+    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_ON) {
+
+        if (kvmppc_has_cap_ppc_fwnmi()) {
+            return 0;
+        }
+
+        return kvmppc_set_fwnmi();
+    }
+
+    return 0;
+}
+
+static int spapr_fwnmi_pre_save(void *opaque)
+{
+    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
+
+    /*
+     * With -only-migratable QEMU option, we cannot block migration.
+     * Hence check if machine check handling is in progress and print
+     * a warning message.
+     */
+    if (spapr->mc_status != -1) {
+        warn_report("A machine check is being handled during migration. The"
+                "handler may run and log hardware error on the destination");
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_spapr_machine_check = {
+    .name = "spapr_machine_check",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_fwnmi_needed,
+    .post_load = spapr_fwnmi_post_load,
+    .pre_save = spapr_fwnmi_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(guest_machine_check_addr, SpaprMachineState),
+        VMSTATE_INT32(mc_status, SpaprMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
@@ -2152,6 +2209,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_dtb,
         &vmstate_spapr_cap_large_decr,
         &vmstate_spapr_cap_ccf_assist,
+        &vmstate_spapr_machine_check,
         NULL
     }
 };
@@ -2948,6 +3006,11 @@ static void spapr_machine_init(MachineState *machine)
             exit(1);
         }
 
+        /* Create the error string for live migration blocker */
+        error_setg(&spapr->fwnmi_migration_blocker,
+            "A machine check is being handled during migration. The handler"
+            "may run and log hardware error on the destination");
+
         /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
         spapr_fwnmi_register();
     }
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index ecc3d68..71caa03 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -43,6 +43,7 @@
 #include "qemu/main-loop.h"
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
+#include "migration/blocker.h"
 
 #define RTAS_LOG_VERSION_MASK                   0xff000000
 #define   RTAS_LOG_VERSION_6                    0x06000000
@@ -844,6 +845,8 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     CPUState *cs = CPU(cpu);
+    int ret;
+    Error *local_err = NULL;
 
     if (spapr->guest_machine_check_addr == -1) {
         /*
@@ -873,8 +876,19 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
             return;
         }
     }
-    spapr->mc_status = cpu->vcpu_id;
 
+    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_err);
+    if (ret == -EBUSY) {
+        /*
+         * We don't want to abort so we let the migration to continue.
+         * In a rare case, the machine check handler will run on the target.
+         * Though this is not preferable, it is better than aborting
+         * the migration or killing the VM.
+         */
+        warn_report_err(local_err);
+    }
+
+    spapr->mc_status = cpu->vcpu_id;
     spapr_mce_dispatch_elog(cpu, recovered);
 }
 
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index b569538..c652ec3 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -50,6 +50,7 @@
 #include "hw/ppc/fdt.h"
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
+#include "migration/blocker.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -446,6 +447,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
      */
     spapr->mc_status = -1;
     qemu_cond_signal(&spapr->mc_delivery_cond);
+    migrate_del_blocker(spapr->fwnmi_migration_blocker);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index dada821..ea7625e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -217,6 +217,8 @@ struct SpaprMachineState {
 
     unsigned gpu_numa_id;
     SpaprTpmProxy *tpm_proxy;
+
+    Error *fwnmi_migration_blocker;
 };
 
 #define H_SUCCESS         0


