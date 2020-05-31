Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43360C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:25:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E2020723
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E2020723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfQmN-0005fo-9K
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:25:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1jfQlL-0004DM-Jb
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:39 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:48260)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jfQlJ-0004KS-Uh
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:24:39 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 0A2EDECD3D;
 Mon,  1 Jun 2020 01:24:35 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by sakura.ysato.name (Postfix) with ESMTPSA id B56F71C0DB3;
 Mon,  1 Jun 2020 01:24:34 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] hw/sh4: Convert to renesas_timer.c
Date: Mon,  1 Jun 2020 01:24:26 +0900
Message-Id: <20200531162427.57410-10-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200531162427.57410-1-ysato@users.sourceforge.jp>
References: <20200531162427.57410-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=202.224.55.15;
 envelope-from=ysato@users.sourceforge.jp; helo=mail03.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 12:24:33
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Using unified TMU/CMT module.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/sh4/sh.h    | 10 ---------
 hw/sh4/sh7750.c        | 47 +++++++++++++++++++++++++++++++++---------
 hw/sh4/Kconfig         |  2 +-
 hw/timer/Makefile.objs |  1 -
 4 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/include/hw/sh4/sh.h b/include/hw/sh4/sh.h
index e184b4b300..248cc052e1 100644
--- a/include/hw/sh4/sh.h
+++ b/include/hw/sh4/sh.h
@@ -28,16 +28,6 @@ typedef struct {
 
 int sh7750_register_io_device(struct SH7750State *s,
 			      sh7750_io_device * device);
-/* sh_timer.c */
-#define TMU012_FEAT_TOCR   (1 << 0)
-#define TMU012_FEAT_3CHAN  (1 << 1)
-#define TMU012_FEAT_EXTCLK (1 << 2)
-void tmu012_init(struct MemoryRegion *sysmem, hwaddr base,
-                 int feat, uint32_t freq,
-		 qemu_irq ch0_irq, qemu_irq ch1_irq,
-		 qemu_irq ch2_irq0, qemu_irq ch2_irq1);
-
-
 /* sh7750.c */
 qemu_irq sh7750_irl(struct SH7750State *s);
 
diff --git a/hw/sh4/sh7750.c b/hw/sh4/sh7750.c
index 150d3029f7..733c4009e1 100644
--- a/hw/sh4/sh7750.c
+++ b/hw/sh4/sh7750.c
@@ -32,6 +32,7 @@
 #include "sh7750_regnames.h"
 #include "hw/sh4/sh_intc.h"
 #include "hw/char/renesas_sci.h"
+#include "hw/timer/renesas_timer.h"
 #include "hw/qdev-properties.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
@@ -756,13 +757,13 @@ static const MemoryRegionOps sh7750_mmct_ops = {
 };
 
 static void sh_serial_init(SH7750State *s, MemoryRegion *sysmem,
-                    hwaddr base, int feat,
-                    uint32_t freq, Chardev *chr,
-                    qemu_irq eri_source,
-                    qemu_irq rxi_source,
-                    qemu_irq txi_source,
-                    qemu_irq tei_source,
-                    qemu_irq bri_source)
+                           hwaddr base, int feat,
+                           uint32_t freq, Chardev *chr,
+                           qemu_irq eri_source,
+                           qemu_irq rxi_source,
+                           qemu_irq txi_source,
+                           qemu_irq tei_source,
+                           qemu_irq bri_source)
 {
     DeviceState *dev;
     SysBusDevice *sci;
@@ -789,6 +790,31 @@ static void sh_serial_init(SH7750State *s, MemoryRegion *sysmem,
     }
 }
 
+static void tmu012_init(SH7750State *s, MemoryRegion *sysmem, hwaddr base,
+                        int feat, uint32_t freq,
+                        qemu_irq ch0_irq, qemu_irq ch1_irq,
+                        qemu_irq ch2_irq0, qemu_irq ch2_irq1)
+{
+    DeviceState *dev;
+    SysBusDevice *tmu;
+
+    dev = qdev_create(NULL, TYPE_RENESAS_TIMER);
+
+    tmu = SYS_BUS_DEVICE(dev);
+
+    qdev_prop_set_uint64(dev, "input-freq", freq);
+    qdev_prop_set_int32(dev, "feature", feat);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(tmu, 0, base);
+    sysbus_mmio_map(tmu, 1, P4ADDR(base));
+    sysbus_mmio_map(tmu, 2, A7ADDR(base));
+    sysbus_connect_irq(tmu, 0, ch0_irq);
+    sysbus_connect_irq(tmu, 1, ch1_irq);
+    if (ch2_irq0) {
+        sysbus_connect_irq(tmu, 2, ch2_irq0);
+    }
+}
+
 SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
 {
     SH7750State *s;
@@ -853,8 +879,8 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
                    NULL,
                    s->intc.irqs[SCIF_BRI]);
 
-    tmu012_init(sysmem, 0x1fd80000,
-		TMU012_FEAT_TOCR | TMU012_FEAT_3CHAN | TMU012_FEAT_EXTCLK,
+    tmu012_init(s, sysmem, 0x1fd80000,
+                RTIMER_FEAT_TMU_LOW,
 		s->periph_freq,
 		s->intc.irqs[TMU0],
 		s->intc.irqs[TMU1],
@@ -877,7 +903,8 @@ SH7750State *sh7750_init(SuperHCPU *cpu, MemoryRegion *sysmem)
         sh_intc_register_sources(&s->intc,
 				 _INTC_ARRAY(vectors_tmu34),
 				 NULL, 0);
-        tmu012_init(sysmem, 0x1e100000, 0, s->periph_freq,
+        tmu012_init(s, sysmem, 0x1e100000,
+                    RTIMER_FEAT_TMU_HIGH, s->periph_freq,
 		    s->intc.irqs[TMU3],
 		    s->intc.irqs[TMU4],
 		    NULL, NULL);
diff --git a/hw/sh4/Kconfig b/hw/sh4/Kconfig
index 38509b7e65..ac21830bb5 100644
--- a/hw/sh4/Kconfig
+++ b/hw/sh4/Kconfig
@@ -21,5 +21,5 @@ config SH7750
 
 config SH4
     bool
-    select PTIMER
+    select RENESAS_TIMER
     select RENESAS_SCI
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 289b6b03ab..f3918836e4 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -22,7 +22,6 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
 common-obj-$(CONFIG_OMAP) += omap_gptimer.o
 common-obj-$(CONFIG_OMAP) += omap_synctimer.o
 common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
-common-obj-$(CONFIG_SH4) += sh_timer.o
 common-obj-$(CONFIG_DIGIC) += digic-timer.o
 common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
 
-- 
2.20.1


