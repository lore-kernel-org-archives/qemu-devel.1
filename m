Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0932222B0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0932222B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4SB-00047H-CP
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4Gn-0007cN-NV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4Gm-0005oD-ES
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:17 -0500
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:48389)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4Gm-0005nv-8a
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:16 -0500
Received: from player795.ha.ovh.net (unknown [10.108.54.9])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 3FE0514BB34
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:14:15 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 51526C18AF9A;
 Tue, 19 Nov 2019 14:14:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 14/17] aspeed: Add support for the tacoma-bmc board
Date: Tue, 19 Nov 2019 15:12:08 +0100
Message-Id: <20191119141211.25716-15-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
References: <20191119141211.25716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17921793246394288913
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeei
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.56.76
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Tacoma BMC board is replacement board for the BMC of the OpenPOWER
Witherspoon system. It uses a AST2600 SoC instead of a AST2500 and the
I2C layout is the same as it controls the same main board. Used for HW
bringup.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e34e6787430b..cc06af4fbb3e 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -92,6 +92,10 @@ struct AspeedBoardState {
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
=20
+/* Tacoma hardware value */
+#define TACOMA_BMC_HW_STRAP1  0x00000000
+#define TACOMA_BMC_HW_STRAP2  0x00000000
+
 /*
  * The max ram region is for firmwares that scan the address space
  * with load/store to guess how much RAM the SoC has.
@@ -363,6 +367,9 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState=
 *bmc)
     AspeedSoCState *soc =3D &bmc->soc;
     uint8_t *eeprom_buf =3D g_malloc0(8 * 1024);
=20
+    /* Bus 3: TODO bmp280@77 */
+    /* Bus 3: TODO max31785@52 */
+    /* Bus 3: TODO dps310@76 */
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 3), TYPE_PCA9=
552,
                      0x60);
=20
@@ -381,6 +388,7 @@ static void witherspoon_bmc_i2c_init(AspeedBoardState=
 *bmc)
                           eeprom_buf);
     i2c_create_slave(aspeed_i2c_get_bus(DEVICE(&soc->i2c), 11), TYPE_PCA=
9552,
                      0x60);
+    /* Bus 11: TODO ucd90160@64 */
 }
=20
 static void aspeed_machine_class_init(ObjectClass *oc, void *data)
@@ -485,6 +493,22 @@ static void aspeed_machine_ast2600_evb_class_init(Ob=
jectClass *oc, void *data)
     mc->default_ram_size =3D 1 * GiB;
 };
=20
+static void aspeed_machine_tacoma_class_init(ObjectClass *oc, void *data=
)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       =3D "Aspeed AST2600 EVB (Cortex A7)";
+    amc->soc_name  =3D "ast2600-a0";
+    amc->hw_strap1 =3D TACOMA_BMC_HW_STRAP1;
+    amc->hw_strap2 =3D TACOMA_BMC_HW_STRAP2;
+    amc->fmc_model =3D "mx66l1g45g";
+    amc->spi_model =3D "mx66l1g45g";
+    amc->num_cs    =3D 2;
+    amc->i2c_init  =3D witherspoon_bmc_i2c_init; /* Same board layout */
+    mc->default_ram_size =3D 1 * GiB;
+};
+
 static const TypeInfo aspeed_machine_types[] =3D {
     {
         .name          =3D MACHINE_TYPE_NAME("palmetto-bmc"),
@@ -510,6 +534,10 @@ static const TypeInfo aspeed_machine_types[] =3D {
         .name          =3D MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        =3D TYPE_ASPEED_MACHINE,
         .class_init    =3D aspeed_machine_ast2600_evb_class_init,
+    }, {
+        .name          =3D MACHINE_TYPE_NAME("tacoma-bmc"),
+        .parent        =3D TYPE_ASPEED_MACHINE,
+        .class_init    =3D aspeed_machine_tacoma_class_init,
     }, {
         .name          =3D TYPE_ASPEED_MACHINE,
         .parent        =3D TYPE_MACHINE,
--=20
2.21.0


