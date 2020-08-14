Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC98C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:46:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460432078D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgprchOO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460432078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cqg-0007n2-HQ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cll-0007GK-3l; Fri, 14 Aug 2020 12:41:29 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1k6cli-0002e5-TE; Fri, 14 Aug 2020 12:41:28 -0400
Received: by mail-pj1-x1043.google.com with SMTP id t6so4642752pjr.0;
 Fri, 14 Aug 2020 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0qEo1hz0I8O6710IYplEt/yoyn+bJ3u/IgwuYdEDrVY=;
 b=HgprchOOxSAq9t7AQQpZnAUj7R44U0HhBsvNew1fbxK73xYE66vC3v5MgqAsmi8Okd
 EbYwgSToTTzsRDIrK5n23ARQdzYtt7DyrkeVtYDOq26aSrXps7pzFwHzL2I7/tP8PMug
 /22x58ggm6DMnOm0Ovkeh9Ybe9rZDeqYVzZxgNSPiLyAyimDJBLBGP/B1tmP7eSBVaZa
 8wTitRhXHiAZKShZ0o+dAs85+RUu2uemiLqgIPoxeqpHYxCoz8JXa+4+wX3+GxgzPiSR
 MogtZOg25oxRWe4HhSVj5bIuI/GdaP2W2g3EmAQ4o6tEqppPU1DugkMqE7ODAyHNpPEV
 0kqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0qEo1hz0I8O6710IYplEt/yoyn+bJ3u/IgwuYdEDrVY=;
 b=NknpJqkcH/xXiMg7MId92cK4pfUmGrvPlU1hwDBi2sf/7UOiQkdbQzKu7nW9QF9Bjq
 fbmQOMZ3Iq68Tk8j3aSB0t3Ml+t5AQQ0puDLiUHFlWONQMqxoQ2qVlcxzy631ki/PUgh
 n5Nw+xj8pVVmoSnsHhvPZqrUplRFRGAY+Hl1PlV8jfD5UplQ43GBtU7SD5eWjYlK9eHz
 ccKEuszyocFCbvfE6/Go8TLUbgm3kWcV/qPwrKXHhzTIuTTXYo9r3XS1uJqNbHorKGN/
 dgXTMrc7K6v5NXV8A/rekdAw+7EK11cVG3xDJnNxj9mft/LvDU1BZ8Qpcsb8FGGxUhk2
 bSCg==
X-Gm-Message-State: AOAM533+rK+j/DUW1NI8HZLK5ePEDjkwOf1Kuu48GKZaTKr92f19pkFF
 3l/AyvwgYaFMDCjWK+jmBLI=
X-Google-Smtp-Source: ABdhPJwzf6wMP46rS13dixdwkfHUMX+wj0MZPvMfjai0UCSFL25g6qCJtt4PgfH0+GbdZ/Nf0n4nCA==
X-Received: by 2002:a17:902:834a:: with SMTP id
 z10mr2685889pln.5.1597423285312; 
 Fri, 14 Aug 2020 09:41:25 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id 16sm9836332pfi.161.2020.08.14.09.41.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:41:24 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 05/18] hw/char: Add Microchip PolarFire SoC MMUART emulation
Date: Sat, 15 Aug 2020 00:40:43 +0800
Message-Id: <1597423256-14847-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
References: <1597423256-14847-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1043.google.com
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

Microchip PolarFire SoC MMUART is ns16550 compatible, with some
additional registers. Create a simple MMUART model built on top
of the existing ns16550 model.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 MAINTAINERS                         |  2 +
 hw/char/Kconfig                     |  3 ++
 hw/char/Makefile.objs               |  1 +
 hw/char/mchp_pfsoc_mmuart.c         | 82 +++++++++++++++++++++++++++++++++++++
 include/hw/char/mchp_pfsoc_mmuart.h | 61 +++++++++++++++++++++++++++
 5 files changed, 149 insertions(+)
 create mode 100644 hw/char/mchp_pfsoc_mmuart.c
 create mode 100644 include/hw/char/mchp_pfsoc_mmuart.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8716cb6..e51edac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1319,7 +1319,9 @@ M: Bin Meng <bin.meng@windriver.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/microchip_pfsoc.c
+F: hw/char/mchp_pfsoc_mmuart.c
 F: include/hw/riscv/microchip_pfsoc.h
+F: include/hw/char/mchp_pfsoc_mmuart.h
 
 RX Machines
 -----------
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index b7e0e4d..1d64555 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -52,3 +52,6 @@ config RENESAS_SCI
 
 config AVR_USART
     bool
+
+config MCHP_PFSOC_MMUART
+    bool
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index bf177ac..f705845 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -33,6 +33,7 @@ common-obj-$(CONFIG_LM32) += lm32_juart.o
 common-obj-$(CONFIG_LM32) += lm32_uart.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-uart.o
 common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
+common-obj-$(CONFIG_MCHP_PFSOC_MMUART) += mchp_pfsoc_mmuart.o
 
 obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
 obj-$(CONFIG_PSERIES) += spapr_vty.o
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
new file mode 100644
index 0000000..9984acc
--- /dev/null
+++ b/hw/char/mchp_pfsoc_mmuart.c
@@ -0,0 +1,82 @@
+/*
+ * Microchip PolarFire SoC MMUART emulation
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
+#include "qemu/log.h"
+#include "chardev/char.h"
+#include "exec/address-spaces.h"
+#include "hw/char/mchp_pfsoc_mmuart.h"
+
+static uint64_t mchp_pfsoc_mmuart_read(void *opaque, hwaddr addr, unsigned size)
+{
+    MchpPfSoCMMUartState *s = opaque;
+
+    if ((addr % sizeof(uint32_t)) || (addr >= 0x34)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        return 0;
+    }
+
+    return s->reg[addr / sizeof(uint32_t)];
+}
+
+static void mchp_pfsoc_mmuart_write(void *opaque, hwaddr addr,
+                                    uint64_t value, unsigned size)
+{
+    MchpPfSoCMMUartState *s = opaque;
+    uint32_t val32 = (uint32_t)value;
+
+    if ((addr % sizeof(uint32_t)) || (addr >= 0x34)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%" HWADDR_PRIx
+                      " v=0x%x\n", __func__, addr, val32);
+        return;
+    }
+
+    s->reg[addr / sizeof(uint32_t)] = val32;
+}
+
+static const MemoryRegionOps mchp_pfsoc_mmuart_ops = {
+    .read = mchp_pfsoc_mmuart_read,
+    .write = mchp_pfsoc_mmuart_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(MemoryRegion *sysmem,
+    hwaddr base, qemu_irq irq, Chardev *chr)
+{
+    MchpPfSoCMMUartState *s;
+
+    s = g_new0(MchpPfSoCMMUartState, 1);
+
+    memory_region_init_io(&s->iomem, NULL, &mchp_pfsoc_mmuart_ops, s,
+                          "mchp.pfsoc.mmuart", 0x1000);
+
+    s->base = base;
+    s->irq = irq;
+
+    s->serial = serial_mm_init(sysmem, base, 2, irq, 399193, chr,
+                               DEVICE_LITTLE_ENDIAN);
+
+    memory_region_add_subregion(sysmem, base + 0x20, &s->iomem);
+
+    return s;
+}
diff --git a/include/hw/char/mchp_pfsoc_mmuart.h b/include/hw/char/mchp_pfsoc_mmuart.h
new file mode 100644
index 0000000..f619902
--- /dev/null
+++ b/include/hw/char/mchp_pfsoc_mmuart.h
@@ -0,0 +1,61 @@
+/*
+ * Microchip PolarFire SoC MMUART emulation
+ *
+ * Copyright (c) 2020 Wind River Systems, Inc.
+ *
+ * Author:
+ *   Bin Meng <bin.meng@windriver.com>
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
+#ifndef HW_MCHP_PFSOC_MMUART_H
+#define HW_MCHP_PFSOC_MMUART_H
+
+#include "hw/char/serial.h"
+
+#define MCHP_PFSOC_MMUART_REG_SIZE  52
+
+typedef struct MchpPfSoCMMUartState {
+    MemoryRegion iomem;
+    hwaddr base;
+    qemu_irq irq;
+
+    SerialMM *serial;
+
+    uint32_t reg[MCHP_PFSOC_MMUART_REG_SIZE / sizeof(uint32_t)];
+} MchpPfSoCMMUartState;
+
+/**
+ * mchp_pfsoc_mmuart_create - Create a Microchip PolarFire SoC MMUART
+ *
+ * This is a helper routine for board to create a MMUART device that is
+ * compatible with Microchip PolarFire SoC.
+ *
+ * @sysmem: system memory region to map
+ * @base: base address of the MMUART registers
+ * @irq: IRQ number of the MMUART device
+ * @chr: character device to associate to
+ *
+ * @return: a pointer to the device specific control structure
+ */
+MchpPfSoCMMUartState *mchp_pfsoc_mmuart_create(MemoryRegion *sysmem,
+    hwaddr base, qemu_irq irq, Chardev *chr);
+
+#endif /* HW_MCHP_PFSOC_MMUART_H */
-- 
2.7.4


