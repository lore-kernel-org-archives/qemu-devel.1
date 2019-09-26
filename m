Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DBAC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EA5222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 14:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EA5222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDUVS-0005gA-Df
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1iDUTu-0004UT-Pe
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:10:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1iDUTt-00016e-Nz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 10:10:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28050)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1iDUTt-00014N-GX; Thu, 26 Sep 2019 10:10:53 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8QE8u60113928; Thu, 26 Sep 2019 10:10:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v8w5u63ca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 10:10:44 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8QE9CIH115749;
 Thu, 26 Sep 2019 10:10:44 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2v8w5u63be-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 10:10:44 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8QE6Pbk018255;
 Thu, 26 Sep 2019 14:10:43 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 2v5bg7ujm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Sep 2019 14:10:43 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8QEAdXH50856354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2019 14:10:39 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CE7AC607A;
 Thu, 26 Sep 2019 14:10:39 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF180C6067;
 Thu, 26 Sep 2019 14:10:37 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.182.236])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 26 Sep 2019 14:10:37 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com
Subject: [PATCH] s390: PCI: fix IOMMU region init
Date: Thu, 26 Sep 2019 10:10:36 -0400
Message-Id: <1569507036-15314-1-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-26_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909260130
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: walling@linux.ibm.com, fiuczy@linux.ibm.com, pmorel@linux.ibm.com,
 david@redhat.com, stzi@linux.ibm.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 thuth@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The fix in dbe9cf606c shrinks the IOMMU memory region to a size
that seems reasonable on the surface, however is actually too
small as it is based against a 0-mapped address space.  This
causes breakage with small guests as they can overrun the IOMMU window.

Let's go back to the prior method of initializing iommu for now.

Fixes: dbe9cf606c ("s390x/pci: Set the iommu region size mpcifc request")
Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Reported-by: Stefan Zimmerman <stzi@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 963a41c..2d2f4a7 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -695,10 +695,15 @@ static const MemoryRegionOps s390_msi_ctrl_ops = {
 
 void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
 {
+    /*
+     * The iommu region is initialized against a 0-mapped address space,
+     * so the smallest IOMMU region we can define runs from 0 to the end
+     * of the PCI address space.
+     */
     char *name = g_strdup_printf("iommu-s390-%04x", iommu->pbdev->uid);
     memory_region_init_iommu(&iommu->iommu_mr, sizeof(iommu->iommu_mr),
                              TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
-                             name, iommu->pal - iommu->pba + 1);
+                             name, iommu->pal + 1);
     iommu->enabled = true;
     memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
     g_free(name);
-- 
1.8.3.1


