Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580BFC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B5F2467A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B5F2467A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjl0-0000H5-Qr
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjdI-0000Fw-GO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:01:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjdH-0006Eo-8K
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:01:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjdH-0006E5-3C
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 07:01:19 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBulqX195248
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:01:18 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf71jkjd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 07:01:17 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 12:00:45 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 12:00:42 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDC0fpQ30867664
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 12:00:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EBB0AE058;
 Fri, 13 Dec 2019 12:00:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 601D8AE04D;
 Fri, 13 Dec 2019 12:00:41 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 12:00:41 +0000 (GMT)
Subject: [PATCH 13/13] ppc/pnv: Drop PnvChipClass::type
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 13:00:41 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121312-0020-0000-0000-00000397C4D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121312-0021-0000-0000-000021EED241
Message-Id: <157623844102.360005.12070225703151669294.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1034 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=868 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130097
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It isn't used anymore.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c         |    5 -----
 include/hw/ppc/pnv.h |    9 ---------
 2 files changed, 14 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index cc40b90e9cd2..232b4a25603c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1132,7 +1132,6 @@ static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
 
-    k->chip_type = PNV_CHIP_POWER8E;
     k->chip_cfam_id = 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask = POWER8E_CORE_MASK;
     k->core_pir = pnv_chip_core_pir_p8;
@@ -1156,7 +1155,6 @@ static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
 
-    k->chip_type = PNV_CHIP_POWER8;
     k->chip_cfam_id = 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->core_pir = pnv_chip_core_pir_p8;
@@ -1180,7 +1178,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
 
-    k->chip_type = PNV_CHIP_POWER8NVL;
     k->chip_cfam_id = 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask = POWER8_CORE_MASK;
     k->core_pir = pnv_chip_core_pir_p8;
@@ -1360,7 +1357,6 @@ static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
 
-    k->chip_type = PNV_CHIP_POWER9;
     k->chip_cfam_id = 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask = POWER9_CORE_MASK;
     k->core_pir = pnv_chip_core_pir_p9;
@@ -1449,7 +1445,6 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PnvChipClass *k = PNV_CHIP_CLASS(klass);
 
-    k->chip_type = PNV_CHIP_POWER10;
     k->chip_cfam_id = 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
     k->cores_mask = POWER10_CORE_MASK;
     k->core_pir = pnv_chip_core_pir_p10;
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 4972e93c2619..f78fd0dd967c 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -38,14 +38,6 @@
 #define PNV_CHIP_GET_CLASS(obj) \
      OBJECT_GET_CLASS(PnvChipClass, (obj), TYPE_PNV_CHIP)
 
-typedef enum PnvChipType {
-    PNV_CHIP_POWER8E,     /* AKA Murano (default) */
-    PNV_CHIP_POWER8,      /* AKA Venice */
-    PNV_CHIP_POWER8NVL,   /* AKA Naples */
-    PNV_CHIP_POWER9,      /* AKA Nimbus */
-    PNV_CHIP_POWER10,     /* AKA TBD */
-} PnvChipType;
-
 typedef struct PnvChip {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -123,7 +115,6 @@ typedef struct PnvChipClass {
     SysBusDeviceClass parent_class;
 
     /*< public >*/
-    PnvChipType  chip_type;
     uint64_t     chip_cfam_id;
     uint64_t     cores_mask;
 


