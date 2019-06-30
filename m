Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B42C5B576
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036C32086D
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 20:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036C32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhgpR-0008Bk-8Z
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 16:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hhgjA-00007b-0G
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hhgj5-0002PK-Ag
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:09 -0400
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:34593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hhgj2-0002LN-AW
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 16:47:05 -0400
Received: from player157.ha.ovh.net (unknown [10.109.143.145])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id AF0CA6E500
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 22:47:01 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 9CA2C7575AD1;
 Sun, 30 Jun 2019 20:46:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 30 Jun 2019 22:45:58 +0200
Message-Id: <20190630204601.30574-8-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190630204601.30574-1-clg@kaod.org>
References: <20190630204601.30574-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2289235986895440870
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrvdeggdduheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.75.45
Subject: [Qemu-devel] [PATCH 07/10] ppc/xive: Improve 'info pic' support
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
 Greg Kurz <groug@kaod.org>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a better output of the XIVE END structures including the
escalation information and extend the PowerNV machine 'info pic'
command with a dump of the END EAS table used for escalations.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      |  5 ----
 include/hw/ppc/xive_regs.h |  6 +++++
 hw/intc/pnv_xive.c         |  9 +++++++
 hw/intc/spapr_xive.c       |  1 -
 hw/intc/xive.c             | 48 +++++++++++++++++++++++++++++++++-----
 5 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index a6ee7e831d8b..d922524982d3 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -356,8 +356,6 @@ typedef struct XiveRouterClass {
     XiveTCTX *(*get_tctx)(XiveRouter *xrtr, CPUState *cs);
 } XiveRouterClass;
=20
-void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
-
 int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_=
idx,
                         XiveEAS *eas);
 int xive_router_get_end(XiveRouter *xrtr, uint8_t end_blk, uint32_t end_=
idx,
@@ -399,9 +397,6 @@ typedef struct XiveENDSource {
  */
 #define XIVE_PRIORITY_MAX  7
=20
-void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n);
-void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon);
-
 /*
  * XIVE Thread Interrupt Management Aera (TIMA)
  *
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 69af326ebf2c..3fdf1a83b9b6 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -128,6 +128,8 @@ typedef struct XiveEAS {
 #define xive_eas_is_valid(eas)   (be64_to_cpu((eas)->w) & EAS_VALID)
 #define xive_eas_is_masked(eas)  (be64_to_cpu((eas)->w) & EAS_MASKED)
=20
+void xive_eas_pic_print_info(XiveEAS *eas, uint32_t lisn, Monitor *mon);
+
 static inline uint64_t xive_get_field64(uint64_t mask, uint64_t word)
 {
     return (be64_to_cpu(word) & mask) >> ctz64(mask);
@@ -218,6 +220,10 @@ static inline uint64_t xive_end_qaddr(XiveEND *end)
         be32_to_cpu(end->w3);
 }
=20
+void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n);
+void xive_end_queue_pic_print_info(XiveEND *end, uint32_t width, Monitor=
 *mon);
+void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor=
 *mon);
+
 /* Notification Virtual Target (NVT) */
 typedef struct XiveNVT {
         uint32_t        w0;
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 4dc92ef1e372..ff1226485983 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1593,6 +1593,15 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monito=
r *mon)
         }
         xive_end_pic_print_info(&end, i, mon);
     }
+
+    monitor_printf(mon, "XIVE[%x] END Escalation %08x .. %08x\n", blk, 0=
,
+                   nr_ends - 1);
+    for (i =3D 0; i < nr_ends; i++) {
+        if (xive_router_get_end(xrtr, blk, i, &end)) {
+            break;
+        }
+        xive_end_eas_pic_print_info(&end, i, mon);
+    }
 }
=20
 static void pnv_xive_reset(void *dev)
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 58c2e5d890bd..48cd50192f61 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -143,7 +143,6 @@ static void spapr_xive_end_pic_print_info(SpaprXive *=
xive, XiveEND *end,
                    priority, qindex, qentries, qaddr_base, qgen);
=20
     xive_end_queue_pic_print_info(end, 6, mon);
-    monitor_printf(mon, "]");
 }
=20
 void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 3970999f4837..f7ba1c3b622f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1136,6 +1136,7 @@ void xive_end_queue_pic_print_info(XiveEND *end, ui=
nt32_t width, Monitor *mon)
                        be32_to_cpu(qdata));
         qindex =3D (qindex + 1) & (qentries - 1);
     }
+    monitor_printf(mon, "]");
 }
=20
 void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor *mo=
n)
@@ -1146,24 +1147,36 @@ void xive_end_pic_print_info(XiveEND *end, uint32=
_t end_idx, Monitor *mon)
     uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
     uint32_t qentries =3D 1 << (qsize + 10);
=20
-    uint32_t nvt =3D xive_get_field32(END_W6_NVT_INDEX, end->w6);
+    uint32_t nvt_blk =3D xive_get_field32(END_W6_NVT_BLOCK, end->w6);
+    uint32_t nvt_idx =3D xive_get_field32(END_W6_NVT_INDEX, end->w6);
     uint8_t priority =3D xive_get_field32(END_W7_F0_PRIORITY, end->w7);
+    uint8_t pq;
=20
     if (!xive_end_is_valid(end)) {
         return;
     }
=20
-    monitor_printf(mon, "  %08x %c%c%c%c%c prio:%d nvt:%04x eq:@%08"PRIx=
64
-                   "% 6d/%5d ^%d", end_idx,
+    pq =3D xive_get_field32(END_W1_ESn, end->w1);
+
+    monitor_printf(mon, "  %08x %c%c %c%c%c%c%c%c%c prio:%d nvt:%02x/%04=
x",
+                   end_idx,
+                   pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                   pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
                    xive_end_is_valid(end)    ? 'v' : '-',
                    xive_end_is_enqueue(end)  ? 'q' : '-',
                    xive_end_is_notify(end)   ? 'n' : '-',
                    xive_end_is_backlog(end)  ? 'b' : '-',
                    xive_end_is_escalate(end) ? 'e' : '-',
-                   priority, nvt, qaddr_base, qindex, qentries, qgen);
+                   xive_end_is_uncond_escalation(end)   ? 'u' : '-',
+                   xive_end_is_silent_escalation(end)   ? 's' : '-',
+                   priority, nvt_blk, nvt_idx);
=20
-    xive_end_queue_pic_print_info(end, 6, mon);
-    monitor_printf(mon, "]\n");
+    if (qaddr_base) {
+        monitor_printf(mon, " eq:@%08"PRIx64"% 6d/%5d ^%d",
+                       qaddr_base, qindex, qentries, qgen);
+        xive_end_queue_pic_print_info(end, 6, mon);
+    }
+    monitor_printf(mon, "\n");
 }
=20
 static void xive_end_enqueue(XiveEND *end, uint32_t data)
@@ -1191,6 +1204,29 @@ static void xive_end_enqueue(XiveEND *end, uint32_=
t data)
     end->w1 =3D xive_set_field32(END_W1_PAGE_OFF, end->w1, qindex);
 }
=20
+void xive_end_eas_pic_print_info(XiveEND *end, uint32_t end_idx,
+                                   Monitor *mon)
+{
+    XiveEAS *eas =3D (XiveEAS *) &end->w4;
+    uint8_t pq;
+
+    if (!xive_end_is_escalate(end)) {
+        return;
+    }
+
+    pq =3D xive_get_field32(END_W1_ESe, end->w1);
+
+    monitor_printf(mon, "  %08x %c%c %c%c end:%02x/%04x data:%08x\n",
+                   end_idx,
+                   pq & XIVE_ESB_VAL_P ? 'P' : '-',
+                   pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
+                   xive_eas_is_valid(eas) ? 'V' : ' ',
+                   xive_eas_is_masked(eas) ? 'M' : ' ',
+                   (uint8_t)  xive_get_field64(EAS_END_BLOCK, eas->w),
+                   (uint32_t) xive_get_field64(EAS_END_INDEX, eas->w),
+                   (uint32_t) xive_get_field64(EAS_END_DATA, eas->w));
+}
+
 /*
  * XIVE Router (aka. Virtualization Controller or IVRE)
  */
--=20
2.21.0


