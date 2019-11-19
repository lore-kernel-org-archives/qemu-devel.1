Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF928C43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:55:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D48721823
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D48721823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7iR-0002CU-No
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:55:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iX7f8-0005z6-4t
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iX7f7-0005DU-1O
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11796
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iX7f6-0005DG-Sz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:36 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJHnDcB116347
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:51:36 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2wcf7u1mft-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:51:36 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 19 Nov 2019 17:51:34 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 19 Nov 2019 17:51:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAJHpUP923593174
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 17:51:30 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 713904C059;
 Tue, 19 Nov 2019 17:51:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17CEE4C040;
 Tue, 19 Nov 2019 17:51:29 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.84.11])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 17:51:28 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/5] hw/ppc/pnv_xscom: occ common area to be mapped only once
Date: Tue, 19 Nov 2019 23:20:55 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191119175056.32518-1-bala24@linux.ibm.com>
References: <20191119175056.32518-1-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19111917-0008-0000-0000-00000333FD5A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111917-0009-0000-0000-00004A531D2C
Message-Id: <20191119175056.32518-5-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=1 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=935
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190152
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id xAJHnDcB116347
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Balamuruhan S <bala24@linux.ibm.com>, david@gibson.dropbear.id.au,
 qemu-ppc@nongnu.org, clg@kaod.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

occ common area should be mapped once and disable it for every
other chip.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv_xscom.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index cb6d6bbcfc..f797a5ec7d 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -98,13 +98,22 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
         return HOMER_SIZE_MASK;
=20
     case P9_PBA_BAR2: /* P9 occ common area */
-        return PNV9_OCC_COMMON_AREA(chip);
+        if (!PNV_CHIP_INDEX(chip)) {
+            return PNV9_OCC_COMMON_AREA(chip);
+        }
+        return 0;
     case P8_PBA_BAR3: /* P8 occ common area */
-        return PNV_OCC_COMMON_AREA(chip);
+        if (!PNV_CHIP_INDEX(chip)) {
+            return PNV_OCC_COMMON_AREA(chip);
+        }
+        return 0;
=20
     case P9_PBA_BARMASK2: /* P9 occ common area size */
     case P8_PBA_BARMASK3: /* P8 occ common area size */
-        return OCC_SIZE_MASK;
+        if (!PNV_CHIP_INDEX(chip)) {
+            return OCC_SIZE_MASK;
+        }
+        return 0;
=20
     case 0x1010c00:     /* PIBAM FIR */
     case 0x1010c03:     /* PIBAM FIR MASK */
--=20
2.14.5


