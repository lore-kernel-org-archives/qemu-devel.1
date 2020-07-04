Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C54C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 19:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD655207D4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 19:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD655207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tribudubois.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnbf-0007Qj-Vm
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 15:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jrnat-0005mC-Pf
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 15:12:59 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1jrnas-0002EK-8E
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 15:12:59 -0400
X-Originating-IP: 90.127.194.69
Received: from jcd-UX305CA.home (lfbn-idf1-1-2027-69.w90-127.abo.wanadoo.fr
 [90.127.194.69]) (Authenticated sender: jcd@tribudubois.net)
 by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4769D20008;
 Sat,  4 Jul 2020 19:12:55 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, peter.chubb@nicta.com.au,
 f4bug@amsat.org
Subject: [PATCH v2 2/3] Add the ability to change the FEC PHY MDIO device
 number on i.MX6 processor
Date: Sat,  4 Jul 2020 21:12:44 +0200
Message-ID: <05a64e83eb1c0c865ac077b22c599425c024c02c.1593806826.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1593806826.git.jcd@tribudubois.net>
References: <cover.1593806826.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.70.183.200; envelope-from=jcd@tribudubois.net;
 helo=relay7-d.mail.gandi.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 14:54:37
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
Message-ID: <20200704191244.o_7TDz75U6HCU3TvLqMaHW8NOdL85uVEs24UsjdGG6Y@z>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---

 v2: same patch after pull request from peter is validated.

 hw/arm/fsl-imx6.c         | 7 +++++++
 include/hw/arm/fsl-imx6.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 4ae3c3efc28..0721f333497 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -402,6 +402,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             spi_table[i].irq));
     }
 
+    object_property_set_uint(OBJECT(&s->eth), s->phy_num, "phy-num", &err);
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
     sysbus_realize(SYS_BUS_DEVICE(&s->eth), &err);
     if (err) {
@@ -476,10 +477,16 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->ocram_alias);
 }
 
+static Property fsl_imx6_properties[] = {
+    DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void fsl_imx6_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx6_properties);
     dc->realize = fsl_imx6_realize;
     dc->desc = "i.MX6 SOC";
     /* Reason: Uses serial_hd() in the realize() function */
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 1ebd7513246..162fe99375d 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -73,6 +73,7 @@ typedef struct FslIMX6State {
     MemoryRegion   caam;
     MemoryRegion   ocram;
     MemoryRegion   ocram_alias;
+    uint32_t       phy_num;
 } FslIMX6State;
 
 
-- 
2.25.1


