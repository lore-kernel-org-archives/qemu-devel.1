Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F37C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:23:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A50520731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A50520731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUDm-0007wn-Ow
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49233)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioToU-0008Up-RJ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioToT-0000Ni-HP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:02 -0500
Received: from 3.mo5.mail-out.ovh.net ([46.105.40.108]:37099)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioToT-0000MD-BZ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:01 -0500
Received: from player731.ha.ovh.net (unknown [10.108.42.176])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 565A5263469
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:56:59 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 72C5CDB3A3F4;
 Mon,  6 Jan 2020 14:56:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 01/12] ppc/pnv: Introduce a "xics" property alias under the
 PSI model
Date: Mon,  6 Jan 2020 15:56:34 +0100
Message-Id: <20200106145645.4539-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106145645.4539-1-clg@kaod.org>
References: <20200106145645.4539-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5384897783093103590
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgjeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.40.108
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

This removes the need of the intermediate link under PSI to pass the
XICS link to the underlying ICSState object.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c     |  4 ++--
 hw/ppc/pnv_psi.c | 11 ++---------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 855254f28263..230bb9f31235 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -992,8 +992,6 @@ static void pnv_chip_power8_instance_init(Object *obj=
)
=20
     object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi)=
,
                             TYPE_PNV8_PSI, &error_abort, NULL);
-    object_property_add_const_link(OBJECT(&chip8->psi), "xics",
-                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
=20
     object_initialize_child(obj, "lpc",  &chip8->lpc, sizeof(chip8->lpc)=
,
                             TYPE_PNV8_LPC, &error_abort, NULL);
@@ -1060,6 +1058,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
     /* Processor Service Interface (PSI) Host Bridge */
     object_property_set_int(OBJECT(&chip8->psi), PNV_PSIHB_BASE(chip),
                             "bar", &error_fatal);
+    object_property_set_link(OBJECT(&chip8->psi), OBJECT(qdev_get_machin=
e()),
+                             ICS_PROP_XICS, &error_abort);
     object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 75e20d9da08b..4da3d2568624 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -470,6 +470,8 @@ static void pnv_psi_power8_instance_init(Object *obj)
=20
     object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ic=
s),
                             TYPE_ICS, &error_abort, NULL);
+    object_property_add_alias(obj, ICS_PROP_XICS, OBJECT(&psi8->ics),
+                              ICS_PROP_XICS, &error_abort);
 }
=20
 static const uint8_t irq_to_xivr[] =3D {
@@ -485,19 +487,10 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
 {
     PnvPsi *psi =3D PNV_PSI(dev);
     ICSState *ics =3D &PNV8_PSI(psi)->ics;
-    Object *obj;
     Error *err =3D NULL;
     unsigned int i;
=20
-    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
-    if (!obj) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
-                   __func__, error_get_pretty(err));
-        return;
-    }
-
     /* Create PSI interrupt control source */
-    object_property_set_link(OBJECT(ics), obj, ICS_PROP_XICS, &error_abo=
rt);
     object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", =
&err);
     if (err) {
         error_propagate(errp, err);
--=20
2.21.1


