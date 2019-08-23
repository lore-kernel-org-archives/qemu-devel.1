Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436F4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA40221019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgIhKKCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA40221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12Nj-0005b8-1n
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rY-0004Sw-8d
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rW-0002mq-BZ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:48 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43096)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11rW-0002mJ-3F; Fri, 23 Aug 2019 01:11:46 -0400
Received: by mail-pl1-x644.google.com with SMTP id 4so4863934pld.10;
 Thu, 22 Aug 2019 22:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=OZVOOh0SxX0IlUeweFB/zoT4qJOUme1j3/PcnjdOxM8=;
 b=SgIhKKCpWI/ndMySZ3y+c6jWKlfCBALgKq89jrH8F9pfeUhdxkEx6bJSJJX3Ec5vEx
 h7m15fbRjWPtOMCzpO6sk/BjLpXDwRcb0sqrNCPcpZwPk2p63ncwCthymIMp3DSgL+Hn
 VGM7ZD5uHZmz9Sw26DlTXaJu9cDKBrdRRvLC/3Ra7hV4qkDQZm+wAu1xmjaVpy465jqq
 1iQYWCyTo2kRHPEgAR008milg7ST8glkKGvFA6/TDXg0EDbZDP7uklj9x+/Zjfnp+2ik
 MCu0tDFTCz+5y32cLJ29pWCPvQPbMcxr40OpdFN/RQqOCRPDsXBkyxqyuwQE6P38IPog
 Wvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=OZVOOh0SxX0IlUeweFB/zoT4qJOUme1j3/PcnjdOxM8=;
 b=rSuh9AXEw3eM3fcOpihZfKUIeWbzIEuCJiM0Xl7ZnN7QjwHghM9okVmspeJm/m/3vL
 0YHKq/plOzjTmNVXnywGYVMBv+X9MEr+/mnX+Tj6RBMjD+7EtHSKeY+Detou2AdJ4AfW
 ZOPNMt7UGlo0zi6Lr2uj4XdQu3j9QSdkSbyDuYqU6BefjRlkRx6u3qfOUh7QyX8Mjbil
 DfkwdoCuBczkGHOHABAEZ/n/3zZPnme05w2LZtIsXV2WUw17777QV5N4NzO5oR1bYxMX
 06QTOX2F6qOnr+2IizdLJNrXhlrLy2XHBP9mZZOcGm9ZQbBR12koFq4wiMiyewV/GjoW
 liYQ==
X-Gm-Message-State: APjAAAXJc7flCyQ0YFRQIfSwFYOPttm0XT5FwkKWTJxRIYtpdo8Gom4N
 LXDAMHKDvEsTnQ0rIO8nEa0=
X-Google-Smtp-Source: APXvYqw3yUbRbjGggUKiBo7IUqA+IzVthcnfPWHeDn/9fTwxgvF/LmXD/vGLCMBBA9q+G8m93KhHLQ==
X-Received: by 2002:a17:902:6843:: with SMTP id
 f3mr2529394pln.97.1566537105258; 
 Thu, 22 Aug 2019 22:11:45 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.44
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:44 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:11:05 -0700
Message-Id: <1566537069-22741-27-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: [Qemu-devel] [PATCH v5 26/30] riscv: sifive: Implement a model for
 SiFive FU540 OTP
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This implements a simple model for SiFive FU540 OTP (One-Time
Programmable) Memory interface, primarily for reading out the
stored serial number from the first 1 KiB of the 16 KiB OTP
memory reserved by SiFive for internal use.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v5:
- change to use defines instead of enums
- change to use qemu_log_mask(LOG_GUEST_ERROR,...) in sifive_u_otp
- creating a 32-bit val variable and using that instead of casting
  everywhere in sifive_u_otp_write()
- move all register initialization to sifive_u_otp_reset() function
- drop sifive_u_otp_create()

Changes in v4:
- prefix all macros/variables/functions with SIFIVE_U/sifive_u
  in the sifive_u_otp driver

Changes in v3: None
Changes in v2: None

 hw/riscv/Makefile.objs          |   1 +
 hw/riscv/sifive_u_otp.c         | 190 ++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  80 +++++++++++++++++
 3 files changed, 271 insertions(+)
 create mode 100644 hw/riscv/sifive_u_otp.c
 create mode 100644 include/hw/riscv/sifive_u_otp.h

diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index b95bbd5..fc3c6dd 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -8,6 +8,7 @@ obj-$(CONFIG_SIFIVE) += sifive_gpio.o
 obj-$(CONFIG_SIFIVE) += sifive_plic.o
 obj-$(CONFIG_SIFIVE) += sifive_test.o
 obj-$(CONFIG_SIFIVE_U) += sifive_u.o
+obj-$(CONFIG_SIFIVE_U) += sifive_u_otp.o
 obj-$(CONFIG_SIFIVE_U) += sifive_u_prci.o
 obj-$(CONFIG_SIFIVE) += sifive_uart.o
 obj-$(CONFIG_SPIKE) += spike.o
diff --git a/hw/riscv/sifive_u_otp.c b/hw/riscv/sifive_u_otp.c
new file mode 100644
index 0000000..7d65a85
--- /dev/null
+++ b/hw/riscv/sifive_u_otp.c
@@ -0,0 +1,190 @@
+/*
+ * QEMU SiFive U OTP (One-Time Programmable) Memory interface
+ *
+ * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
+ *
+ * Simple model of the OTP to emulate register reads made by the SDK BSP
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/riscv/sifive_u_otp.h"
+
+static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    SiFiveUOTPState *s = opaque;
+
+    switch (addr) {
+    case SIFIVE_U_OTP_PA:
+        return s->pa;
+    case SIFIVE_U_OTP_PAIO:
+        return s->paio;
+    case SIFIVE_U_OTP_PAS:
+        return s->pas;
+    case SIFIVE_U_OTP_PCE:
+        return s->pce;
+    case SIFIVE_U_OTP_PCLK:
+        return s->pclk;
+    case SIFIVE_U_OTP_PDIN:
+        return s->pdin;
+    case SIFIVE_U_OTP_PDOUT:
+        if ((s->pce & SIFIVE_U_OTP_PCE_EN) &&
+            (s->pdstb & SIFIVE_U_OTP_PDSTB_EN) &&
+            (s->ptrim & SIFIVE_U_OTP_PTRIM_EN)) {
+            return s->fuse[s->pa & SIFIVE_U_OTP_PA_MASK];
+        } else {
+            return 0xff;
+        }
+    case SIFIVE_U_OTP_PDSTB:
+        return s->pdstb;
+    case SIFIVE_U_OTP_PPROG:
+        return s->pprog;
+    case SIFIVE_U_OTP_PTC:
+        return s->ptc;
+    case SIFIVE_U_OTP_PTM:
+        return s->ptm;
+    case SIFIVE_U_OTP_PTM_REP:
+        return s->ptm_rep;
+    case SIFIVE_U_OTP_PTR:
+        return s->ptr;
+    case SIFIVE_U_OTP_PTRIM:
+        return s->ptrim;
+    case SIFIVE_U_OTP_PWE:
+        return s->pwe;
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%x\n",
+                  __func__, (int)addr);
+    return 0;
+}
+
+static void sifive_u_otp_write(void *opaque, hwaddr addr,
+                               uint64_t val64, unsigned int size)
+{
+    SiFiveUOTPState *s = opaque;
+    uint32_t val32 = (uint32_t)val64;
+
+    switch (addr) {
+    case SIFIVE_U_OTP_PA:
+        s->pa = val32 & SIFIVE_U_OTP_PA_MASK;
+        break;
+    case SIFIVE_U_OTP_PAIO:
+        s->paio = val32;
+        break;
+    case SIFIVE_U_OTP_PAS:
+        s->pas = val32;
+        break;
+    case SIFIVE_U_OTP_PCE:
+        s->pce = val32;
+        break;
+    case SIFIVE_U_OTP_PCLK:
+        s->pclk = val32;
+        break;
+    case SIFIVE_U_OTP_PDIN:
+        s->pdin = val32;
+        break;
+    case SIFIVE_U_OTP_PDOUT:
+        /* read-only */
+        break;
+    case SIFIVE_U_OTP_PDSTB:
+        s->pdstb = val32;
+        break;
+    case SIFIVE_U_OTP_PPROG:
+        s->pprog = val32;
+        break;
+    case SIFIVE_U_OTP_PTC:
+        s->ptc = val32;
+        break;
+    case SIFIVE_U_OTP_PTM:
+        s->ptm = val32;
+        break;
+    case SIFIVE_U_OTP_PTM_REP:
+        s->ptm_rep = val32;
+        break;
+    case SIFIVE_U_OTP_PTR:
+        s->ptr = val32;
+        break;
+    case SIFIVE_U_OTP_PTRIM:
+        s->ptrim = val32;
+        break;
+    case SIFIVE_U_OTP_PWE:
+        s->pwe = val32;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
+                      __func__, (int)addr, (int)val64);
+    }
+}
+
+static const MemoryRegionOps sifive_u_otp_ops = {
+    .read = sifive_u_otp_read,
+    .write = sifive_u_otp_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static Property sifive_u_otp_properties[] = {
+    DEFINE_PROP_UINT32("serial", SiFiveUOTPState, serial, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sifive_u_otp_realize(DeviceState *dev, Error **errp)
+{
+    SiFiveUOTPState *s = SIFIVE_U_OTP(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_u_otp_ops, s,
+                          TYPE_SIFIVE_U_OTP, SIFIVE_U_OTP_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+}
+
+static void sifive_u_otp_reset(DeviceState *dev)
+{
+    SiFiveUOTPState *s = SIFIVE_U_OTP(dev);
+
+    /* Initialize all fuses' initial value to 0xFFs */
+    memset(s->fuse, 0xff, sizeof(s->fuse));
+
+    /* Make a valid content of serial number */
+    s->fuse[SIFIVE_U_OTP_SERIAL_ADDR] = s->serial;
+    s->fuse[SIFIVE_U_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+}
+
+static void sifive_u_otp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = sifive_u_otp_properties;
+    dc->realize = sifive_u_otp_realize;
+    dc->reset = sifive_u_otp_reset;
+}
+
+static const TypeInfo sifive_u_otp_info = {
+    .name          = TYPE_SIFIVE_U_OTP,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFiveUOTPState),
+    .class_init    = sifive_u_otp_class_init,
+};
+
+static void sifive_u_otp_register_types(void)
+{
+    type_register_static(&sifive_u_otp_info);
+}
+
+type_init(sifive_u_otp_register_types)
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
new file mode 100644
index 0000000..6392975
--- /dev/null
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -0,0 +1,80 @@
+/*
+ * QEMU SiFive U OTP (One-Time Programmable) Memory interface
+ *
+ * Copyright (c) 2019 Bin Meng <bmeng.cn@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_SIFIVE_U_OTP_H
+#define HW_SIFIVE_U_OTP_H
+
+#define SIFIVE_U_OTP_PA         0x00
+#define SIFIVE_U_OTP_PAIO       0x04
+#define SIFIVE_U_OTP_PAS        0x08
+#define SIFIVE_U_OTP_PCE        0x0C
+#define SIFIVE_U_OTP_PCLK       0x10
+#define SIFIVE_U_OTP_PDIN       0x14
+#define SIFIVE_U_OTP_PDOUT      0x18
+#define SIFIVE_U_OTP_PDSTB      0x1C
+#define SIFIVE_U_OTP_PPROG      0x20
+#define SIFIVE_U_OTP_PTC        0x24
+#define SIFIVE_U_OTP_PTM        0x28
+#define SIFIVE_U_OTP_PTM_REP    0x2C
+#define SIFIVE_U_OTP_PTR        0x30
+#define SIFIVE_U_OTP_PTRIM      0x34
+#define SIFIVE_U_OTP_PWE        0x38
+
+#define SIFIVE_U_OTP_PCE_EN     (1 << 0)
+
+#define SIFIVE_U_OTP_PDSTB_EN   (1 << 0)
+
+#define SIFIVE_U_OTP_PTRIM_EN   (1 << 0)
+
+#define SIFIVE_U_OTP_PA_MASK        0xfff
+#define SIFIVE_U_OTP_NUM_FUSES      0x1000
+#define SIFIVE_U_OTP_SERIAL_ADDR    0xfc
+
+#define SIFIVE_U_OTP_REG_SIZE       0x1000
+
+#define TYPE_SIFIVE_U_OTP           "riscv.sifive.u.otp"
+
+#define SIFIVE_U_OTP(obj) \
+    OBJECT_CHECK(SiFiveUOTPState, (obj), TYPE_SIFIVE_U_OTP)
+
+typedef struct SiFiveUOTPState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    uint32_t pa;
+    uint32_t paio;
+    uint32_t pas;
+    uint32_t pce;
+    uint32_t pclk;
+    uint32_t pdin;
+    uint32_t pdstb;
+    uint32_t pprog;
+    uint32_t ptc;
+    uint32_t ptm;
+    uint32_t ptm_rep;
+    uint32_t ptr;
+    uint32_t ptrim;
+    uint32_t pwe;
+    uint32_t fuse[SIFIVE_U_OTP_NUM_FUSES];
+    /* config */
+    uint32_t serial;
+} SiFiveUOTPState;
+
+#endif /* HW_SIFIVE_U_OTP_H */
-- 
2.7.4


