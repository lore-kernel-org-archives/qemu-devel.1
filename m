Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B59AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CAF2146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o5TzheW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CAF2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiC1K-0006zS-Ul
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByd-0004iQ-9O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByc-0002ns-1t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:15 -0400
Received: from ozlabs.org ([203.11.71.1]:41321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByb-0002jt-EU; Tue, 02 Jul 2019 02:09:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMg2BfQz9sND; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047743;
 bh=cfrKF0Hv5dm4uW4tcyxYHvklYX7U7LT2Ph0PXGDvs4s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o5TzheW4sIuv9emMr7F49Hrg4Wm16cR6qhLOF92QBMTeRmbAEVX3eCABYV8PrDqyw
 9xdzeAEuuxWyGU/qkF1eURRS6cOVNgQq1FQUsrd7MeockUEJCc1ZAexnpWzZce7Rn8
 /5kKIrJJD2y8yfCO1pTBH6uH3U/nAsbsmvDhkdaA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:13 +1000
Message-Id: <20190702060857.3926-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 05/49] ppc/pnv: remove xscom_base field from
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

It has now became useless with the previous patch.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190612174345.9799-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 10 ----------
 include/hw/ppc/pnv.h |  5 +----
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0d98a281f6..b87e01e5b9 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -924,7 +924,6 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
-    k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8E";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -944,7 +943,6 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
-    k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -964,7 +962,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->dt_populate =3D pnv_chip_power8_dt_populate;
     k->pic_print_info =3D pnv_chip_power8_pic_print_info;
-    k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8NVL";
=20
     device_class_set_parent_realize(dc, pnv_chip_power8_realize,
@@ -1115,7 +1112,6 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
     k->isa_create =3D pnv_chip_power9_isa_create;
     k->dt_populate =3D pnv_chip_power9_dt_populate;
     k->pic_print_info =3D pnv_chip_power9_pic_print_info;
-    k->xscom_base =3D 0x00603fc00000000ull;
     dc->desc =3D "PowerNV Chip POWER9";
=20
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
@@ -1152,11 +1148,6 @@ static void pnv_chip_core_sanitize(PnvChip *chip, =
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
@@ -1406,7 +1397,6 @@ static const TypeInfo types[] =3D {
         .name          =3D TYPE_PNV_CHIP,
         .parent        =3D TYPE_SYS_BUS_DEVICE,
         .class_init    =3D pnv_chip_class_init,
-        .instance_init =3D pnv_chip_instance_init,
         .instance_size =3D sizeof(PnvChip),
         .class_size    =3D sizeof(PnvChipClass),
         .abstract      =3D true,
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 01ac9e7996..fb123edc4e 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -56,7 +56,6 @@ typedef struct PnvChip {
     uint64_t     cores_mask;
     void         *cores;
=20
-    hwaddr       xscom_base;
     MemoryRegion xscom_mmio;
     MemoryRegion xscom;
     AddressSpace xscom_as;
@@ -105,8 +104,6 @@ typedef struct PnvChipClass {
     uint64_t     chip_cfam_id;
     uint64_t     cores_mask;
=20
-    hwaddr       xscom_base;
-
     DeviceRealize parent_realize;
=20
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
@@ -199,7 +196,7 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
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
--=20
2.21.0


