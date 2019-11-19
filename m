Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C512C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B31B2231A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B31B2231A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7k8-0004eZ-9U
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53476)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1iX7f7-0005xi-B5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1iX7f6-0005D1-7W
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1iX7f5-0005CZ-Vx
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:36 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAJHlTcU096158
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:51:35 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wcencbvst-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:51:34 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 19 Nov 2019 17:51:32 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 19 Nov 2019 17:51:28 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAJHpSu248496796
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Nov 2019 17:51:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 082AF4C04A;
 Tue, 19 Nov 2019 17:51:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A0B434C052;
 Tue, 19 Nov 2019 17:51:26 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.84.11])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 19 Nov 2019 17:51:26 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] hw/ppc/pnv_xscom: Power8 occ common area is in PBA BAR 3
Date: Tue, 19 Nov 2019 23:20:54 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191119175056.32518-1-bala24@linux.ibm.com>
References: <20191119175056.32518-1-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19111917-0020-0000-0000-0000038B2B14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111917-0021-0000-0000-000021E158C3
Message-Id: <20191119175056.32518-4-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_06:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=1 malwarescore=0
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911190152
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id xAJHlTcU096158
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: Balamuruhan S <bala24@linux.ibm.com>, david@gibson.dropbear.id.au,
 qemu-ppc@nongnu.org, clg@kaod.org, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix incorrect PBA BAR and BARMASK value for Power8 occ common area
region where skiboot enum declaration have it in BAR 3 and BARMASK
is calculated BARMASK0 + BAR,

enum P8_BAR {
        P8_BAR_HOMER =3D 0,
        P8_BAR_CENTAUR =3D 1,
        P8_BAR_SLW =3D 2,
        P8_BAR_OCC_COMMON =3D 3,
};

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv_xscom.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index cdd5fa356e..cb6d6bbcfc 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -38,9 +38,9 @@
=20
 /* PBA BARs */
 #define P8_PBA_BAR0                     0x2013f00
-#define P8_PBA_BAR2                     0x2013f02
+#define P8_PBA_BAR3                     0x2013f03
 #define P8_PBA_BARMASK0                 0x2013f04
-#define P8_PBA_BARMASK2                 0x2013f06
+#define P8_PBA_BARMASK3                 0x2013f07
 #define P9_PBA_BAR0                     0x5012b00
 #define P9_PBA_BAR2                     0x5012b02
 #define P9_PBA_BARMASK0                 0x5012b04
@@ -99,11 +99,11 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
=20
     case P9_PBA_BAR2: /* P9 occ common area */
         return PNV9_OCC_COMMON_AREA(chip);
-    case P8_PBA_BAR2: /* P8 occ common area */
+    case P8_PBA_BAR3: /* P8 occ common area */
         return PNV_OCC_COMMON_AREA(chip);
=20
     case P9_PBA_BARMASK2: /* P9 occ common area size */
-    case P8_PBA_BARMASK2: /* P8 occ common area size */
+    case P8_PBA_BARMASK3: /* P8 occ common area size */
         return OCC_SIZE_MASK;
=20
     case 0x1010c00:     /* PIBAM FIR */
@@ -126,9 +126,9 @@ static uint64_t xscom_read_default(PnvChip *chip, uin=
t32_t pcba)
     case 0x202000f:     /* ADU stuff, receive status register*/
         return 0;
     case 0x2013f01:     /* PBA stuff */
-    case 0x2013f03:     /* PBA stuff */
+    case 0x2013f02:     /* PBA stuff */
     case 0x2013f05:     /* PBA stuff */
-    case 0x2013f07:     /* PBA stuff */
+    case 0x2013f06:     /* PBA stuff */
         return 0;
     case 0x2013028:     /* CAPP stuff */
     case 0x201302a:     /* CAPP stuff */
--=20
2.14.5


