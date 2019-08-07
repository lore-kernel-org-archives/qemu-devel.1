Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A465DC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761F02199C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 07:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761F02199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvGGB-0004kA-OW
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 03:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59935)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAp-0007Im-Ox
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1hvGAo-0001fR-Qm
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32854)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1hvGAo-0001ej-EV
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 03:15:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x777E8Xu112225
 for <qemu-devel@nongnu.org>; Wed, 7 Aug 2019 03:15:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2u7rw0jpru-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:15:49 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 7 Aug 2019 08:15:47 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 7 Aug 2019 08:15:44 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x777FhWY38928414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 7 Aug 2019 07:15:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8AFC5A404D;
 Wed,  7 Aug 2019 07:15:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55876A4051;
 Wed,  7 Aug 2019 07:15:41 +0000 (GMT)
Received: from dhcp-9-109-247-185.in.ibm.com (unknown [9.109.247.185])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  7 Aug 2019 07:15:41 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed,  7 Aug 2019 12:44:44 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190807071445.4109-1-bala24@linux.ibm.com>
References: <20190807071445.4109-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080707-0008-0000-0000-0000030628D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080707-0009-0000-0000-00004A2429E5
Message-Id: <20190807071445.4109-6-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-07_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=5 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=804 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070078
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [RFC PATCH 5/6] hw/ppc/pnv_xscom: retrieve homer/occ
 base address from PBA BARs
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
Cc: maddy@linux.vnet.ibm.com, Balamuruhan S <bala24@linux.ibm.com>,
 anju@linux.vnet.ibm.com, clg@kaod.org, hari@linux.vnet.ibm.com,
 pbonzini@redhat.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During PowerNV boot skiboot populates the device tree by retrieving
base address of homer/occ common area from PBA BARs and prd ipoll
mask by accessing xscom read/write accesses.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv_xscom.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 5d5b5e9884..18a780bcdf 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -77,6 +77,29 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
     case 0x18002:       /* ECID2 */
         return 0;
 
+    /* PBA BAR0 */
+    case 0x5012b00: /* P9 homer base address */
+        return PNV9_HOMER_BASE(chip);
+    case 0x2013f00: /* P8 homer base address */
+        return PNV_HOMER_BASE(chip);
+
+    /* PBA BARMASK0 */
+    case 0x5012b04: /* P9 homer region size */
+    case 0x2013f04: /* P8 homer region size */
+        return PNV_HOMER_SIZE;
+
+    /* PBA BAR2 */
+    case 0x5012b02: /* P9 occ common area */
+        return PNV9_OCC_COMMON_AREA(chip);
+    case 0x2013f02: /* P8 occ common area */
+        return PNV_OCC_COMMON_AREA(chip);
+
+    /* PBA BARMASK2 */
+    case 0x5012b06: /* P9 occ common area size */
+    case 0x2013f06: /* P8 occ common area size */
+        return PNV_OCC_COMMON_AREA_SIZE;
+
+
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
 
@@ -96,13 +119,9 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
     case 0x2020009:     /* ADU stuff, error register */
     case 0x202000f:     /* ADU stuff, receive status register*/
         return 0;
-    case 0x2013f00:     /* PBA stuff */
     case 0x2013f01:     /* PBA stuff */
-    case 0x2013f02:     /* PBA stuff */
     case 0x2013f03:     /* PBA stuff */
-    case 0x2013f04:     /* PBA stuff */
     case 0x2013f05:     /* PBA stuff */
-    case 0x2013f06:     /* PBA stuff */
     case 0x2013f07:     /* PBA stuff */
         return 0;
     case 0x2013028:     /* CAPP stuff */
-- 
2.14.5


