Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60242C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:46:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E722084B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 08:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E722084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHOfR-0000XN-Tf
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 04:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iHOaY-0003gu-Tk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iHOaV-00040D-Ip
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:41:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2380
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iHOa4-0003mi-Cf
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 04:41:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x978d8Mm130892
 for <qemu-devel@nongnu.org>; Mon, 7 Oct 2019 04:41:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2vfy46mw6r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 04:41:15 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 7 Oct 2019 09:41:13 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 7 Oct 2019 09:41:11 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x978eeNn21561778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Oct 2019 08:40:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15D8511C04A;
 Mon,  7 Oct 2019 08:41:10 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDAA411C052;
 Mon,  7 Oct 2019 08:41:09 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  7 Oct 2019 08:41:09 +0000 (GMT)
Received: from yukon.kaod.org.com (sig-9-145-169-184.de.ibm.com
 [9.145.169.184])
 by smtp.tls.ibm.com (Postfix) with ESMTP id 260E6220204;
 Mon,  7 Oct 2019 10:41:09 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/9] ppc/pnv: Improve trigger data definition
Date: Mon,  7 Oct 2019 10:40:54 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191007084102.29776-1-clg@kaod.org>
References: <20191007084102.29776-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19100708-0008-0000-0000-0000031EBC64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100708-0009-0000-0000-00004A3DCC99
Message-Id: <20191007084102.29776-2-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-07_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=722 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910070090
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id x978d8Mm130892
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

The trigger data is used for both triggers of a HW source interrupts,
PHB, PSI, and triggers for rerouting interrupts between interrupt
controllers.

When an interrupt is rerouted, the trigger data follows an "END
trigger" format. In that case, the remote IC needs EAS containing an
END index to perform a lookup of an END.

An END trigger, bit0 of word0 set to '1', is defined as :

             |0123|4567|0123|4567|0123|4567|0123|4567|
    W0 E=3D1   |1P--|BLOC|          END IDX            |
    W1 E=3D1   |M   |           END DATA               |

An EAS is defined as :

             |0123|4567|0123|4567|0123|4567|0123|4567|
    W0       |V---|BLOC|          END IDX            |
    W1       |M   |          END DATA                |

The END trigger adds an extra 'PQ' bit, bit1 of word0 set to '1',
signaling that the PQ bits have been checked. That bit is unused in
the initial EAS definition.

When a HW device performs the trigger, the trigger data follows an
"EAS trigger" format because the trigger data in that case contains an
EAS index which the IC needs to look for.

An EAS trigger, bit0 of word0 set to '0', is defined as :

             |0123|4567|0123|4567|0123|4567|0123|4567|
    W0 E=3D0   |0P--|---- ---- ---- ---- ---- ---- ----|
    W1 E=3D0   |BLOC|            EAS INDEX             |

There is also a 'PQ' bit, bit1 of word0 to '1', signaling that the
PQ bits have been checked.

Introduce these new trigger bits and rename the XIVE_SRCNO macros in
XIVE_EAS to reflect better the nature of the data.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h | 26 +++++++++++++++++++++++---
 hw/intc/pnv_xive.c         | 20 ++++++++++++++++----
 hw/intc/xive.c             |  4 ++--
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 08c8bf7172e2..55307cd1533c 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -22,9 +22,29 @@
 /*
  * Interrupt source number encoding on PowerBUS
  */
-#define XIVE_SRCNO_BLOCK(srcno) (((srcno) >> 28) & 0xf)
-#define XIVE_SRCNO_INDEX(srcno) ((srcno) & 0x0fffffff)
-#define XIVE_SRCNO(blk, idx)    ((uint32_t)(blk) << 28 | (idx))
+/*
+ * Trigger data definition
+ *
+ * The trigger definition is used for triggers both for HW source
+ * interrupts (PHB, PSI), as well as for rerouting interrupts between
+ * Interrupt Controller.
+ *
+ * HW source controllers set bit0 of word0 to =E2=80=980=E2=80=99 as the=
y provide EAS
+ * information (EAS block + EAS index) in the 8 byte data and not END
+ * information, which is use for rerouting interrupts.
+ *
+ * bit1 of word0 to =E2=80=981=E2=80=99 signals that the state bit check=
 has been
+ * performed.
+ */
+#define XIVE_TRIGGER_END        PPC_BIT(0)
+#define XIVE_TRIGGER_PQ         PPC_BIT(1)
+
+/*
+ * QEMU macros to manipulate the trigger payload in native endian
+ */
+#define XIVE_EAS_BLOCK(n)       (((n) >> 28) & 0xf)
+#define XIVE_EAS_INDEX(n)       ((n) & 0x0fffffff)
+#define XIVE_EAS(blk, idx)      ((uint32_t)(blk) << 28 | (idx))
=20
 #define TM_SHIFT                16
=20
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ed6e9d71bbfa..348f2fdd263d 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -385,7 +385,7 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t=
 blk, uint32_t idx,
     PnvXive *xive =3D PNV_XIVE(xrtr);
=20
     if (pnv_xive_get_ic(blk) !=3D xive) {
-        xive_error(xive, "VST: EAS %x is remote !?", XIVE_SRCNO(blk, idx=
));
+        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx))=
;
         return -1;
     }
=20
@@ -431,7 +431,7 @@ static void pnv_xive_notify(XiveNotifier *xn, uint32_=
t srcno)
     PnvXive *xive =3D PNV_XIVE(xn);
     uint8_t blk =3D xive->chip->chip_id;
=20
-    xive_router_notify(xn, XIVE_SRCNO(blk, srcno));
+    xive_router_notify(xn, XIVE_EAS(blk, srcno));
 }
=20
 /*
@@ -1225,12 +1225,24 @@ static const MemoryRegionOps pnv_xive_ic_reg_ops =
=3D {
=20
 static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t =
val)
 {
+    uint8_t blk;
+    uint32_t idx;
+
+    if (val & XIVE_TRIGGER_END) {
+        xive_error(xive, "IC: END trigger at @0x%"HWADDR_PRIx" data 0x%"=
PRIx64,
+                   addr, val);
+        return;
+    }
+
     /*
      * Forward the source event notification directly to the Router.
      * The source interrupt number should already be correctly encoded
      * with the chip block id by the sending device (PHB, PSI).
      */
-    xive_router_notify(XIVE_NOTIFIER(xive), val);
+    blk =3D XIVE_EAS_BLOCK(val);
+    idx =3D XIVE_EAS_INDEX(val);
+
+    xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx));
 }
=20
 static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint64_t=
 val,
@@ -1566,7 +1578,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
     uint8_t blk =3D xive->chip->chip_id;
-    uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
+    uint32_t srcno0 =3D XIVE_EAS(blk, 0);
     uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive);
     uint32_t nr_ends =3D pnv_xive_nr_ends(xive);
     XiveEAS eas;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 29df06df1136..cbe4ae6c294d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1648,8 +1648,8 @@ do_escalation:
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn)
 {
     XiveRouter *xrtr =3D XIVE_ROUTER(xn);
-    uint8_t eas_blk =3D XIVE_SRCNO_BLOCK(lisn);
-    uint32_t eas_idx =3D XIVE_SRCNO_INDEX(lisn);
+    uint8_t eas_blk =3D XIVE_EAS_BLOCK(lisn);
+    uint32_t eas_idx =3D XIVE_EAS_INDEX(lisn);
     XiveEAS eas;
=20
     /* EAS cache lookup */
--=20
2.21.0


