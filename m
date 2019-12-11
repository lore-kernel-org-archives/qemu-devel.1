Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1F3C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3338F2073D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3338F2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if4Uy-0003Ng-2Z
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1if4U6-0002XQ-BD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1if4U5-0003O7-4q
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1if4U4-0003LM-VR
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:05:05 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBBG3VN8037864
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 11:05:03 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf6yj1wm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 11:05:01 -0500
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Wed, 11 Dec 2019 16:04:19 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 11 Dec 2019 16:04:17 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id xBBG3Y2A46793114
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2019 16:03:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FD3442049;
 Wed, 11 Dec 2019 16:04:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D368742041;
 Wed, 11 Dec 2019 16:04:15 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.152.115])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2019 16:04:15 +0000 (GMT)
Subject: [PATCH v2] ppc/pnv: Make PnvXScomInterface an incomplete type
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 11 Dec 2019 17:04:15 +0100
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121116-0008-0000-0000-0000033FDB77
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121116-0009-0000-0000-00004A5F1264
Message-Id: <157608025541.186670.1577861507610404326.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_04:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1034 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=738 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110135
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

PnvXScomInterface is an interface instance. It should never be
dereferenced. Drop the dummy type definition for extra safety,
which is the common practice with QOM interfaces.

While here also convert the bogus OBJECT_CHECK() to INTERFACE_CHECK().

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: convert OBJECT_CHECK() to INTERFACE_CHECK()
---
 include/hw/ppc/pnv_xscom.h |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 1c1d76bf9be5..306c22461587 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -22,13 +22,11 @@
 
 #include "qom/object.h"
 
-typedef struct PnvXScomInterface {
-    Object parent;
-} PnvXScomInterface;
+typedef struct PnvXScomInterface PnvXScomInterface;
 
 #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
 #define PNV_XSCOM_INTERFACE(obj) \
-     OBJECT_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
+    INTERFACE_CHECK(PnvXScomInterface, (obj), TYPE_PNV_XSCOM_INTERFACE)
 #define PNV_XSCOM_INTERFACE_CLASS(klass)                \
     OBJECT_CLASS_CHECK(PnvXScomInterfaceClass, (klass), \
                        TYPE_PNV_XSCOM_INTERFACE)


