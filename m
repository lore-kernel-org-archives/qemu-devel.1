Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C10C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:45:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62253218D3
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62253218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1T1-00041r-DW
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45089)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hr1Sg-0002q4-6L
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hr1Se-0008LK-Ua
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25728
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hr1Se-0008KO-OM
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:44:44 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6QEhZ1V078300
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:44:43 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2u01ne6jk4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:44:43 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 26 Jul 2019 15:44:41 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 26 Jul 2019 15:44:40 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6QEidWc57082084
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 Jul 2019 14:44:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F9924C04A;
 Fri, 26 Jul 2019 14:44:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DEA5A4C040;
 Fri, 26 Jul 2019 14:44:38 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.15.116])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 26 Jul 2019 14:44:38 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Jul 2019 16:44:38 +0200
In-Reply-To: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19072614-4275-0000-0000-00000350E576
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072614-4276-0000-0000-000038614ED5
Message-Id: <156415227855.1064338.5657793835271464648.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-26_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907260181
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 1/3] spapr/pci: Consolidate de-allocation of
 MSIs
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

When freeing MSIs, we need to:
- remove them from the machine's MSI bitmap
- remove them from the IC backend
- remove them from the PHB's MSI cache

This is currently open coded in two places in rtas_ibm_change_msi(),
and we're about to need this in spapr_phb_reset() as well. Instead of
duplicating this code again, make it a destroy function for the PHB's
MSI cache. Removing an MSI device from the cache will call the destroy
function internally.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 2d5697d119f4..bc22568bfa71 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -336,10 +336,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
             return;
         }
 
-        if (!smc->legacy_irq_allocation) {
-            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
-        }
-        spapr_irq_free(spapr, msi->first_irq, msi->num);
         if (msi_present(pdev)) {
             spapr_msi_setmsg(pdev, 0, false, 0, 0);
         }
@@ -409,10 +405,6 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     /* Release previous MSIs */
     if (msi) {
-        if (!smc->legacy_irq_allocation) {
-            spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
-        }
-        spapr_irq_free(spapr, msi->first_irq, msi->num);
         g_hash_table_remove(phb->msi, &config_addr);
     }
 
@@ -1806,6 +1798,19 @@ static void spapr_phb_unrealize(DeviceState *dev, Error **errp)
     memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
 }
 
+static void spapr_phb_destroy_msi(gpointer opaque)
+{
+    SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    spapr_pci_msi *msi = opaque;
+
+    if (!smc->legacy_irq_allocation) {
+        spapr_irq_msi_free(spapr, msi->first_irq, msi->num);
+    }
+    spapr_irq_free(spapr, msi->first_irq, msi->num);
+    g_free(msi);
+}
+
 static void spapr_phb_realize(DeviceState *dev, Error **errp)
 {
     /* We don't use SPAPR_MACHINE() in order to exit gracefully if the user
@@ -2017,7 +2022,8 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                                     spapr_tce_get_iommu(tcet));
     }
 
-    sphb->msi = g_hash_table_new_full(g_int_hash, g_int_equal, g_free, g_free);
+    sphb->msi = g_hash_table_new_full(g_int_hash, g_int_equal, g_free,
+                                      spapr_phb_destroy_msi);
     return;
 
 unrealize:


