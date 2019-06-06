Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23EDC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFABD20868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFABD20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35828 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYwRv-0002fj-G8
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:45:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hYwR6-0002Gq-M3
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hYwR5-0000og-8c
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:44:24 -0400
Received: from 10.mo1.mail-out.ovh.net ([178.32.96.102]:37543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hYwR4-0000mH-UL
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:44:23 -0400
Received: from player758.ha.ovh.net (unknown [10.108.35.232])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id B36EA17D3A3
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 19:44:20 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player758.ha.ovh.net (Postfix) with ESMTPSA id 408A569BFEAC;
	Thu,  6 Jun 2019 17:44:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  6 Jun 2019 19:44:09 +0200
Message-Id: <20190606174409.12502-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5833287421316860902
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggedguddujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.96.102
Subject: [Qemu-devel] [PATCH] ppc/xive: Make XIVE generate the proper
 interrupt types
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It should be generic Hypervisor Virtualization interrupts for HV
directed rings and traditional External Interrupts for the OS directed
ring.

Don't generate anything for the user ring as it isn't actually
supported.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 I forgot to resend this patch, an important one for HV machines !

 include/hw/ppc/xive.h |  3 ++-
 hw/intc/xive.c        | 22 +++++++++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index d872f96d1a1b..a6ee7e831d8b 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -317,7 +317,8 @@ typedef struct XiveTCTX {
     DeviceState parent_obj;
=20
     CPUState    *cs;
-    qemu_irq    output;
+    qemu_irq    hv_output;
+    qemu_irq    os_output;
=20
     uint8_t     regs[XIVE_TM_RING_COUNT * XIVE_TM_RING_SIZE];
 } XiveTCTX;
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 0c74e47aa49c..b2b92a92c84f 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -61,13 +61,28 @@ static uint8_t exception_mask(uint8_t ring)
     }
 }
=20
+static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
+{
+        switch (ring) {
+        case TM_QW0_USER:
+                return 0; /* Not supported */
+        case TM_QW1_OS:
+                return tctx->os_output;
+        case TM_QW2_HV_POOL:
+        case TM_QW3_HV_PHYS:
+                return tctx->hv_output;
+        default:
+                return 0;
+        }
+}
+
 static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs =3D &tctx->regs[ring];
     uint8_t nsr =3D regs[TM_NSR];
     uint8_t mask =3D exception_mask(ring);
=20
-    qemu_irq_lower(tctx->output);
+    qemu_irq_lower(xive_tctx_output(tctx, ring));
=20
     if (regs[TM_NSR] & mask) {
         uint8_t cppr =3D regs[TM_PIPR];
@@ -100,7 +115,7 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_t =
ring)
         default:
             g_assert_not_reached();
         }
-        qemu_irq_raise(tctx->output);
+        qemu_irq_raise(xive_tctx_output(tctx, ring));
     }
 }
=20
@@ -556,7 +571,8 @@ static void xive_tctx_realize(DeviceState *dev, Error=
 **errp)
     env =3D &cpu->env;
     switch (PPC_INPUT(env)) {
     case PPC_FLAGS_INPUT_POWER9:
-        tctx->output =3D env->irq_inputs[POWER9_INPUT_INT];
+        tctx->hv_output =3D env->irq_inputs[POWER9_INPUT_HINT];
+        tctx->os_output =3D env->irq_inputs[POWER9_INPUT_INT];
         break;
=20
     default:
--=20
2.21.0


