Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D95C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:38:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20033207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCBT0AFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20033207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzQ2-0003IX-Ba
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOs-0001Ke-QG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqzOq-0004I7-H8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 09:37:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id z13so28441235wrw.5
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5jSKi2QOxwNQ1UhTGOrIlKaL8fARM41TzI1DAZN/UMI=;
 b=bCBT0AFWnkllwtDyRzWUuM+M0aXnZeOCe7mT9y5wlQkghPOqY1b0BoCUs2JOMFzIBb
 e1JwKTF3DyVr8WggNUwObXgYk+x3JENac5lo0KOfyZi0w3psi8s0fkwGr425YdPsGUvl
 m9ROX3Pl6BW6hvB0vr8xK4KsKpCP/yPMae3drpFQNzXsfXeE1OBji52AdZX+/Bo60s5A
 JaQ8pnb9iCRERXdmTJ1C90ydSlyffj0A27XcNJsJ/A9gRhP3zpl8p1zx0nToO7EmSLql
 KBNgXvNBoEHHOj/2RNi4kphJh91SWK4qdBfECoMLNh1aZDE0XkxuvsVBU00jyEvLMpFq
 AV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5jSKi2QOxwNQ1UhTGOrIlKaL8fARM41TzI1DAZN/UMI=;
 b=gCxRKPdo/YPqjYjTDaYjDuY0D7UJ5HV1tYVrmn54GDPPBFQzbj5c/gmt8esu89rlEy
 iDRJ7FJNDPdwXKU+FxBj6PElTGRYVTlGmL0JFXHOeyWdIsODQMnXS8cKBL39CboSplSP
 eHTPEYcFZx1vyqoFEW4oa4UXPnAt4iS7PLzNbbkIxS1sZtdJN5R/JGBLV8+otgKuixik
 fjTzIzEehSwxRK9fUFLT/FZtVjpVrQ/JJIRYMSK0M7rhPF45nEtaFlbCayRZs2IoXxNj
 DhhPpV4t6FK+A6gBjcT3Y867bLLiSeVkbcDzkvHjvtMEqRv0Uktl0s88xx6ncT4SLf++
 G+Lw==
X-Gm-Message-State: AOAM530x08e6DsavXZJv7IUvK4qidb9Lvkmtk/FUZ/oL1VSINtP9nKL+
 motRmrY66PaZo9rA1wxHJVDeAryxnaQ=
X-Google-Smtp-Source: ABdhPJzi8fnfIawZfNy5CXLhyGUqiySVxve1m3tUkgJEwCdemzU9BsZc8nVPaSdxmgu9pCCyGR3RXw==
X-Received: by 2002:a05:6000:1107:: with SMTP id
 z7mr31064692wrw.355.1593697030260; 
 Thu, 02 Jul 2020 06:37:10 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p17sm10190511wma.47.2020.07.02.06.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 06:37:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] Revert "hw/intc: Add Loongson LIOINTC support"
Date: Thu,  2 Jul 2020 15:36:57 +0200
Message-Id: <20200702133701.25237-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702133701.25237-1-f4bug@amsat.org>
References: <20200702133701.25237-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhc@lemote.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Aleksandar Markovic said the "[Loongson-3 virtual platforms]
machine, for multiple reasons, will not be accepted in 5.1." [*].

As this file file is not buildable/testable neither, remove it
from the repository. Re-introducing it later with the rest of the
machine will be as easy as reverting this very commit.

This reverts commit c012e0b1f9121f3d8d2315af4dfd63084ea23faa.

[*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg718416.html

Cc: Huacai Chen <chenhc@lemote.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reported-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/intc/loongson_liointc.c | 242 -------------------------------------
 MAINTAINERS                |   1 -
 hw/intc/Kconfig            |   3 -
 hw/intc/Makefile.objs      |   1 -
 4 files changed, 247 deletions(-)
 delete mode 100644 hw/intc/loongson_liointc.c

diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
deleted file mode 100644
index 23ca51cc2e..0000000000
--- a/hw/intc/loongson_liointc.c
+++ /dev/null
@@ -1,242 +0,0 @@
-/*
- * QEMU Loongson Local I/O interrupt controler.
- *
- * Copyright (c) 2020 Jiaxun Yang <jiaxun.yang@flygoat.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <https://www.gnu.org/licenses/>.
- *
- */
-
-#include "qemu/osdep.h"
-#include "hw/sysbus.h"
-#include "qemu/module.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-
-#define D(x)
-
-#define NUM_IRQS                32
-
-#define NUM_CORES               4
-#define NUM_IPS                 4
-#define NUM_PARENTS             (NUM_CORES * NUM_IPS)
-#define PARENT_COREx_IPy(x, y)  (NUM_IPS * x + y)
-
-#define R_MAPPER_START          0x0
-#define R_MAPPER_END            0x20
-#define R_ISR                   R_MAPPER_END
-#define R_IEN                   0x24
-#define R_IEN_SET               0x28
-#define R_IEN_CLR               0x2c
-#define R_PERCORE_ISR(x)        (0x40 + 0x8 * x)
-#define R_END                   0x64
-
-#define TYPE_LOONGSON_LIOINTC "loongson.liointc"
-#define LOONGSON_LIOINTC(obj) \
-        OBJECT_CHECK(struct loongson_liointc, (obj), TYPE_LOONGSON_LIOINTC)
-
-struct loongson_liointc {
-    SysBusDevice parent_obj;
-
-    MemoryRegion mmio;
-    qemu_irq parent_irq[NUM_PARENTS];
-
-    uint8_t mapper[NUM_IRQS]; /* 0:3 for core, 4:7 for IP */
-    uint32_t isr;
-    uint32_t ien;
-    uint32_t per_core_isr[NUM_CORES];
-
-    /* state of the interrupt input pins */
-    uint32_t pin_state;
-    bool parent_state[NUM_PARENTS];
-};
-
-static void update_irq(struct loongson_liointc *p)
-{
-    uint32_t irq, core, ip;
-    uint32_t per_ip_isr[NUM_IPS] = {0};
-
-    /* level triggered interrupt */
-    p->isr = p->pin_state;
-
-    /* Clear disabled IRQs */
-    p->isr &= p->ien;
-
-    /* Clear per_core_isr */
-    for (core = 0; core < NUM_CORES; core++) {
-        p->per_core_isr[core] = 0;
-    }
-
-    /* Update per_core_isr and per_ip_isr */
-    for (irq = 0; irq < NUM_IRQS; irq++) {
-        if (!(p->isr & (1 << irq))) {
-            continue;
-        }
-
-        for (core = 0; core < NUM_CORES; core++) {
-            if ((p->mapper[irq] & (1 << core))) {
-                p->per_core_isr[core] |= (1 << irq);
-            }
-        }
-
-        for (ip = 0; ip < NUM_IPS; ip++) {
-            if ((p->mapper[irq] & (1 << (ip + 4)))) {
-                per_ip_isr[ip] |= (1 << irq);
-            }
-        }
-    }
-
-    /* Emit IRQ to parent! */
-    for (core = 0; core < NUM_CORES; core++) {
-        for (ip = 0; ip < NUM_IPS; ip++) {
-            int parent = PARENT_COREx_IPy(core, ip);
-            if (p->parent_state[parent] !=
-                (!!p->per_core_isr[core] && !!per_ip_isr[ip])) {
-                p->parent_state[parent] = !p->parent_state[parent];
-                qemu_set_irq(p->parent_irq[parent], p->parent_state[parent]);
-            }
-        }
-    }
-}
-
-static uint64_t
-liointc_read(void *opaque, hwaddr addr, unsigned int size)
-{
-    struct loongson_liointc *p = opaque;
-    uint32_t r = 0;
-
-    /* Mapper is 1 byte */
-    if (size == 1 && addr < R_MAPPER_END) {
-        r = p->mapper[addr];
-        goto out;
-    }
-
-    /* Rest is 4 byte */
-    if (size != 4 || (addr % 4)) {
-        goto out;
-    }
-
-    if (addr >= R_PERCORE_ISR(0) &&
-        addr < R_PERCORE_ISR(NUM_CORES)) {
-        int core = (addr - R_PERCORE_ISR(0)) / 4;
-        r = p->per_core_isr[core];
-        goto out;
-    }
-
-    switch (addr) {
-    case R_ISR:
-        r = p->isr;
-        break;
-    case R_IEN:
-        r = p->ien;
-        break;
-    default:
-        break;
-    }
-
-out:
-    D(qemu_log("%s: size=%d addr=%lx val=%x\n", __func__, size, addr, r));
-    return r;
-}
-
-static void
-liointc_write(void *opaque, hwaddr addr,
-          uint64_t val64, unsigned int size)
-{
-    struct loongson_liointc *p = opaque;
-    uint32_t value = val64;
-
-    D(qemu_log("%s: size=%d, addr=%lx val=%x\n", __func__, size, addr, value));
-
-    /* Mapper is 1 byte */
-    if (size == 1 && addr < R_MAPPER_END) {
-        p->mapper[addr] = value;
-        goto out;
-    }
-
-    /* Rest is 4 byte */
-    if (size != 4 || (addr % 4)) {
-        goto out;
-    }
-
-    if (addr >= R_PERCORE_ISR(0) &&
-        addr < R_PERCORE_ISR(NUM_CORES)) {
-        int core = (addr - R_PERCORE_ISR(0)) / 4;
-        p->per_core_isr[core] = value;
-        goto out;
-    }
-
-    switch (addr) {
-    case R_IEN_SET:
-        p->ien |= value;
-        break;
-    case R_IEN_CLR:
-        p->ien &= ~value;
-        break;
-    default:
-        break;
-    }
-
-out:
-    update_irq(p);
-}
-
-static const MemoryRegionOps pic_ops = {
-    .read = liointc_read,
-    .write = liointc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-    .valid = {
-        .min_access_size = 1,
-        .max_access_size = 4
-    }
-};
-
-static void irq_handler(void *opaque, int irq, int level)
-{
-    struct loongson_liointc *p = opaque;
-
-    p->pin_state &= ~(1 << irq);
-    p->pin_state |= level << irq;
-    update_irq(p);
-}
-
-static void loongson_liointc_init(Object *obj)
-{
-    struct loongson_liointc *p = LOONGSON_LIOINTC(obj);
-    int i;
-
-    qdev_init_gpio_in(DEVICE(obj), irq_handler, 32);
-
-    for (i = 0; i < NUM_PARENTS; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(obj), &p->parent_irq[i]);
-    }
-
-    memory_region_init_io(&p->mmio, obj, &pic_ops, p,
-                         "loongson.liointc", R_END);
-    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &p->mmio);
-}
-
-static const TypeInfo loongson_liointc_info = {
-    .name          = TYPE_LOONGSON_LIOINTC,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(struct loongson_liointc),
-    .instance_init = loongson_liointc_init,
-};
-
-static void loongson_liointc_register_types(void)
-{
-    type_register_static(&loongson_liointc_info);
-}
-
-type_init(loongson_liointc_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..f463b83d7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1100,7 +1100,6 @@ Loongson-3 virtual platforms
 M: Huacai Chen <chenhc@lemote.com>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 S: Maintained
-F: hw/intc/loongson_liointc.c
 
 Boston
 M: Paul Burton <pburton@wavecomp.com>
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 2ae1e89497..f562342bab 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -64,6 +64,3 @@ config OMPIC
 
 config RX_ICU
     bool
-
-config LOONGSON_LIOINTC
-    bool
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 3ac2b40fbb..a4202636d4 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -51,4 +51,3 @@ obj-$(CONFIG_MIPS_CPS) += mips_gic.o
 obj-$(CONFIG_NIOS2) += nios2_iic.o
 obj-$(CONFIG_OMPIC) += ompic.o
 obj-$(CONFIG_IBEX) += ibex_plic.o
-obj-$(CONFIG_LOONGSON_LIOINTC) += loongson_liointc.o
-- 
2.21.3


