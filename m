Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2866C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD44120772
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD44120772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrS6s-00052g-Up
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jrS5z-0003lX-0L
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 16:15:39 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jrS5x-00010e-9O
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 16:15:38 -0400
X-Originating-IP: 82.252.130.88
Received: from localhost.localdomain (lns-bzn-59-82-252-130-88.adsl.proxad.net
 [82.252.130.88]) (Authenticated sender: jcd@tribudubois.net)
 by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C3B901BF20B;
 Fri,  3 Jul 2020 20:15:34 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au,
 f4bug@amsat.org
Subject: [PATCH 3/3] Add the ability to change the FEC PHY MDIO devices
 numbers on i.MX7 processor
Date: Fri,  3 Jul 2020 22:15:17 +0200
Message-Id: <c850187322be9930e47c8b234c385a7d0da245cb.1593806826.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1593806826.git.jcd@tribudubois.net>
References: <cover.1593806826.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.70.183.201; envelope-from=jcd@tribudubois.net;
 helo=relay8-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 16:15:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/arm/fsl-imx7.c         | 9 +++++++++
 include/hw/arm/fsl-imx7.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index b49d895a412..5dbf0e500aa 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -364,6 +364,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_ENET2_ADDR,
         };
 
+        object_property_set_uint(OBJECT(&s->eth[i]), s->phy_num[i],
+                                 "phy-num", &error_abort);
         object_property_set_uint(OBJECT(&s->eth[i]), FSL_IMX7_ETH_NUM_TX_RINGS,
                                  "tx-ring-num", &error_abort);
         qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
@@ -551,10 +553,17 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                 FSL_IMX7_PCIE_PHY_SIZE);
 }
 
+static Property fsl_imx7_properties[] = {
+    DEFINE_PROP_UINT32("fec1-phy-num", FslIMX7State, phy_num[0], 0),
+    DEFINE_PROP_UINT32("fec2-phy-num", FslIMX7State, phy_num[1], 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void fsl_imx7_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx7_properties);
     dc->realize = fsl_imx7_realize;
 
     /* Reason: Uses serial_hds and nd_table in realize() directly */
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index da977f9ffb4..ad889237077 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -81,6 +81,7 @@ typedef struct FslIMX7State {
     IMX7GPRState       gpr;
     ChipideaState      usb[FSL_IMX7_NUM_USBS];
     DesignwarePCIEHost pcie;
+    uint32_t           phy_num[FSL_IMX7_NUM_ETHS];
 } FslIMX7State;
 
 enum FslIMX7MemoryMap {
-- 
2.25.1


