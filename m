Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74290C2D0D1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC2124672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUuO85Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC2124672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii1B7-0002KU-Eh
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 14:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tp-0007M1-6b
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tn-0000DQ-DO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34084)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tm-00007T-UD; Thu, 19 Dec 2019 13:51:47 -0500
Received: by mail-wr1-x442.google.com with SMTP id t2so7079099wrr.1;
 Thu, 19 Dec 2019 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YyPr5A6rnL1yXh0BplYIOMYBILGoNVomOgJvBtF2zv8=;
 b=gUuO85EmTJkhrApzSOHS/sPi8S4du85fP8278KxyPehzc58JtzuXRUDCRLHkbiuvp3
 NPazvAgtkPY9ecZf5T0lc7UizXq/gbCP/e70LfomtWKylgfOUoWoig1KNrPvqKdjTVut
 kj4T5ALd+fG02eGAUgloEo/sTga7V1oWywzZXCmyYy/XtgytdRuvGZz+D0Bvf19x/EXk
 ZP/lw86I7jo9M4e6zkHA9y4I2guuaSO4Tula4t3nu6W8Foa3lL1D7/miOnbr9lrICrvB
 PYp1a7J1Pdew9MiHsTcWogWyYLKMKiqXu0FmbzU6APBcnc2YOW+zCerMqrPuxJO9fBcN
 GWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=YyPr5A6rnL1yXh0BplYIOMYBILGoNVomOgJvBtF2zv8=;
 b=bDf3O4bo4QDGUDPRcTShc3X1Di+4fJN8pA/VOFJj+25oQVS9kVzdDb3s+HU1hAYuhq
 kON0/utza1Q7536jopm/IMYZPMpHomldISpEON3E1bWNi9SlhLvmVp4nZsgphXavVr06
 268AiIu/mtNoA/hMc7Ju+Lkbts2e3X41aCDLxiCswMWIMXOTm8K84py6YIrI8A7MI8pq
 6gVXt+KFd6+7oU9h7/YbG1aa9G05qedlCitXsDvc9XoSb9Mwk+2FHyN9/5UUMHFaXlY6
 ECNYZleXvFnfdllRTPPhU1PN4xytQJ4arVr1YCaHzwaunF6ybxQrjeQxnaKMd8d94DTJ
 2K3A==
X-Gm-Message-State: APjAAAU8kHw3/qFbu1Ip0A/2901COuryXBYofBpXotztEvrM5sleL8Fg
 yw1YJW6O7qySU5Pbp/qp17TB5BC4
X-Google-Smtp-Source: APXvYqyLyNogYXoyqkJOSnD1UD2EBFCbaWURl03eELNPKujhSBXoRXU2zHSTo8NDkUW5Kqs2meGf+A==
X-Received: by 2002:a05:6000:cb:: with SMTP id
 q11mr10656214wrx.14.1576781505386; 
 Thu, 19 Dec 2019 10:51:45 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [RFC PATCH 13/13] hw/timer/allwinner: Rename functions not specific
 to the A10 SoC
Date: Thu, 19 Dec 2019 19:51:27 +0100
Message-Id: <20191219185127.24388-14-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These functions are used by different Allwinner timer controllers,
rename them.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/timer/allwinner-a10-pit.c | 52 ++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 7413f046cc..dff534cfef 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -68,7 +68,7 @@ typedef struct AllwinnerTmrCtrlClass {
 #define AW_TIMER_GET_CLASS(obj) \
      OBJECT_GET_CLASS(AllwinnerTmrCtrlClass, (obj), TYPE_AW_COMMON_PIT)
 
-static void a10_pit_update_irq(AllwinnerTmrCtrlState *s)
+static void allwinner_timer_update_irq(AllwinnerTmrCtrlState *s)
 {
     int i;
 
@@ -78,7 +78,7 @@ static void a10_pit_update_irq(AllwinnerTmrCtrlState *s)
     }
 }
 
-static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
+static uint64_t allwinner_timer_read(void *opaque, hwaddr offset, unsigned size)
 {
     AllwinnerTmrCtrlState *s = AW_TIMER_CTRL(opaque);
     uint8_t index;
@@ -125,7 +125,7 @@ static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
 }
 
 /* Must be called inside a ptimer transaction block for s->timer[idx].ptimer */
-static void a10_pit_set_freq(AllwinnerTmrCtrlState *s, int index)
+static void allwinner_ptimer_set_freq(AllwinnerTmrCtrlState *s, int index)
 {
     uint32_t prescaler, source, source_freq;
 
@@ -141,8 +141,8 @@ static void a10_pit_set_freq(AllwinnerTmrCtrlState *s, int index)
     }
 }
 
-static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
-                            unsigned size)
+static void allwinner_timer_write(void *opaque, hwaddr offset,
+                                  uint64_t value, unsigned size)
 {
      AllwinnerTmrCtrlState *s = AW_TIMER_CTRL(opaque);
      uint8_t index;
@@ -150,11 +150,11 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
     switch (offset) {
     case AW_A10_PIT_TIMER_IRQ_EN:
         s->irq_enable = value;
-        a10_pit_update_irq(s);
+        allwinner_timer_update_irq(s);
         break;
     case AW_A10_PIT_TIMER_IRQ_ST:
         s->irq_status &= ~value;
-        a10_pit_update_irq(s);
+        allwinner_timer_update_irq(s);
         break;
     case AW_A10_PIT_TIMER_BASE ... AW_A10_PIT_TIMER_BASE_END:
         index = offset & 0xf0;
@@ -164,7 +164,7 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
         case AW_A10_PIT_TIMER_CONTROL:
             s->timer[index].control = value;
             ptimer_transaction_begin(s->timer[index].ptimer);
-            a10_pit_set_freq(s, index);
+            allwinner_ptimer_set_freq(s, index);
             if (s->timer[index].control & AW_A10_PIT_TIMER_RELOAD) {
                 ptimer_set_count(s->timer[index].ptimer,
                                  s->timer[index].interval);
@@ -229,13 +229,13 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
     }
 }
 
-static const MemoryRegionOps a10_pit_ops = {
-    .read = a10_pit_read,
-    .write = a10_pit_write,
+static const MemoryRegionOps allwinner_timer_ops = {
+    .read = allwinner_timer_read,
+    .write = allwinner_timer_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static Property a10_pit_properties[] = {
+static Property allwinner_timer_properties[] = {
     DEFINE_PROP_UINT32("clk0-freq", AllwinnerTmrCtrlState, clk_freq[0], 0),
     DEFINE_PROP_UINT32("clk1-freq", AllwinnerTmrCtrlState, clk_freq[1], 0),
     DEFINE_PROP_UINT32("clk2-freq", AllwinnerTmrCtrlState, clk_freq[2], 0),
@@ -276,14 +276,14 @@ static const VMStateDescription vmstate_a10_pit = {
     }
 };
 
-static void a10_pit_reset(DeviceState *dev)
+static void allwinner_timer_reset(DeviceState *dev)
 {
     AllwinnerTmrCtrlState *s = AW_TIMER_CTRL(dev);
     uint8_t i;
 
     s->irq_enable = 0;
     s->irq_status = 0;
-    a10_pit_update_irq(s);
+    allwinner_timer_update_irq(s);
 
     for (i = 0; i < s->timer_count; i++) {
         s->timer[i].control = AW_A10_PIT_DEFAULT_CLOCK;
@@ -291,7 +291,7 @@ static void a10_pit_reset(DeviceState *dev)
         s->timer[i].count = 0;
         ptimer_transaction_begin(s->timer[i].ptimer);
         ptimer_stop(s->timer[i].ptimer);
-        a10_pit_set_freq(s, i);
+        allwinner_ptimer_set_freq(s, i);
         ptimer_transaction_commit(s->timer[i].ptimer);
     }
     s->watch_dog_mode = 0;
@@ -301,7 +301,7 @@ static void a10_pit_reset(DeviceState *dev)
     s->count_ctl = 0;
 }
 
-static void a10_pit_timer_cb(void *opaque)
+static void allwinner_ptimer_cb(void *opaque)
 {
     AllwinnerTmrState *tc = opaque;
     AllwinnerTmrCtrlState *s = tc->container;
@@ -313,11 +313,11 @@ static void a10_pit_timer_cb(void *opaque)
             ptimer_stop(s->timer[i].ptimer);
             s->timer[i].control &= ~AW_A10_PIT_TIMER_EN;
         }
-        a10_pit_update_irq(s);
+        allwinner_timer_update_irq(s);
     }
 }
 
-static void aw_pit_instance_init(Object *obj)
+static void allwinner_timer_instance_init(Object *obj)
 {
     AllwinnerTmrCtrlState *s = AW_TIMER_CTRL(obj);
     AllwinnerTmrCtrlClass *c = AW_TIMER_GET_CLASS(s);
@@ -329,8 +329,8 @@ static void aw_pit_instance_init(Object *obj)
     for (i = 0; i < s->timer_count; i++) {
         sysbus_init_irq(sbd, &s->timer[i].irq);
     }
-    memory_region_init_io(&s->iomem, OBJECT(s), &a10_pit_ops, s,
-                          TYPE_AW_COMMON_PIT, c->region_size);
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_timer_ops,
+                          s, TYPE_AW_COMMON_PIT, c->region_size);
     sysbus_init_mmio(sbd, &s->iomem);
 
     for (i = 0; i < s->timer_count; i++) {
@@ -338,7 +338,7 @@ static void aw_pit_instance_init(Object *obj)
 
         tc->container = s;
         tc->index = i;
-        s->timer[i].ptimer = ptimer_init(a10_pit_timer_cb, tc,
+        s->timer[i].ptimer = ptimer_init(allwinner_ptimer_cb, tc,
                                          PTIMER_POLICY_DEFAULT);
     }
 }
@@ -347,8 +347,8 @@ static void aw_timer_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
-    dc->reset = a10_pit_reset;
-    dc->props = a10_pit_properties;
+    dc->reset = allwinner_timer_reset;
+    dc->props = allwinner_timer_properties;
     dc->desc = "Allwinner Timer Controller";
     dc->vmsd = &vmstate_a10_pit;
 }
@@ -356,7 +356,7 @@ static void aw_timer_class_init(ObjectClass *klass, void *data)
 static const TypeInfo allwinner_pit_info = {
     .name = TYPE_AW_COMMON_PIT,
     .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_init = aw_pit_instance_init,
+    .instance_init = allwinner_timer_instance_init,
     .instance_size = sizeof(AllwinnerTmrCtrlState),
     .class_init = aw_timer_class_init,
     .class_size = sizeof(AllwinnerTmrCtrlClass),
@@ -379,10 +379,10 @@ static const TypeInfo a10_pit_info = {
     .class_init = a10_pit_class_init,
 };
 
-static void a10_register_types(void)
+static void allwinner_timer_register_types(void)
 {
     type_register_static(&allwinner_pit_info);
     type_register_static(&a10_pit_info);
 }
 
-type_init(a10_register_types);
+type_init(allwinner_timer_register_types);
-- 
2.21.0


