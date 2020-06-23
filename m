Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420FBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A78620716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC8vsTm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A78620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhvA-0001Ir-BF
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jnhoD-0001SG-HB
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:13:49 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jnho9-0004Re-Ox
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 08:13:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id j4so9050329plk.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vDU3X+taTS/YwEP9AAI4BFFyXzhZAMScdjTJslNEy7U=;
 b=mC8vsTm60qb7VcaWc2MHfd4u+IufvevLmuwILBieQbi2OJ3BxNn/GJiOEgbQ4EJX/t
 MD3UBGB5+qT/35bDFv29saDHDira9meKRM0q19L0wo15I7/NTryFJT7GgcXaoz4XMBG8
 lo3Es0MOlKjx6QXCaHpoBJ+bvQIpRjfvQIEk9AfksXcHO+oMxCLF8hFmtE3uk5CJuFWR
 j9/Npquz3YQagl6iVbztv+GWETrCErg4ORJmQ/98hc5tDW5G8kB/PsfUKj4OFP3K7hl7
 IFCMZppPjo3a6Dq+HmVA0ic9j+Mw2V7JH+s4BqsGO8cziDSnCWsrXJglVVDKW8ity4Zj
 xsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vDU3X+taTS/YwEP9AAI4BFFyXzhZAMScdjTJslNEy7U=;
 b=AWpCn8wmZE4Dg9XGHR+vG5xz7oTN9ONkD/kir4ffNLd7o/kijOuURc49ngWT5aUcIV
 ThxfZbBlscV2UQEJrYv3mt8AWVK1iPkOqb2zv2rIyf+Nnt4HWwjKFy0Q2XI4xTiB96ue
 DnGHV+Yg3+8r1LgtJP3yqYo4K6EIfbVrbknTlCS2M0VzOP/9UKiQ7UjTNM2ioLPA04oQ
 p04UIwvhjVaQTg7bduz8xoVnhD0JqfXF4El8toACrMb2V9M3qfVRDOaUPDP1ZlK4eJ/Q
 72rZRiwSjsQo8n30OnBmcaeMqG00XSl4IA5fmE2ojGB6vFb4awtB+tfa7gA8e/xg3BWK
 +P5w==
X-Gm-Message-State: AOAM533p2A6RoDDiIpZ+2Rmn8tynQoZEjbYDBX3hLvq+uw9BxxHmgbjb
 V0ntkYc2uZnoSfebf0gQ7cc=
X-Google-Smtp-Source: ABdhPJx2ysMvL2uGA8XGEXBi70DhkqCp/C/W8oCU4EzAMqrt07iBN04p9WYTeJ0kYWCLTNKe3I75aA==
X-Received: by 2002:a17:90b:252:: with SMTP id
 fz18mr21381148pjb.96.1592914424333; 
 Tue, 23 Jun 2020 05:13:44 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id m18sm17022782pfo.173.2020.06.23.05.13.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jun 2020 05:13:43 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V5 2/4] hw/intc: Add Loongson liointc support
Date: Tue, 23 Jun 2020 20:13:56 +0800
Message-Id: <1592914438-30317-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
References: <1592914438-30317-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3 has an integrated liointc (Local I/O interrupt controller).
It is similar to goldfish interrupt controller, but more powerful (e.g.,
it can route external interrupt to multi-cores).

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/intc/Kconfig            |   3 +
 hw/intc/Makefile.objs      |   1 +
 hw/intc/loongson_liointc.c | 246 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 250 insertions(+)
 create mode 100644 hw/intc/loongson_liointc.c

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index a189d6f..264d82d 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -61,3 +61,6 @@ config S390_FLIC_KVM
 
 config OMPIC
     bool
+
+config LOONGSON_LIOINTC
+    bool
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index a61e672..9a26fbe 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -50,3 +50,4 @@ obj-$(CONFIG_MIPS_CPS) += mips_gic.o
 obj-$(CONFIG_NIOS2) += nios2_iic.o
 obj-$(CONFIG_OMPIC) += ompic.o
 obj-$(CONFIG_IBEX) += ibex_plic.o
+obj-$(CONFIG_LOONGSON_LIOINTC) += loongson_liointc.o
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
new file mode 100644
index 0000000..d4c1b48
--- /dev/null
+++ b/hw/intc/loongson_liointc.c
@@ -0,0 +1,246 @@
+/*
+ * QEMU Loongson Local I/O interrupt controler.
+ *
+ * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
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
+#define NUM_IRQS    32
+
+#define NUM_CORES   4
+#define NUM_IPS     4
+#define NUM_PARENTS (NUM_CORES * NUM_IPS)
+#define PARENT_COREx_IPy(x, y)    (NUM_IPS * x + y)
+
+#define R_MAPPER_START    0x0
+#define R_MAPPER_END      0x20
+#define R_ISR           R_MAPPER_END
+#define R_IEN           0x24
+#define R_IEN_SET       0x28
+#define R_IEN_CLR       0x2c
+#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)
+#define R_END           0x64
+
+#define TYPE_LOONGSON_LIOINTC "loongson.liointc"
+#define LOONGSON_LIOINTC(obj) OBJECT_CHECK(struct loongson_liointc, (obj), TYPE_LOONGSON_LIOINTC)
+
+struct loongson_liointc
+{
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
+	    if (p->parent_state[parent] !=
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
-- 
2.7.0


