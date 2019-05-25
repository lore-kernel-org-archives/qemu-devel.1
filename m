Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94144C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE082081C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE082081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43256 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYT3-0002En-I8
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:20:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYMe-0005kF-CZ
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYMd-0001er-1B
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:40 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:60913)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUYMc-0001de-Rk
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:13:38 -0400
Received: from player698.ha.ovh.net (unknown [10.109.146.168])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 8496C193BB4
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 17:13:37 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id 38DB3625A797;
	Sat, 25 May 2019 15:13:31 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 17:12:28 +0200
Message-Id: <20190525151241.5017-7-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525151241.5017-1-clg@kaod.org>
References: <20190525151241.5017-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6602558530083326737
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddukedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.53.149
Subject: [Qemu-devel] [PATCH 06/19] aspeed: introduce a configurable number
 of CPU per machine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrew Jeffery <andrew@aj.id.au>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current models of the Aspeed SoCs only have one CPU but future
ones will support SMP. Introduce a way to configure the maximum number
of CPU per machine. SMP support will be activated when models for such
SoCs are implemented.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed.h     |  1 +
 include/hw/arm/aspeed_soc.h |  3 ++-
 hw/arm/aspeed.c             |  8 ++++++--
 hw/arm/aspeed_soc.c         | 17 +++++++++++------
 4 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 02073a6b4d61..f2f238ea83cc 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -23,6 +23,7 @@ typedef struct AspeedBoardConfig {
     uint32_t num_cs;
     void (*i2c_init)(AspeedBoardState *bmc);
     uint32_t ram;
+    uint32_t num_cpus;
 } AspeedBoardConfig;
=20
 #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index fa0ba957a611..7247f6da2505 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -24,13 +24,14 @@
=20
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
+#define ASPEED_CPUS_NUM  2
=20
 typedef struct AspeedSoCState {
     /*< private >*/
     DeviceState parent;
=20
     /*< public >*/
-    ARMCPU cpu;
+    ARMCPU cpu[ASPEED_CPUS_NUM];
     MemoryRegion sram;
     AspeedVICState vic;
     AspeedRtcState rtc;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 10ba3f50481a..004b0c318951 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -29,7 +29,6 @@
=20
 static struct arm_boot_info aspeed_board_binfo =3D {
     .board_id =3D -1, /* device-tree-only board */
-    .nb_cpus =3D 1,
 };
=20
 struct AspeedBoardState {
@@ -231,6 +230,7 @@ static void aspeed_board_init(MachineState *machine,
     aspeed_board_binfo.kernel_cmdline =3D machine->kernel_cmdline;
     aspeed_board_binfo.ram_size =3D ram_size;
     aspeed_board_binfo.loader_start =3D sc->info->memmap[ASPEED_SDRAM];
+    aspeed_board_binfo.nb_cpus =3D cfg->num_cpus;
=20
     if (cfg->i2c_init) {
         cfg->i2c_init(bmc);
@@ -327,7 +327,7 @@ static void aspeed_machine_class_init(ObjectClass *oc=
, void *data)
=20
     mc->desc =3D board->desc;
     mc->init =3D aspeed_machine_init;
-    mc->max_cpus =3D 1;
+    mc->max_cpus =3D ASPEED_CPUS_NUM;
     mc->no_sdcard =3D 1;
     mc->no_floppy =3D 1;
     mc->no_cdrom =3D 1;
@@ -357,6 +357,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .num_cs    =3D 1,
         .i2c_init  =3D palmetto_bmc_i2c_init,
         .ram       =3D 256 * MiB,
+        .num_cpus  =3D 1,
     }, {
         .name      =3D MACHINE_TYPE_NAME("ast2500-evb"),
         .desc      =3D "Aspeed AST2500 EVB (ARM1176)",
@@ -367,6 +368,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .num_cs    =3D 1,
         .i2c_init  =3D ast2500_evb_i2c_init,
         .ram       =3D 512 * MiB,
+        .num_cpus  =3D 1,
     }, {
         .name      =3D MACHINE_TYPE_NAME("romulus-bmc"),
         .desc      =3D "OpenPOWER Romulus BMC (ARM1176)",
@@ -377,6 +379,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .num_cs    =3D 2,
         .i2c_init  =3D romulus_bmc_i2c_init,
         .ram       =3D 512 * MiB,
+        .num_cpus  =3D 1,
     }, {
         .name      =3D MACHINE_TYPE_NAME("witherspoon-bmc"),
         .desc      =3D "OpenPOWER Witherspoon BMC (ARM1176)",
@@ -387,6 +390,7 @@ static const AspeedBoardConfig aspeed_boards[] =3D {
         .num_cs    =3D 2,
         .i2c_init  =3D witherspoon_bmc_i2c_init,
         .ram       =3D 512 * MiB,
+        .num_cpus  =3D 1,
     },
 };
=20
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index d1dc8f03f35c..b983d5efc5d1 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -172,8 +172,11 @@ static void aspeed_soc_init(Object *obj)
     AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
     int i;
=20
-    object_initialize_child(obj, "cpu", OBJECT(&s->cpu), sizeof(s->cpu),
-                            sc->info->cpu_type, &error_abort, NULL);
+    for (i =3D 0; i < MIN(smp_cpus, ASPEED_CPUS_NUM); i++) {
+        object_initialize_child(obj, "cpu[*]", OBJECT(&s->cpu[i]),
+                                sizeof(s->cpu[i]), sc->info->cpu_type,
+                                &error_abort, NULL);
+    }
=20
     sysbus_init_child_obj(obj, "scu", OBJECT(&s->scu), sizeof(s->scu),
                           TYPE_ASPEED_SCU);
@@ -242,10 +245,12 @@ static void aspeed_soc_realize(DeviceState *dev, Er=
ror **errp)
                                 ASPEED_SOC_IOMEM_SIZE);
=20
     /* CPU */
-    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
+    for (i =3D 0; i < smp_cpus; i++) {
+        object_property_set_bool(OBJECT(&s->cpu[i]), true, "realized", &=
err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
     }
=20
     /* SRAM */
--=20
2.20.1


