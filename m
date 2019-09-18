Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F5C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7528920640
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 16:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7528920640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcSq-0000S1-EC
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 12:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49907)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsq-0007kO-IG
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbso-00077q-Kl
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:44 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:36150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbso-00077V-E8
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:42 -0400
Received: by mail-pf1-f170.google.com with SMTP id y22so216508pfr.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=NAoLszzRm3k2OAxVjRO5F2hqnGWq+M7aG/MqKO/leNo=;
 b=HK1D18scl5JAZaCxtW6LrgVYV5mlBAL9lbQW0uYxgvveHDcqoiDpphGNG2if7NLUEA
 utmR5S0g+ExGNnH1AoSL3CbhZ9ST3307t0N5xfHlaiYy5PPN6B2CY4uLrR20zjccb6GJ
 9VD+vSkE6Nx8q60+cZTxp5UYBu2+Qv4CkCZoCD2oauZ0qVoR3pVMaKvGvdgvVh/Jqn5R
 i05I6yBtGaglftigbIWB+VYRUtjHjQsgiasPS9r1McLgUfbU1mCSGVzmEmdiVZa/sg7f
 k4kNEfz01nLFg+bPKz5sxqoSPeL74HpfSoBRonmFzx8mA4Oa0ukf5W4AYQWQ66YhCntu
 cM8Q==
X-Gm-Message-State: APjAAAU8gkd/f/EnSAW/6u2MeNg9Cagohvm6x7g2TOh8l50RmvQPjKdp
 DOfvcF2BYEc1adREbvoeo5vxeQ==
X-Google-Smtp-Source: APXvYqxaP3R6dxiUPKwTQUI1oN87dooiMOOu5DMZhUbMlxwDYax/wewql2z6JRXAEODl5ZN8l4+sLQ==
X-Received: by 2002:a62:3403:: with SMTP id b3mr1825897pfa.35.1568820521161;
 Wed, 18 Sep 2019 08:28:41 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id z13sm7444875pfq.121.2019.09.18.08.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:40 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:32 -0700
Message-Id: <20190918145640.17349-41-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.170
Subject: [Qemu-devel] [PULL 40/48] riscv: sifive: Implement a model for
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

This implements a simple model for SiFive FU540 OTP (One-Time
Programmable) Memory interface, primarily for reading out the
stored serial number from the first 1 KiB of the 16 KiB OTP
memory reserved by SiFive for internal use.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/Makefile.objs          |   1 +
 hw/riscv/sifive_u_otp.c         | 191 ++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  80 +++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 hw/riscv/sifive_u_otp.c
 create mode 100644 include/hw/riscv/sifive_u_otp.h

diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index b95bbd51e2..fc3c6dd7c8 100644
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
index 0000000000..ea0eee5678
--- /dev/null
+++ b/hw/riscv/sifive_u_otp.c
@@ -0,0 +1,191 @@
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
+#include "hw/qdev-properties.h"
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
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%" HWADDR_PRIx "\n",
+                  __func__, addr);
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
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%" HWADDR_PRIx
+                      " v=0x%x\n", __func__, addr, val32);
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
index 0000000000..639297564a
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
2.21.0


