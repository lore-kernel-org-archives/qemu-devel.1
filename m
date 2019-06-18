Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5DEC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAAFE2147A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAAFE2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHse-0001Da-3o
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60907)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdHNr-00012J-E0
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdHNp-0005CK-FC
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:58 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:36741)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdHNp-00057m-75
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:54:57 -0400
Received: from player157.ha.ovh.net (unknown [10.108.57.72])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id E297613289C
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:54:53 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 554A66EB53EB;
 Tue, 18 Jun 2019 16:54:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 18:53:03 +0200
Message-Id: <20190618165311.27066-14-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618165311.27066-1-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1683501838070614801
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgdejjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.52.162
Subject: [Qemu-devel] [PATCH v2 13/21] aspeed: add a RAM memory region
 container
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

The RAM memory region is defined after the SoC is realized when the
SDMC controller has checked that the defined RAM size for the machine
is correct. This is problematic for controller models requiring a link
on the RAM region, for DMA support in the SMC controller for instance.

Introduce a container memory region for the RAM that we can link into
the controllers early, before the SoC is realized. It will be
populated with the RAM region after the checks have be done.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
---
 hw/arm/aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 5d73267da16f..7f01df1b61d8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -33,6 +33,7 @@ static struct arm_boot_info aspeed_board_binfo =3D {
=20
 struct AspeedBoardState {
     AspeedSoCState soc;
+    MemoryRegion ram_container;
     MemoryRegion ram;
     MemoryRegion max_ram;
 };
@@ -159,6 +160,10 @@ static void aspeed_board_init(MachineState *machine,
     ram_addr_t max_ram_size;
=20
     bmc =3D g_new0(AspeedBoardState, 1);
+
+    memory_region_init(&bmc->ram_container, NULL, "aspeed-ram-container"=
,
+                       UINT32_MAX);
+
     object_initialize_child(OBJECT(machine), "soc", &bmc->soc,
                             (sizeof(bmc->soc)), cfg->soc_name, &error_ab=
ort,
                             NULL);
@@ -193,16 +198,16 @@ static void aspeed_board_init(MachineState *machine=
,
                                         &error_abort);
=20
     memory_region_allocate_system_memory(&bmc->ram, NULL, "ram", ram_siz=
e);
+    memory_region_add_subregion(&bmc->ram_container, 0, &bmc->ram);
     memory_region_add_subregion(get_system_memory(),
-                                sc->info->memmap[ASPEED_SDRAM], &bmc->ra=
m);
+                                sc->info->memmap[ASPEED_SDRAM],
+                                &bmc->ram_container);
=20
     max_ram_size =3D object_property_get_uint(OBJECT(&bmc->soc), "max-ra=
m-size",
                                             &error_abort);
     memory_region_init_io(&bmc->max_ram, NULL, &max_ram_ops, NULL,
                           "max_ram", max_ram_size  - ram_size);
-    memory_region_add_subregion(get_system_memory(),
-                                sc->info->memmap[ASPEED_SDRAM] + ram_siz=
e,
-                                &bmc->max_ram);
+    memory_region_add_subregion(&bmc->ram_container, ram_size, &bmc->max=
_ram);
=20
     aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abor=
t);
     aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_a=
bort);
--=20
2.21.0


