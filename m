Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92336C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B900208A9
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw9FC+80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B900208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2fn-0005ww-Cu
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cu-00016R-12; Sat, 29 Aug 2020 11:18:46 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cq-0005DE-Tz; Sat, 29 Aug 2020 11:18:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id t7so1819463otp.0;
 Sat, 29 Aug 2020 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PHk4R7Q6zSMZIYBl2ymJCbZkfAxRFWypEZFsLzbb1ac=;
 b=Zw9FC+80wingsKpnqxWhuoeU5nzUGOEIGyle8rurjfkyTkNo7U8nEm646GnRv9ykZm
 OLA/ZmTZXy4wVsZ/p2MEgav6e9Ieujn0SVssDSNH1+2i1OHwQq5oSDcQtrWq3+BQ1WZk
 k3T3uMA7o3Pcb9i05WquJiJibCmKHUH0/XL+95or4yg785IInPJCeidG5fMIJwqDj5m1
 xPcUL6mvJhjpknf3kVwLzB9hF5epcqZg6lspU8yAT+GhmP4a7/afLI9B9ZdePpKFCoIb
 v1nBfF3X0cPkN6NB6/YGApzIvvHGRR8RUtG+xRG8nWjN7HDmKufDxcGh5DZYCapA48+G
 oT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=PHk4R7Q6zSMZIYBl2ymJCbZkfAxRFWypEZFsLzbb1ac=;
 b=kMzYBzGKnvLlpzKT0aj0h8r8fXH2bSAdawZ1O2Wj4oPmZQYsIq5NQeYY2290qzKtba
 0IvKBW9xtGf1mr1Jhdzcju/beXGJ7U3EyJKukIuObg73OJyAe7uKWTb2Oo+YMyUlPqQW
 30waBwv8/dh1EWU4gAKH9+E4PV88xP6+3umYUSFEac+Dq9LutJiy77oyu+rWwweItvEf
 4t1Z/a7jPnjLutmwouORnA23LozHry5tkPJ9iIUaJle0/DbJIh/ZCaq5pajY3Ka5wScc
 g3EIuAunt4+0tKF2XF4feh2YvE0gu9NE8XLizNPc24P/Da9UCDtJDJuKs8DH6U9y9+M5
 AQVg==
X-Gm-Message-State: AOAM531ja+U9Rx4UL70ZbUl+Ybn50POYSqZA4XjwRHn6cXYB0oXb7txR
 hUqnQRLP+pwmfXSKTO9UEIFeuShKh18=
X-Google-Smtp-Source: ABdhPJxqLQ+IhaIOGeH7qENXqIy0ha8FBQG4nq5H/DAuBfg9/WvRuLrsSZJxLPW1HV6ZdIAxIsXRzA==
X-Received: by 2002:a05:6830:15ca:: with SMTP id
 j10mr2330710otr.2.1598714319591; 
 Sat, 29 Aug 2020 08:18:39 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id f50sm58181otf.47.2020.08.29.08.18.36
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:18:39 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 09/16] hw/dma: Add SiFive platform DMA controller emulation
Date: Sat, 29 Aug 2020 23:17:33 +0800
Message-Id: <1598714261-8320-10-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=bmeng.cn@gmail.com; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Microchip PolarFire SoC integrates a DMA engine that supports:
* Independent concurrent DMA transfers using 4 DMA channels
* Generation of interrupts on various conditions during execution
which is actually an IP reused from the SiFive FU540 chip.

This creates a model to support both polling and interrupt modes.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- change to update hw/dma/meson.build
- rename the file names to sifive_pdma.[c|h]
- update irq number to 8 per the SiFive FU540 manual
- fix the register offset for channel 1/2/3 in the read/write ops

 include/hw/dma/sifive_pdma.h |  57 ++++++++
 hw/dma/sifive_pdma.c         | 313 +++++++++++++++++++++++++++++++++++++++++++
 hw/dma/Kconfig               |   3 +
 hw/dma/meson.build           |   1 +
 4 files changed, 374 insertions(+)
 create mode 100644 include/hw/dma/sifive_pdma.h
 create mode 100644 hw/dma/sifive_pdma.c

diff --git a/include/hw/dma/sifive_pdma.h b/include/hw/dma/sifive_pdma.h
new file mode 100644
index 0000000..fb09383
--- /dev/null
+++ b/include/hw/dma/sifive_pdma.h
@@ -0,0 +1,57 @@
+/*
+ * SiFive Platform DMA emulation
+ *
+ * Copyright (c) 2020 Wind River Systems, Inc.
+ *
+ * Author:
+ *   Bin Meng <bin.meng@windriver.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef SIFIVE_PDMA_H
+#define SIFIVE_PDMA_H
+
+struct sifive_pdma_chan {
+    uint32_t control;
+    uint32_t next_config;
+    uint64_t next_bytes;
+    uint64_t next_dst;
+    uint64_t next_src;
+    uint32_t exec_config;
+    uint64_t exec_bytes;
+    uint64_t exec_dst;
+    uint64_t exec_src;
+    int state;
+};
+
+#define SIFIVE_PDMA_CHANS           4
+#define SIFIVE_PDMA_IRQS            (SIFIVE_PDMA_CHANS * 2)
+#define SIFIVE_PDMA_REG_SIZE        0x100000
+#define SIFIVE_PDMA_CHAN_NO(reg)    ((reg & (SIFIVE_PDMA_REG_SIZE - 1)) >> 12)
+
+typedef struct SiFivePDMAState {
+    SysBusDevice parent;
+    MemoryRegion iomem;
+    qemu_irq irq[SIFIVE_PDMA_IRQS];
+
+    struct sifive_pdma_chan chan[SIFIVE_PDMA_CHANS];
+} SiFivePDMAState;
+
+#define TYPE_SIFIVE_PDMA    "sifive.pdma"
+
+#define MCHP_PFSOC_DMA(obj) \
+    OBJECT_CHECK(SiFivePDMAState, (obj), TYPE_SIFIVE_PDMA)
+
+#endif /* SIFIVE_PDMA_H */
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
new file mode 100644
index 0000000..365bad9
--- /dev/null
+++ b/hw/dma/sifive_pdma.c
@@ -0,0 +1,313 @@
+/*
+ * SiFive Platform DMA emulation
+ *
+ * Copyright (c) 2020 Wind River Systems, Inc.
+ *
+ * Author:
+ *   Bin Meng <bin.meng@windriver.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 or
+ * (at your option) version 3 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "sysemu/dma.h"
+#include "hw/dma/sifive_pdma.h"
+
+#define DMA_CONTROL         0x000
+#define   CONTROL_CLAIM     BIT(0)
+#define   CONTROL_RUN       BIT(1)
+#define   CONTROL_DONE_IE   BIT(14)
+#define   CONTROL_ERR_IE    BIT(15)
+#define   CONTROL_DONE      BIT(30)
+#define   CONTROL_ERR       BIT(31)
+
+#define DMA_NEXT_CONFIG     0x004
+#define   CONFIG_REPEAT     BIT(2)
+#define   CONFIG_ORDER      BIT(3)
+#define   CONFIG_WRSZ_SHIFT 24
+#define   CONFIG_RDSZ_SHIFT 28
+#define   CONFIG_SZ_MASK    0xf
+
+#define DMA_NEXT_BYTES      0x008
+#define DMA_NEXT_DST        0x010
+#define DMA_NEXT_SRC        0x018
+#define DMA_EXEC_CONFIG     0x104
+#define DMA_EXEC_BYTES      0x108
+#define DMA_EXEC_DST        0x110
+#define DMA_EXEC_SRC        0x118
+
+enum dma_chan_state {
+    DMA_CHAN_STATE_IDLE,
+    DMA_CHAN_STATE_STARTED,
+    DMA_CHAN_STATE_ERROR,
+    DMA_CHAN_STATE_DONE
+};
+
+static void sifive_pdma_run(SiFivePDMAState *s, int ch)
+{
+    uint64_t bytes = s->chan[ch].next_bytes;
+    uint64_t dst = s->chan[ch].next_dst;
+    uint64_t src = s->chan[ch].next_src;
+    uint32_t config = s->chan[ch].next_config;
+    int wsize, rsize, size;
+    uint8_t buf[64];
+    int n;
+
+    /* do nothing if bytes to transfer is zero */
+    if (!bytes) {
+        goto error;
+    }
+
+    /*
+     * The manual does not describe how the hardware behaviors when
+     * config.wsize and config.rsize are given different values.
+     * A common case is memory to memory DMA, and in this case they
+     * are normally the same. Abort if this expectation fails.
+     */
+    wsize = (config >> CONFIG_WRSZ_SHIFT) & CONFIG_SZ_MASK;
+    rsize = (config >> CONFIG_RDSZ_SHIFT) & CONFIG_SZ_MASK;
+    if (wsize != rsize) {
+        goto error;
+    }
+
+    /*
+     * Calculate the transaction size
+     *
+     * size field is base 2 logarithm of DMA transaction size,
+     * but there is an upper limit of 64 bytes per transaction.
+     */
+    size = wsize;
+    if (size > 6) {
+        size = 6;
+    }
+    size = 1 << size;
+
+    /* the bytes to transfer should be multiple of transaction size */
+    if (bytes % size) {
+        goto error;
+    }
+
+    /* indicate a DMA transfer is started */
+    s->chan[ch].state = DMA_CHAN_STATE_STARTED;
+    s->chan[ch].control &= ~CONTROL_DONE;
+    s->chan[ch].control &= ~CONTROL_ERR;
+
+    /* load the next_ registers into their exec_ counterparts */
+    s->chan[ch].exec_config = config;
+    s->chan[ch].exec_bytes = bytes;
+    s->chan[ch].exec_dst = dst;
+    s->chan[ch].exec_src = src;
+
+    for (n = 0; n < bytes / size; n++) {
+        cpu_physical_memory_read(s->chan[ch].exec_src, buf, size);
+        cpu_physical_memory_write(s->chan[ch].exec_dst, buf, size);
+        s->chan[ch].exec_src += size;
+        s->chan[ch].exec_dst += size;
+        s->chan[ch].exec_bytes -= size;
+    }
+
+    /* indicate a DMA transfer is done */
+    s->chan[ch].state = DMA_CHAN_STATE_DONE;
+    s->chan[ch].control &= ~CONTROL_RUN;
+    s->chan[ch].control |= CONTROL_DONE;
+
+    /* reload exec_ registers if repeat is required */
+    if (s->chan[ch].next_config & CONFIG_REPEAT) {
+        s->chan[ch].exec_bytes = bytes;
+        s->chan[ch].exec_dst = dst;
+        s->chan[ch].exec_src = src;
+    }
+
+    return;
+
+error:
+    s->chan[ch].state = DMA_CHAN_STATE_ERROR;
+    s->chan[ch].control |= CONTROL_ERR;
+    return;
+}
+
+static inline void sifive_pdma_update_irq(SiFivePDMAState *s, int ch)
+{
+    bool done_ie, err_ie;
+
+    done_ie = !!(s->chan[ch].control & CONTROL_DONE_IE);
+    err_ie = !!(s->chan[ch].control & CONTROL_ERR_IE);
+
+    if (done_ie && (s->chan[ch].control & CONTROL_DONE)) {
+        qemu_irq_raise(s->irq[ch * 2]);
+    } else {
+        qemu_irq_lower(s->irq[ch * 2]);
+    }
+
+    if (err_ie && (s->chan[ch].control & CONTROL_ERR)) {
+        qemu_irq_raise(s->irq[ch * 2 + 1]);
+    } else {
+        qemu_irq_lower(s->irq[ch * 2 + 1]);
+    }
+
+    s->chan[ch].state = DMA_CHAN_STATE_IDLE;
+}
+
+static uint64_t sifive_pdma_read(void *opaque, hwaddr offset, unsigned size)
+{
+    SiFivePDMAState *s = opaque;
+    int ch = SIFIVE_PDMA_CHAN_NO(offset);
+    uint64_t val = 0;
+
+    if (ch >= SIFIVE_PDMA_CHANS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid channel no %d\n",
+                      __func__, ch);
+        return 0;
+    }
+
+    offset &= 0xfff;
+    switch (offset) {
+    case DMA_CONTROL:
+        val = s->chan[ch].control;
+        break;
+    case DMA_NEXT_CONFIG:
+        val = s->chan[ch].next_config;
+        break;
+    case DMA_NEXT_BYTES:
+        val = s->chan[ch].next_bytes;
+        break;
+    case DMA_NEXT_DST:
+        val = s->chan[ch].next_dst;
+        break;
+    case DMA_NEXT_SRC:
+        val = s->chan[ch].next_src;
+        break;
+    case DMA_EXEC_CONFIG:
+        val = s->chan[ch].exec_config;
+        break;
+    case DMA_EXEC_BYTES:
+        val = s->chan[ch].exec_bytes;
+        break;
+    case DMA_EXEC_DST:
+        val = s->chan[ch].exec_dst;
+        break;
+    case DMA_EXEC_SRC:
+        val = s->chan[ch].exec_src;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
+        break;
+    }
+
+    return val;
+}
+
+static void sifive_pdma_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    SiFivePDMAState *s = opaque;
+    int ch = SIFIVE_PDMA_CHAN_NO(offset);
+
+    if (ch >= SIFIVE_PDMA_CHANS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid channel no %d\n",
+                      __func__, ch);
+        return;
+    }
+
+    offset &= 0xfff;
+    switch (offset) {
+    case DMA_CONTROL:
+        s->chan[ch].control = value;
+
+        if (value & CONTROL_RUN) {
+            sifive_pdma_run(s, ch);
+        }
+
+        sifive_pdma_update_irq(s, ch);
+        break;
+    case DMA_NEXT_CONFIG:
+        s->chan[ch].next_config = value;
+        break;
+    case DMA_NEXT_BYTES:
+        s->chan[ch].next_bytes = value;
+        break;
+    case DMA_NEXT_DST:
+        s->chan[ch].next_dst = value;
+        break;
+    case DMA_NEXT_SRC:
+        s->chan[ch].next_src = value;
+        break;
+    case DMA_EXEC_CONFIG:
+    case DMA_EXEC_BYTES:
+    case DMA_EXEC_DST:
+    case DMA_EXEC_SRC:
+        /* these are read-only registers */
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps sifive_pdma_ops = {
+    .read = sifive_pdma_read,
+    .write = sifive_pdma_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    /* there are 32-bit and 64-bit wide registers */
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    }
+};
+
+static void sifive_pdma_realize(DeviceState *dev, Error **errp)
+{
+    SiFivePDMAState *s = MCHP_PFSOC_DMA(dev);
+    int i;
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &sifive_pdma_ops, s,
+                          TYPE_SIFIVE_PDMA, SIFIVE_PDMA_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+
+    for (i = 0; i < SIFIVE_PDMA_IRQS; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
+    }
+}
+
+static void sifive_pdma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "SiFive Platform DMA controller";
+    dc->realize = sifive_pdma_realize;
+}
+
+static const TypeInfo sifive_pdma_info = {
+    .name          = TYPE_SIFIVE_PDMA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFivePDMAState),
+    .class_init    = sifive_pdma_class_init,
+};
+
+static void sifive_pdma_register_types(void)
+{
+    type_register_static(&sifive_pdma_info);
+}
+
+type_init(sifive_pdma_register_types)
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 5c61b67..d67492d 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -20,3 +20,6 @@ config ZYNQ_DEVCFG
 
 config STP2000
     bool
+
+config SIFIVE_PDMA
+    bool
diff --git a/hw/dma/meson.build b/hw/dma/meson.build
index ff5bb37..b991d76 100644
--- a/hw/dma/meson.build
+++ b/hw/dma/meson.build
@@ -13,3 +13,4 @@ softmmu_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zdma.c'))
 softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_dma.c', 'soc_dma.c'))
 softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_dma.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_dma.c'))
+softmmu_ss.add(when: 'CONFIG_SIFIVE_PDMA', if_true: files('sifive_pdma.c'))
-- 
2.7.4


