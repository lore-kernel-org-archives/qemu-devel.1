Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F19C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:29:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDFCB20657
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFCB20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cpy-0002xP-6u
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5cC3-0000Mq-UD
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5cC1-0001Se-Rz
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:55 -0400
Received: from 4.mo68.mail-out.ovh.net ([46.105.59.63]:57114)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5cC1-0001MO-KA
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:53 -0400
Received: from player691.ha.ovh.net (unknown [10.109.160.226])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 33C44141684
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 22:47:52 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 80BD398B2845;
 Wed,  4 Sep 2019 20:47:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 22:46:50 +0200
Message-Id: <20190904204659.13878-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904204659.13878-1-clg@kaod.org>
References: <20190904204659.13878-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2519763993783274257
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.59.63
Subject: [Qemu-devel] [RFC PATCH 06/15] aspeed/sdmc: Introduce an object
 class per SoC
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
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use class handlers and class constants to differentiate the
characteristics of the memory controller and remove the 'silicon_rev'
property.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/misc/aspeed_sdmc.h |  19 +++-
 hw/arm/aspeed_soc.c           |   5 +-
 hw/misc/aspeed_sdmc.c         | 168 +++++++++++++++++++++-------------
 3 files changed, 122 insertions(+), 70 deletions(-)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.=
h
index b3c926acae90..81156320c497 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -13,6 +13,8 @@
=20
 #define TYPE_ASPEED_SDMC "aspeed.sdmc"
 #define ASPEED_SDMC(obj) OBJECT_CHECK(AspeedSDMCState, (obj), TYPE_ASPEE=
D_SDMC)
+#define TYPE_ASPEED_2400_SDMC TYPE_ASPEED_SDMC "-ast2400"
+#define TYPE_ASPEED_2500_SDMC TYPE_ASPEED_SDMC "-ast2500"
=20
 #define ASPEED_SDMC_NR_REGS (0x174 >> 2)
=20
@@ -24,12 +26,21 @@ typedef struct AspeedSDMCState {
     MemoryRegion iomem;
=20
     uint32_t regs[ASPEED_SDMC_NR_REGS];
-    uint32_t silicon_rev;
-    uint32_t ram_bits;
     uint64_t ram_size;
     uint64_t max_ram_size;
-    uint32_t fixed_conf;
-
 } AspeedSDMCState;
=20
+#define ASPEED_SDMC_CLASS(klass) \
+     OBJECT_CLASS_CHECK(AspeedSDMCClass, (klass), TYPE_ASPEED_SDMC)
+#define ASPEED_SDMC_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(AspeedSDMCClass, (obj), TYPE_ASPEED_SDMC)
+
+typedef struct AspeedSDMCClass {
+    SysBusDeviceClass parent_class;
+
+    uint64_t max_ram_size;
+    uint32_t (*compute_conf)(AspeedSDMCState *s, uint32_t data);
+    void (*write)(AspeedSDMCState *s, uint32_t reg, uint32_t data);
+} AspeedSDMCClass;
+
 #endif /* ASPEED_SDMC_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 26e03486f9b7..aaf18d3e42f1 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -205,10 +205,9 @@ static void aspeed_soc_init(Object *obj)
                               sizeof(s->spi[i]), typename);
     }
=20
+    snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
     sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc)=
,
-                          TYPE_ASPEED_SDMC);
-    qdev_prop_set_uint32(DEVICE(&s->sdmc), "silicon-rev",
-                         sc->info->silicon_rev);
+                          typename);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
                               "ram-size", &error_abort);
     object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index cb13c63ec848..60c99e773488 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -110,6 +110,7 @@ static void aspeed_sdmc_write(void *opaque, hwaddr ad=
dr, uint64_t data,
                              unsigned int size)
 {
     AspeedSDMCState *s =3D ASPEED_SDMC(opaque);
+    AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
=20
     addr >>=3D 2;
=20
@@ -130,41 +131,7 @@ static void aspeed_sdmc_write(void *opaque, hwaddr a=
ddr, uint64_t data,
         return;
     }
=20
-    if (addr =3D=3D R_CONF) {
-        /* Make sure readonly bits are kept */
-        switch (s->silicon_rev) {
-        case AST2400_A0_SILICON_REV:
-        case AST2400_A1_SILICON_REV:
-            data &=3D ~ASPEED_SDMC_READONLY_MASK;
-            data |=3D s->fixed_conf;
-            break;
-        case AST2500_A0_SILICON_REV:
-        case AST2500_A1_SILICON_REV:
-            data &=3D ~ASPEED_SDMC_AST2500_READONLY_MASK;
-            data |=3D s->fixed_conf;
-            break;
-        default:
-            g_assert_not_reached();
-        }
-    }
-    if (s->silicon_rev =3D=3D AST2500_A0_SILICON_REV ||
-            s->silicon_rev =3D=3D AST2500_A1_SILICON_REV) {
-        switch (addr) {
-        case R_STATUS1:
-            /* Will never return 'busy' */
-            data &=3D ~PHY_BUSY_STATE;
-            break;
-        case R_ECC_TEST_CTRL:
-            /* Always done, always happy */
-            data |=3D ECC_TEST_FINISHED;
-            data &=3D ~ECC_TEST_FAIL;
-            break;
-        default:
-            break;
-        }
-    }
-
-    s->regs[addr] =3D data;
+    asc->write(s, addr, data);
 }
=20
 static const MemoryRegionOps aspeed_sdmc_ops =3D {
@@ -222,44 +189,21 @@ static int ast2500_rambits(AspeedSDMCState *s)
 static void aspeed_sdmc_reset(DeviceState *dev)
 {
     AspeedSDMCState *s =3D ASPEED_SDMC(dev);
+    AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
=20
     memset(s->regs, 0, sizeof(s->regs));
=20
     /* Set ram size bit and defaults values */
-    s->regs[R_CONF] =3D s->fixed_conf;
+    s->regs[R_CONF] =3D asc->compute_conf(s, 0);
 }
=20
 static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     AspeedSDMCState *s =3D ASPEED_SDMC(dev);
+    AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);
=20
-    if (!is_supported_silicon_rev(s->silicon_rev)) {
-        error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
-                s->silicon_rev);
-        return;
-    }
-
-    switch (s->silicon_rev) {
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-        s->ram_bits =3D ast2400_rambits(s);
-        s->max_ram_size =3D 512 << 20;
-        s->fixed_conf =3D ASPEED_SDMC_VGA_COMPAT |
-            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
-        break;
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        s->ram_bits =3D ast2500_rambits(s);
-        s->max_ram_size =3D 1024 << 20;
-        s->fixed_conf =3D ASPEED_SDMC_HW_VERSION(1) |
-            ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
-            ASPEED_SDMC_CACHE_INITIAL_DONE |
-            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
-        break;
-    default:
-        g_assert_not_reached();
-    }
+    s->max_ram_size =3D asc->max_ram_size;
=20
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sdmc_ops, s,
                           TYPE_ASPEED_SDMC, 0x1000);
@@ -277,7 +221,6 @@ static const VMStateDescription vmstate_aspeed_sdmc =3D=
 {
 };
=20
 static Property aspeed_sdmc_properties[] =3D {
-    DEFINE_PROP_UINT32("silicon-rev", AspeedSDMCState, silicon_rev, 0),
     DEFINE_PROP_UINT64("ram-size", AspeedSDMCState, ram_size, 0),
     DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0)=
,
     DEFINE_PROP_END_OF_LIST(),
@@ -298,11 +241,110 @@ static const TypeInfo aspeed_sdmc_info =3D {
     .parent =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(AspeedSDMCState),
     .class_init =3D aspeed_sdmc_class_init,
+    .class_size =3D sizeof(AspeedSDMCClass),
+    .abstract   =3D true,
+};
+
+static uint32_t aspeed_2400_sdmc_compute_conf(AspeedSDMCState *s, uint32=
_t data)
+{
+    uint32_t fixed_conf =3D ASPEED_SDMC_VGA_COMPAT |
+        ASPEED_SDMC_DRAM_SIZE(ast2400_rambits(s));
+
+    /* Make sure readonly bits are kept */
+    data &=3D ~ASPEED_SDMC_READONLY_MASK;
+
+    return data | fixed_conf;
+}
+
+static void aspeed_2400_sdmc_write(AspeedSDMCState *s, uint32_t reg,
+                                   uint32_t data)
+{
+    switch (reg) {
+    case R_CONF:
+        data =3D aspeed_2400_sdmc_compute_conf(s, data);
+        break;
+    default:
+        break;
+    }
+
+    s->regs[reg] =3D data;
+}
+
+static void aspeed_2400_sdmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedSDMCClass *asc =3D ASPEED_SDMC_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2400 SDRAM Memory Controller";
+    asc->max_ram_size =3D 512 << 20;
+    asc->compute_conf =3D aspeed_2400_sdmc_compute_conf;
+    asc->write =3D aspeed_2400_sdmc_write;
+}
+
+static const TypeInfo aspeed_2400_sdmc_info =3D {
+    .name =3D TYPE_ASPEED_2400_SDMC,
+    .parent =3D TYPE_ASPEED_SDMC,
+    .class_init =3D aspeed_2400_sdmc_class_init,
+};
+
+static uint32_t aspeed_2500_sdmc_compute_conf(AspeedSDMCState *s, uint32=
_t data)
+{
+    uint32_t fixed_conf =3D ASPEED_SDMC_HW_VERSION(1) |
+        ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
+        ASPEED_SDMC_CACHE_INITIAL_DONE |
+        ASPEED_SDMC_DRAM_SIZE(ast2500_rambits(s));
+
+    /* Make sure readonly bits are kept */
+    data &=3D ~ASPEED_SDMC_AST2500_READONLY_MASK;
+
+    return data | fixed_conf;
+}
+
+static void aspeed_2500_sdmc_write(AspeedSDMCState *s, uint32_t reg,
+                                   uint32_t data)
+{
+    switch (reg) {
+    case R_CONF:
+        data =3D aspeed_2500_sdmc_compute_conf(s, data);
+        break;
+    case R_STATUS1:
+        /* Will never return 'busy' */
+        data &=3D ~PHY_BUSY_STATE;
+        break;
+    case R_ECC_TEST_CTRL:
+        /* Always done, always happy */
+        data |=3D ECC_TEST_FINISHED;
+        data &=3D ~ECC_TEST_FAIL;
+        break;
+    default:
+        break;
+    }
+
+    s->regs[reg] =3D data;
+}
+
+static void aspeed_2500_sdmc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedSDMCClass *asc =3D ASPEED_SDMC_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2500 SDRAM Memory Controller";
+    asc->max_ram_size =3D 1024 << 20;
+    asc->compute_conf =3D aspeed_2500_sdmc_compute_conf;
+    asc->write =3D aspeed_2500_sdmc_write;
+}
+
+static const TypeInfo aspeed_2500_sdmc_info =3D {
+    .name =3D TYPE_ASPEED_2500_SDMC,
+    .parent =3D TYPE_ASPEED_SDMC,
+    .class_init =3D aspeed_2500_sdmc_class_init,
 };
=20
 static void aspeed_sdmc_register_types(void)
 {
     type_register_static(&aspeed_sdmc_info);
+    type_register_static(&aspeed_2400_sdmc_info);
+    type_register_static(&aspeed_2500_sdmc_info);
 }
=20
 type_init(aspeed_sdmc_register_types);
--=20
2.21.0


