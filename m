Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFEEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951A42072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 14:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqF+zlwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951A42072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIgh-0000xt-TE
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 10:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbZ-0001Af-TS; Mon, 08 Jun 2020 10:18:25 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1jiIbY-0004Un-Qr; Mon, 08 Jun 2020 10:18:25 -0400
Received: by mail-pf1-x442.google.com with SMTP id b201so8625661pfb.0;
 Mon, 08 Jun 2020 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=m1uCGtly3GSrMtDLr7Rmnch/rNjW0Q7N17njNjBRd1A=;
 b=JqF+zlwMeGzD02FVVgFvP5XwptAeaQAmM3eNJSJ/Oa/kJn4X5ReMgEcZmFSWUC9DQv
 1yjzpCeKPL79Z0PLzQR9dPMZuY73GNzYgOBUJ635z3lGrWqyT/00xqt8Hj94RnDq5THB
 nrEHqIoMLf+NKUVYhH9005ul7QWzDnb868X9dbd/9i28Y9CjQ9IonvilQwDTHaiZGi97
 gz6ze6Qwltp/acQ6VVEETIymF0hwYKk8VhOhGZSI1/8F3PCXcj2GHsBb/IDih4UTnYbV
 lX9futGjVQfZr+2rJbzY0ZcN056zDtK2/u6rKkuTu2fogzMbuFd7dcyrYS9TTjsT9J/b
 lQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=m1uCGtly3GSrMtDLr7Rmnch/rNjW0Q7N17njNjBRd1A=;
 b=RNVfkN0RQficlYuFCYUOp1a2uo3mwpeOaJ4y/qbG0Giu0J0/9V1Xzk11q//AswC1Qw
 6TcQbdcsQ+4tUNOyNsMeHLioWSfzcAlkMLTlv2uafCweAuuh2pXS0NtmTymmmPf3YLZy
 sRjzqPIJ41a++iP/DsRDmgEYl7SeA95XirUayB8RyIkrCzZM7EIHsZqvgC3Ux+5PdTKX
 BtfPmSeiud7gF81ZkIYdwZp8263x21delHGaoIdwJx0iPHUkzdYopg8XJdKHyOcCM/bi
 s4KLYyNdHZtVH+UDT8BWY5jJpfqr2GFQqH8NsrcYCBeVQ87zwacxeiaNG0QBOyJNHacz
 eEjw==
X-Gm-Message-State: AOAM5302RaRRO3QsGl+67XppJCBr3cAMoxkbARQLXPq/G7gix5fgSiFH
 e8LyRn70jWoi+kKL4kAhXNs=
X-Google-Smtp-Source: ABdhPJxMMMbAZZCUv98/EgIKLSJeiH6A1JbikoF4sHy2AkbjhXTYnKJpJBD0mMC6l/KgjuXqXmk/Fw==
X-Received: by 2002:a62:cd8d:: with SMTP id o135mr21530921pfg.26.1591625903176; 
 Mon, 08 Jun 2020 07:18:23 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id b19sm7292575pft.74.2020.06.08.07.18.22
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 08 Jun 2020 07:18:22 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 06/15] hw/riscv: sifive_gpio: Add a new 'ngpio' property
Date: Mon,  8 Jun 2020 07:17:35 -0700
Message-Id: <1591625864-31494-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
References: <1591625864-31494-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Add a new property to represent the number of GPIO pins supported
by the GPIO controller.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 hw/riscv/sifive_gpio.c         | 30 +++++++++++++++++++-----------
 include/hw/riscv/sifive_gpio.h |  3 +++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/riscv/sifive_gpio.c b/hw/riscv/sifive_gpio.c
index c9cffa2..0d0fd2b 100644
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
 
diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/riscv/sifive_gpio.h
index ad915b2..cf12fcf 100644
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
-- 
2.7.4


