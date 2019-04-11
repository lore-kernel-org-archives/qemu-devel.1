Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874E6C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:33:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501D12133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501D12133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51941 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEcdt-0004Kx-Fq
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:33:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hEccu-00030n-7s
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hEccs-0005jk-Ns
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:32:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58024
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hEccs-0005iy-CJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:32:34 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3BGVGan024341
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 12:32:30 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2rt964g29m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 12:32:30 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Thu, 11 Apr 2019 17:32:28 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 11 Apr 2019 17:32:25 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3BGWOnc45678680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 11 Apr 2019 16:32:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B9644203F;
	Thu, 11 Apr 2019 16:32:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 612A442041;
	Thu, 11 Apr 2019 16:32:24 +0000 (GMT)
Received: from bahia.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.41])
	by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 11 Apr 2019 16:32:24 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Thu, 11 Apr 2019 18:32:24 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19041116-0028-0000-0000-0000035FD206
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041116-0029-0000-0000-0000241EF9A1
Message-Id:
 <155500034416.646888.1307366522340665522.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-11_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904110110
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH for-4.0] spapr_pci: Fix broken naming of PCI bus
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
Message-ID: <20190411163224.csyiIQIsgwSHbY_zNci18ihHvJgjreVZifiICusf9nM@z>

Recent commit 5cf0d326a0fe fixed a regression which was preventing the
guest to access the extended config space of a PCIe device. This was
done by introducing a new PCI bus subtype for PAPR. The original fix
was causing PCI busses to be named "spapr-pci-host-bridge-root-bus.N"
instead of "pci.N", which was making upper layers unhappy of course.
This got worked around by hardcoding the PCI bus name to "pci.0", but
this only works for the default PHB. And we're now hitting:

# qemu-system-ppc64 \
             -device spapr-pci-host-bridge,index=1 \
             -device e1000e,bus=pci.0 \
             -device e1000e,bus=pci.1
qemu-system-ppc64: -device e1000e,bus=pci.1: Bus 'pci.1' not found

David already posted some patches [1] to control PCI extended config
space accesses with a new flag in the base PCI bus class instead of
subtyping. These patches are a bit more intrusive though, and
are targetted for 4.1.

When no name is passed to pci_register_bus(), the core device code
generates a lowercase name based on the QOM typename. The typename
for the base PCI bus class is "PCI", hence the "pci.0", "pci.1"
bus names. Rename the type of the PAPR PCI bus to "pci", so that
the QOM code can generate proper names. This is a hack but it is
enough to fix the regression. And all this will be reworked properly
in 4.1.

[1] https://patchwork.ozlabs.org/project/qemu-devel/list/?series=100486

Fixes: 5cf0d326a0fe
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f0b6b23afc9b..f62e6833b8c9 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1652,7 +1652,7 @@ static void spapr_phb_root_bus_class_init(ObjectClass *klass, void *data)
     pbc->allows_extended_config_space = spapr_phb_allows_extended_config_space;
 }
 
-#define TYPE_SPAPR_PHB_ROOT_BUS "spapr-pci-host-bridge-root-bus"
+#define TYPE_SPAPR_PHB_ROOT_BUS "pci"
 
 static const TypeInfo spapr_phb_root_bus_info = {
     .name = TYPE_SPAPR_PHB_ROOT_BUS,
@@ -1761,7 +1761,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), sphb->io_win_addr,
                                 &sphb->iowindow);
 
-    bus = pci_register_root_bus(dev, "pci.0",
+    bus = pci_register_root_bus(dev, NULL,
                                 pci_spapr_set_irq, pci_spapr_map_irq, sphb,
                                 &sphb->memspace, &sphb->iospace,
                                 PCI_DEVFN(0, 0), PCI_NUM_PINS,


