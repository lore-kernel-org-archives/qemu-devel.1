Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501CDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:14:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C86B20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="msg7rmZU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C86B20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKaW-0008C9-4r
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUN-0000qk-9T
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:39 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUH-0004Ps-8A
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586458; x=1624122458;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oPLJE6KNzWJHMq3vdNFTZOYl4tq3PNDGEUzIW+NYt6w=;
 b=msg7rmZUeywedDCNSzZNarK1dTE0biOSgHtOhoxINYSfPL7AV92jhqtx
 VIFc9tf/LSUmBqroIVBz0MTL1/BmglZn3hrxuPHtsjbCIMehXlzXi/y02
 TPTuh7xyh5d8y3Oxv2hpX4FeraRNPYW3mKdtJBbsegDFYAdQwMUI6Izzj
 sGaGH406u9r6hExJXsjq9LMaJrpw7Km/HCm2GTiNv68230RZmDqbS6YxV
 4eJBsYKTLCWleV6JWOt+z6FPNnL1TcRMW3OcJ0GGZG6aUWB4r6+azeO8y
 vPAMynwBOVqR8z/c+wXs572Sgu+pepRiJvaX48AY3s/oeXIiT0gN1HPu2 A==;
IronPort-SDR: qYS1kLBW/isHgeHtXzsW6CFm/w21SLd6sW6RQUeIJZE4T31H6Ib22oDPL4GFD6S0fTMEoRCimr
 55wlkHp/4npN6vYBuiNoK98KBV73r0FWhrae9X/UrC66xxY1mzKvRRNIEU8xPYT1weeUF669Ye
 DFwl/eZ75jc8DeeOE8WQgIXGVSopHSqhcudl3/vvpIg5KGiVjqjWkd2NERacQr8sn22BAQlpuv
 IlQ5myB2pNZjJlQAbzsE1Fjtv5kG5gZA2zYJYBGa9sBx2fNv4dox57cqqGSCC13FXCQg2/i/VX
 x0A=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417007"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:28 +0800
IronPort-SDR: E62XRyNfRXlvkN8oWxTo6mhMPG1CtROk66TX3Jam2XmJt948NLqDpodf/xlDvOFS9mSNR0h/iq
 yaUq6W6ev83yIlDCz2iql/OkspJsWwC14=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:03 -0700
IronPort-SDR: IL3tNfyim1hKFCi9NsZDOLE/GJGY911phuibiJqFnWRuSxtvKVzEWaf+q9wOYnddXim6azv8zA
 66A9xUUjf/kg==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:27 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 22/32] hw/riscv: sifive_gpio: Add a new 'ngpio' property
Date: Fri, 19 Jun 2020 09:58:07 -0700
Message-Id: <20200619165817.4144200-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Add a new property to represent the number of GPIO pins supported
by the GPIO controller.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-7-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-7-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_gpio.h |  3 +++
 hw/riscv/sifive_gpio.c         | 30 +++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpio.h
index ad915b26d6..cf12fcfd62 100644
--- a/include/hw/riscv/sifive_gpio.h
+++ b/include/hw/riscv/sifive_gpio.h
@@ -68,6 +68,9 @@ typedef struct SIFIVEGPIOState {
     uint32_t out_xor;
     uint32_t in;
     uint32_t in_mask;
+
+    /* config */
+    uint32_t ngpio;
 } SIFIVEGPIOState;
 
 #endif /* SIFIVE_GPIO_H */
diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index c9cffa2eba..0d0fd2ba5e 100644
--- a/hw/riscv/sifive_gpio.c
+++ b/hw/riscv/sifive_gpio.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/riscv/sifive_gpio.h"
 #include "migration/vmstate.h"
 #include "trace.h"
@@ -28,7 +29,7 @@ static void update_output_irq(SIFIVEGPIOState *s)
     pending |= s->rise_ip & s->rise_ie;
     pending |= s->fall_ip & s->fall_ie;
 
-    for (int i = 0; i < SIFIVE_GPIO_PINS; i++) {
+    for (int i = 0; i < s->ngpio; i++) {
         pin = 1 << i;
         qemu_set_irq(s->irq[i], (pending & pin) != 0);
         trace_sifive_gpio_update_output_irq(i, (pending & pin) != 0);
@@ -41,7 +42,7 @@ static void update_state(SIFIVEGPIOState *s)
     bool prev_ival, in, in_mask, port, out_xor, pull, output_en, input_en,
         rise_ip, fall_ip, low_ip, high_ip, oval, actual_value, ival;
 
-    for (i = 0; i < SIFIVE_GPIO_PINS; i++) {
+    for (i = 0; i < s->ngpio; i++) {
 
         prev_ival = extract32(s->value, i, 1);
         in        = extract32(s->in, i, 1);
@@ -346,27 +347,35 @@ static const VMStateDescription vmstate_sifive_gpio = {
     }
 };
 
-static void sifive_gpio_init(Object *obj)
+static Property sifive_gpio_properties[] = {
+    DEFINE_PROP_UINT32("ngpio", SIFIVEGPIOState, ngpio, SIFIVE_GPIO_PINS),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sifive_gpio_realize(DeviceState *dev, Error **errp)
 {
-    SIFIVEGPIOState *s = SIFIVE_GPIO(obj);
+    SIFIVEGPIOState *s = SIFIVE_GPIO(dev);
 
-    memory_region_init_io(&s->mmio, obj, &gpio_ops, s,
+    memory_region_init_io(&s->mmio, OBJECT(dev), &gpio_ops, s,
             TYPE_SIFIVE_GPIO, SIFIVE_GPIO_SIZE);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 
-    for (int i = 0; i < SIFIVE_GPIO_PINS; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    for (int i = 0; i < s->ngpio; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
     }
 
-    qdev_init_gpio_in(DEVICE(s), sifive_gpio_set, SIFIVE_GPIO_PINS);
-    qdev_init_gpio_out(DEVICE(s), s->output, SIFIVE_GPIO_PINS);
+    qdev_init_gpio_in(DEVICE(s), sifive_gpio_set, s->ngpio);
+    qdev_init_gpio_out(DEVICE(s), s->output, s->ngpio);
 }
 
 static void sifive_gpio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    device_class_set_props(dc, sifive_gpio_properties);
     dc->vmsd = &vmstate_sifive_gpio;
+    dc->realize = sifive_gpio_realize;
     dc->reset = sifive_gpio_reset;
     dc->desc = "SiFive GPIO";
 }
@@ -375,7 +384,6 @@ static const TypeInfo sifive_gpio_info = {
     .name = TYPE_SIFIVE_GPIO,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(SIFIVEGPIOState),
-    .instance_init = sifive_gpio_init,
     .class_init = sifive_gpio_class_init
 };
 
-- 
2.27.0


