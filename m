Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11393C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD047208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD047208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdjO-0004xt-QV
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcUZ-0003ln-HG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcUY-00033I-6e
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:43 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:51040)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcUY-000321-0c
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:42 -0400
Received: from player799.ha.ovh.net (unknown [10.109.160.11])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 330451901F4
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:07:40 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id A82B79F0E5EE;
 Wed, 18 Sep 2019 16:07:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:28 +0200
Message-Id: <20190918160645.25126-9-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6218345189355129830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.119.250
Subject: [Qemu-devel] [PATCH v4 08/25] ppc/xive: Use the XiveFabric and
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that the machines have handlers implementing the XiveFabric and
XivePresenter interfaces, remove xive_presenter_match() and make use
of the 'match_nvt' handler of the machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c | 48 +++++++++++++++++-------------------------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7a15a64ed7fe..f951ad8cb08d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1376,30 +1376,6 @@ int xive_presenter_tctx_match(XivePresenter *xptr,=
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
-    XivePresenter *xptr =3D XIVE_PRESENTER(xrtr);
-    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
-    int count;
-
-    count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
-                           priority, logic_serv, match);
-    if (count < 0) {
-        return false;
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
@@ -1415,22 +1391,32 @@ static bool xive_presenter_match(XiveRouter *xrtr=
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
@@ -1543,7 +1529,7 @@ static void xive_router_end_notify(XiveRouter *xrtr=
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


