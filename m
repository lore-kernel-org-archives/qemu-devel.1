Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E255C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:48:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3885622CAF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 12:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3885622CAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBHKX-0007Xm-Hg
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 08:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1kBHBW-0008Ax-Lh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:18 -0400
Received: from mail01.asahi-net.or.jp ([202.224.55.13]:47911)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1kBHBS-0005y5-3g
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 08:39:18 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail01.asahi-net.or.jp (Postfix) with ESMTPA id 95A8910894A;
 Thu, 27 Aug 2020 21:39:08 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id 50D301C0696;
 Thu, 27 Aug 2020 21:39:08 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/20] hw/rx/rx62n: RX62N Add MTU module
Date: Thu, 27 Aug 2020 21:38:53 +0900
Message-Id: <20200827123859.81793-15-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827123859.81793-1-ysato@users.sourceforge.jp>
References: <20200827123859.81793-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.13;
 envelope-from=ysato@users.sourceforge.jp; helo=mail01.asahi-net.or.jp
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
 hw/rx/rx62n.c         | 28 ++++++++++++++++++++++++++++
 hw/rx/Kconfig         |  1 +
 3 files changed, 32 insertions(+)

diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index f463148799..170c8cb6fc 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -28,6 +28,7 @@
 #include "hw/intc/rx_icu.h"
 #include "hw/timer/renesas_tmr8.h"
 #include "hw/timer/renesas_timer.h"
+#include "hw/timer/renesas_mtu.h"
 #include "hw/char/renesas_sci.h"
 #include "hw/rx/rx62n-cpg.h"
 #include "qemu/units.h"
@@ -45,6 +46,7 @@
 #define RX62N_NR_TMR    2
 #define RX62N_NR_CMT    2
 #define RX62N_NR_SCI    6
+#define RX62N_NR_MTU    2
 
 typedef struct RX62NClass {
     /*< private >*/
@@ -70,6 +72,7 @@ typedef struct RX62NState {
     RXICUState icu;
     RenesasTMR8State tmr[RX62N_NR_TMR];
     RenesasCMTState cmt[RX62N_NR_CMT];
+    RenesasMTU2State mtu[RX62N_NR_MTU];
     RSCIAState sci[RX62N_NR_SCI];
     RX62NCPGState cpg;
 
diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index f61383a4c2..344be846bc 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -46,6 +46,7 @@
 #define RX62N_ICU_BASE  0x00087000
 #define RX62N_TMR_BASE  0x00088200
 #define RX62N_CMT_BASE  0x00088000
+#define RX62N_MTU_BASE  0x00088600
 #define RX62N_SCI_BASE  0x00088240
 #define RX62N_CPG_BASE  0x00080010
 
@@ -55,6 +56,7 @@
  */
 #define RX62N_TMR_IRQ   174
 #define RX62N_CMT_IRQ   28
+#define RX62N_MTU_IRQ   114
 #define RX62N_SCI_IRQ   214
 
 /*
@@ -187,6 +189,30 @@ static void register_cmt(RX62NState *s, int unit)
                           qdev_get_clock_out(DEVICE(&s->cpg), ckname));
 }
 
+static void register_mtu(RX62NState *s, int unit)
+{
+    SysBusDevice *mtu;
+    int i, irqbase;
+    char ckname[16];
+
+    object_initialize_child(OBJECT(s), "mtu[*]", &s->mtu[unit],
+                            TYPE_RENESAS_MTU2);
+    mtu = SYS_BUS_DEVICE(&s->mtu[unit]);
+    qdev_prop_set_uint32(DEVICE(mtu), "unit", unit);
+
+    sysbus_mmio_map(mtu, 0, RX62N_MTU_BASE + 0x100 + unit * 0x400);
+    sysbus_mmio_map(mtu, 1, RX62N_MTU_BASE + unit * 0x400);
+    sysbus_mmio_map(mtu, 2, RX62N_MTU_BASE + 0x280 + unit * 0x400);
+    irqbase = RX62N_MTU_IRQ + MTU_NR_IRQ * unit;
+    for (i = 0; i < MTU_NR_IRQ; i++) {
+        sysbus_connect_irq(mtu, i, s->irq[irqbase + i]);
+    }
+    sysbus_realize(mtu, &error_abort);
+    snprintf(ckname, sizeof(ckname), "pck_mtu-%d", unit);
+    qdev_connect_clock_in(DEVICE(mtu), "pck",
+                          qdev_get_clock_out(DEVICE(&s->cpg), ckname));
+}
+
 static void register_sci(RX62NState *s, int unit)
 {
     SysBusDevice *sci;
@@ -248,6 +274,8 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
     register_tmr(s, 1);
     register_cmt(s, 0);
     register_cmt(s, 1);
+    register_mtu(s, 0);
+    register_mtu(s, 1);
     register_sci(s, 0);
     sysbus_realize(SYS_BUS_DEVICE(&s->cpg), &error_abort);
 }
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index d1812870ea..887a5782bb 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -4,6 +4,7 @@ config RX62N_MCU
     select RENESAS_TMR8
     select RENESAS_TIMER
     select RENESAS_SCI
+    select RENESAS_MTU
 
 config RX_GDBSIM
     bool
-- 
2.20.1


