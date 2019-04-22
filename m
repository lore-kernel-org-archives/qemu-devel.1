Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AAAC282E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 07:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797F820857
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 07:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797F820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33506 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIT6c-0004KG-Ld
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 03:11:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hIT4U-0002PU-UT
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hIT4T-00016w-Sh
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:08:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hIT4T-000167-IX
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:08:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3M73eP2113230
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:08:53 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s188tsdm0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:08:53 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 22 Apr 2019 08:03:52 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
	by e34.co.us.ibm.com (192.168.1.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 22 Apr 2019 08:03:50 +0100
Received: from b03ledav002.gho.boulder.ibm.com
	(b03ledav002.gho.boulder.ibm.com [9.17.130.233])
	by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3M73nOZ49938608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 22 Apr 2019 07:03:49 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D5613604F;
	Mon, 22 Apr 2019 07:03:49 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4C5136051;
	Mon, 22 Apr 2019 07:03:46 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.199.63.199])
	by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 22 Apr 2019 07:03:46 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	david@gibson.dropbear.id.au
Date: Mon, 22 Apr 2019 12:33:45 +0530
In-Reply-To: <155591636364.20338.844048953355207313.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042207-0016-0000-0000-000009A37CEB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010972; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01192628; UDB=6.00625138;
	IPR=6.00973446; 
	MB=3.00026542; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-22 07:03:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042207-0017-0000-0000-000042E849C7
Message-Id: <155591662496.20338.3862565585716109724.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-21_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=993 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904220053
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v8 6/6] migration: Block migration while
 handling machine check
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
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422070345.CFNfMByZBCrV5bw3ju24PtKoG-GHLdUkWs_-veZbbmc@z>

Block VM migration requests until the machine check
error handling is complete as (i) these errors are
specific to the source hardware and is irrelevant on
the target hardware, (ii) these errors cause data
corruption and should be handled before migration.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr_events.c  |   17 +++++++++++++++++
 hw/ppc/spapr_rtas.c    |    4 ++++
 include/hw/ppc/spapr.h |    3 +++
 3 files changed, 24 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 4032db0..45b990c 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -41,6 +41,7 @@
 #include "qemu/bcd.h"
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
+#include "migration/blocker.h"
 
 #define RTAS_LOG_VERSION_MASK                   0xff000000
 #define   RTAS_LOG_VERSION_6                    0x06000000
@@ -864,6 +865,22 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    int ret;
+    Error *local_err = NULL;
+
+    error_setg(&spapr->migration_blocker,
+            "Live migration not supported during machine check handling");
+    ret = migrate_add_blocker(spapr->migration_blocker, &local_err);
+    if (ret < 0) {
+        /*
+         * We don't want to abort and let the migration to continue. In a
+         * rare case, the machine check handler will run on the target
+         * hardware. Though this is not preferable, it is better than aborting
+         * the migration or killing the VM.
+         */
+        error_free(spapr->migration_blocker);
+        fprintf(stderr, "Warning: Machine check during VM migration\n");
+    }
 
     while (spapr->mc_status != -1) {
         /*
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 997cf19..1229a0e 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -50,6 +50,7 @@
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
 #include "kvm_ppc.h"
+#include "migration/blocker.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -396,6 +397,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
         spapr->mc_status = -1;
         qemu_cond_signal(&spapr->mc_delivery_cond);
         rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+        migrate_del_blocker(spapr->migration_blocker);
+        error_free(spapr->migration_blocker);
+        spapr->migration_blocker = NULL;
     }
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9d16ad1..dda5fd2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -10,6 +10,7 @@
 #include "hw/ppc/spapr_irq.h"
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
+#include "qapi/error.h"
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -213,6 +214,8 @@ struct SpaprMachineState {
     SpaprCapabilities def, eff, mig;
 
     unsigned gpu_numa_id;
+
+    Error *migration_blocker;
 };
 
 #define H_SUCCESS         0


