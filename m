Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDACC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2120207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2120207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTo5-0000QX-Vp
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPTif-00039l-2y; Mon, 05 Oct 2020 12:52:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kPTid-0001e2-6M; Mon, 05 Oct 2020 12:52:12 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 095GWFH0001044; Mon, 5 Oct 2020 12:52:05 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 34072ggq7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 12:52:04 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
 by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 095GbdmT019531;
 Mon, 5 Oct 2020 16:52:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com
 (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
 by ppma04fra.de.ibm.com with ESMTP id 33xgx817d0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Oct 2020 16:52:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 095Gq0T532571842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Oct 2020 16:52:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A4FBAE04D;
 Mon,  5 Oct 2020 16:52:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 14EA0AE053;
 Mon,  5 Oct 2020 16:52:00 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
 Mon,  5 Oct 2020 16:52:00 +0000 (GMT)
Received: from yukon.ibmuc.com (sig-9-145-2-207.uk.ibm.com [9.145.2.207])
 by smtp.tlslab.ibm.com (Postfix) with ESMTP id 494572201BC;
 Mon,  5 Oct 2020 18:51:59 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 4/6] spapr/xive: Enforce load-after-store ordering
Date: Mon,  5 Oct 2020 18:51:45 +0200
Message-Id: <20201005165147.526426-5-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201005165147.526426-1-clg@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-05_11:2020-10-05,
 2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1034 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=801 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050117
Received-SPF: softfail client-ip=148.163.156.1; envelope-from=clg@kaod.org;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 12:52:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XIVE_ESB_SET_PQ_10 load operation is used to disable temporarily
an interrupt source. If StoreEOI is active, a source could be left
enabled if the load and store operations come out of order.

QEMU makes use of this offset to quiesce the sources before a
migration. Enforce the load-after-store ordering always when doing so
without querying the characteristics of the sources on the host. The
performance penalty will be very small for QEMU.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h    |  8 ++++++++
 hw/intc/spapr_xive_kvm.c | 12 ++++++++++++
 hw/intc/xive.c           |  6 ++++++
 3 files changed, 26 insertions(+)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 445eccfe6b73..39cd273f86d5 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -279,6 +279,14 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource=
 *xsrc, int srcno)
 #define XIVE_ESB_SET_PQ_10      0xe00 /* Load */
 #define XIVE_ESB_SET_PQ_11      0xf00 /* Load */
=20
+/*
+ * Load-after-store ordering
+ *
+ * Adding this offset to the load address will enforce
+ * load-after-store ordering. This is required to use with StoreEOI.
+ */
+#define XIVE_ESB_LD_ST_MO       0x40 /* Load-after-store ordering */
+
 uint8_t xive_source_esb_get(XiveSource *xsrc, uint32_t srcno);
 uint8_t xive_source_esb_set(XiveSource *xsrc, uint32_t srcno, uint8_t pq=
);
=20
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 66bf4c06fe55..d428422a7b72 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -357,6 +357,18 @@ static uint64_t xive_esb_rw(XiveSource *xsrc, int sr=
cno, uint32_t offset,
=20
 static uint8_t xive_esb_read(XiveSource *xsrc, int srcno, uint32_t offse=
t)
 {
+    /*
+     * The XIVE_ESB_SET_PQ_10 load operation is used to disable
+     * temporarily an interrupt source. If StoreEOI is active, a
+     * source could be left enabled if the load and store operations
+     * come out of order.
+     *
+     * Enforce the load-after-store ordering always.
+     */
+    if (offset =3D=3D XIVE_ESB_SET_PQ_10) {
+        offset |=3D XIVE_ESB_LD_ST_MO;
+    }
+
     return xive_esb_rw(xsrc, srcno, offset, 0, 0) & 0x3;
 }
=20
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 489e6256ef70..b710ba2df095 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -998,6 +998,12 @@ static uint64_t xive_source_esb_read(void *opaque, h=
waddr addr, unsigned size)
     case XIVE_ESB_SET_PQ_01 ... XIVE_ESB_SET_PQ_01 + 0x0FF:
     case XIVE_ESB_SET_PQ_10 ... XIVE_ESB_SET_PQ_10 + 0x0FF:
     case XIVE_ESB_SET_PQ_11 ... XIVE_ESB_SET_PQ_11 + 0x0FF:
+        if (offset =3D=3D XIVE_ESB_SET_PQ_10 &&
+            xsrc->esb_flags & XIVE_SRC_STORE_EOI) {
+            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: load-after-store order=
ing "
+                          "not enforced with Store EOI active for IRQ %d=
\n",
+                          srcno);
+        }
         ret =3D xive_source_esb_set(xsrc, srcno, (offset >> 8) & 0x3);
         break;
     default:
--=20
2.25.4


