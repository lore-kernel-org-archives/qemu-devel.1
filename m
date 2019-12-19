Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69108C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC8F227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC8F227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0PD-0000Xe-KT
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ii0Hk-0000BI-1O
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ii0Hi-0002rE-Sc
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:27 -0500
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:39580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ii0Hi-0002i6-KB
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:12:26 -0500
Received: from player734.ha.ovh.net (unknown [10.108.35.223])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id F2719263592
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 19:12:24 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id 6A3A3D6D62BE;
 Thu, 19 Dec 2019 18:12:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 03/13] ppc/pnv: Introduce a "xics" property alias under the
 PSI model
Date: Thu, 19 Dec 2019 19:11:45 +0100
Message-Id: <20191219181155.32530-4-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219181155.32530-1-clg@kaod.org>
References: <20191219181155.32530-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 13657165873883679718
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdduuddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepud
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.182.191
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
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c     |  4 ++--
 hw/ppc/pnv_psi.c | 11 ++---------
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1d8bfb164a32..163a658806e2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -999,8 +999,6 @@ static void pnv_chip_power8_instance_init(Object *obj=
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
@@ -1069,6 +1067,8 @@ static void pnv_chip_power8_realize(DeviceState *de=
v, Error **errp)
                             "bar", &error_fatal);
     object_property_set_link(OBJECT(&chip8->psi), OBJECT(chip->system_me=
mory),
                              "system-memory", &error_abort);
+    object_property_set_link(OBJECT(&chip8->psi), OBJECT(qdev_get_machin=
e()),
+                             ICS_PROP_XICS, &error_abort);
     object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 28d34e5c193a..d3124f673571 100644
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
@@ -485,21 +487,12 @@ static void pnv_psi_power8_realize(DeviceState *dev=
, Error **errp)
 {
     PnvPsi *psi =3D PNV_PSI(dev);
     ICSState *ics =3D &PNV8_PSI(psi)->ics;
-    Object *obj;
     Error *err =3D NULL;
     unsigned int i;
=20
     assert(psi->system_memory);
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
2.21.0


