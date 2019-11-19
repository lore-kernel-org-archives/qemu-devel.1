Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAF7C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42A820885
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42A820885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4HC-0007RV-II
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4FH-0005NC-5F
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4FD-00057U-O1
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:43 -0500
Received: from 4.mo1.mail-out.ovh.net ([46.105.76.26]:52013)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4FD-00056Y-HY
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:12:39 -0500
Received: from player795.ha.ovh.net (unknown [10.109.146.131])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id DB7AA19BBDB
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:12:37 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id BE331C18A7D0;
 Tue, 19 Nov 2019 14:12:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 02/17] aspeed/i2c: Check SRAM enablement on AST2500
Date: Tue, 19 Nov 2019 15:11:56 +0100
Message-Id: <20191119141211.25716-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
References: <20191119141211.25716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17894208698231851793
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.76.26
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
Cc: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SRAM must be enabled before using the Buffer Pool mode or the DMA
mode. This is not required on other SoCs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/i2c/aspeed_i2c.h |  3 +++
 hw/i2c/aspeed_i2c.c         | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 5313d07aa72f..7a555072dfbf 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -61,6 +61,7 @@ typedef struct AspeedI2CState {
     qemu_irq irq;
=20
     uint32_t intr_status;
+    uint32_t ctrl_global;
     MemoryRegion pool_iomem;
     uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
=20
@@ -83,6 +84,8 @@ typedef struct AspeedI2CClass {
     uint64_t pool_size;
     hwaddr pool_base;
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
+    bool check_sram;
+
 } AspeedI2CClass;
=20
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index e21f45d96868..c7929aa2850f 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -31,6 +31,8 @@
 #define I2C_CTRL_STATUS         0x00        /* Device Interrupt Status *=
/
 #define I2C_CTRL_ASSIGN         0x08        /* Device Interrupt Target
                                                Assignment */
+#define I2C_CTRL_GLOBAL         0x0C        /* Global Control Register *=
/
+#define   I2C_CTRL_SRAM_EN                 BIT(0)
=20
 /* I2C Device (Bus) Register */
=20
@@ -271,6 +273,29 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus=
)
     }
 }
=20
+static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
+{
+    AspeedI2CState *s =3D bus->controller;
+    AspeedI2CClass *aic =3D ASPEED_I2C_GET_CLASS(s);
+
+    if (!aic->check_sram) {
+        return true;
+    }
+
+    /*
+     * AST2500: SRAM must be enabled before using the Buffer Pool or
+     * DMA mode.
+     */
+    if (!(s->ctrl_global & I2C_CTRL_SRAM_EN) &&
+        (bus->cmd & (I2CD_RX_DMA_ENABLE | I2CD_TX_DMA_ENABLE |
+                     I2CD_RX_BUFF_ENABLE | I2CD_TX_BUFF_ENABLE))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SRAM is not enabled\n", __fu=
nc__);
+        return false;
+    }
+
+    return true;
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
@@ -282,6 +307,10 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *=
bus, uint64_t value)
     bus->cmd &=3D ~0xFFFF;
     bus->cmd |=3D value & 0xFFFF;
=20
+    if (!aspeed_i2c_check_sram(bus)) {
+        return;
+    }
+
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state =3D aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
             I2CD_MSTARTR : I2CD_MSTART;
@@ -436,6 +465,8 @@ static uint64_t aspeed_i2c_ctrl_read(void *opaque, hw=
addr offset,
     switch (offset) {
     case I2C_CTRL_STATUS:
         return s->intr_status;
+    case I2C_CTRL_GLOBAL:
+        return s->ctrl_global;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
                       __func__, offset);
@@ -448,7 +479,12 @@ static uint64_t aspeed_i2c_ctrl_read(void *opaque, h=
waddr offset,
 static void aspeed_i2c_ctrl_write(void *opaque, hwaddr offset,
                                   uint64_t value, unsigned size)
 {
+    AspeedI2CState *s =3D opaque;
+
     switch (offset) {
+    case I2C_CTRL_GLOBAL:
+        s->ctrl_global =3D value;
+        break;
     case I2C_CTRL_STATUS:
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx =
"\n",
@@ -684,6 +720,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *k=
lass, void *data)
     aic->pool_size =3D 0x100;
     aic->pool_base =3D 0x200;
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;
+    aic->check_sram =3D true;
 }
=20
 static const TypeInfo aspeed_2500_i2c_info =3D {
--=20
2.21.0


