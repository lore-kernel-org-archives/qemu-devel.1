Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BB1C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:45:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7021B20651
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7021B20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1Tm-0006bj-23
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45547)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hr1Ss-0003hq-0g
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hr1Sr-0000Bb-1J
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hr1Sq-0000AO-Q8
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6QEiBRe140352
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:44:56 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u02a0v18r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:44:55 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 26 Jul 2019 15:44:53 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Jul 2019 15:44:51 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com
 [9.149.105.60])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6QEioq911272316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2019 14:44:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3582C42041;
 Fri, 26 Jul 2019 14:44:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0677B4203F;
 Fri, 26 Jul 2019 14:44:50 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.15.116])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jul 2019 14:44:49 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Jul 2019 16:44:49 +0200
In-Reply-To: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072614-0016-0000-0000-0000029677A7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072614-0017-0000-0000-000032F478EE
Message-Id: <156415228966.1064338.190189424190233355.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-26_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260181
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 3/3] spapr/irq: Drop spapr_irq_msi_reset()
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PHBs already take care of clearing the MSIs from the bitmap during reset
or unplug. No need to do this globally from the machine code. Rather add
an assert to ensure that PHBs have acted as expected.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c             |    4 ----
 hw/ppc/spapr_irq.c         |    7 ++-----
 include/hw/ppc/spapr_irq.h |    1 -
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5894329f29a9..855e9fbd9805 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1739,10 +1739,6 @@ static void spapr_machine_reset(MachineState *machine)
         ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fatal);
     }
 
-    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        spapr_irq_msi_reset(spapr);
-    }
-
     /*
      * NVLink2-connected GPU RAM needs to be placed on a separate NUMA node.
      * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() which is
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index d07aed8ca9f9..c72d8433681d 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -57,11 +57,6 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)
     bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
 }
 
-void spapr_irq_msi_reset(SpaprMachineState *spapr)
-{
-    bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
-}
-
 static void spapr_irq_init_kvm(SpaprMachineState *spapr,
                                   SpaprIrq *irq, Error **errp)
 {
@@ -729,6 +724,8 @@ int spapr_irq_post_load(SpaprMachineState *spapr, int version_id)
 
 void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
 {
+    assert(bitmap_empty(spapr->irq_map, spapr->irq_map_nr));
+
     if (spapr->irq->reset) {
         spapr->irq->reset(spapr, errp);
     }
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index f965a58f8954..44fe4f9e0e2e 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -28,7 +28,6 @@ void spapr_irq_msi_init(SpaprMachineState *spapr, uint32_t nr_msis);
 int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool align,
                         Error **errp);
 void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num);
-void spapr_irq_msi_reset(SpaprMachineState *spapr);
 
 typedef struct SpaprIrq {
     uint32_t    nr_irqs;


