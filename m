Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0D3C31E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D74206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D74206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd9kI-0004I7-I0
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 04:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43502)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hd9ig-0002yM-Vm
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hd9if-0002ni-TA
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:43:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hd9if-0002mr-Hf
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:43:57 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5I8hh0l118767
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 04:43:55 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t6u8n3ed1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 04:43:51 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Tue, 18 Jun 2019 09:42:57 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 18 Jun 2019 09:42:55 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5I8gsOX30277710
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jun 2019 08:42:54 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F27FE529E9;
 Tue, 18 Jun 2019 08:42:53 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.14.35])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C4702529E6;
 Tue, 18 Jun 2019 08:42:53 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 18 Jun 2019 10:42:53 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061808-0012-0000-0000-0000032A13E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061808-0013-0000-0000-000021632F9C
Message-Id: <156084737348.512412.3552825999605902691.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-18_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=848 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906180073
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] spapr_pci: Fix DRC owner in spapr_dt_pci_bus()
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr_dt_drc() scans the aliases of all DRConnector objects and filters
the ones that it will use to generate OF properties according to their
owner and type.

Passing bus->parent_dev _works_ if bus belongs to a PCI bridge, but it is
NULL if it is the PHB's root bus. This causes all allocated PCI DRCs to
be associated to all PHBs (visible in their "ibm,drc-types" properties).
As a consequence, hot unplugging a PHB results in PCI devices from the
other PHBs to be unplugged as well, and likely confuses the guest.

Use the same logic as in add_drcs() to ensure the correct owner is passed
to spapr_dt_drc().

Fixes: 14e714900f6b "spapr: Allow hot plug/unplug of PCI bridges and devices under PCI bridges"
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_pci.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index fbeb1c90ee6c..2dca1e57f36c 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1343,6 +1343,7 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
 static int spapr_dt_pci_bus(SpaprPhbState *sphb, PCIBus *bus,
                                void *fdt, int offset)
 {
+    Object *owner;
     PciWalkFdt cbinfo = {
         .fdt = fdt,
         .offset = offset,
@@ -1363,7 +1364,13 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, PCIBus *bus,
         return cbinfo.err;
     }
 
-    ret = spapr_dt_drc(fdt, offset, OBJECT(bus->parent_dev),
+    if (pci_bus_is_root(bus)) {
+        owner = OBJECT(sphb);
+    } else {
+        owner = OBJECT(pci_bridge_get_device(bus));
+    }
+
+    ret = spapr_dt_drc(fdt, offset, owner,
                        SPAPR_DR_CONNECTOR_TYPE_PCI);
     if (ret) {
         return ret;


