Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BBDC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59C18206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 09:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C18206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDxZ-0003Ln-F9
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 05:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kBDwh-0001hb-CU; Thu, 27 Aug 2020 05:11:47 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:42149)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1kBDwe-0001zk-8y; Thu, 27 Aug 2020 05:11:47 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.44])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 21B9954810E7;
 Thu, 27 Aug 2020 11:11:34 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 27 Aug
 2020 11:11:32 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G0037ad0b0ec-b560-4631-aafb-8b451044cef8,
 618CF37EF0508A6B3BD090B4D8B11E595DDBE7AA) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/2] m25p80: Add the n25q256a SFDP table
Date: Thu, 27 Aug 2020 11:11:30 +0200
Message-ID: <20200827091130.3525790-3-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200827091130.3525790-1-clg@kaod.org>
References: <20200827091130.3525790-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 5532ed18-4329-496b-b1f1-afc464dcf5aa
X-Ovh-Tracer-Id: 8702361857402047340
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgedguddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheehfeegjeeitdfffeetjeduveejueefuefgtdefueelueetveeliefhhffgtdelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 05:11:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The same values were collected on 4 differents OpenPower systems,
palmettos, romulus and tacoma.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/block/m25p80_sfdp.h |  2 ++
 hw/block/m25p80.c      |  6 ++++--
 hw/block/m25p80_sfdp.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 hw/block/Makefile.objs |  2 +-
 4 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100644 hw/block/m25p80_sfdp.c

diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
index b75fd0b0c13f..ca2658a676e0 100644
--- a/hw/block/m25p80_sfdp.h
+++ b/hw/block/m25p80_sfdp.h
@@ -12,4 +12,6 @@
 
 #define M25P80_SFDP_AREA_SIZE 0x100
 
+extern const uint8_t m25p80_sfdp_n25q256a[M25P80_SFDP_AREA_SIZE];
+
 #endif
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 32925589ec7a..d053bdbb2805 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -233,11 +233,13 @@ static const FlashPartInfo known_devices[] = {
     { INFO("n25q128a11",  0x20bb18,      0,  64 << 10, 256, ER_4K) },
     { INFO("n25q128a13",  0x20ba18,      0,  64 << 10, 256, ER_4K) },
     { INFO("n25q256a11",  0x20bb19,      0,  64 << 10, 512, ER_4K) },
-    { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K) },
+    { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K),
+      .sfdp = m25p80_sfdp_n25q256a },
     { INFO("n25q512a11",  0x20bb20,      0,  64 << 10, 1024, ER_4K) },
     { INFO("n25q512a13",  0x20ba20,      0,  64 << 10, 1024, ER_4K) },
     { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
-    { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
+    { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K),
+      .sfdp = m25p80_sfdp_n25q256a },
     { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
     { INFO_STACKED("n25q00",    0x20ba21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
     { INFO_STACKED("n25q00a",   0x20bb21, 0x1000, 64 << 10, 2048, ER_4K, 4) },
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
new file mode 100644
index 000000000000..def94bd4ea02
--- /dev/null
+++ b/hw/block/m25p80_sfdp.c
@@ -0,0 +1,49 @@
+/*
+ * M25P80 Serial Flash Discoverable Parameter (SFDP)
+ *
+ * Copyright (c) 2020, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "m25p80_sfdp.h"
+
+/*
+ * Micron
+ */
+const uint8_t m25p80_sfdp_n25q256a[M25P80_SFDP_AREA_SIZE] = {
+    0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x00, 0xff,
+    0x00, 0x00, 0x01, 0x09, 0x30, 0x00, 0x00, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xe5, 0x20, 0xfb, 0xff, 0xff, 0xff, 0xff, 0x0f,
+    0x29, 0xeb, 0x27, 0x6b, 0x08, 0x3b, 0x27, 0xbb,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x27, 0xbb,
+    0xff, 0xff, 0x29, 0xeb, 0x0c, 0x20, 0x10, 0xd8,
+    0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+};
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 8855c2265639..b65a12c52b52 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-y += block.o cdrom.o hd-geometry.o
 common-obj-$(CONFIG_FDC) += fdc.o
-common-obj-$(CONFIG_SSI_M25P80) += m25p80.o
+common-obj-$(CONFIG_SSI_M25P80) += m25p80.o m25p80_sfdp.o
 common-obj-$(CONFIG_NAND) += nand.o
 common-obj-$(CONFIG_PFLASH_CFI01) += pflash_cfi01.o
 common-obj-$(CONFIG_PFLASH_CFI02) += pflash_cfi02.o
-- 
2.25.4


