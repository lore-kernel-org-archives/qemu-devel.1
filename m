Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC59C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980E62177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980E62177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHFT-0007ue-SM
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBS-000800-RF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:14 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:39222)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBO-0005wU-AR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:14 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 5EA3D26A0D;
 Thu, 27 Aug 2020 21:39:09 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 167771C0792;
 Thu, 27 Aug 2020 21:39:09 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/20] hw/rx/rx62n: Add Ethernet support.
Date: Thu, 27 Aug 2020 21:38:56 +0900
Message-Id: <20200827123859.81793-18-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.15;
 envelope-from=ysato@users.sourceforge.jp; helo=mail03.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 08:39:06
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/rx/rx62n.h |  3 +++
 hw/rx/rx62n.c         | 26 ++++++++++++++++++++++++++
 hw/rx/Kconfig         |  3 ++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 170c8cb6fc..4f11ca3fd9 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -30,6 +30,7 @@
 #include "hw/timer/renesas_timer.h"
 #include "hw/timer/renesas_mtu.h"
 #include "hw/char/renesas_sci.h"
+#include "hw/net/renesas_eth.h"
 #include "hw/rx/rx62n-cpg.h"
 #include "qemu/units.h"
 
@@ -74,6 +75,8 @@ typedef struct RX62NState {
     RenesasCMTState cmt[RX62N_NR_CMT];
     RenesasMTU2State mtu[RX62N_NR_MTU];
     RSCIAState sci[RX62N_NR_SCI];
+    RenesasEthState ether;
+    MDIOState *mdio;
     RX62NCPGState cpg;
 
     MemoryRegion *sysmem;
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 344be846bc..8b41cdf90c 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -28,6 +28,7 @@
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-properties.h"
+#include "hw/net/mdio.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/qtest.h"
 #include "cpu.h"
@@ -48,6 +49,8 @@
 #define RX62N_CMT_BASE  0x00088000
 #define RX62N_MTU_BASE  0x00088600
 #define RX62N_SCI_BASE  0x00088240
+#define RX62N_EDMAC_BASE 0x000c0000
+#define RX62N_ETHER_BASE 0x000c0100
 #define RX62N_CPG_BASE  0x00080010
 
 /*
@@ -58,6 +61,7 @@
 #define RX62N_CMT_IRQ   28
 #define RX62N_MTU_IRQ   114
 #define RX62N_SCI_IRQ   214
+#define RX62N_EDMAC_IRQ 32
 
 /*
  * IRQ -> IPR mapping table
@@ -236,6 +240,25 @@ static void register_sci(RX62NState *s, int unit)
                           qdev_get_clock_out(DEVICE(&s->cpg), ckname));
 }
 
+static void register_eth(RX62NState *s, NICInfo *nd)
+{
+    SysBusDevice *etherc;
+
+    qemu_check_nic_model(nd, TYPE_RENESAS_ETH);
+    object_initialize_child(OBJECT(s), "ether",
+                            &s->ether, TYPE_RENESAS_ETH);
+    etherc = SYS_BUS_DEVICE(&s->ether);
+    qdev_set_nic_properties(DEVICE(etherc), nd);
+    object_property_set_link(OBJECT(etherc), "mdio",
+                             OBJECT(s->mdio), &error_abort);
+    sysbus_realize(etherc, &error_abort);
+    sysbus_connect_irq(etherc, 0, s->irq[RX62N_EDMAC_IRQ]);
+    sysbus_mmio_map(etherc, 0, RX62N_ETHER_BASE);
+    sysbus_mmio_map(etherc, 1, RX62N_EDMAC_BASE);
+    qdev_connect_clock_in(DEVICE(etherc), "ick",
+                          qdev_get_clock_out(DEVICE(&s->cpg), "ick_edmac"));
+}
+
 static void register_cpg(RX62NState *s)
 {
     SysBusDevice *cpg;
@@ -277,6 +300,7 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
     register_mtu(s, 0);
     register_mtu(s, 1);
     register_sci(s, 0);
+    register_eth(s, nd_table);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpg), &error_abort);
 }
 
@@ -284,6 +308,8 @@ static Property rx62n_properties[] = {
     DEFINE_PROP_LINK("main-bus", RX62NState, sysmem, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_UINT32("xtal-frequency-hz", RX62NState, xtal_freq_hz, 0),
+    DEFINE_PROP_LINK("mdiodev", RX62NState, mdio, TYPE_ETHER_MDIO_BB,
+                     MDIOState *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index 887a5782bb..f20ea63fd9 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -3,8 +3,9 @@ config RX62N_MCU
     select RX_ICU
     select RENESAS_TMR8
     select RENESAS_TIMER
-    select RENESAS_SCI
     select RENESAS_MTU
+    select RENESAS_SCI
+    select RENESAS_ETH
 
 config RX_GDBSIM
     bool
-- 
2.20.1


