Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB76C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE4042071A
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 19:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcXYumDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE4042071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpGsf-00043T-23
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 15:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGrf-0002Ox-Dn
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:51 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:42889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jpGrb-0003uJ-Rs
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 15:51:51 -0400
Received: by mail-ed1-x533.google.com with SMTP id z17so9469711edr.9
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=64eDVR5Sna6gcF5BUI1E9LG+Hd4AD5Rm3+MS+ZxvZvw=;
 b=rcXYumDHgxhMEGk1J3ufNd+PQZqlx6iAW+/XhotH/hR+Ze8t/cmBdbeOwJcVnG+0xd
 uRAH7Cyaa6C/IQg6/gyR/WkN382iyWErT0ts/uX4W5rG+t35od18o57rnm4l8L2CzsEh
 jMNFdF+c8YJ1WN283jT9KuColXaI+rqJIFFMqxIingRgqSGlj2HzWYi8zSSnpyanN1ha
 XoqSxFGQZMo5/ErJhyzcmL8TgMKZJW8RghJMXfe0KA/MG4iBkwZahzD8It3kb8mpm1cl
 oZJL5pysgwPBfNa5mlu1e+2NtAg94OeJj5x9m9wLM1KTn2FJ8jlk4UsApYzKEKHNA5EM
 p6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=64eDVR5Sna6gcF5BUI1E9LG+Hd4AD5Rm3+MS+ZxvZvw=;
 b=ayunfi7ZQh5ZcE4+ilQqPLTYZIBDOfA+5vUPEYsbKXQlpI7qfAywDG7ErXDpf5omxF
 RrTusnhRhl40/sZZFHtZfbLiAlo9mgbn16H7j0oUxnaB2aZFLvoysIQ9MtlVQquDTwWO
 PI48KG7n8MCt3r3jw145ArAKia2aZI0yyyZ9rzRUy3X27IwBa+6RqbNL5FnECM3WSs6o
 ncpgl/DK72RLy2jh9l+Z8MljlY1q0Cpc2Lr9Td21WSwyOYYgzfGPAkDbaJehq2zoPUrH
 aVe8kP/hfdSoCU0NJV1Gm+xqig1+uoRtZvc8KdWYbjSa3mfakzxghFI6hevlhMna57/I
 100w==
X-Gm-Message-State: AOAM531/Re3bX5lFO/WbuA0G0pceZkUdSfzjWJhmhT+ELPgP/d0uiqwE
 snCOHJPEMBuUcgmTvwlHoHKx/Lkt
X-Google-Smtp-Source: ABdhPJy1uw9hmdhoHqgEH1uACUYh0Lx+RBffCjM4C9eS/1Xyln6W9KJFWaFFZfzlPMKe7dfRDAGdNA==
X-Received: by 2002:aa7:c808:: with SMTP id a8mr6768572edt.259.1593287505880; 
 Sat, 27 Jun 2020 12:51:45 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id y11sm5298734ejw.63.2020.06.27.12.51.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jun 2020 12:51:45 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 2/6] hw/intc: Add Loongson LIOINTC support
Date: Sat, 27 Jun 2020 21:51:39 +0200
Message-Id: <1593287503-25197-3-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1593287503-25197-1-git-send-email-aleksandar.qemu.devel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-ed1-x533.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Huacai Chen <zltjiangshi@gmail.com>

Loongson-3 has an integrated liointc (Local I/O Interrupt Controller).
It is similar to Goldfish interrupt controller, but more powerful (e.g.,
it can route external interrupt to multi-cores).

Documents about Loongson-3's liointc:
1, https://wiki.godson.ac.cn/ip_block:liointc;
2, The "I/O中断" section of Loongson-3's user mannual, part 1.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <1592995531-32600-3-git-send-email-chenhc@lemote.com>
---
 hw/intc/loongson_liointc.c | 242 +++++++++++++++++++++++++++++++++++++++++++++
 hw/intc/Kconfig            |   3 +
 hw/intc/Makefile.objs      |   1 +
 3 files changed, 246 insertions(+)
 create mode 100644 hw/intc/loongson_liointc.c

diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
new file mode 100644
index 0000000..23ca51c
--- /dev/null
+++ b/hw/intc/loongson_liointc.c
@@ -0,0 +1,242 @@
+/*
+ * QEMU Loongson Local I/O interrupt controler.
+ *
+ * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <https://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "qemu/module.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+
+#define D(x)
+
+#define NUM_IRQS                32
+
+#define NUM_CORES               4
+#define NUM_IPS                 4
+#define NUM_PARENTS             (NUM_CORES * NUM_IPS)
+#define PARENT_COREx_IPy(x, y)  (NUM_IPS * x + y)
+
+#define R_MAPPER_START          0x0
+#define R_MAPPER_END            0x20
+#define R_ISR                   R_MAPPER_END
+#define R_IEN                   0x24
+#define R_IEN_SET               0x28
+#define R_IEN_CLR               0x2c
+#define R_PERCORE_ISR(x)        (0x40 + 0x8 * x)
+#define R_END                   0x64
+
+#define TYPE_LOONGSON_LIOINTC "loongson.liointc"
+#define LOONGSON_LIOINTC(obj) \
+        OBJECT_CHECK(struct loongson_liointc, (obj), TYPE_LOONGSON_LIOINTC)
+
+struct loongson_liointc {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    qemu_irq parent_irq[NUM_PARENTS];
+
+    uint8_t mapper[NUM_IRQS]; /* 0:3 for core, 4:7 for IP */
+    uint32_t isr;
+    uint32_t ien;
+    uint32_t per_core_isr[NUM_CORES];
+
+    /* state of the interrupt input pins */
+    uint32_t pin_state;
+    bool parent_state[NUM_PARENTS];
+};
+
+static void update_irq(struct loongson_liointc *p)
+{
+    uint32_t irq, core, ip;
+    uint32_t per_ip_isr[NUM_IPS] = {0};
+
+    /* level triggered interrupt */
+    p->isr = p->pin_state;
+
+    /* Clear disabled IRQs */
+    p->isr &= p->ien;
+
+    /* Clear per_core_isr */
+    for (core = 0; core < NUM_CORES; core++) {
+        p->per_core_isr[core] = 0;
+    }
+
+    /* Update per_core_isr and per_ip_isr */
+    for (irq = 0; irq < NUM_IRQS; irq++) {
+        if (!(p->isr & (1 << irq))) {
+            continue;
+        }
+
+        for (core = 0; core < NUM_CORES; core++) {
+            if ((p->mapper[irq] & (1 << core))) {
+                p->per_core_isr[core] |= (1 << irq);
+            }
+        }
+
+        for (ip = 0; ip < NUM_IPS; ip++) {
+            if ((p->mapper[irq] & (1 << (ip + 4)))) {
+                per_ip_isr[ip] |= (1 << irq);
+            }
+        }
+    }
+
+    /* Emit IRQ to parent! */
+    for (core = 0; core < NUM_CORES; core++) {
+        for (ip = 0; ip < NUM_IPS; ip++) {
+            int parent = PARENT_COREx_IPy(core, ip);
+            if (p->parent_state[parent] !=
+                (!!p->per_core_isr[core] && !!per_ip_isr[ip])) {
+                p->parent_state[parent] = !p->parent_state[parent];
+                qemu_set_irq(p->parent_irq[parent], p->parent_state[parent]);
+            }
+        }
+    }
+}
+
+static uint64_t
+liointc_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    struct loongson_liointc *p = opaque;
+    uint32_t r = 0;
+
+    /* Mapper is 1 byte */
+    if (size == 1 && addr < R_MAPPER_END) {
+        r = p->mapper[addr];
+        goto out;
+    }
+
+    /* Rest is 4 byte */
+    if (size != 4 || (addr % 4)) {
+        goto out;
+    }
+
+    if (addr >= R_PERCORE_ISR(0) &&
+        addr < R_PERCORE_ISR(NUM_CORES)) {
+        int core = (addr - R_PERCORE_ISR(0)) / 4;
+        r = p->per_core_isr[core];
+        goto out;
+    }
+
+    switch (addr) {
+    case R_ISR:
+        r = p->isr;
+        break;
+    case R_IEN:
+        r = p->ien;
+        break;
+    default:
+        break;
+    }
+
+out:
+    D(qemu_log("%s: size=%d addr=%lx val=%x\n", __func__, size, addr, r));
+    return r;
+}
+
+static void
+liointc_write(void *opaque, hwaddr addr,
+          uint64_t val64, unsigned int size)
+{
+    struct loongson_liointc *p = opaque;
+    uint32_t value = val64;
+
+    D(qemu_log("%s: size=%d, addr=%lx val=%x\n", __func__, size, addr, value));
+
+    /* Mapper is 1 byte */
+    if (size == 1 && addr < R_MAPPER_END) {
+        p->mapper[addr] = value;
+        goto out;
+    }
+
+    /* Rest is 4 byte */
+    if (size != 4 || (addr % 4)) {
+        goto out;
+    }
+
+    if (addr >= R_PERCORE_ISR(0) &&
+        addr < R_PERCORE_ISR(NUM_CORES)) {
+        int core = (addr - R_PERCORE_ISR(0)) / 4;
+        p->per_core_isr[core] = value;
+        goto out;
+    }
+
+    switch (addr) {
+    case R_IEN_SET:
+        p->ien |= value;
+        break;
+    case R_IEN_CLR:
+        p->ien &= ~value;
+        break;
+    default:
+        break;
+    }
+
+out:
+    update_irq(p);
+}
+
+static const MemoryRegionOps pic_ops = {
+    .read = liointc_read,
+    .write = liointc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4
+    }
+};
+
+static void irq_handler(void *opaque, int irq, int level)
+{
+    struct loongson_liointc *p = opaque;
+
+    p->pin_state &= ~(1 << irq);
+    p->pin_state |= level << irq;
+    update_irq(p);
+}
+
+static void loongson_liointc_init(Object *obj)
+{
+    struct loongson_liointc *p = LOONGSON_LIOINTC(obj);
+    int i;
+
+    qdev_init_gpio_in(DEVICE(obj), irq_handler, 32);
+
+    for (i = 0; i < NUM_PARENTS; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &p->parent_irq[i]);
+    }
+
+    memory_region_init_io(&p->mmio, obj, &pic_ops, p,
+                         "loongson.liointc", R_END);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &p->mmio);
+}
+
+static const TypeInfo loongson_liointc_info = {
+    .name          = TYPE_LOONGSON_LIOINTC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(struct loongson_liointc),
+    .instance_init = loongson_liointc_init,
+};
+
+static void loongson_liointc_register_types(void)
+{
+    type_register_static(&loongson_liointc_info);
+}
+
+type_init(loongson_liointc_register_types)
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index f562342..2ae1e89 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -64,3 +64,6 @@ config OMPIC
 
 config RX_ICU
     bool
+
+config LOONGSON_LIOINTC
+    bool
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index a420263..3ac2b40 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -51,3 +51,4 @@ obj-$(CONFIG_MIPS_CPS) += mips_gic.o
 obj-$(CONFIG_NIOS2) += nios2_iic.o
 obj-$(CONFIG_OMPIC) += ompic.o
 obj-$(CONFIG_IBEX) += ibex_plic.o
+obj-$(CONFIG_LOONGSON_LIOINTC) += loongson_liointc.o
-- 
2.7.4


