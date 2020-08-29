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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CE2C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:22:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A3420707
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJaZki/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A3420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC2gl-0000EE-6t
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 11:22:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cf-0000hD-EK; Sat, 29 Aug 2020 11:18:29 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:46866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kC2cb-0005BJ-V5; Sat, 29 Aug 2020 11:18:28 -0400
Received: by mail-oo1-xc41.google.com with SMTP id r6so439216oon.13;
 Sat, 29 Aug 2020 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kq3y5HQV/PUolrKKsQRxge2Z7DyIbib/n6eqgklz5W4=;
 b=JJaZki/yGpvY6gtZSDN59QPbWcXL+oau3VHDQIXbPlKk1EZbJFqaFkYGc5gHaT6h+G
 x4lKb0rUdq7sB1BX2jp2KBAti/ZkmlLohOUcPebYbeHeQXqdd1DsNhc26mnZUASKDum6
 meQuqab/Z+gvLXVgxvtAIgFxLVeeAdGhaktyVkwJ3e2YjeXp6zpWrjXoI+OESNLzyh/Z
 2lvLrSQkWDHgm9RL6HRVSD1gVT15XKmelPUn88cxpXC2PXkZcFsLuZ2umJLIK9U3jLQz
 YUHSvI74l6NjZ40LmSpeW0DalVlwkOKpukcmzC+Rk5eOuVe262j/pT6vMIkRGNyf9CGQ
 vvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kq3y5HQV/PUolrKKsQRxge2Z7DyIbib/n6eqgklz5W4=;
 b=o/raWolFQgOOMBh8a3bySQfZeS6589FcyWQ6QWx9c+yX5/+G3Nt+fjWoxrG/K2WCnD
 hTuj/8ud6eEe75YWHayiSUOFp9UcMiWHY3SYLYFABIJQy3Ou+MaKWRJjcoBX5SKg6xh7
 /tUXxOjP1uc8AdRzsilNkjGAA2Gr56W3aEjTd63oXQlD8cBdqPER9lUiWMaF5jL+Do5I
 O4OUSD+G9NXkY3WME4OdDRZePnwMdRVkfVYwjBBt5Z8kBD8X3mNiwdLgNGifn43CSq3+
 55yTW/L1DdB1eBUjOa1IQQao74iir62kpBMvATyIWiMAxSlm2ItjWCT/+57193cMizV5
 Syag==
X-Gm-Message-State: AOAM5322yP/ElBxRvTHyW98q+3gfrmDB9RSEYnFmzqCfCZI8MYdolfhK
 GyDIiStEWBcx5WF6DapRsYc=
X-Google-Smtp-Source: ABdhPJyzw33dm6KbhNBY+auEE5qqcuPJAQugp6/2m75x70kj5gkknVsOi1wv5+lnywyntYKjfQmHzw==
X-Received: by 2002:a4a:a60a:: with SMTP id e10mr2602288oom.25.1598714304464; 
 Sat, 29 Aug 2020 08:18:24 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id f50sm58181otf.47.2020.08.29.08.18.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 29 Aug 2020 08:18:24 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 05/16] hw/char: Add Microchip PolarFire SoC MMUART emulation
Date: Sat, 29 Aug 2020 23:17:29 +0800
Message-Id: <1598714261-8320-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
References: <1598714261-8320-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-oo1-xc41.google.com
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

Changes in v2:
- change to update hw/char/meson.build
- add impl.min_access_size and impl.max_access_size as part of
  MemoryRegionOps and remove the allignment check

 include/hw/char/mchp_pfsoc_mmuart.h | 61 ++++++++++++++++++++++++++
 hw/char/mchp_pfsoc_mmuart.c         | 86 +++++++++++++++++++++++++++++++++++++
 MAINTAINERS                         |  2 +
 hw/char/Kconfig                     |  3 ++
 hw/char/meson.build                 |  1 +
 5 files changed, 153 insertions(+)
 create mode 100644 include/hw/char/mchp_pfsoc_mmuart.h
 create mode 100644 hw/char/mchp_pfsoc_mmuart.c

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
diff --git a/hw/char/mchp_pfsoc_mmuart.c b/hw/char/mchp_pfsoc_mmuart.c
new file mode 100644
index 0000000..8a002b0
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
index 5359b39..4002d51 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1320,7 +1320,9 @@ M: Bin Meng <bin.meng@windriver.com>
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
diff --git a/hw/char/meson.build b/hw/char/meson.build
index e888215..ae27932 100644
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
2.7.4


