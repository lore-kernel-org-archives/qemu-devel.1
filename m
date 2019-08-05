Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2886FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95BEF20651
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvC4bLRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BEF20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hufWP-00056I-Pa
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 12:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58598)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPu-0000mw-49
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:01:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hufPr-00032l-3s
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 12:00:57 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45309)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hufPn-0002yc-6g; Mon, 05 Aug 2019 12:00:52 -0400
Received: by mail-pf1-x444.google.com with SMTP id r1so39861385pfq.12;
 Mon, 05 Aug 2019 09:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=2ms6qzywynSYGndXaBF2HCSrVQr5HrR87UomFY43oOo=;
 b=QvC4bLRX7/Un2bwF6t1LcfjWRSrTf1kSbJlIKjKtm2omg+/8uoItJiDxknXwcda7Ns
 xBKevTlUYkiMm4IDCLEwr6JWz1gIiEKiTdE+G3Dl9Cpt+k5jSOm8jK+y0JuY4LEozooU
 EcQcHVNjPtfdt2ZYza30z0a8iIj3Gm4SkmJpDU+Fwr0ui79Va06Q1q9v42Ws2KClIg+e
 KiwxhszK+j82YIO+5pvdHGk7r7HsLozKgQq3SaKLN4bDy/SljiB+iCUwtrsJp5N87Kcz
 5FGCDWZFVYBC0uGWMtVyYKJKhDDwAlO2kb7tyHTqHXINab4d+GmLbCc1vI7svvLYvBNQ
 pRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=2ms6qzywynSYGndXaBF2HCSrVQr5HrR87UomFY43oOo=;
 b=HLx9jmYL9YaTZnW4HOUyKPkLCxpl6dAuCD0FirLh5LdBqIdJ4XFKKSaoxHsK/zWWI1
 uwoxXvv7QYwqh8GEO6x+ILpit0nhZWcecLrPZZZmAPafx0VbxSi75vNpeeUCDCjSBBNa
 8OL96TV1SaEMZtv14ISP7SEm2cFp9bLpnuaYrespW6prIoePpPEj09V4JrlO5B/5lcxx
 pYSLm9lTv2RCFosNK/3h5B2AcsQWTj5mpuwZ/Zm+WH2ZDBZUfLH3fF8G6nAxQfayn+RD
 X+izXAwZiwTaRbGc/zre1HLVj4mSiCUpthkLGIA0PexsRNW5/XG5irkVACgWzPmLmUZk
 fkMg==
X-Gm-Message-State: APjAAAWjnghmXl7Gqs4H8PxcMoNvWJpKUx9scKgXjN+IsXI/AAy/iDyk
 Cs4Ae4qXa+B2dOPjgOlAH/FGY1Y7
X-Google-Smtp-Source: APXvYqxfva+PWi8e3QiT9G1GxXpJrXe+H8jP672rmwkV9AxzNlxs1PdT9YzSNNTYq6o4G1TM/+VSeg==
X-Received: by 2002:aa7:96a4:: with SMTP id g4mr76499241pfk.193.1565020847412; 
 Mon, 05 Aug 2019 09:00:47 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id d18sm47728793pgi.40.2019.08.05.09.00.46
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Mon, 05 Aug 2019 09:00:46 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Mon,  5 Aug 2019 09:00:13 -0700
Message-Id: <1565020823-24223-19-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
References: <1565020823-24223-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 18/28] riscv: hw: Implement a model for SiFive
 FU540 OTP
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


