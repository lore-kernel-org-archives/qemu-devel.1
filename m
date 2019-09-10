Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83AC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DA82084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DA82084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aKP-0004Wr-3p
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i7aJ3-00033t-So
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i7aJ2-0005Lx-Np
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5442
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i7aJ2-0005LO-IQ
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:16 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8A77W8W104234
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 03:11:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ux5htjv2a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 03:11:15 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 10 Sep 2019 08:11:14 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Sep 2019 08:11:11 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8A7BADA54067350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2019 07:11:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3E7294C04A;
 Tue, 10 Sep 2019 07:11:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A63004C040;
 Tue, 10 Sep 2019 07:11:08 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.221])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Sep 2019 07:11:08 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Tue, 10 Sep 2019 12:40:17 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190910071019.16689-1-bala24@linux.ibm.com>
References: <20190910071019.16689-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19091007-4275-0000-0000-00000363D446
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091007-4276-0000-0000-0000387626A5
Message-Id: <20190910071019.16689-2-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-10_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100071
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v1 1/3] hw/ppc/pnv_xscom: retrieve homer/occ
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org,
 Balamuruhan S <bala24@linux.ibm.com>, anju@linux.vnet.ibm.com, clg@kaod.org,
 hari@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During PowerNV boot skiboot populates the device tree by
retrieving base address of homer/occ common area from
PBA BARs and prd ipoll mask by accessing xscom read/write
accesses.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv_xscom.c   | 34 ++++++++++++++++++++++++++++++----
 include/hw/ppc/pnv.h | 18 ++++++++++++++++++
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 67aab98fef..f01d788a65 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -36,6 +36,16 @@
 #define PRD_P9_IPOLL_REG_MASK           0x000F0033
 #define PRD_P9_IPOLL_REG_STATUS         0x000F0034
 
+/* PBA BARs */
+#define P8_PBA_BAR0                     0x2013f00
+#define P8_PBA_BAR2                     0x2013f02
+#define P8_PBA_BARMASK0                 0x2013f04
+#define P8_PBA_BARMASK2                 0x2013f06
+#define P9_PBA_BAR0                     0x5012b00
+#define P9_PBA_BAR2                     0x5012b02
+#define P9_PBA_BARMASK0                 0x5012b04
+#define P9_PBA_BARMASK2                 0x5012b06
+
 static void xscom_complete(CPUState *cs, uint64_t hmer_bits)
 {
     /*
@@ -74,6 +84,26 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
     case 0x18002:       /* ECID2 */
         return 0;
 
+    case P9_PBA_BAR0:
+        return PNV9_HOMER_BASE(chip);
+    case P8_PBA_BAR0:
+        return PNV_HOMER_BASE(chip);
+
+    case P9_PBA_BARMASK0: /* P9 homer region size */
+        return PNV9_HOMER_SIZE;
+    case P8_PBA_BARMASK0: /* P8 homer region size */
+        return PNV_HOMER_SIZE;
+
+    case P9_PBA_BAR2: /* P9 occ common area */
+        return PNV9_OCC_COMMON_AREA(chip);
+    case P8_PBA_BAR2: /* P8 occ common area */
+        return PNV_OCC_COMMON_AREA(chip);
+
+    case P9_PBA_BARMASK2: /* P9 occ common area size */
+        return PNV9_OCC_COMMON_AREA_SIZE;
+    case P8_PBA_BARMASK2: /* P8 occ common area size */
+        return PNV_OCC_COMMON_AREA_SIZE;
+
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
 
@@ -93,13 +123,9 @@ static uint64_t xscom_read_default(PnvChip *chip, uint32_t pcba)
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
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fb123edc4e..63a4b7b6a7 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -198,6 +198,16 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV_XSCOM_BASE(chip)                                            \
     (0x0003fc0000000000ull + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZE)
 
+#define PNV_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
+#define PNV_OCC_COMMON_AREA(chip)                                       \
+    (0x7fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
+                         PNV_OCC_COMMON_AREA_SIZE))
+
+#define PNV_HOMER_SIZE              0x0000000000300000ull
+#define PNV_HOMER_BASE(chip)                                            \
+    (0x7ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV_HOMER_SIZE)
+
+
 /*
  * XSCOM 0x20109CA defines the ICP BAR:
  *
@@ -256,4 +266,12 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV9_XSCOM_SIZE              0x0000000400000000ull
 #define PNV9_XSCOM_BASE(chip)        PNV9_CHIP_BASE(chip, 0x00603fc00000000ull)
 
+#define PNV9_OCC_COMMON_AREA_SIZE    0x0000000000700000ull
+#define PNV9_OCC_COMMON_AREA(chip)                                      \
+    (0x203fff800000ull + ((uint64_t)PNV_CHIP_INDEX(chip) * \
+                           PNV9_OCC_COMMON_AREA_SIZE))
+
+#define PNV9_HOMER_SIZE              0x0000000000300000ull
+#define PNV9_HOMER_BASE(chip)                                           \
+    (0x203ffd800000ull + ((uint64_t)PNV_CHIP_INDEX(chip)) * PNV9_HOMER_SIZE)
 #endif /* PPC_PNV_H */
-- 
2.14.5


