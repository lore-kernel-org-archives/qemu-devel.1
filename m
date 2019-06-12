Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F6DC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA5D20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA5D20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34140 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb7M2-0003aO-Mb
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42123)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hb7I6-0001Oe-DX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hb7I5-00062k-6R
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:44:06 -0400
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:52745)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hb7I5-00061c-0t
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 13:44:05 -0400
Received: from player792.ha.ovh.net (unknown [10.109.159.20])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id E19CB17D05E
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 19:44:02 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 6F5CF6D9169F;
 Wed, 12 Jun 2019 17:43:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 12 Jun 2019 19:43:45 +0200
Message-Id: <20190612174345.9799-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612174345.9799-1-clg@kaod.org>
References: <20190612174345.9799-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 4170896207446445030
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudehjedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.97.206
Subject: [Qemu-devel] [PATCH 2/2] ppc/pnc: remove xscom_base field from
 PnvChip
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It has now became useless with the previous patch.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  5 +----
 hw/ppc/pnv.c         | 10 ----------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index aa926d120771..de0c1d285fa7 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -58,7 +58,6 @@ typedef struct PnvChip {
     uint64_t     cores_mask;
     void         *cores;
=20
-    hwaddr       xscom_base;
     MemoryRegion xscom_mmio;
     MemoryRegion xscom;
     AddressSpace xscom_as;
@@ -114,8 +113,6 @@ typedef struct PnvChipClass {
     uint64_t     cores_mask;
     uint32_t     num_phbs;
=20
-    hwaddr       xscom_base;
-
     DeviceRealize parent_realize;
=20
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
@@ -226,7 +223,7 @@ int pnv_bmc_hiomap(IPMIBmc *bmc);
  */
 #define PNV_XSCOM_SIZE        0x800000000ull
 #define PNV_XSCOM_BASE(chip)                                            =
\
-    (chip->xscom_base + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZE)
+    (0x0003fc0000000000ull + ((uint64_t)(chip)->chip_id) * PNV_XSCOM_SIZ=
E)
=20
 /*
  * XSCOM 0x20109CA defines the ICP BAR:
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 92c01dfc09ef..4352066ec1f2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -982,7 +982,6 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
-    k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8E";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1003,7 +1002,6 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
-    k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1024,7 +1022,6 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
-    k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8NVL";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1210,7 +1207,6 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
     k->isa_create =3D pnv_chip_power9_isa_create;
     k->dt_populate =3D pnv_chip_power9_dt_populate;
     k->pic_print_info =3D pnv_chip_power9_pic_print_info;
-    k->xscom_base =3D 0x00603fc00000000ull;
     dc->desc =3D "PowerNV Chip POWER9";
=20
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
@@ -1247,11 +1243,6 @@ static void pnv_chip_core_sanitize(PnvChip *chip, =
Error **errp)
     }
 }
=20
-static void pnv_chip_instance_init(Object *obj)
-{
-    PNV_CHIP(obj)->xscom_base =3D PNV_CHIP_GET_CLASS(obj)->xscom_base;
-}
-
 static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
 {
     Error *error =3D NULL;
@@ -1519,7 +1510,6 @@ static const TypeInfo types[] =3D {
         .name          =3D TYPE_PNV_CHIP,
         .parent        =3D TYPE_SYS_BUS_DEVICE,
         .class_init    =3D pnv_chip_class_init,
-        .instance_init =3D pnv_chip_instance_init,
         .instance_size =3D sizeof(PnvChip),
         .class_size    =3D sizeof(PnvChipClass),
         .abstract      =3D true,
--=20
2.21.0


