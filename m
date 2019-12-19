Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05723C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7E02146E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 07:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7E02146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihqKd-0002Bu-WC
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 02:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52552)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ihqHA-0007QE-1D
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:31:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ihqH8-0005UV-Ov
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:31:11 -0500
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:34292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ihqH8-0005Lk-GS
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 02:31:10 -0500
Received: from player714.ha.ovh.net (unknown [10.108.1.232])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id F26EF89454
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 08:31:08 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 62B6FD671FA9;
 Thu, 19 Dec 2019 07:31:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 10/10] ppc/pnv: Add a "pnor" const link property to the BMC
 internal simulator
Date: Thu, 19 Dec 2019 08:30:01 +0100
Message-Id: <20191219073001.26790-11-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219073001.26790-1-clg@kaod.org>
References: <20191219073001.26790-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2827134669933218790
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddutddguddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedugedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.53.132
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

This allows to get rid of a call to qdev_get_machine().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h | 2 +-
 hw/ppc/pnv.c         | 2 +-
 hw/ppc/pnv_bmc.c     | 8 +++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 4c13d4394a11..d016ab0d0319 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -231,7 +231,7 @@ PnvChip *pnv_get_chip(uint32_t chip_id);
  */
 void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
 void pnv_bmc_powerdown(IPMIBmc *bmc);
-IPMIBmc *pnv_bmc_create(void);
+IPMIBmc *pnv_bmc_create(PnvPnor *pnor);
=20
 /*
  * POWER8 MMIO base addresses
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7add208f997b..6ef90da92325 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -815,7 +815,7 @@ static void pnv_init(MachineState *machine)
     g_free(chip_typename);
=20
     /* Create the machine BMC simulator */
-    pnv->bmc =3D pnv_bmc_create();
+    pnv->bmc =3D pnv_bmc_create(pnv->pnor);
=20
     /* Instantiate ISA bus on chip 0 */
     pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 07fa1e1c7e45..8863354c1c08 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -143,8 +143,8 @@ static uint16_t bytes_to_blocks(uint32_t bytes)
 static void hiomap_cmd(IPMIBmcSim *ibs, uint8_t *cmd, unsigned int cmd_l=
en,
                        RspBuffer *rsp)
 {
-    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
-    PnvPnor *pnor =3D pnv->pnor;
+    PnvPnor *pnor =3D PNV_PNOR(object_property_get_link(OBJECT(ibs), "pn=
or",
+                                                      &error_abort));
     uint32_t pnor_size =3D pnor->size;
     uint32_t pnor_addr =3D PNOR_SPI_OFFSET;
     bool readonly =3D false;
@@ -217,11 +217,13 @@ static const IPMINetfn hiomap_netfn =3D {
  * Instantiate the machine BMC. PowerNV uses the QEMU internal
  * simulator but it could also be external.
  */
-IPMIBmc *pnv_bmc_create(void)
+IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
 {
     Object *obj;
=20
     obj =3D object_new(TYPE_IPMI_BMC_SIMULATOR);
+    object_ref(OBJECT(pnor));
+    object_property_add_const_link(obj, "pnor", OBJECT(pnor), &error_abo=
rt);
     object_property_set_bool(obj, true, "realized", &error_fatal);
=20
     /* Install the HIOMAP protocol handlers to access the PNOR */
--=20
2.21.0


