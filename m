Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33491C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:36:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E0D208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E0D208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJAwe-0001jC-KI
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kJAnf-0007vI-4m
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:27:19 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:41897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1kJAnc-0003lr-ON
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:27:18 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.179])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 575FB62F468F;
 Fri, 18 Sep 2020 09:27:06 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 18 Sep
 2020 09:27:05 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001b2f8559a-14e6-41c9-8032-d655c38789ec,
 ECEC63DD04C3092DE3B5C7147C06DCFEA73B34A9) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <qemu-devel@nongnu.org>
Subject: [PULL 2/3] hw/arm/aspeed: Add machine properties to define the flash
 models
Date: Fri, 18 Sep 2020 09:27:02 +0200
Message-ID: <20200918072703.331138-3-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918072703.331138-1-clg@kaod.org>
References: <20200918072703.331138-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: c2dbda0d-ff30-4377-ab7f-cd2628be6dbb
X-Ovh-Tracer-Id: 7010134295899966371
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdehgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:27:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_BL_SPAMCOP_NET=1.347,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?=E9=83=81=E9=9B=B7?= <yulei.sh@bytedance.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some machines don't have much differences a part from the flash model
being used. Introduce new machine properties to change them from the
command line.

For instance, to start the ast2500-evb machine with a different FMC
chip and a 64M SPI chip, use :

  -M ast2500-evb,fmc-model=mx25l25635e,spi-model=mx66u51235f

Cc: 郁雷 <yulei.sh@bytedance.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Lei YU <yulei.sh@bytedance.com>
Message-Id: <20200915054859.2338477-1-clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 docs/system/arm/aspeed.rst | 18 +++++++++++++++
 hw/arm/aspeed.c            | 45 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
index 45f891eb3cad..2d33d023453e 100644
--- a/docs/system/arm/aspeed.rst
+++ b/docs/system/arm/aspeed.rst
@@ -83,3 +83,21 @@ The image should be attached as an MTD drive. Run :
 
   $ qemu-system-arm -M romulus-bmc -nic user \
 	-drive file=flash-romulus,format=raw,if=mtd -nographic
+
+Options specific to Aspeed machines are :
+
+ * ``execute-in-place`` which emulates the boot from the CE0 flash
+   device by using the FMC controller to load the instructions, and
+   not simply from RAM. This takes a little longer.
+
+ * ``fmc-model`` to change the FMC Flash model. FW needs support for
+   the chip model to boot.
+
+ * ``spi-model`` to change the SPI Flash model.
+
+For instance, to start the ``ast2500-evb`` machine with a different
+FMC chip and a bigger (64M) SPI chip, use :
+
+.. code-block:: bash
+
+  -M ast2500-evb,fmc-model=mx25l25635e,spi-model=mx66u51235f
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8bfb1c79ddc5..bdb981d2f878 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -41,6 +41,8 @@ struct AspeedMachineState {
     MemoryRegion ram_container;
     MemoryRegion max_ram;
     bool mmio_exec;
+    char *fmc_model;
+    char *spi_model;
 };
 
 /* Palmetto hardware value: 0x120CE416 */
@@ -332,8 +334,10 @@ static void aspeed_machine_init(MachineState *machine)
                           "max_ram", max_ram_size  - ram_size);
     memory_region_add_subregion(&bmc->ram_container, ram_size, &bmc->max_ram);
 
-    aspeed_board_init_flashes(&bmc->soc.fmc, amc->fmc_model);
-    aspeed_board_init_flashes(&bmc->soc.spi[0], amc->spi_model);
+    aspeed_board_init_flashes(&bmc->soc.fmc, bmc->fmc_model ?
+                              bmc->fmc_model : amc->fmc_model);
+    aspeed_board_init_flashes(&bmc->soc.spi[0], bmc->spi_model ?
+                              bmc->spi_model : amc->spi_model);
 
     /* Install first FMC flash content as a boot rom. */
     if (drive0) {
@@ -570,6 +574,34 @@ static void aspeed_machine_instance_init(Object *obj)
     ASPEED_MACHINE(obj)->mmio_exec = false;
 }
 
+static char *aspeed_get_fmc_model(Object *obj, Error **errp)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+    return g_strdup(bmc->fmc_model);
+}
+
+static void aspeed_set_fmc_model(Object *obj, const char *value, Error **errp)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+
+    g_free(bmc->fmc_model);
+    bmc->fmc_model = g_strdup(value);
+}
+
+static char *aspeed_get_spi_model(Object *obj, Error **errp)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+    return g_strdup(bmc->spi_model);
+}
+
+static void aspeed_set_spi_model(Object *obj, const char *value, Error **errp)
+{
+    AspeedMachineState *bmc = ASPEED_MACHINE(obj);
+
+    g_free(bmc->spi_model);
+    bmc->spi_model = g_strdup(value);
+}
+
 static void aspeed_machine_class_props_init(ObjectClass *oc)
 {
     object_class_property_add_bool(oc, "execute-in-place",
@@ -577,6 +609,15 @@ static void aspeed_machine_class_props_init(ObjectClass *oc)
                                    aspeed_set_mmio_exec);
     object_class_property_set_description(oc, "execute-in-place",
                            "boot directly from CE0 flash device");
+
+    object_class_property_add_str(oc, "fmc-model", aspeed_get_fmc_model,
+                                   aspeed_set_fmc_model);
+    object_class_property_set_description(oc, "fmc-model",
+                                          "Change the FMC Flash model");
+    object_class_property_add_str(oc, "spi-model", aspeed_get_spi_model,
+                                   aspeed_set_spi_model);
+    object_class_property_set_description(oc, "spi-model",
+                                          "Change the SPI Flash model");
 }
 
 static int aspeed_soc_num_cpus(const char *soc_name)
-- 
2.25.4


