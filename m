Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8578DC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4623C20820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4623C20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cuN-0007jd-UT
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i5cCV-0000t8-Ic
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i5cCT-0001mz-NM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:23 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:33985)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i5cCT-0001mK-GS
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:48:21 -0400
Received: from player691.ha.ovh.net (unknown [10.109.143.24])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id E4D8B109720
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 22:48:19 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 4AD2C98B28F4;
 Wed,  4 Sep 2019 20:48:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Wed,  4 Sep 2019 22:46:54 +0200
Message-Id: <20190904204659.13878-11-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904204659.13878-1-clg@kaod.org>
References: <20190904204659.13878-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 2527363817981578001
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejhedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.143
Subject: [Qemu-devel] [RFC PATCH 10/15] aspeed/smc: Add support for the
 AST2600 SoC
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

The AST2600 SoC SMC controller is a SPI only controller now and has a
few extensions which we will need to take into account when SW
requires it.

 - 4BYTE mode
 - HCLK divider has changed (SPI Training)
 - CE0-2 Read Timing Compensation registers

This is enough to support u-boot.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ssi/aspeed_smc.h |   2 +
 hw/ssi/aspeed_smc.c         | 129 +++++++++++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 8 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 5176ff6bf95f..84f268de3091 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -49,6 +49,8 @@ typedef struct AspeedSMCController {
     hwaddr dma_flash_mask;
     hwaddr dma_dram_mask;
     uint32_t nregs;
+    uint32_t (*segment_to_reg)(const AspeedSegments *seg);
+    void (*reg_to_segment)(uint32_t reg, AspeedSegments *seg);
 } AspeedSMCController;
=20
 typedef struct AspeedSMCFlash {
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 9ffc7e01179a..1be53b5e53ac 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -54,10 +54,8 @@
=20
 /* CE Control Register */
 #define R_CE_CTRL            (0x04 / 4)
-#define   CTRL_EXTENDED4       4  /* 32 bit addressing for SPI */
-#define   CTRL_EXTENDED3       3  /* 32 bit addressing for SPI */
-#define   CTRL_EXTENDED2       2  /* 32 bit addressing for SPI */
-#define   CTRL_EXTENDED1       1  /* 32 bit addressing for SPI */
+
+#define   CTRL_4B_AUTOREAD     4  /* 4B address Auto-Read command select=
ion */
 #define   CTRL_EXTENDED0       0  /* 32 bit addressing for SPI */
=20
 /* Interrupt Control and Status Register */
@@ -71,8 +69,11 @@
=20
 /* CEx Control Register */
 #define R_CTRL0           (0x10 / 4)
+#define   CTRL_IO_QPI              (1 << 31)
+#define   CTRL_IO_QUAD_DATA        (1 << 30)
 #define   CTRL_IO_DUAL_DATA        (1 << 29)
 #define   CTRL_IO_DUAL_ADDR_DATA   (1 << 28) /* Includes dummies */
+#define   CTRL_IO_QUAD_ADDR_DATA   (1 << 28) /* Includes dummies */
 #define   CTRL_CMD_SHIFT           16
 #define   CTRL_CMD_MASK            0xff
 #define   CTRL_DUMMY_HIGH_SHIFT    14
@@ -84,7 +85,7 @@
 #define   CTRL_DUMMY_LOW_SHIFT     6 /* 2 bits [7:6] */
 #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
 #define   CTRL_CMD_MODE_MASK       0x3
-#define     CTRL_READMODE          0x0
+#define     CTRL_READMODE          0x0 /* AST2600: 4BYTE READ */
 #define     CTRL_FREADMODE         0x1
 #define     CTRL_WRITEMODE         0x2
 #define     CTRL_USERMODE          0x3
@@ -135,8 +136,11 @@
=20
 /* Misc Control Register #2 */
 #define R_TIMINGS         (0x94 / 4)
+#define R_CE0_READ_TIMING (0x94 / 4)
+#define R_CE1_READ_TIMING (0x98 / 4)
+#define R_CE2_READ_TIMING (0x9C / 4)
=20
-/* SPI controller registers and bits */
+/* AST2400 SPI1 controller registers and bits */
 #define R_SPI_CONF        (0x00 / 4)
 #define   SPI_CONF_ENABLE_W0   0
 #define R_SPI_CTRL0       (0x4 / 4)
@@ -212,6 +216,36 @@ static const AspeedSegments aspeed_segments_ast2500_=
spi2[] =3D {
     { 0x3A000000, 96 * 1024 * 1024 }, /* end address is readonly */
 };
=20
+/*
+ * AST2600 definitions
+ */
+#define ASPEED26_SOC_FMC_FLASH_BASE   0x20000000
+#define ASPEED26_SOC_SPI_FLASH_BASE   0x30000000
+#define ASPEED26_SOC_SPI2_FLASH_BASE  0x50000000
+
+static const AspeedSegments aspeed_segments_ast2600_fmc[] =3D {
+    { 0x20000000, 128 * 1024 * 1024 }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+    { 0x0, 0 }, /* disabled */
+};
+
+static const AspeedSegments aspeed_segments_ast2600_spi1[] =3D {
+    { 0x30000000, 128 * 1024 * 1024 }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+};
+
+static const AspeedSegments aspeed_segments_ast2600_spi2[] =3D {
+    { 0x50000000, 128 * 1024 * 1024 }, /* start address is readonly */
+    { 0x0, 0 }, /* disabled */
+    { 0x0, 0 }, /* disabled */
+};
+
+static uint32_t aspeed_smc_segment_to_reg(const AspeedSegments *seg);
+static void aspeed_smc_reg_to_segment(uint32_t reg, AspeedSegments *seg)=
;
+
+static uint32_t aspeed_2600_smc_segment_to_reg(const AspeedSegments *seg=
);
+static void aspeed_2600_smc_reg_to_segment(uint32_t reg, AspeedSegments =
*seg);
+
 static const AspeedSMCController controllers[] =3D {
     {
         .name              =3D "aspeed.smc-ast2400",
@@ -226,6 +260,8 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_size =3D 0x6000000,
         .has_dma           =3D false,
         .nregs             =3D ASPEED_SMC_R_SMC_MAX,
+        .segment_to_reg    =3D aspeed_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_smc_reg_to_segment,
     }, {
         .name              =3D "aspeed.fmc-ast2400",
         .r_conf            =3D R_CONF,
@@ -241,6 +277,8 @@ static const AspeedSMCController controllers[] =3D {
         .dma_flash_mask    =3D 0x0FFFFFFC,
         .dma_dram_mask     =3D 0x1FFFFFFC,
         .nregs             =3D ASPEED_SMC_R_MAX,
+        .segment_to_reg    =3D aspeed_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_smc_reg_to_segment,
     }, {
         .name              =3D "aspeed.spi1-ast2400",
         .r_conf            =3D R_SPI_CONF,
@@ -254,6 +292,8 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_size =3D 0x10000000,
         .has_dma           =3D false,
         .nregs             =3D ASPEED_SMC_R_SPI_MAX,
+        .segment_to_reg    =3D aspeed_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_smc_reg_to_segment,
     }, {
         .name              =3D "aspeed.fmc-ast2500",
         .r_conf            =3D R_CONF,
@@ -269,6 +309,8 @@ static const AspeedSMCController controllers[] =3D {
         .dma_flash_mask    =3D 0x0FFFFFFC,
         .dma_dram_mask     =3D 0x3FFFFFFC,
         .nregs             =3D ASPEED_SMC_R_MAX,
+        .segment_to_reg    =3D aspeed_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_smc_reg_to_segment,
     }, {
         .name              =3D "aspeed.spi1-ast2500",
         .r_conf            =3D R_CONF,
@@ -282,6 +324,8 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_size =3D 0x8000000,
         .has_dma           =3D false,
         .nregs             =3D ASPEED_SMC_R_MAX,
+        .segment_to_reg    =3D aspeed_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_smc_reg_to_segment,
     }, {
         .name              =3D "aspeed.spi2-ast2500",
         .r_conf            =3D R_CONF,
@@ -295,6 +339,53 @@ static const AspeedSMCController controllers[] =3D {
         .flash_window_size =3D 0x8000000,
         .has_dma           =3D false,
         .nregs             =3D ASPEED_SMC_R_MAX,
+        .segment_to_reg    =3D aspeed_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_smc_reg_to_segment,
+    }, {
+        .name              =3D "aspeed.fmc-ast2600",
+        .r_conf            =3D R_CONF,
+        .r_ce_ctrl         =3D R_CE_CTRL,
+        .r_ctrl0           =3D R_CTRL0,
+        .r_timings         =3D R_TIMINGS,
+        .conf_enable_w0    =3D CONF_ENABLE_W0,
+        .max_slaves        =3D 3,
+        .segments          =3D aspeed_segments_ast2600_fmc,
+        .flash_window_base =3D ASPEED26_SOC_FMC_FLASH_BASE,
+        .flash_window_size =3D 0x10000000,
+        .has_dma           =3D true,
+        .nregs             =3D ASPEED_SMC_R_MAX,
+        .segment_to_reg    =3D aspeed_2600_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_2600_smc_reg_to_segment,
+    }, {
+        .name              =3D "aspeed.spi1-ast2600",
+        .r_conf            =3D R_CONF,
+        .r_ce_ctrl         =3D R_CE_CTRL,
+        .r_ctrl0           =3D R_CTRL0,
+        .r_timings         =3D R_TIMINGS,
+        .conf_enable_w0    =3D CONF_ENABLE_W0,
+        .max_slaves        =3D 2,
+        .segments          =3D aspeed_segments_ast2600_spi1,
+        .flash_window_base =3D ASPEED26_SOC_SPI_FLASH_BASE,
+        .flash_window_size =3D 0x10000000,
+        .has_dma           =3D false,
+        .nregs             =3D ASPEED_SMC_R_MAX,
+        .segment_to_reg    =3D aspeed_2600_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_2600_smc_reg_to_segment,
+    }, {
+        .name              =3D "aspeed.spi2-ast2600",
+        .r_conf            =3D R_CONF,
+        .r_ce_ctrl         =3D R_CE_CTRL,
+        .r_ctrl0           =3D R_CTRL0,
+        .r_timings         =3D R_TIMINGS,
+        .conf_enable_w0    =3D CONF_ENABLE_W0,
+        .max_slaves        =3D 3,
+        .segments          =3D aspeed_segments_ast2600_spi2,
+        .flash_window_base =3D ASPEED26_SOC_SPI2_FLASH_BASE,
+        .flash_window_size =3D 0x10000000,
+        .has_dma           =3D false,
+        .nregs             =3D ASPEED_SMC_R_MAX,
+        .segment_to_reg    =3D aspeed_2600_smc_segment_to_reg,
+        .reg_to_segment    =3D aspeed_2600_smc_reg_to_segment,
     },
 };
=20
@@ -307,7 +398,7 @@ static const AspeedSMCController controllers[] =3D {
  *        |  end   |  start |   0    |   0    |
  *
  */
-static inline uint32_t aspeed_smc_segment_to_reg(const AspeedSegments *s=
eg)
+static uint32_t aspeed_smc_segment_to_reg(const AspeedSegments *seg)
 {
     uint32_t reg =3D 0;
     reg |=3D ((seg->addr >> 23) & SEG_START_MASK) << SEG_START_SHIFT;
@@ -315,12 +406,34 @@ static inline uint32_t aspeed_smc_segment_to_reg(co=
nst AspeedSegments *seg)
     return reg;
 }
=20
-static inline void aspeed_smc_reg_to_segment(uint32_t reg, AspeedSegment=
s *seg)
+static void aspeed_smc_reg_to_segment(uint32_t reg, AspeedSegments *seg)
 {
     seg->addr =3D ((reg >> SEG_START_SHIFT) & SEG_START_MASK) << 23;
     seg->size =3D (((reg >> SEG_END_SHIFT) & SEG_END_MASK) << 23) - seg-=
>addr;
 }
=20
+/*
+ * AST2600 uses a 1MB unit
+ */
+static uint32_t aspeed_2600_smc_segment_to_reg(const AspeedSegments *seg=
)
+{
+    uint32_t reg =3D 0;
+
+    /* Disabled segments have a nil register */
+    if (!seg->addr) {
+        return 0;
+    }
+    reg |=3D (seg->addr >> 20) & 0xffff;
+    reg |=3D (((seg->addr + seg->size) >> 20) & 0xffff) << 16;
+    return reg;
+}
+
+static void aspeed_2600_smc_reg_to_segment(uint32_t reg, AspeedSegments =
*seg)
+{
+    seg->addr =3D (reg & 0xffff) << 20;
+    seg->size =3D (((reg >> 16) & 0xffff) << 20) - seg->addr;
+}
+
 static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
                                      const AspeedSegments *new,
                                      int cs)
--=20
2.21.0


