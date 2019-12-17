Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B5EC43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C2E20733
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 05:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OBnGOYAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C2E20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih5l4-0002Ol-Oj
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 00:50:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kh-0003C6-W4
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4kg-0000eq-SO
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:46:31 -0500
Received: from ozlabs.org ([203.11.71.1]:45995)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4kg-0008Ml-Gy; Mon, 16 Dec 2019 23:46:30 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWk6TzBz9sTr; Tue, 17 Dec 2019 15:43:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557826;
 bh=dvxrJfW6c+Bk0ahYO+qDrE1ZifZjK+c5PPctx0EOceM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OBnGOYANRdRyXC/PfmjVsMDrrk3JhfPheo1E7oWnqnBuumIY0qexvh4nQqpFyb1xs
 od9j8WzVrKCQbycP4rnNve//5iZHx3ARhqcVD2Ng23ACaV3hADnNJZIInVZeW/D1Lb
 Z2V3/k5hmenCDtz2Wuj6KRMT7+pVcNEylp8ZfN6I=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 77/88] ppc/pnv: Drop PnvPsiClass::chip_type
Date: Tue, 17 Dec 2019 15:43:11 +1100
Message-Id: <20191217044322.351838-78-david@gibson.dropbear.id.au>
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
Message-Id: <157623838530.360005.15470128760871845396.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_psi.c         | 3 ---
 include/hw/ppc/pnv_psi.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 98a82b25e0..75e20d9da0 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -574,7 +574,6 @@ static void pnv_psi_power8_class_init(ObjectClass *kl=
ass, void *data)
     dc->desc    =3D "PowerNV PSI Controller POWER8";
     dc->realize =3D pnv_psi_power8_realize;
=20
-    ppc->chip_type =3D  PNV_CHIP_POWER8;
     ppc->xscom_pcba =3D PNV_XSCOM_PSIHB_BASE;
     ppc->xscom_size =3D PNV_XSCOM_PSIHB_SIZE;
     ppc->bar_mask   =3D PSIHB_BAR_MASK;
@@ -884,7 +883,6 @@ static void pnv_psi_power9_class_init(ObjectClass *kl=
ass, void *data)
     dc->desc    =3D "PowerNV PSI Controller POWER9";
     dc->realize =3D pnv_psi_power9_realize;
=20
-    ppc->chip_type  =3D PNV_CHIP_POWER9;
     ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
     ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
     ppc->bar_mask   =3D PSIHB9_BAR_MASK;
@@ -915,7 +913,6 @@ static void pnv_psi_power10_class_init(ObjectClass *k=
lass, void *data)
=20
     dc->desc    =3D "PowerNV PSI Controller POWER10";
=20
-    ppc->chip_type  =3D PNV_CHIP_POWER10;
     ppc->xscom_pcba =3D PNV10_XSCOM_PSIHB_BASE;
     ppc->xscom_size =3D PNV10_XSCOM_PSIHB_SIZE;
     ppc->compat     =3D compat;
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index fc068c95e5..f0f5b55197 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -79,7 +79,6 @@ typedef struct Pnv9Psi {
 typedef struct PnvPsiClass {
     SysBusDeviceClass parent_class;
=20
-    int chip_type;
     uint32_t xscom_pcba;
     uint32_t xscom_size;
     uint64_t bar_mask;
--=20
2.23.0


