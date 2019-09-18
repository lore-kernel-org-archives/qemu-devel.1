Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7340EC4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:09:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A202208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 18:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A202208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAe2x-0007i0-7p
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcW0-0005ax-Ri
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcVz-00042f-Bm
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:09:12 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:49365)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcVz-00041q-6c
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:09:11 -0400
Received: from player799.ha.ovh.net (unknown [10.109.143.216])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id BB6EE1AD3E9
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:09:09 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 552AF9F0EB3D;
 Wed, 18 Sep 2019 16:09:04 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:44 +0200
Message-Id: <20190918160645.25126-25-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6243396460226907110
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.172.75
Subject: [Qemu-devel] [PATCH v4 24/25] ppc/pnv: Improve trigger data
 definition
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

The trigger definition is used for triggers both for HW source
interrupts, PHB, PSI, as well as for rerouting interrupts between
Interrupt Controller.

HW source controllers set bit0 of word0 to =E2=80=980=E2=80=99 as they pr=
ovide EAS
information (EAS block + EAS index) in the 8 byte data and not END
information, and bit1 of word0 to =E2=80=981=E2=80=99 to signal that the =
state bit
check has been performed.

Introduce these new trigger bits and rename the XIVE_SRCNO macros in
XIVE_EAS to reflect better the nature of the data. This is breaking
the notification for the PSI model which will be fixed in the next
patch.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive_regs.h | 24 +++++++++++++++++++++---
 hw/intc/pnv_xive.c         | 16 ++++++++++++----
 hw/intc/xive.c             |  4 ++--
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index dd42c33cef35..83a2f2cc1318 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -22,9 +22,27 @@
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
+ * information, and bit1 of word0 to =E2=80=981=E2=80=99 to signal that =
the state bit
+ * check has been performed.
+ */
+#define XIVE_TRIGGER_END        PPC_BIT(0)
+#define XIVE_TRIGGER_EAS        PPC_BIT(1)
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
index 4c1fa024cdf5..61af3f23000f 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -385,7 +385,7 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_t=
 blk, uint32_t idx,
      * EAT lookups should be local to the IC
      */
     if (pnv_xive_block_id(xive) !=3D blk) {
-        xive_error(xive, "VST: EAS %x is remote !?", XIVE_SRCNO(blk, idx=
));
+        xive_error(xive, "VST: EAS %x is remote !?", XIVE_EAS(blk, idx))=
;
         return -1;
     }
=20
@@ -502,7 +502,7 @@ static void pnv_xive_notify(XiveNotifier *xn, uint32_=
t srcno)
     PnvXive *xive =3D PNV_XIVE(xn);
     uint8_t blk =3D pnv_xive_block_id(xive);
=20
-    xive_router_notify(xn, XIVE_SRCNO(blk, srcno));
+    xive_router_notify(xn, XIVE_EAS(blk, srcno));
 }
=20
 /*
@@ -1287,12 +1287,20 @@ static const MemoryRegionOps pnv_xive_ic_reg_ops =
=3D {
=20
 static void pnv_xive_ic_hw_trigger(PnvXive *xive, hwaddr addr, uint64_t =
val)
 {
+    uint8_t blk =3D XIVE_EAS_BLOCK(val);
+    uint32_t idx =3D XIVE_EAS_INDEX(val);
+
     /*
      * Forward the source event notification directly to the Router.
      * The source interrupt number should already be correctly encoded
      * with the chip block id by the sending device (PHB, PSI).
      */
-    xive_router_notify(XIVE_NOTIFIER(xive), val);
+    if (val & XIVE_TRIGGER_EAS) {
+        xive_router_notify(XIVE_NOTIFIER(xive), XIVE_EAS(blk, idx));
+    } else {
+        xive_error(xive, "IC: END trigger at @0x%"HWADDR_PRIx" data 0x%"=
PRIx64,
+                   addr, val);
+    }
 }
=20
 static void pnv_xive_ic_notify_write(void *opaque, hwaddr addr, uint64_t=
 val,
@@ -1683,7 +1691,7 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monitor=
 *mon)
     XiveRouter *xrtr =3D XIVE_ROUTER(xive);
     uint8_t blk =3D pnv_xive_block_id(xive);
     uint8_t chip_id =3D xive->chip->chip_id;
-    uint32_t srcno0 =3D XIVE_SRCNO(blk, 0);
+    uint32_t srcno0 =3D XIVE_EAS(blk, 0);
     uint32_t nr_ipis =3D pnv_xive_nr_ipis(xive, blk);
     XiveEAS eas;
     XiveEND end;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 07b7c3586c12..6702f32be601 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1652,8 +1652,8 @@ do_escalation:
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


