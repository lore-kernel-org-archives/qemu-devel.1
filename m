Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B79C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 776B82146F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 16:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 776B82146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCRmw-0005IT-QL
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 12:33:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCRkO-0003sE-1c
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hCRkH-0000G9-8x
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hCRkB-0008Qp-BK
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 12:31:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x35GTEKk119564
	for <qemu-devel@nongnu.org>; Fri, 5 Apr 2019 12:30:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rp82hyrnw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 12:30:53 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 5 Apr 2019 17:30:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 5 Apr 2019 17:30:49 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x35GUn6344302528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 5 Apr 2019 16:30:49 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6742A4054;
	Fri,  5 Apr 2019 16:30:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEE66A4066;
	Fri,  5 Apr 2019 16:30:48 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.33.11])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri,  5 Apr 2019 16:30:48 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Fri, 05 Apr 2019 18:30:48 +0200
In-Reply-To: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
References: <155448184292.8446.8225650773162648595.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19040516-0012-0000-0000-0000030BB6C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040516-0013-0000-0000-00002143CC83
Message-Id: <155448184841.8446.13959787238854054119.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-05_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904050112
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH for-4.1 2/2] spapr: Drop duplicate code in LSI
 mapping
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405163048.nuyPsEtqzw2txq0horA8Ya53Qe49urjRY5m1B9xwg5o@z>

LSI mapping in spapr currently open-codes standard PCI swizzling. It thus
duplicates the code of pci_swizzle_map_irq_fn().

Expose the swizzling formula so that it can be used with a slot number
when building the device tree. Simply drop pci_spapr_map_irq() and call
pci_swizzle_map_irq_fn() instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/pci/pci.c         |    2 +-
 hw/ppc/spapr_pci.c   |   24 ++++--------------------
 include/hw/pci/pci.h |    4 ++++
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 35451c1e9987..bb52bafd8d1c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1532,7 +1532,7 @@ void pci_device_set_intx_routing_notifier(PCIDevice *dev,
  */
 int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin)
 {
-    return (pin + PCI_SLOT(pci_dev->devfn)) % PCI_NUM_PINS;
+    return pci_swizzle(PCI_SLOT(pci_dev->devfn), pin);
 }
 
 /***********************************************************/
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index c70688a0dc23..26850d0b94f4 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -719,26 +719,10 @@ param_error_exit:
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
 
-static int pci_spapr_swizzle(int slot, int pin)
-{
-    return (slot + pin) % PCI_NUM_PINS;
-}
-
-static int pci_spapr_map_irq(PCIDevice *pci_dev, int irq_num)
-{
-    /*
-     * Here we need to convert pci_dev + irq_num to some unique value
-     * which is less than number of IRQs on the specific bus (4).  We
-     * use standard PCI swizzling, that is (slot number + pin number)
-     * % 4.
-     */
-    return pci_spapr_swizzle(PCI_SLOT(pci_dev->devfn), irq_num);
-}
-
 static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
 {
     /*
-     * Here we use the number returned by pci_spapr_map_irq to find a
+     * Here we use the number returned by pci_swizzle_map_irq_fn to find a
      * corresponding qemu_irq.
      */
     SpaprPhbState *phb = opaque;
@@ -1744,7 +1728,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
                                 &sphb->iowindow);
 
     bus = pci_register_root_bus(dev, NULL,
-                                pci_spapr_set_irq, pci_spapr_map_irq, sphb,
+                                pci_spapr_set_irq, pci_swizzle_map_irq_fn, sphb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS, TYPE_PCI_BUS);
     phb->bus = bus;
@@ -2236,14 +2220,14 @@ int spapr_populate_pci_dt(SpaprPhbState *phb, uint32_t intc_phandle, void *fdt,
     }
 
     /* Build the interrupt-map, this must matches what is done
-     * in pci_spapr_map_irq
+     * in pci_swizzle_map_irq_fn
      */
     _FDT(fdt_setprop(fdt, bus_off, "interrupt-map-mask",
                      &interrupt_map_mask, sizeof(interrupt_map_mask)));
     for (i = 0; i < PCI_SLOT_MAX; i++) {
         for (j = 0; j < PCI_NUM_PINS; j++) {
             uint32_t *irqmap = interrupt_map[i*PCI_NUM_PINS + j];
-            int lsi_num = pci_spapr_swizzle(i, j);
+            int lsi_num = pci_swizzle(i, j);
 
             irqmap[0] = cpu_to_be32(b_ddddd(i)|b_fff(0));
             irqmap[1] = 0;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index d87f5f93e9cd..033b2145d98c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -411,6 +411,10 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
 void pci_bus_irqs_cleanup(PCIBus *bus);
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
 /* 0 <= pin <= 3 0 = INTA, 1 = INTB, 2 = INTC, 3 = INTD */
+static inline int pci_swizzle(int slot, int pin)
+{
+    return (slot + pin) % PCI_NUM_PINS;
+}
 int pci_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin);
 PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
                               pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,


