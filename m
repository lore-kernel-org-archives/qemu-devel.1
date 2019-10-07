Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C40C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:44:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D78CF20867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D78CF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHOcf-0005rv-JR
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 04:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iHOab-0003iJ-CB
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iHOaW-00042U-Ch
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:41:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54078)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iHOa9-0003ob-9B
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:41:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x978d5xh102072
 for <qemu-devel@nongnu.org>; Mon, 7 Oct 2019 04:41:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vg0y6j6xd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 04:41:20 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 7 Oct 2019 09:41:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 7 Oct 2019 09:41:15 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x978fE4f55771250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2019 08:41:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B9E1A404D;
 Mon,  7 Oct 2019 08:41:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 91391A4040;
 Mon,  7 Oct 2019 08:41:14 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2019 08:41:14 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-169-184.de.ibm.com
 [9.145.169.184])
 by smtp.tls.ibm.com (Postfix) with ESMTP id CED83220204;
 Mon,  7 Oct 2019 10:41:13 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 7/9] ppc/pnv: Quiesce some XIVE errors
Date: Mon,  7 Oct 2019 10:41:00 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007084102.29776-1-clg@kaod.org>
References: <20191007084102.29776-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19100708-0008-0000-0000-0000031EBC67
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0009-0000-0000-00004A3DCC9C
Message-Id: <20191007084102.29776-8-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-07_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=653 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070090
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x978d5xh102072
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When dumping the END and NVT tables, the error logging is too noisy.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 9f7e0e1662d6..6e0bb6dbe44f 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -29,7 +29,7 @@
=20
 #include "pnv_xive_regs.h"
=20
-#define XIVE_DEBUG
+#undef XIVE_DEBUG
=20
 /*
  * Virtual structures table (VST)
@@ -157,7 +157,9 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *x=
ive, uint32_t type,
     vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
=20
     if (!(vsd & VSD_ADDRESS_MASK)) {
+#ifdef XIVE_DEBUG
         xive_error(xive, "VST: invalid %s entry %x !?", info->name, idx)=
;
+#endif
         return 0;
     }
=20
@@ -178,7 +180,9 @@ static uint64_t pnv_xive_vst_addr_indirect(PnvXive *x=
ive, uint32_t type,
         vsd =3D ldq_be_dma(&address_space_memory, vsd_addr);
=20
         if (!(vsd & VSD_ADDRESS_MASK)) {
+#ifdef XIVE_DEBUG
             xive_error(xive, "VST: invalid %s entry %x !?", info->name, =
idx);
+#endif
             return 0;
         }
=20
--=20
2.21.0


