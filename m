Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E28C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45AE720867
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45AE720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHOcT-0005aS-Tt
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 04:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48978)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iHOaa-0003iE-Ox
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iHOaW-00041O-1Q
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:41:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45782)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iHOa6-0003ns-9u
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:41:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x978cFK1057949
 for <qemu-devel@nongnu.org>; Mon, 7 Oct 2019 04:41:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vf98g469w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 04:41:17 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 7 Oct 2019 09:41:14 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 7 Oct 2019 09:41:13 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x978egAt13369654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2019 08:40:42 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50633A4062;
 Mon,  7 Oct 2019 08:41:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BD30A4054;
 Mon,  7 Oct 2019 08:41:12 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2019 08:41:12 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-169-184.de.ibm.com
 [9.145.169.184])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 818D722006B;
 Mon,  7 Oct 2019 10:41:11 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 4/9] ppc/xive: Introduce helpers for the NVT id
Date: Mon,  7 Oct 2019 10:40:57 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007084102.29776-1-clg@kaod.org>
References: <20191007084102.29776-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19100708-0012-0000-0000-00000354C280
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0013-0000-0000-0000218FD255
Message-Id: <20191007084102.29776-5-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-07_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=811 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070090
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x978cFK1057949
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NVT space is 19 bits wide, giving a maximum of 512K per chip. When
a vPCU is dispatched on a HW thread, the NVT identifier is pushed in
the CAM line (QW1W2). This identifier is used in the presenter
subengine to fetch a NVT structure which might contain pending
interrupts that need a resend.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      |  5 -----
 include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index fd3319bd3202..c1d274f39f9f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -416,11 +416,6 @@ uint64_t xive_tctx_tm_read(XiveTCTX *tctx, hwaddr of=
fset, unsigned size);
 void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor *mon);
 Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
=20
-static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
-{
-    return (nvt_blk << 19) | nvt_idx;
-}
-
 /*
  * KVM XIVE device helpers
  */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 530f232b04f8..1a5622f8ded8 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -272,4 +272,25 @@ typedef struct XiveNVT {
=20
 #define xive_nvt_is_valid(nvt)    (be32_to_cpu((nvt)->w0) & NVT_W0_VALID=
)
=20
+/*
+ * The VP number space in a block is defined by the END_W6_NVT_INDEX
+ * field of the XIVE END
+ */
+#define XIVE_NVT_SHIFT                19
+
+static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
+{
+    return (nvt_blk << XIVE_NVT_SHIFT) | nvt_idx;
+}
+
+static inline uint32_t xive_nvt_idx(uint32_t cam_line)
+{
+    return cam_line & ((1 << XIVE_NVT_SHIFT) - 1);
+}
+
+static inline uint32_t xive_nvt_blk(uint32_t cam_line)
+{
+    return (cam_line >> XIVE_NVT_SHIFT) & 0xf;
+}
+
 #endif /* PPC_XIVE_REGS_H */
--=20
2.21.0


