Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6792DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBB1121655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB1121655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifjl8-0000Um-NH
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 07:09:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ifjbv-0007CD-1Z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ifjbs-0003sr-Uq
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20512
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ifjbs-0003rU-JT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 06:59:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBDBv7ET061092
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:59:50 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wujxsc3ew-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:59:49 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Fri, 13 Dec 2019 11:59:48 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 13 Dec 2019 11:59:46 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBDBxjqQ57606320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Dec 2019 11:59:45 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0FC6A4057;
 Fri, 13 Dec 2019 11:59:45 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2E0DA4040;
 Fri, 13 Dec 2019 11:59:45 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.185.241])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Fri, 13 Dec 2019 11:59:45 +0000 (GMT)
Subject: [PATCH 03/13] ppc/pnv: Drop PnvPsiClass::chip_type
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 13 Dec 2019 12:59:45 +0100
In-Reply-To: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
References: <157623836852.360005.1112241220707384093.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121311-0028-0000-0000-000003C82A47
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121311-0029-0000-0000-0000248B6788
Message-Id: <157623838530.360005.15470128760871845396.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_03:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=665 impostorscore=0 priorityscore=1501
 clxscore=1034 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 hw/ppc/pnv_psi.c         |    3 ---
 include/hw/ppc/pnv_psi.h |    1 -
 2 files changed, 4 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 98a82b25e01f..75e20d9da08b 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -574,7 +574,6 @@ static void pnv_psi_power8_class_init(ObjectClass *klass, void *data)
     dc->desc    = "PowerNV PSI Controller POWER8";
     dc->realize = pnv_psi_power8_realize;
 
-    ppc->chip_type =  PNV_CHIP_POWER8;
     ppc->xscom_pcba = PNV_XSCOM_PSIHB_BASE;
     ppc->xscom_size = PNV_XSCOM_PSIHB_SIZE;
     ppc->bar_mask   = PSIHB_BAR_MASK;
@@ -884,7 +883,6 @@ static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
     dc->desc    = "PowerNV PSI Controller POWER9";
     dc->realize = pnv_psi_power9_realize;
 
-    ppc->chip_type  = PNV_CHIP_POWER9;
     ppc->xscom_pcba = PNV9_XSCOM_PSIHB_BASE;
     ppc->xscom_size = PNV9_XSCOM_PSIHB_SIZE;
     ppc->bar_mask   = PSIHB9_BAR_MASK;
@@ -915,7 +913,6 @@ static void pnv_psi_power10_class_init(ObjectClass *klass, void *data)
 
     dc->desc    = "PowerNV PSI Controller POWER10";
 
-    ppc->chip_type  = PNV_CHIP_POWER10;
     ppc->xscom_pcba = PNV10_XSCOM_PSIHB_BASE;
     ppc->xscom_size = PNV10_XSCOM_PSIHB_SIZE;
     ppc->compat     = compat;
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index fc068c95e543..f0f5b5519767 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -79,7 +79,6 @@ typedef struct Pnv9Psi {
 typedef struct PnvPsiClass {
     SysBusDeviceClass parent_class;
 
-    int chip_type;
     uint32_t xscom_pcba;
     uint32_t xscom_size;
     uint64_t bar_mask;


