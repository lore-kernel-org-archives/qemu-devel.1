Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA425C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:17:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD7C20449
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD7C20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspQ6-0006xK-O6
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34282)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hspM8-0007wp-Vr
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hspM7-0001uR-N1
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:28 -0400
Received: from 20.mo7.mail-out.ovh.net ([46.105.49.208]:32838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hspM7-0001tm-H5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:27 -0400
Received: from player715.ha.ovh.net (unknown [10.108.35.74])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 314E7129E7A
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:13:26 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id B8044850B979;
 Wed, 31 Jul 2019 14:13:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 31 Jul 2019 16:12:21 +0200
Message-Id: <20190731141233.1340-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731141233.1340-1-clg@kaod.org>
References: <20190731141233.1340-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11675019088031091686
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.49.208
Subject: [Qemu-devel] [PATCH v3 06/18] ppc/xive: Use the XiveFabric and
 XivePresenter interfaces
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
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the machines have handlers implemented for the XiveFabric and
XivePresenter interfaces, remove xive_presenter_match() and make use of
the 'match_nvt' handler of the machine.

Fixes: af53dbf6227a ("ppc/xive: introduce a simplified XIVE presenter")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 77 +++++++++++---------------------------------------
 1 file changed, 17 insertions(+), 60 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 4bdedab13047..bec0c878705c 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1354,59 +1354,6 @@ int xive_presenter_tctx_match(XivePresenter *xptr,=
 XiveTCTX *tctx,
     return -1;
 }
=20
-static bool xive_presenter_match(XiveRouter *xrtr, uint8_t format,
-                                 uint8_t nvt_blk, uint32_t nvt_idx,
-                                 bool cam_ignore, uint8_t priority,
-                                 uint32_t logic_serv, XiveTCTXMatch *mat=
ch)
-{
-    CPUState *cs;
-
-    /*
-     * TODO (PowerNV): handle chip_id overwrite of block field for
-     * hardwired CAM compares
-     */
-
-    CPU_FOREACH(cs) {
-        XiveTCTX *tctx =3D xive_router_get_tctx(xrtr, cs);
-        int ring;
-
-        /*
-         * HW checks that the CPU is enabled in the Physical Thread
-         * Enable Register (PTER).
-         */
-
-        /*
-         * Check the thread context CAM lines and record matches. We
-         * will handle CPU exception delivery later
-         */
-        ring =3D xive_presenter_tctx_match(XIVE_PRESENTER(xrtr), tctx, f=
ormat,
-                                         nvt_blk, nvt_idx,
-                                         cam_ignore, logic_serv);
-        /*
-         * Save the context and follow on to catch duplicates, that we
-         * don't support yet.
-         */
-        if (ring !=3D -1) {
-            if (match->tctx) {
-                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
-                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
-                return false;
-            }
-
-            match->ring =3D ring;
-            match->tctx =3D tctx;
-        }
-    }
-
-    if (!match->tctx) {
-        qemu_log_mask(LOG_UNIMP, "XIVE: NVT %x/%x is not dispatched\n",
-                      nvt_blk, nvt_idx);
-        return false;
-    }
-
-    return true;
-}
-
 /*
  * This is our simple Xive Presenter Engine model. It is merged in the
  * Router as it does not require an extra object.
@@ -1422,22 +1369,32 @@ static bool xive_presenter_match(XiveRouter *xrtr=
, uint8_t format,
  *
  * The parameters represent what is sent on the PowerBus
  */
-static bool xive_presenter_notify(XiveRouter *xrtr, uint8_t format,
+static bool xive_presenter_notify(uint8_t format,
                                   uint8_t nvt_blk, uint32_t nvt_idx,
                                   bool cam_ignore, uint8_t priority,
                                   uint32_t logic_serv)
 {
+    XiveFabric *xfb =3D XIVE_FABRIC(qdev_get_machine());
+    XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
     XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
-    bool found;
+    int count;
=20
-    found =3D xive_presenter_match(xrtr, format, nvt_blk, nvt_idx, cam_i=
gnore,
-                                 priority, logic_serv, &match);
-    if (found) {
+    /*
+     * Ask the machine to scan the interrupt controllers for a match
+     */
+    count =3D xfc->match_nvt(xfb, format, nvt_blk, nvt_idx, cam_ignore,
+                           priority, logic_serv, &match);
+    if (count < 0) {
+        return false;
+    }
+
+    /* handle CPU exception delivery */
+    if (count) {
         ipb_update(&match.tctx->regs[match.ring], priority);
         xive_tctx_notify(match.tctx, match.ring);
     }
=20
-    return found;
+    return count;
 }
=20
 /*
@@ -1550,7 +1507,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
, uint8_t end_blk,
         return;
     }
=20
-    found =3D xive_presenter_notify(xrtr, format, nvt_blk, nvt_idx,
+    found =3D xive_presenter_notify(format, nvt_blk, nvt_idx,
                           xive_get_field32(END_W7_F0_IGNORE, end.w7),
                           priority,
                           xive_get_field32(END_W7_F1_LOG_SERVER_ID, end.=
w7));
--=20
2.21.0


