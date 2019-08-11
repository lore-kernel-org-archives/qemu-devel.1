Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610D2C433FF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:12:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01B0208C2
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 08:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjefImP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01B0208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwixp-0002qW-1V
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 04:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60395)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisz-0006MU-Q6
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hwisy-00042t-0y
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 04:07:29 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:44695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hwisx-00042I-P0; Sun, 11 Aug 2019 04:07:27 -0400
Received: by mail-pf1-x444.google.com with SMTP id t16so48213024pfe.11;
 Sun, 11 Aug 2019 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=UpOsIboFQbNIZn0pMkCS3oxKC336H0PR09s+83mHDOs=;
 b=VjefImP9U+xccSCzmn6TYw1wUEbn3YIVDyxY0fdQ5QDtU4B0GqrhohtgFJKsq3U/Ca
 syjFK6EyQEbMBh/x2nCXEdGxkOpX+cSyOct+Uo/SXLCmQfhFfcS8497mv3u1+ExlhdLt
 +9kuuy40GGDsFcdHGTxbMsd4+lB8poD723j01x4NrRI1gtfHAZIZ28KWYAt32Pa2jBKO
 MFUbWnh8m7SkkdYj/44RFyjSd5Lqac3XHq936x3ENz50a32mxtVlj9Br0B2mpjKN8Foq
 gUhJpTAlKkUuNffpuWAHn+o+kK0vH+OI4Jq0EO6QfhcRIsJhkPnc6+aF2FKLTpbW6DRl
 8kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=UpOsIboFQbNIZn0pMkCS3oxKC336H0PR09s+83mHDOs=;
 b=aj/I5hCbAwmQ/mtyPCVTAE/XomHjDSiJkD7MFzBlMKWYWZXKVbl96Tjt5utkF1BmLL
 F9yO8xn9DY9kexB+bflkQn3LZVU0JFrZKjCXWR7TO5Ccq9vxleQSgldGB5KxwswsKR2m
 XE6x+Xqe/NTvl4BHsP9NCGBQklUj06hXN12PRRbWvKPdoIyEdsNEKdQ5fS4S3dG39Xtd
 YRZTYJ1h+nsHdrU667ePmdY4lNO5j+LFP5YaSTB2QmAGgFrD7Uha+QMI+t2RTuM9uVRQ
 05ZWZjgBfa3jxXa+e9fS2l4s/k7HlBp1S7DzwTy/A4d1Z8ErsrSvbAzpqm/wRAtrZTh4
 Vg2Q==
X-Gm-Message-State: APjAAAWBFonQwO8CDwk+pppn0CcybBOOFUEkuzU3iAQWnX23u5ESnl6A
 6fzki0GKy7FFfs8dVpssBnU=
X-Google-Smtp-Source: APXvYqzs/UiPN+ZAhtDdvrZYhL/Hsarbx+EOyCmKveKYYO9Wudz1Qimi45grYoBwut7LCX6OIGlWUQ==
X-Received: by 2002:a17:90a:710c:: with SMTP id
 h12mr17694849pjk.36.1565510846900; 
 Sun, 11 Aug 2019 01:07:26 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v8sm87339107pgs.82.2019.08.11.01.07.25
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sun, 11 Aug 2019 01:07:25 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sun, 11 Aug 2019 01:06:51 -0700
Message-Id: <1565510821-3927-19-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
References: <1565510821-3927-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v3 18/28] riscv: hw: Implement a model for
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

Changes in v3: None
Changes in v2: None

 hw/riscv/Makefile.objs          |   1 +
 hw/riscv/sifive_u_otp.c         | 194 ++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/sifive_u_otp.h |  90 +++++++++++++++++++
 3 files changed, 285 insertions(+)
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
index 0000000..f21d9f4
--- /dev/null
+++ b/hw/riscv/sifive_u_otp.c
@@ -0,0 +1,194 @@
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
+#include "qemu/module.h"
+#include "target/riscv/cpu.h"
+#include "hw/riscv/sifive_u_otp.h"
+
+static uint64_t sifive_otp_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    SiFiveOTPState *s = opaque;
+
+    switch (addr) {
+    case SIFIVE_OTP_PA:
+        return s->pa;
+    case SIFIVE_OTP_PAIO:
+        return s->paio;
+    case SIFIVE_OTP_PAS:
+        return s->pas;
+    case SIFIVE_OTP_PCE:
+        return s->pce;
+    case SIFIVE_OTP_PCLK:
+        return s->pclk;
+    case SIFIVE_OTP_PDIN:
+        return s->pdin;
+    case SIFIVE_OTP_PDOUT:
+        if ((s->pce & SIFIVE_OTP_PCE_EN) &&
+            (s->pdstb & SIFIVE_OTP_PDSTB_EN) &&
+            (s->ptrim & SIFIVE_OTP_PTRIM_EN)) {
+            return s->fuse[s->pa & SIFIVE_OTP_PA_MASK];
+        } else {
+            return 0xff;
+        }
+    case SIFIVE_OTP_PDSTB:
+        return s->pdstb;
+    case SIFIVE_OTP_PPROG:
+        return s->pprog;
+    case SIFIVE_OTP_PTC:
+        return s->ptc;
+    case SIFIVE_OTP_PTM:
+        return s->ptm;
+    case SIFIVE_OTP_PTM_REP:
+        return s->ptm_rep;
+    case SIFIVE_OTP_PTR:
+        return s->ptr;
+    case SIFIVE_OTP_PTRIM:
+        return s->ptrim;
+    case SIFIVE_OTP_PWE:
+        return s->pwe;
+    }
+
+    hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);
+    return 0;
+}
+
+static void sifive_otp_write(void *opaque, hwaddr addr,
+                             uint64_t val64, unsigned int size)
+{
+    SiFiveOTPState *s = opaque;
+
+    switch (addr) {
+    case SIFIVE_OTP_PA:
+        s->pa = (uint32_t) val64 & SIFIVE_OTP_PA_MASK;
+        break;
+    case SIFIVE_OTP_PAIO:
+        s->paio = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PAS:
+        s->pas = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PCE:
+        s->pce = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PCLK:
+        s->pclk = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PDIN:
+        s->pdin = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PDOUT:
+        /* read-only */
+        break;
+    case SIFIVE_OTP_PDSTB:
+        s->pdstb = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PPROG:
+        s->pprog = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PTC:
+        s->ptc = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PTM:
+        s->ptm = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PTM_REP:
+        s->ptm_rep = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PTR:
+        s->ptr = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PTRIM:
+        s->ptrim = (uint32_t) val64;
+        break;
+    case SIFIVE_OTP_PWE:
+        s->pwe = (uint32_t) val64;
+        break;
+    default:
+        hw_error("%s: bad write: addr=0x%x v=0x%x\n",
+                 __func__, (int)addr, (int)val64);
+    }
+}
+
+static const MemoryRegionOps sifive_otp_ops = {
+    .read = sifive_otp_read,
+    .write = sifive_otp_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4
+    }
+};
+
+static Property sifive_otp_properties[] = {
+    DEFINE_PROP_UINT32("serial", SiFiveOTPState, serial, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void sifive_otp_realize(DeviceState *dev, Error **errp)
+{
+    SiFiveOTPState *s = SIFIVE_U_OTP(dev);
+
+    memory_region_init_io(&s->mmio, OBJECT(dev), &sifive_otp_ops, s,
+                          TYPE_SIFIVE_U_OTP, SIFIVE_U_OTP_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
+
+    /* Initialize all fuses' initial value to 0xFFs */
+    memset(s->fuse, 0xff, sizeof(s->fuse));
+
+    /* Make a valid content of serial number */
+    s->fuse[SIFIVE_OTP_SERIAL_ADDR] = s->serial;
+    s->fuse[SIFIVE_OTP_SERIAL_ADDR + 1] = ~(s->serial);
+}
+
+static void sifive_otp_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props = sifive_otp_properties;
+    dc->realize = sifive_otp_realize;
+}
+
+static const TypeInfo sifive_otp_info = {
+    .name          = TYPE_SIFIVE_U_OTP,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(SiFiveOTPState),
+    .class_init    = sifive_otp_class_init,
+};
+
+static void sifive_otp_register_types(void)
+{
+    type_register_static(&sifive_otp_info);
+}
+
+type_init(sifive_otp_register_types)
+
+
+/* Create OTP device */
+DeviceState *sifive_u_otp_create(hwaddr addr, uint32_t serial)
+{
+    DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_U_OTP);
+    qdev_prop_set_uint32(dev, "serial", serial);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
+
+    return dev;
+}
diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/riscv/sifive_u_otp.h
new file mode 100644
index 0000000..16095b0
--- /dev/null
+++ b/include/hw/riscv/sifive_u_otp.h
@@ -0,0 +1,90 @@
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
+enum {
+    SIFIVE_OTP_PA       = 0x00,
+    SIFIVE_OTP_PAIO     = 0x04,
+    SIFIVE_OTP_PAS      = 0x08,
+    SIFIVE_OTP_PCE      = 0x0C,
+    SIFIVE_OTP_PCLK     = 0x10,
+    SIFIVE_OTP_PDIN     = 0x14,
+    SIFIVE_OTP_PDOUT    = 0x18,
+    SIFIVE_OTP_PDSTB    = 0x1C,
+    SIFIVE_OTP_PPROG    = 0x20,
+    SIFIVE_OTP_PTC      = 0x24,
+    SIFIVE_OTP_PTM      = 0x28,
+    SIFIVE_OTP_PTM_REP  = 0x2C,
+    SIFIVE_OTP_PTR      = 0x30,
+    SIFIVE_OTP_PTRIM    = 0x34,
+    SIFIVE_OTP_PWE      = 0x38
+};
+
+enum {
+    SIFIVE_OTP_PCE_EN   = (1 << 0)
+};
+
+enum {
+    SIFIVE_OTP_PDSTB_EN = (1 << 0)
+};
+
+enum {
+    SIFIVE_OTP_PTRIM_EN = (1 << 0)
+};
+
+#define SIFIVE_OTP_PA_MASK      0xfff
+#define SIFIVE_OTP_NUM_FUSES    0x1000
+#define SIFIVE_OTP_SERIAL_ADDR  0xfc
+
+#define SIFIVE_U_OTP_REG_SIZE   0x1000
+
+#define TYPE_SIFIVE_U_OTP       "riscv.sifive.u.otp"
+
+#define SIFIVE_U_OTP(obj) \
+    OBJECT_CHECK(SiFiveOTPState, (obj), TYPE_SIFIVE_U_OTP)
+
+typedef struct SiFiveOTPState {
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
+    uint32_t fuse[SIFIVE_OTP_NUM_FUSES];
+    /* config */
+    uint32_t serial;
+} SiFiveOTPState;
+
+DeviceState *sifive_u_otp_create(hwaddr addr, uint32_t serial);
+
+#endif /* HW_SIFIVE_U_OTP_H */
-- 
2.7.4


