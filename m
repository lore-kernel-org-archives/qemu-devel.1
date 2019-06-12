Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5F5C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:29:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38D6207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38D6207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58006 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hazZM-0006ES-SW
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39277)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hazRw-0001RU-DG
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hazRu-0007xO-31
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:21:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51182
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hazRt-0007vZ-Sw
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:21:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5C9E8HQ114123
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 05:21:38 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t2vnkwsk2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 05:21:37 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 12 Jun 2019 10:21:36 +0100
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 12 Jun 2019 10:21:34 +0100
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5C9LXeD20316580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:21:33 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A4FBC6055;
 Wed, 12 Jun 2019 09:21:33 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B35D5C6057;
 Wed, 12 Jun 2019 09:21:30 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.124.31.35])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 12 Jun 2019 09:21:30 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Date: Wed, 12 Jun 2019 14:51:29 +0530
In-Reply-To: <156033104292.26635.15759339817253067370.stgit@aravinda>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061209-0036-0000-0000-00000AC9FFB1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011250; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216839; UDB=6.00639831; IPR=6.00997939; 
 MB=3.00027275; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-12 09:21:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061209-0037-0000-0000-00004C325A8F
Message-Id: <156033128952.26635.18407252540270604091.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-12_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120064
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v10 5/6] migration: Include migration support
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
 hw/ppc/spapr.c         |   27 +++++++++++++++++++++++++++
 hw/ppc/spapr_events.c  |   14 ++++++++++++++
 include/hw/ppc/spapr.h |    2 ++
 3 files changed, 43 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d61905b..3d6d139 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -42,6 +42,7 @@
 #include "migration/misc.h"
 #include "migration/global_state.h"
 #include "migration/register.h"
+#include "migration/blocker.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 #include "cpu-models.h"
@@ -1812,6 +1813,8 @@ static void spapr_machine_reset(void)
 
     /* Signal all vCPUs waiting on this condition */
     qemu_cond_broadcast(&spapr->mc_delivery_cond);
+
+    migrate_del_blocker(spapr->fwnmi_migration_blocker);
 }
 
 static void spapr_create_nvram(SpaprMachineState *spapr)
@@ -2102,6 +2105,25 @@ static const VMStateDescription vmstate_spapr_dtb = {
     },
 };
 
+static bool spapr_fwnmi_needed(void *opaque)
+{
+    SpaprMachineState *spapr = (SpaprMachineState *)opaque;
+
+    return spapr->guest_machine_check_addr != -1;
+}
+
+static const VMStateDescription vmstate_spapr_machine_check = {
+    .name = "spapr_machine_check",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = spapr_fwnmi_needed,
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
@@ -2135,6 +2157,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_dtb,
         &vmstate_spapr_cap_large_decr,
         &vmstate_spapr_cap_ccf_assist,
+        &vmstate_spapr_machine_check,
         NULL
     }
 };
@@ -2919,6 +2942,10 @@ static void spapr_machine_init(MachineState *machine)
 
         /* Resize rtas blob to accommodate error log */
         spapr->rtas_size = RTAS_ERROR_LOG_MAX;
+
+        /* Create the error string for live migration blocker */
+        error_setg(&spapr->fwnmi_migration_blocker,
+                "Live migration not supported during machine check handling");
     }
 
     spapr->rtas_blob = g_malloc(spapr->rtas_size);
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 51c052e..f8ce7f0 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -41,6 +41,7 @@
 #include "qemu/bcd.h"
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
+#include "migration/blocker.h"
 
 #define RTAS_LOG_VERSION_MASK                   0xff000000
 #define   RTAS_LOG_VERSION_6                    0x06000000
@@ -857,6 +858,19 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
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
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index debb57b..0dedf0a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -214,6 +214,8 @@ struct SpaprMachineState {
     SpaprCapabilities def, eff, mig;
 
     unsigned gpu_numa_id;
+
+    Error *fwnmi_migration_blocker;
 };
 
 #define H_SUCCESS         0


