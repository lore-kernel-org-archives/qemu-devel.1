Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED490C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11D02074B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 13:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11D02074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg7Kx-0004j1-2B
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 09:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jg7Js-0003tm-0m
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:51:08 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:36960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jg7Jo-0008C7-8B
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 09:51:06 -0400
Received: from player732.ha.ovh.net (unknown [10.108.54.108])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 79D2E12F6CB
 for <qemu-devel@nongnu.org>; Tue,  2 Jun 2020 15:51:00 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player732.ha.ovh.net (Postfix) with ESMTPSA id 2A27E12D4F05A;
 Tue,  2 Jun 2020 13:50:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00187efc2a0-7079-4454-b5a0-9e7c81b30e2b,5E62BD569A294C88FEF25C709A17CDFB03A24EB6)
 smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] docs/system: Document Aspeed boards
Date: Tue,  2 Jun 2020 15:50:50 +0200
Message-Id: <20200602135050.593692-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6432266171118947089
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -77
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudefjedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrhhlucfvnfffucdlvdefmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepleeugfeuueejgffhfefhjeffheefkeegtdeghfefudffhfekffdvfeetleeileeinecuffhomhgrihhnpehophgvnhhpohifvghrrdighiiinecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.37.72; envelope-from=clg@kaod.org;
 helo=4.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 09:51:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 docs/system/arm/aspeed.rst | 85 ++++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |  1 +
 2 files changed, 86 insertions(+)
 create mode 100644 docs/system/arm/aspeed.rst

diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
new file mode 100644
index 000000000000..45f891eb3cad
--- /dev/null
+++ b/docs/system/arm/aspeed.rst
@@ -0,0 +1,85 @@
+Aspeed family boards (``*-bmc``, ``ast2500-evb``, ``ast2600-evb``)
+==================================================================
+
+The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
+Aspeed evaluation boards. They are based on different releases of the
+Aspeed SoC : the AST2400 integrating an ARM926EJ-S CPU (400MHz), the
+AST2500 with an ARM1176JZS CPU (800MHz) and more recently the AST2600
+with dual cores ARM Cortex A7 CPUs (1.2GHz).
+
+The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
+etc.
+
+AST2400 SoC based machines :
+
+- ``palmetto-bmc``         OpenPOWER Palmetto POWER8 BMC
+
+AST2500 SoC based machines :
+
+- ``ast2500-evb``          Aspeed AST2500 Evaluation board
+- ``romulus-bmc``          OpenPOWER Romulus POWER9 BMC
+- ``witherspoon-bmc``      OpenPOWER Witherspoon POWER9 BMC
+- ``sonorapass-bmc``       OCP SonoraPass BMC
+- ``swift-bmc``            OpenPOWER Swift BMC POWER9
+
+AST2600 SoC based machines :
+
+- ``ast2600-evb``          Aspeed AST2600 Evaluation board (Cortex A7)
+- ``tacoma-bmc``           OpenPOWER Witherspoon POWER9 AST2600 BMC
+
+Supported devices
+-----------------
+
+ * SMP (for the AST2600 Cortex-A7)
+ * Interrupt Controller (VIC)
+ * Timer Controller
+ * RTC Controller
+ * I2C Controller
+ * System Control Unit (SCU)
+ * SRAM mapping
+ * X-DMA Controller (basic interface)
+ * Static Memory Controller (SMC or FMC) - Only SPI Flash support
+ * SPI Memory Controller
+ * USB 2.0 Controller
+ * SD/MMC storage controllers
+ * SDRAM controller (dummy interface for basic settings and training)
+ * Watchdog Controller
+ * GPIO Controller (Master only)
+ * UART
+ * Ethernet controllers
+
+
+Missing devices
+---------------
+
+ * Coprocessor support
+ * ADC (out of tree implementation)
+ * PWM and Fan Controller
+ * LPC Bus Controller
+ * Slave GPIO Controller
+ * Super I/O Controller
+ * Hash/Crypto Engine
+ * PCI-Express 1 Controller
+ * Graphic Display Controller
+ * PECI Controller
+ * MCTP Controller
+ * Mailbox Controller
+ * Virtual UART
+ * eSPI Controller
+ * I3C Controller
+
+Boot options
+------------
+
+The Aspeed machines can be started using the -kernel option to load a
+Linux kernel or from a firmare image which can be downloaded from the
+OpenPOWER jenkins :
+
+   https://openpower.xyz/
+
+The image should be attached as an MTD drive. Run :
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M romulus-bmc -nic user \
+	-drive file=flash-romulus,format=raw,if=mtd -nographic
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index dce384cb0e3e..1bd477a2936c 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -81,6 +81,7 @@ undocumented; you can get a complete list by running
    arm/realview
    arm/versatile
    arm/vexpress
+   arm/aspeed
    arm/musicpal
    arm/nseries
    arm/orangepi
-- 
2.25.4


