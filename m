Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4915BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 154842070B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 08:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AiNwoTDj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 154842070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNYP6-0005dl-UE
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 04:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36474)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKQ-0004c9-G2
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iNYKP-0004yw-3t
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 04:18:42 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34799 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iNYKO-0004s8-Lw; Thu, 24 Oct 2019 04:18:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46zKrX5tRCz9sR6; Thu, 24 Oct 2019 19:18:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1571905116;
 bh=SQwpN+RW74j0cauvfIg1SAmlAX+IHu0+B9uvfDotYJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AiNwoTDjffU6mIsWMCImthT6K6awsq+Bo6/mJsJwMvjYwGXEc2K3IIYvCfoT6zetL
 5IqEFD9WqjnnS4iahFdwwXn8xV0WRMEAqB/6vC9oJWu19BgEm7nKh935KvBFjpi2sb
 ciOlFtvcjJVxDT0KuxiP2BQllauMKFit2I/Ikn2U=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 04/28] ppc/pnv: Improve trigger data definition
Date: Thu, 24 Oct 2019 19:17:49 +1100
Message-Id: <20191024081813.2115-5-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191024081813.2115-1-david@gibson.dropbear.id.au>
References: <20191024081813.2115-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

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
Message-Id: <20191007084102.29776-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/pnv_xive.c         | 20 ++++++++++++++++----
 hw/intc/xive.c             |  4 ++--
 include/hw/ppc/xive_regs.h | 26 +++++++++++++++++++++++---
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ed6e9d71bb..348f2fdd26 100644
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
index 453d389848..d420c6571e 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1658,8 +1658,8 @@ do_escalation:
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
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 08c8bf7172..55307cd153 100644
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
--=20
2.21.0


