Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6130FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E2F4208E4
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E2F4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5d39-0001hm-JD
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5cBZ-00089y-HB
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5cBU-0000iH-W6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:23 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:56754)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5cBU-0000hf-IK
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:47:20 -0400
Received: from player691.ha.ovh.net (unknown [10.109.159.136])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 0EA751097C2
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 22:47:18 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 405CB98B27AC;
 Wed,  4 Sep 2019 20:47:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 22:46:45 +0200
Message-Id: <20190904204659.13878-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904204659.13878-1-clg@kaod.org>
References: <20190904204659.13878-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2510193846439807761
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.143
Subject: [Qemu-devel] [RFC PATCH 01/15] hw: aspeed_scu: Add AST2600 support
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

From: Joel Stanley <joel@jms.id.au>

AST2600 has extra registers. Increase the number of regs of the model
and introduce a new field in the class to customize the MemoryRegion
operations depending on the SoC model.

Signed-off-by: Joel Stanley <joel@jms.id.au>
[clg: - improved commit log ]
      - reworked mode integration into new objet class ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/misc/aspeed_scu.h |   7 +-
 hw/misc/aspeed_scu.c         | 184 ++++++++++++++++++++++++++++++++++-
 2 files changed, 185 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 239e94fe2c47..1d7f7ffc1598 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -17,8 +17,10 @@
 #define ASPEED_SCU(obj) OBJECT_CHECK(AspeedSCUState, (obj), TYPE_ASPEED_=
SCU)
 #define TYPE_ASPEED_2400_SCU TYPE_ASPEED_SCU "-ast2400"
 #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"
+#define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"
=20
 #define ASPEED_SCU_NR_REGS (0x1A8 >> 2)
+#define ASPEED_AST2600_SCU_NR_REGS (0xE20 >> 2)
=20
 typedef struct AspeedSCUState {
     /*< private >*/
@@ -27,7 +29,7 @@ typedef struct AspeedSCUState {
     /*< public >*/
     MemoryRegion iomem;
=20
-    uint32_t regs[ASPEED_SCU_NR_REGS];
+    uint32_t regs[ASPEED_AST2600_SCU_NR_REGS];
     uint32_t silicon_rev;
     uint32_t hw_strap1;
     uint32_t hw_strap2;
@@ -38,6 +40,7 @@ typedef struct AspeedSCUState {
 #define AST2400_A1_SILICON_REV   0x02010303U
 #define AST2500_A0_SILICON_REV   0x04000303U
 #define AST2500_A1_SILICON_REV   0x04010303U
+#define AST2600_A0_SILICON_REV   0x05000303U
=20
 #define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) =3D=3D =
0x04)
=20
@@ -54,6 +57,8 @@ typedef struct  AspeedSCUClass {
     const uint32_t *resets;
     uint32_t (*calc_hpll)(AspeedSCUState *s, uint32_t hpll_reg);
     uint32_t apb_divider;
+    uint32_t nr_regs;
+    const MemoryRegionOps *ops;
 }  AspeedSCUClass;
=20
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 620b25c20476..4190adab8220 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -88,6 +88,33 @@
 #define BMC_REV              TO_REG(0x19C)
 #define BMC_DEV_ID           TO_REG(0x1A4)
=20
+#define AST2600_PROT_KEY          TO_REG(0x00)
+#define AST2600_SILICON_REV       TO_REG(0x04)
+#define AST2600_SILICON_REV2      TO_REG(0x14)
+#define AST2600_SYS_RST_CTRL      TO_REG(0x40)
+#define AST2600_SYS_RST_CTRL_CLR  TO_REG(0x44)
+#define AST2600_SYS_RST_CTRL2     TO_REG(0x50)
+#define AST2600_SYS_RST_CTRL2_CLR TO_REG(0x54)
+#define AST2600_CLK_STOP_CTRL     TO_REG(0x80)
+#define AST2600_CLK_STOP_CTRL_CLR TO_REG(0x84)
+#define AST2600_CLK_STOP_CTRL2     TO_REG(0x90)
+#define AST2600_CLK_STOP_CTR2L_CLR TO_REG(0x94)
+#define AST2600_MPLL_EXT          TO_REG(0x224)
+#define AST2600_EPLL_EXT          TO_REG(0x244)
+#define AST2600_CLK_SEL           TO_REG(0x300)
+#define AST2600_CLK_SEL2          TO_REG(0x304)
+#define AST2600_CLK_SEL3          TO_REG(0x310)
+#define AST2600_HW_STRAP1         TO_REG(0x500)
+#define AST2600_HW_STRAP1_CLR     TO_REG(0x504)
+#define AST2600_HW_STRAP1_PROT    TO_REG(0x508)
+#define AST2600_HW_STRAP2         TO_REG(0x510)
+#define AST2600_HW_STRAP2_CLR     TO_REG(0x514)
+#define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
+#define AST2600_RNG_CTRL          TO_REG(0x524)
+#define AST2600_RNG_DATA          TO_REG(0x540)
+
+#define AST2600_CLK TO_REG(0x40)
+
 #define SCU_IO_REGION_SIZE 0x1000
=20
 static const uint32_t ast2400_a0_resets[ASPEED_SCU_NR_REGS] =3D {
@@ -178,7 +205,7 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr =
offset, unsigned size)
     AspeedSCUState *s =3D ASPEED_SCU(opaque);
     int reg =3D TO_REG(offset);
=20
-    if (reg >=3D ARRAY_SIZE(s->regs)) {
+    if (reg >=3D ASPEED_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx=
 "\n",
                       __func__, offset);
@@ -208,7 +235,7 @@ static void aspeed_scu_write(void *opaque, hwaddr off=
set, uint64_t data,
     AspeedSCUState *s =3D ASPEED_SCU(opaque);
     int reg =3D TO_REG(offset);
=20
-    if (reg >=3D ARRAY_SIZE(s->regs)) {
+    if (reg >=3D ASPEED_SCU_NR_REGS) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Out-of-bounds write at offset 0x%" HWADDR_PRI=
x "\n",
                       __func__, offset);
@@ -346,7 +373,7 @@ static void aspeed_scu_reset(DeviceState *dev)
     AspeedSCUState *s =3D ASPEED_SCU(dev);
     AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);
=20
-    memcpy(s->regs, asc->resets, sizeof(s->regs));
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);
     s->regs[SILICON_REV] =3D s->silicon_rev;
     s->regs[HW_STRAP1] =3D s->hw_strap1;
     s->regs[HW_STRAP2] =3D s->hw_strap2;
@@ -358,6 +385,7 @@ static uint32_t aspeed_silicon_revs[] =3D {
     AST2400_A1_SILICON_REV,
     AST2500_A0_SILICON_REV,
     AST2500_A1_SILICON_REV,
+    AST2600_A0_SILICON_REV,
 };
=20
 bool is_supported_silicon_rev(uint32_t silicon_rev)
@@ -377,6 +405,7 @@ static void aspeed_scu_realize(DeviceState *dev, Erro=
r **errp)
 {
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
     AspeedSCUState *s =3D ASPEED_SCU(dev);
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);
=20
     if (!is_supported_silicon_rev(s->silicon_rev)) {
         error_setg(errp, "Unknown silicon revision: 0x%" PRIx32,
@@ -384,7 +413,7 @@ static void aspeed_scu_realize(DeviceState *dev, Erro=
r **errp)
         return;
     }
=20
-    memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_scu_ops, s,
+    memory_region_init_io(&s->iomem, OBJECT(s), asc->ops, s,
                           TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
=20
     sysbus_init_mmio(sbd, &s->iomem);
@@ -395,7 +424,7 @@ static const VMStateDescription vmstate_aspeed_scu =3D=
 {
     .version_id =3D 1,
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_SCU_NR_REGS),
+        VMSTATE_UINT32_ARRAY(regs, AspeedSCUState, ASPEED_AST2600_SCU_NR=
_REGS),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -436,6 +465,8 @@ static void aspeed_2400_scu_class_init(ObjectClass *k=
lass, void *data)
     asc->resets =3D ast2400_a0_resets;
     asc->calc_hpll =3D aspeed_2400_scu_calc_hpll;
     asc->apb_divider =3D 2;
+    asc->nr_regs =3D ASPEED_SCU_NR_REGS;
+    asc->ops =3D &aspeed_scu_ops;
 }
=20
 static const TypeInfo aspeed_2400_scu_info =3D {
@@ -454,6 +485,8 @@ static void aspeed_2500_scu_class_init(ObjectClass *k=
lass, void *data)
     asc->resets =3D ast2500_a1_resets;
     asc->calc_hpll =3D aspeed_2500_scu_calc_hpll;
     asc->apb_divider =3D 4;
+    asc->nr_regs =3D ASPEED_SCU_NR_REGS;
+    asc->ops =3D &aspeed_scu_ops;
 }
=20
 static const TypeInfo aspeed_2500_scu_info =3D {
@@ -463,11 +496,152 @@ static const TypeInfo aspeed_2500_scu_info =3D {
     .class_init =3D aspeed_2500_scu_class_init,
 };
=20
+static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    AspeedSCUState *s =3D ASPEED_SCU(opaque);
+    int reg =3D TO_REG(offset);
+
+    if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx=
 "\n",
+                      __func__, offset);
+        return 0;
+    }
+
+    switch (reg) {
+    case AST2600_EPLL_EXT:
+    case AST2600_MPLL_EXT:
+        /* PLLs are always "locked" */
+        return s->regs[reg] | BIT(31);
+    case AST2600_RNG_DATA:
+        /*
+         * On hardware, RNG_DATA works regardless of the state of the
+         * enable bit in RNG_CTRL
+         *
+         * TODO: Check this is true for ast2600
+         */
+        s->regs[AST2600_RNG_DATA] =3D aspeed_scu_get_random();
+        break;
+    }
+
+    return s->regs[reg];
+}
+
+static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64=
_t data,
+                                     unsigned size)
+{
+    AspeedSCUState *s =3D ASPEED_SCU(opaque);
+    int reg =3D TO_REG(offset);
+
+    if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRI=
x "\n",
+                      __func__, offset);
+        return;
+    }
+
+    if (reg > PROT_KEY && !s->regs[PROT_KEY]) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__)=
;
+    }
+
+    trace_aspeed_scu_write(offset, size, data);
+
+    switch (reg) {
+    case AST2600_PROT_KEY:
+        s->regs[reg] =3D (data =3D=3D ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        return;
+    case AST2600_HW_STRAP1:
+    case AST2600_HW_STRAP2:
+        if (s->regs[reg + 2]) {
+            return;
+        }
+        /* fall through */
+    case AST2600_SYS_RST_CTRL:
+    case AST2600_SYS_RST_CTRL2:
+        /* W1S (Write 1 to set) registers */
+        s->regs[reg] |=3D data;
+        return;
+    case AST2600_SYS_RST_CTRL_CLR:
+    case AST2600_SYS_RST_CTRL2_CLR:
+    case AST2600_HW_STRAP1_CLR:
+    case AST2600_HW_STRAP2_CLR:
+        /* W1C (Write 1 to clear) registers */
+        s->regs[reg] &=3D ~data;
+        return;
+
+    case AST2600_RNG_DATA:
+    case AST2600_SILICON_REV:
+    case AST2600_SILICON_REV2:
+        /* Add read only registers here */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Write to read-only offset 0x%" HWADDR_PRIx "\=
n",
+                      __func__, offset);
+        return;
+    }
+
+    s->regs[reg] =3D data;
+}
+
+static const MemoryRegionOps aspeed_ast2600_scu_ops =3D {
+    .read =3D aspeed_ast2600_scu_read,
+    .write =3D aspeed_ast2600_scu_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+    .valid.unaligned =3D false,
+};
+
+static const uint32_t ast2600_a0_resets[ASPEED_AST2600_SCU_NR_REGS] =3D =
{
+    [AST2600_SILICON_REV]       =3D AST2600_SILICON_REV,
+    [AST2600_SILICON_REV2]      =3D AST2600_SILICON_REV,
+    [AST2600_SYS_RST_CTRL]      =3D 0xF7CFFEDC | 0x100,
+    [AST2600_SYS_RST_CTRL2]     =3D 0xFFFFFFFC,
+    [AST2600_CLK_STOP_CTRL]     =3D 0xEFF43E8B,
+    [AST2600_CLK_STOP_CTRL2]    =3D 0xFFF0FFF0,
+};
+
+static void aspeed_ast2600_scu_reset(DeviceState *dev)
+{
+    AspeedSCUState *s =3D ASPEED_SCU(dev);
+    AspeedSCUClass *asc =3D ASPEED_SCU_GET_CLASS(dev);
+
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);
+
+    s->regs[AST2600_SILICON_REV] =3D s->silicon_rev;
+    s->regs[AST2600_SILICON_REV2] =3D s->silicon_rev;
+    s->regs[AST2600_HW_STRAP1] =3D s->hw_strap1;
+    s->regs[AST2600_HW_STRAP2] =3D s->hw_strap2;
+    s->regs[PROT_KEY] =3D s->hw_prot_key;
+}
+
+static void aspeed_2600_scu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    AspeedSCUClass *asc =3D ASPEED_SCU_CLASS(klass);
+
+    dc->desc =3D "ASPEED 2600 System Control Unit";
+    dc->reset =3D aspeed_ast2600_scu_reset;
+    asc->resets =3D ast2600_a0_resets;
+    asc->calc_hpll =3D aspeed_2500_scu_calc_hpll;
+    asc->apb_divider =3D 4;
+    asc->nr_regs =3D ASPEED_AST2600_SCU_NR_REGS;
+    asc->ops =3D &aspeed_ast2600_scu_ops;
+}
+
+static const TypeInfo aspeed_2600_scu_info =3D {
+    .name =3D TYPE_ASPEED_2600_SCU,
+    .parent =3D TYPE_ASPEED_SCU,
+    .instance_size =3D sizeof(AspeedSCUState),
+    .class_init =3D aspeed_2600_scu_class_init,
+};
+
 static void aspeed_scu_register_types(void)
 {
     type_register_static(&aspeed_scu_info);
     type_register_static(&aspeed_2400_scu_info);
     type_register_static(&aspeed_2500_scu_info);
+    type_register_static(&aspeed_2600_scu_info);
 }
=20
 type_init(aspeed_scu_register_types);
--=20
2.21.0


