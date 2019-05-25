Return-Path: <SRS0=E2zY=TZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB68C07542
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F13520862
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2019 15:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F13520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUYjg-0004cy-HR
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 11:37:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYdx-0007r4-Ah
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hUYNk-00035A-TQ
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:50 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:50816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hUYNi-0002xJ-RT
	for qemu-devel@nongnu.org; Sat, 25 May 2019 11:14:46 -0400
Received: from player698.ha.ovh.net (unknown [10.108.57.178])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id A8D7A19A950
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 17:14:36 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player698.ha.ovh.net (Postfix) with ESMTPSA id BCCF2625A885;
	Sat, 25 May 2019 15:14:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 25 May 2019 17:12:37 +0200
Message-Id: <20190525151241.5017-16-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190525151241.5017-1-clg@kaod.org>
References: <20190525151241.5017-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6619165553576872721
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddukedgkeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.53.149
Subject: [Qemu-devel] [PATCH 15/19] aspeed: add a RAM memory region container
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

The RAM memory region is defined after the SoC is realized when the
SDMC controller has cheched that the defined RAM size for the machine
is correct. This is problematic for controller models requiring a link
on the RAM region, for DMA support in the SMC controller for instance.

Introduce a container memory region for the RAM that we can link into
the controllers early, before the SoC is realized. It will be
populated with the RAM region after the checks have be done.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 228fdbcf65e2..ed5c8dd5133a 100644
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
@@ -191,16 +196,16 @@ static void aspeed_board_init(MachineState *machine=
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
2.20.1


