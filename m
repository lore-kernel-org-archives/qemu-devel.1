Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9BF3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD3822DD6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD3822DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fr3-0003mc-PC
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3fpf-0001JT-P3; Thu, 06 Aug 2020 09:21:19 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:48213)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3fpa-0000tt-Ex; Thu, 06 Aug 2020 09:21:19 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.125])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 0B7FB545F89D;
 Thu,  6 Aug 2020 15:21:12 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 6 Aug 2020
 15:21:10 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0050d862c31-b152-4e7f-bf25-1874d3ad7350,
 96EDEDBD7B7627A0205C40E9E2B74F8D513A659B) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH for-5.2 05/19] hw/arm/aspeed: Add board model for Supermicro
 X11 BMC
Date: Thu, 6 Aug 2020 15:20:52 +0200
Message-ID: <20200806132106.747414-6-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200806132106.747414-1-clg@kaod.org>
References: <20200806132106.747414-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG8EX2.mxp5.local (172.16.2.72) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 2d691f75-5c98-480d-a8ed-b9ad3d35caf6
X-Ovh-Tracer-Id: 271904829506423657
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedtgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgihesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehjeethedutdeitefghfeuvedvleelkeffjedufeeigeejgeehheeulefggeelgfenucffohhmrghinhepshhuphgvrhhmihgtrhhordgtohhmnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 09:21:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-devel@nongnu.org,
 erik-smit <erik.lucas.smit@gmail.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: erik-smit <erik.lucas.smit@gmail.com>

The BMC Firmware can be downloaded from :

  https://www.supermicro.com/en/products/motherboard/X11SSL-F

Signed-off-by: erik-smit <erik.lucas.smit@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
[ clg: Modified commit log ]
Message-Id: <20200715173418.186-1-erik.lucas.smit@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index fcb1a7cd8729..d17a4885a03c 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -57,6 +57,20 @@ struct AspeedMachineState {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
 
+/* TODO: Find the actual hardware value */
+#define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
+        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
+        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2) |                           \
+        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
+        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                \
+        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
+        SCU_HW_STRAP_SPI_WIDTH |                                        \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
+
 /* AST2500 evb hardware value: 0xF100C2E6 */
 #define AST2500_EVB_HW_STRAP1 ((                                        \
         AST2500_HW_STRAP1_DEFAULTS |                                    \
@@ -603,6 +617,23 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc, void *data)
         aspeed_soc_num_cpus(amc->soc_name);
 };
 
+static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
+                                                        void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Supermicro X11 BMC (ARM926EJ-S)";
+    amc->soc_name  = "ast2400-a1";
+    amc->hw_strap1 = SUPERMICROX11_BMC_HW_STRAP1;
+    amc->fmc_model = "mx25l25635e";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 1;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
+    amc->i2c_init  = palmetto_bmc_i2c_init;
+    mc->default_ram_size = 256 * MiB;
+}
+
 static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -731,6 +762,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
+    }, {
+        .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
-- 
2.25.4


