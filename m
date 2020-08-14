Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E032C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:52:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57E85204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSfxL/1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E85204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cwi-00017j-Kw
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:52:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cmA-0008Hf-1f; Fri, 14 Aug 2020 12:41:54 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cm7-0002jD-H7; Fri, 14 Aug 2020 12:41:53 -0400
Received: by mail-pl1-x644.google.com with SMTP id y6so4426268plt.3;
 Fri, 14 Aug 2020 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=adiYZFq8zyrROf6pqRS8afgeUZ7H+MCq0abcua8JyKM=;
 b=jSfxL/1JCLTrP7oj99CrcMCoaWiwV81XvwxGPycJS4hjqMPr+cKkK9o13onFsRYltm
 HMn3vuALmLr1yGiMzQbvD5Ut87dE9uqmVD4VdTZdolXEUMhvv5VI7qpE/EF323hmwI8b
 q5wjplC5i/8YB4Bq8XgFQ4LsJmU+ImLA04dxty/YhwdAt9GkkbDor3U6BMoYlWHGwHhi
 FUDJTJIs7cEP4+N4OWU8wMtWr6JrwqnA8b+9Y336XA35CiGypzXalTvsfW/p/lWcBSvL
 LgfeQUC12nJR7D1qfks0p32Zu3DM/JfnKcxJb7+t2El+tXgljHHWoMKczPtxN1Rdp0FK
 bXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=adiYZFq8zyrROf6pqRS8afgeUZ7H+MCq0abcua8JyKM=;
 b=shELQmUkMz2uSLnr/dolHgQFjYLkuLCNxky0QV9uE7/MxDpinWjz0J3e7uJo5nc5Pg
 iOG/YvwXfP99MLEw9B4sRrZA4u4xKhOFi8GsZ3Lwv8O0HQ1zybvI4BhFdDpIyFzZXIPr
 AJ/ajOmBnrKfsxpKBSRFr89skpIn+g2wq8+e4ZPKjNE8i6BPjJUwzWqeLYo7SUmV9xA9
 u4Qyq3XHuTiLQ0IVwr5ulUgXwZG+U8QJJOFQjNA234w/smdpD2s5aw6t2ir/3NfJnWCL
 ceMFWzVatsr1qDcMxa76Vu5EbUv9Ypz6OHUVbmGM+zBOkd+x5G1VGEKY27gr4PmtThp8
 jTKg==
X-Gm-Message-State: AOAM531qg9REC86GUqNoa6F7O9EqWrQ8c0R+/QAguoDZ9OlvIkz5qiS4
 o5PHi0VRRau/YGjjoaj/yjgMhvl+7EYUlEIO
X-Google-Smtp-Source: ABdhPJwEC8XAhdsoR6a04H87jshIW3MbHM4BRbF8G6lKuiSSKqY0//Li9MS72MQIQsT0D61IMeAfRA==
X-Received: by 2002:a17:90a:154e:: with SMTP id
 y14mr3054827pja.178.1597423309942; 
 Fri, 14 Aug 2020 09:41:49 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:49 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 12/18] hw/dma: Add Microchip PolarFire Soc DMA controller
 emulation
Date: Sat, 15 Aug 2020 00:40:50 +0800
Message-Id: <1597423256-14847-13-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pl1-x644.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Microchip PolarFire SoC integrates a DMA engine that supports:
* Independent concurrent DMA transfers using 4 DMA channels
* Generation of interrupts on various conditions during execution

This creates a simple model to support polling mode which is
enough for firmware usage. While there are codes for interrupts
handling, please note the interrupt path has not been validated
due to missing kernel driver for testing as of now.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 MAINTAINERS                     |   2 +
 hw/dma/Kconfig                  |   3 +
 hw/dma/Makefile.objs            |   1 +
 hw/dma/mchp_pfsoc_dma.c         | 322 ++++++++++++++++++++++++++++++++++++++++
 include/hw/dma/mchp_pfsoc_dma.h |  57 +++++++
 5 files changed, 385 insertions(+)
 create mode 100644 hw/dma/mchp_pfsoc_dma.c
 create mode 100644 include/hw/dma/mchp_pfsoc_dma.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e51edac..0aacc90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1320,8 +1320,10 @@ L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
+F: hw/dma/mchp_pfsoc_dma.c
 F: include/hw/riscv/microchip_pfsoc.h
 F: include/hw/char/mchp_pfsoc_mmuart.h
+F: include/hw/dma/mchp_pfsoc_dma.h
 
 RX Machines
 -----------
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 5c61b67..778e20b 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -20,3 +20,6 @@ config ZYNQ_DEVCFG
 
 config STP2000
     bool
+
+config MCHP_PFSOC_DMA
+    bool
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index f4b1cfe..fd7e836 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -14,3 +14,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zdma.o
 common-obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
 common-obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
 common-obj-$(CONFIG_RASPI) += bcm2835_dma.o
+common-obj-$(CONFIG_MCHP_PFSOC_DMA) += mchp_pfsoc_dma.o
diff --git a/hw/dma/mchp_pfsoc_dma.c b/hw/dma/mchp_pfsoc_dma.c
new file mode 100644
index 0000000..8531a6f
--- /dev/null
+++ b/hw/dma/mchp_pfsoc_dma.c
@@ -0,0 +1,322 @@
+/*
+ * Microchip PolarFire SoC DMA emulation
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
+#include "hw/dma/mchp_pfsoc_dma.h"
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
+static void mchp_pfsoc_dma_run(MchpPfSoCDMAState *s, int ch)
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
+    /* inidate a DMA transfer is started */
+    s->chan[ch].state = DMA_CHAN_STATE_STARTED;
+    s->chan[ch].control |= CONTROL_CLAIM;
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
+    /* inidate a DMA transfer is done */
+    s->chan[ch].state = DMA_CHAN_STATE_DONE;
+    s->chan[ch].control &= ~CONTROL_CLAIM;
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
+static inline void mchp_pfsoc_dma_update_irq(MchpPfSoCDMAState *s, int ch)
+{
+    bool done_ie, err_ie;
+
+    done_ie = !!(s->chan[ch].control & CONTROL_DONE_IE);
+    err_ie = !!(s->chan[ch].control & CONTROL_ERR_IE);
+
+    /*
+     * Todo:
+     *
+     * It's unclear from the manual when the interrupt will be lowered.
+     * It might be that the ISR reads the status bits and writes 1 to clear,
+     * Right now there is no driver that uses ISR to validate this guess.
+     *
+     * Also the manual does not clear describe how the 2 interrupt lines
+     * are routed to PLIC hence we assume only 1 line for now.
+     */
+    if ((done_ie && (s->chan[ch].control & CONTROL_DONE)) ||
+        (err_ie && (s->chan[ch].control & CONTROL_ERR))) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+
+    s->chan[ch].state = DMA_CHAN_STATE_IDLE;
+}
+
+static uint64_t mchp_pfsoc_dma_read(void *opaque, hwaddr offset, unsigned size)
+{
+    MchpPfSoCDMAState *s = opaque;
+    int no = MCHP_PFSOC_DMA_CHAN_NO(offset);
+    uint64_t val = 0;
+
+    if (no >= MCHP_PFSOC_DMA_CHANS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid channel no %d\n",
+                      __func__, no);
+        return 0;
+    }
+
+    switch (offset) {
+    case DMA_CONTROL:
+        val = s->chan[no].control;
+        break;
+    case DMA_NEXT_CONFIG:
+        val = s->chan[no].next_config;
+        break;
+    case DMA_NEXT_BYTES:
+        val = s->chan[no].next_bytes;
+        break;
+    case DMA_NEXT_DST:
+        val = s->chan[no].next_dst;
+        break;
+    case DMA_NEXT_SRC:
+        val = s->chan[no].next_src;
+        break;
+    case DMA_EXEC_CONFIG:
+        val = s->chan[no].exec_config;
+        break;
+    case DMA_EXEC_BYTES:
+        val = s->chan[no].exec_bytes;
+        break;
+    case DMA_EXEC_DST:
+        val = s->chan[no].exec_dst;
+        break;
+    case DMA_EXEC_SRC:
+        val = s->chan[no].exec_src;
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
+static void mchp_pfsoc_dma_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    MchpPfSoCDMAState *s = opaque;
+    int no = MCHP_PFSOC_DMA_CHAN_NO(offset);
+
+    if (no >= MCHP_PFSOC_DMA_CHANS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid channel no %d\n",
+                      __func__, no);
+        return;
+    }
+
+    switch (offset) {
+    case DMA_CONTROL:
+        s->chan[no].control = value;
+
+        if (value & CONTROL_CLAIM) {
+            s->chan[no].next_config = 0;
+            s->chan[no].next_bytes = 0;
+            s->chan[no].next_dst = 0;
+            s->chan[no].next_src = 0;
+            s->chan[no].control &= ~CONTROL_CLAIM;
+        }
+
+        if (value & CONTROL_RUN) {
+            mchp_pfsoc_dma_run(s, no);
+        }
+
+        mchp_pfsoc_dma_update_irq(s, no);
+        break;
+    case DMA_NEXT_CONFIG:
+        s->chan[no].next_config = value;
+        break;
+    case DMA_NEXT_BYTES:
+        s->chan[no].next_bytes = value;
+        break;
+    case DMA_NEXT_DST:
+        s->chan[no].next_dst = value;
+        break;
+    case DMA_NEXT_SRC:
+        s->chan[no].next_src = value;
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
+static const MemoryRegionOps mchp_pfsoc_dma_ops = {
+    .read = mchp_pfsoc_dma_read,
+    .write = mchp_pfsoc_dma_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    /* there are 32-bit and 64-bit wide registers */
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    }
+};
+
+static void mchp_pfsoc_dma_realize(DeviceState *dev, Error **errp)
+{
+    MchpPfSoCDMAState *s = MCHP_PFSOC_DMA(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(dev), &mchp_pfsoc_dma_ops, s,
+                          "mchp.pfsoc.dma", MCHP_PFSOC_DMA_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+}
+
+static void mchp_pfsoc_dma_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Microchip PolarFire SoC DMA controller";
+    dc->realize = mchp_pfsoc_dma_realize;
+}
+
+static const TypeInfo mchp_pfsoc_dma_info = {
+    .name          = TYPE_MCHP_PFSOC_DMA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MchpPfSoCDMAState),
+    .class_init    = mchp_pfsoc_dma_class_init,
+};
+
+static void mchp_pfsoc_dma_register_types(void)
+{
+    type_register_static(&mchp_pfsoc_dma_info);
+}
+
+type_init(mchp_pfsoc_dma_register_types)
diff --git a/include/hw/dma/mchp_pfsoc_dma.h b/include/hw/dma/mchp_pfsoc_dma.h
new file mode 100644
index 0000000..e474f67
--- /dev/null
+++ b/include/hw/dma/mchp_pfsoc_dma.h
@@ -0,0 +1,57 @@
+/*
+ * Microchip PolarFire SoC DMA emulation
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
+#ifndef MCHP_PFSOC_DMA_H
+#define MCHP_PFSOC_DMA_H
+
+struct mchp_pfsoc_dma_chan {
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
+#define MCHP_PFSOC_DMA_CHANS        4
+#define MCHP_PFSOC_DMA_REG_SIZE     0x100000
+#define MCHP_PFSOC_DMA_CHAN_NO(reg) \
+        ((reg & (MCHP_PFSOC_DMA_REG_SIZE - 1)) >> 12)
+
+typedef struct MchpPfSoCDMAState {
+    SysBusDevice parent;
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    struct mchp_pfsoc_dma_chan chan[MCHP_PFSOC_DMA_CHANS];
+} MchpPfSoCDMAState;
+
+#define TYPE_MCHP_PFSOC_DMA "mchp.pfsoc.dma"
+
+#define MCHP_PFSOC_DMA(obj) \
+    OBJECT_CHECK(MchpPfSoCDMAState, (obj), TYPE_MCHP_PFSOC_DMA)
+
+#endif /* MCHP_PFSOC_DMA_H */
-- 
2.7.4


