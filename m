Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58D9C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7648721726
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:24:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7648721726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3d9D-0002tu-MS
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 05:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i3czX-00046e-8x
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:14:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i3czR-0001DQ-Oj
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:14:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1i3czJ-0000lZ-B2; Fri, 30 Aug 2019 05:14:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7U97MiT028756; Fri, 30 Aug 2019 05:14:20 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uq03tj87u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2019 05:14:20 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7U99OQY021541;
 Fri, 30 Aug 2019 09:14:19 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma03dal.us.ibm.com with ESMTP id 2umpctyujn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2019 09:14:19 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7U9EJhC53150056
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2019 09:14:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC6F1B2065;
 Fri, 30 Aug 2019 09:14:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A199B2066;
 Fri, 30 Aug 2019 09:14:17 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.85.75.15])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 30 Aug 2019 09:14:16 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Date: Fri, 30 Aug 2019 14:44:16 +0530
Message-ID: <156715645601.27761.6812093467822316951.stgit@aravinda>
In-Reply-To: <156715632966.27761.8190459106519248668.stgit@aravinda>
References: <156715632966.27761.8190459106519248668.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-30_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v12 6/6] migration: Include migration support
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
complete as (i) these errors are specific to the source
hardware and is irrelevant on the target hardware,
(ii) these errors cause data corruption and should
be handled before migration.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |   44 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_events.c  |   14 ++++++++++++++
 hw/ppc/spapr_rtas.c    |    2 ++
 include/hw/ppc/spapr.h |    2 ++
 4 files changed, 62 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c0908e..f6262f0 100644
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
@@ -2119,6 +2122,42 @@ static const VMStateDescription vmstate_spapr_dtb = {
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
+static const VMStateDescription vmstate_spapr_machine_check = {
+    .name = "spapr_machine_check",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_fwnmi_needed,
+    .post_load = spapr_fwnmi_post_load,
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
@@ -2152,6 +2191,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_dtb,
         &vmstate_spapr_cap_large_decr,
         &vmstate_spapr_cap_ccf_assist,
+        &vmstate_spapr_machine_check,
         NULL
     }
 };
@@ -2948,6 +2988,10 @@ static void spapr_machine_init(MachineState *machine)
             exit(1);
         }
 
+        /* Create the error string for live migration blocker */
+        error_setg(&spapr->fwnmi_migration_blocker,
+            "Live migration not supported during machine check handling");
+
         /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
         spapr_fwnmi_register();
     }
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 8ebb85e..a8ce9bd 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -43,6 +43,7 @@
 #include "qemu/main-loop.h"
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
+#include "migration/blocker.h"
 
 #define RTAS_LOG_VERSION_MASK                   0xff000000
 #define   RTAS_LOG_VERSION_6                    0x06000000
@@ -854,6 +855,19 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    int ret;
+    Error *local_err = NULL;
+
+    ret = migrate_add_blocker(spapr->fwnmi_migration_blocker, &local_err);
+    if (ret < 0) {
+        /*
+         * We don't want to abort and let the migration to continue. In a
+         * rare case, the machine check handler will run on the target
+         * hardware. Though this is not preferable, it is better than aborting
+         * the migration or killing the VM.
+         */
+        warn_report_err(local_err);
+    }
 
     while (spapr->mc_status != -1) {
         /*
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d892583..b682cc2 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -50,6 +50,7 @@
 #include "hw/ppc/fdt.h"
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
+#include "migration/blocker.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -438,6 +439,7 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
          */
         spapr->mc_status = -1;
         qemu_cond_signal(&spapr->mc_delivery_cond);
+        migrate_del_blocker(spapr->fwnmi_migration_blocker);
         rtas_st(rets, 0, RTAS_OUT_SUCCESS);
     }
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


