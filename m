Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367FDC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:34:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C12D207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C12D207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUOK-00072v-7N
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:34:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioTpb-0001cH-QI
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioTpa-0001UY-GL
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:58:11 -0500
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:59412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioTpa-0001Sl-A1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:58:10 -0500
Received: from player731.ha.ovh.net (unknown [10.108.42.145])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id CE3C0155AAE
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:58:07 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 35281DB3A926;
 Mon,  6 Jan 2020 14:58:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 12/12] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
Date: Mon,  6 Jan 2020 15:56:45 +0100
Message-Id: <20200106145645.4539-13-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106145645.4539-1-clg@kaod.org>
References: <20200106145645.4539-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5404038079288347622
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeef
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.59.63
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

From: Greg Kurz <groug@kaod.org>

The proper way to do that would be to use device_class_set_parent_realize=
(),
but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_realiz=
e
pointer adds a fair amount of code. Calling pnv_psi_realize() explicitely
is fine for now.

This should probably be achieved with a device realize hook in the
PSI base class and device_class_set_parent_realize() in the children
classes.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_psi.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index cf21e42d93b7..ce7717ccb151 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -471,6 +471,16 @@ static void pnv_psi_reset_handler(void *dev)
     dc->reset(DEVICE(dev));
 }
=20
+static void pnv_psi_realize(DeviceState *dev, Error **errp)
+{
+    PnvPsi *psi =3D PNV_PSI(dev);
+
+    /* Default BAR for MMIO region */
+    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
+
+    qemu_register_reset(pnv_psi_reset_handler, dev);
+}
+
 static void pnv_psi_power8_instance_init(Object *obj)
 {
     Pnv8Psi *psi8 =3D PNV8_PSI(obj);
@@ -523,9 +533,6 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
     memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, psi=
,
                           "psihb", PNV_PSIHB_SIZE);
=20
-    /* Default BAR for MMIO region */
-    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
-
     /* Default sources in XIVR */
     for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
         uint8_t xivr =3D irq_to_xivr[i];
@@ -533,7 +540,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
             ((uint64_t) i << PSIHB_XIVR_SRC_SH);
     }
=20
-    qemu_register_reset(pnv_psi_reset_handler, dev);
+    pnv_psi_realize(dev, errp);
 }
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
@@ -868,9 +875,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
     memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mmio_o=
ps, psi,
                           "psihb", PNV9_PSIHB_SIZE);
=20
-    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
-
-    qemu_register_reset(pnv_psi_reset_handler, dev);
+    pnv_psi_realize(dev, errp);
 }
=20
 static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
--=20
2.21.1


