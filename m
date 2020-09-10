Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E61C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A84FD2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BolboGPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84FD2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRJs-0000Qb-Lw
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBN-0003lh-25
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBK-0002ls-Bd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762026; x=1631298026;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8g6ysUWDe8MSOLkO84zV2OxLWGTJ+6uTo0iNbSo82Zc=;
 b=BolboGPcKZH5MwJZI4qGlpmu2NTxu9e+4XETsrWrEZCGN08vPedR/BbG
 PDlpk0QM2Bid0nQrUJQbjhTcQ/msuUcP+6fZQOZV1IHd1pjm/ITOrJB99
 4hdvZEs+/1VFE4dSXCqYyU8BrV7MBfl/s1ckR6J+gnVuftdAqR7QGjiFn
 7ZeYO+DdC7Nq779JRLygU5qCQCHl3AQWSbyFZHTUansFXDe4vVt3yKNvC
 O1y84052aTLb/CKximOBE2gQS0ccXMFtQ/eMS3GgtilnNolXFCkfrA6s8
 zhcATvhS2OHUB2v9zqJa4of4EXy9SnqWfGYuyCnGwM5nWktxZjg3cRPAf A==;
IronPort-SDR: mtFcXNe5hgeQBpbZZ9fuia8Ri2f9tH5aI3mW/EYKYsMGf36WfiZEsNpA2R3wB+kj05f1NYglwn
 ftnpLHx28O/tckB5RdrHHgipbrn8oCSa14R2lJqkVuPxfJsS1ZOdYXy6Eo8nhVEBtiF8wlxLBw
 rvmewz2ekTya2IXDriEWjpP6Xh7ADBBESL40z6mZ0Ds5L1SNEEuzeoSJWexA7fxiLY3EyBu8do
 9VyPvbzKhuEzl+JoqLL6qsyYN72eqizfQ1pcdnQEfn+Sqh4Hs3h0HuLzCBWha5AEc4bXexQzaM
 HcU=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979219"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:16 +0800
IronPort-SDR: x6T6LkLY1GRnUjCiu3GD8LYlenUcX8c2aNX6GY5S8ZHyPfqswgFUvBpD9lvYlVchBP8sV5RJQQ
 0cxhYpC3KrKA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:33 -0700
IronPort-SDR: c78/JohRjjFJBGYGHNctp96KRbfFyqknpJ9uFWusOTHC8xH19Fh45l8IG+8K8AAJ8MrKe+sBG0
 LpuM2LnMfViQ==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:16 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/30] hw/char: Add Microchip PolarFire SoC MMUART emulation
Date: Thu, 10 Sep 2020 11:09:15 -0700
Message-Id: <20200910180938.584205-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Microchip PolarFire SoC MMUART is ns16550 compatible, with some
additional registers. Create a simple MMUART model built on top
of the existing ns16550 model.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1598924352-89526-6-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/char/mchp_pfsoc_mmuart.h | 61 ++++++++++++++++++++
 hw/char/mchp_pfsoc_mmuart.c         | 86 +++++++++++++++++++++++++++++
 MAINTAINERS                         |  2 +
 hw/char/Kconfig                     |  3 +
 hw/char/meson.build                 |  1 +
 5 files changed, 153 insertions(+)
 create mode 100644 include/hw/char/mchp_pfsoc_mmuart.h
 create mode 100644 hw/char/mchp_pfsoc_mmuart.c

diff --git a/include/hw/char/mchp_pfsoc_mmuart.h b/include/hw/char/mchp_pfsoc_mmuart.h
new file mode 100644
index 0000000000..f61990215f
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
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
new file mode 100644
index 0000000000..8a002b0a19
--- /dev/null
+++ b/hw/char/mchp_pfsoc_mmuart.c
@@ -0,0 +1,86 @@
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
+    if (addr >= MCHP_PFSOC_MMUART_REG_SIZE) {
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
+    if (addr >= MCHP_PFSOC_MMUART_REG_SIZE) {
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
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 9641ed37e2..d17b08fad9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1321,7 +1321,9 @@ M: Bin Meng <bin.meng@windriver.com>
 L: qemu-riscv@nongnu.org
 S: Supported
 F: hw/riscv/microchip_pfsoc.c
+F: hw/char/mchp_pfsoc_mmuart.c
 F: include/hw/riscv/microchip_pfsoc.h
+F: include/hw/char/mchp_pfsoc_mmuart.h
 
 RX Machines
 -----------
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index b7e0e4d5fa..1d645554c7 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -52,3 +52,6 @@ config RENESAS_SCI
 
 config AVR_USART
     bool
+
+config MCHP_PFSOC_MMUART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index e888215145..ae27932d00 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -32,6 +32,7 @@ softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
 softmmu_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
 softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('sh_serial.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
+softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
-- 
2.28.0


