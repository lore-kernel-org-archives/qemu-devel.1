Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C477C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:42:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC76D20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VmE1pc3E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC76D20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5cY-0006wR-KG
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:42:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4l4-0003kl-Hs
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4l3-0001YG-EV
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:54 -0500
Received: from ozlabs.org ([203.11.71.1]:48091)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4l3-0000g2-3O; Mon, 16 Dec 2019 23:46:53 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWm43QMz9sTv; Tue, 17 Dec 2019 15:43:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557828;
 bh=hAkVJ+pdy5kFzF3todD0E6oMTylecfVF64CKJc42ZPI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VmE1pc3EZuaek8lTVma21UoA4Ov6/cFuXSqluCm1nM1cn+m44OYXhU6EeLdp/YXQg
 q26HWjjgHGL5hORxT7joOudFgwuAkCgFM7zUiBCFXL0aNa57EOWLYk4BZt+PGwuDf6
 E20XOYuVLq9etM0b4OMnQryPJt+lkCWDx5g4p4To=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 87/88] ppc/pnv: Drop PnvChipClass::type
Date: Tue, 17 Dec 2019 15:43:21 +1100
Message-Id: <20191217044322.351838-88-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

It isn't used anymore.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <157623844102.360005.12070225703151669294.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 5 -----
 include/hw/ppc/pnv.h | 9 ---------
 2 files changed, 14 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 41e5d762df..f77e7ca84e 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1131,7 +1131,6 @@ static void pnv_chip_power8e_class_init(ObjectClass=
 *klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->chip_type =3D PNV_CHIP_POWER8E;
     k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask =3D POWER8E_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
@@ -1155,7 +1154,6 @@ static void pnv_chip_power8_class_init(ObjectClass =
*klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->chip_type =3D PNV_CHIP_POWER8;
     k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
@@ -1179,7 +1177,6 @@ static void pnv_chip_power8nvl_class_init(ObjectCla=
ss *klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->chip_type =3D PNV_CHIP_POWER8NVL;
     k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
@@ -1359,7 +1356,6 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->chip_type =3D PNV_CHIP_POWER9;
     k->chip_cfam_id =3D 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask =3D POWER9_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p9;
@@ -1448,7 +1444,6 @@ static void pnv_chip_power10_class_init(ObjectClass=
 *klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->chip_type =3D PNV_CHIP_POWER10;
     k->chip_cfam_id =3D 0x120da04900008000ull; /* P10 DD1.0 (with NX) */
     k->cores_mask =3D POWER10_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p10;
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 4972e93c26..f78fd0dd96 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -38,14 +38,6 @@
 #define PNV_CHIP_GET_CLASS(obj) \
      OBJECT_GET_CLASS(PnvChipClass, (obj), TYPE_PNV_CHIP)
=20
-typedef enum PnvChipType {
-    PNV_CHIP_POWER8E,     /* AKA Murano (default) */
-    PNV_CHIP_POWER8,      /* AKA Venice */
-    PNV_CHIP_POWER8NVL,   /* AKA Naples */
-    PNV_CHIP_POWER9,      /* AKA Nimbus */
-    PNV_CHIP_POWER10,     /* AKA TBD */
-} PnvChipType;
-
 typedef struct PnvChip {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -123,7 +115,6 @@ typedef struct PnvChipClass {
     SysBusDeviceClass parent_class;
=20
     /*< public >*/
-    PnvChipType  chip_type;
     uint64_t     chip_cfam_id;
     uint64_t     cores_mask;
=20
--=20
2.23.0


