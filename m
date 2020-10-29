Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8998C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F78820838
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ORSEf0cf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F78820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY91N-0006ST-26
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sV-0001v3-5H
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sS-0005fQ-Qu
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981568; x=1635517568;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rIFZVgK1tCL83dR1cWor9xZmk+6Cf1QUU1Hpc7INByk=;
 b=ORSEf0cfsvAvsdKML4vSN64RTLDh4GI0bUb+4+MbhatVgghkEVzCCnsY
 A5Whrkr3NHGjuhrZQPfZ5jFMv/jgaSv8K4hdE79sT/JT3Ok0jWPnopr7e
 DFr9PISrkYKoBBEwLORVC9KvnEewFD3uc/+33sgXBDKSC8NoYGEuEW+8+
 BXTPGAV0hk8yJ+IteugSyb5dz8yQGeJcsXAnq2FexcvChikIe4uhec6UA
 6CpeWnb0mqtbQ1sHxe3/mBWerIrqJLhAqz8azqVEmmHNN7y3WmafHzLMO
 OllDj5VmYY2OOyz/TshodVkVhTZ0oBmsrU1pSaa9Klr3tvzDm+ZYEEv85 w==;
IronPort-SDR: uH2jEk+GILVussC+5iNWVDOiH5H+8uo2TohwSoASg6sy4Umf5a4AxqDtnZH0YBka/bwx/KMr/j
 VJda8UFwiz6+b12XlPW7xskAVGJVb1ENpcZGH2mSlFQYGVJZCoZbutJ0pOHbOiFz3MVkyE0flb
 llWJu7Nj3xg0ZVK7Ff/IN1ioqhDHjMI4om8NbhiB5Ljo+OPGgG32o7383iecRP0wPiiBz0twXU
 TshQpNPVPsemRZuoOyOEdsECAbIyhdmVp9CvkA/tEwtx7TWr5y8xrE5M/7JwwYLqCtvc3X1/ZS
 sCw=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317896"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:29 +0800
IronPort-SDR: p0qdd3GMK+x6tVpTRGlV1+IQlYg+S69VA5Cy2C/MKrOA6VAdshL6872nBTXeo9wTyLFzo98EHy
 buGEWZapzoGFG9m8BQ4wmGyaDpXj57W2OmrwkRtDTE5tVvHz0J85Fqbp/LlAxyAwmzvWmok1yj
 /HtIcyiP2gbonReQat/fa8FCuQI12A6TJQr7VK0I3dzIBstuf0sLgueFvw+eQDIhscAvdKlsEn
 L4QhyR8Zto54+2jIIaoeVTTeaNG1kmVA9tBjrHKK3Yk0wdKZdf0Z47hy0TjopwhjUrwd7LmLfA
 lNkMTtkaDqypOlVxd1qKrf1Z
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:45 -0700
IronPort-SDR: 4K0dKTx1wdFS5HaPx/UEmTkT7ztvG4tbl7z76YmQYMZvG9PGyezrJfjPb9ulmJ/5t3SbuzyDVx
 9NS80s4NIXTIknPFEUlgUAgYQAyxdRVj5jU4Vr5B048jOF36DXa7JMUUe9l8+K48G9Nsj1tIv/
 KGfk6RFRLIIvmTV4ySeqkLx91DhyzKTx9pkBfbco9RldWAR6HRaWEJyhLdvRP1QE5dHx1HJe1A
 Wok85svtWDc8ffOQFG4k/Nfx4f24xwKVQ3Bx1xXu5BZe8tWHQsoWbIgTQ/d6DLW7F24IA9pvRv
 Uzk=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 14/18] hw/misc: Add Microchip PolarFire SoC SYSREG module
 support
Date: Thu, 29 Oct 2020 07:13:54 -0700
Message-Id: <20201029141358.3102636-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
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

This creates a minimum model for Microchip PolarFire SoC SYSREG
module. It only implements the ENVM_CR register to tell guest
software that eNVM is running at the configured divider rate.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-7-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/misc/mchp_pfsoc_sysreg.h | 39 ++++++++++++
 hw/misc/mchp_pfsoc_sysreg.c         | 99 +++++++++++++++++++++++++++++
 MAINTAINERS                         |  2 +
 hw/misc/Kconfig                     |  3 +
 hw/misc/meson.build                 |  1 +
 5 files changed, 144 insertions(+)
 create mode 100644 include/hw/misc/mchp_pfsoc_sysreg.h
 create mode 100644 hw/misc/mchp_pfsoc_sysreg.c

diff --git a/include/hw/misc/mchp_pfsoc_sysreg.h b/include/hw/misc/mchp_pfsoc_sysreg.h
new file mode 100644
index 0000000000..546ba68f6a
--- /dev/null
+++ b/include/hw/misc/mchp_pfsoc_sysreg.h
@@ -0,0 +1,39 @@
+/*
+ * Microchip PolarFire SoC SYSREG module emulation
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
+#ifndef MCHP_PFSOC_SYSREG_H
+#define MCHP_PFSOC_SYSREG_H
+
+#define MCHP_PFSOC_SYSREG_REG_SIZE  0x2000
+
+typedef struct MchpPfSoCSysregState {
+    SysBusDevice parent;
+    MemoryRegion sysreg;
+} MchpPfSoCSysregState;
+
+#define TYPE_MCHP_PFSOC_SYSREG "mchp.pfsoc.sysreg"
+
+#define MCHP_PFSOC_SYSREG(obj) \
+    OBJECT_CHECK(MchpPfSoCSysregState, (obj), \
+                 TYPE_MCHP_PFSOC_SYSREG)
+
+#endif /* MCHP_PFSOC_SYSREG_H */
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
new file mode 100644
index 0000000000..248a313345
--- /dev/null
+++ b/hw/misc/mchp_pfsoc_sysreg.c
@@ -0,0 +1,99 @@
+/*
+ * Microchip PolarFire SoC SYSREG module emulation
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
+#include "hw/sysbus.h"
+#include "hw/misc/mchp_pfsoc_sysreg.h"
+
+#define ENVM_CR         0xb8
+
+static uint64_t mchp_pfsoc_sysreg_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    uint32_t val = 0;
+
+    switch (offset) {
+    case ENVM_CR:
+        /* Indicate the eNVM is running at the configured divider rate */
+        val = BIT(6);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
+                      "(size %d, offset 0x%" HWADDR_PRIx ")\n",
+                      __func__, size, offset);
+        break;
+    }
+
+    return val;
+}
+
+static void mchp_pfsoc_sysreg_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
+                  "(size %d, value 0x%" PRIx64
+                  ", offset 0x%" HWADDR_PRIx ")\n",
+                  __func__, size, value, offset);
+}
+
+static const MemoryRegionOps mchp_pfsoc_sysreg_ops = {
+    .read = mchp_pfsoc_sysreg_read,
+    .write = mchp_pfsoc_sysreg_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void mchp_pfsoc_sysreg_realize(DeviceState *dev, Error **errp)
+{
+    MchpPfSoCSysregState *s = MCHP_PFSOC_SYSREG(dev);
+
+    memory_region_init_io(&s->sysreg, OBJECT(dev),
+                          &mchp_pfsoc_sysreg_ops, s,
+                          "mchp.pfsoc.sysreg",
+                          MCHP_PFSOC_SYSREG_REG_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->sysreg);
+}
+
+static void mchp_pfsoc_sysreg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "Microchip PolarFire SoC SYSREG module";
+    dc->realize = mchp_pfsoc_sysreg_realize;
+}
+
+static const TypeInfo mchp_pfsoc_sysreg_info = {
+    .name          = TYPE_MCHP_PFSOC_SYSREG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MchpPfSoCSysregState),
+    .class_init    = mchp_pfsoc_sysreg_class_init,
+};
+
+static void mchp_pfsoc_sysreg_register_types(void)
+{
+    type_register_static(&mchp_pfsoc_sysreg_info);
+}
+
+type_init(mchp_pfsoc_sysreg_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 2d29fb02f2..f4dfc588c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1328,10 +1328,12 @@ F: hw/riscv/microchip_pfsoc.c
 F: hw/char/mchp_pfsoc_mmuart.c
 F: hw/misc/mchp_pfsoc_dmc.c
 F: hw/misc/mchp_pfsoc_ioscb.c
+F: hw/misc/mchp_pfsoc_sysreg.c
 F: include/hw/riscv/microchip_pfsoc.h
 F: include/hw/char/mchp_pfsoc_mmuart.h
 F: include/hw/misc/mchp_pfsoc_dmc.h
 F: include/hw/misc/mchp_pfsoc_ioscb.h
+F: include/hw/misc/mchp_pfsoc_sysreg.h
 
 RX Machines
 -----------
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4ff01ec4be..dc44dc14f6 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -145,6 +145,9 @@ config MCHP_PFSOC_DMC
 config MCHP_PFSOC_IOSCB
     bool
 
+config MCHP_PFSOC_SYSREG
+    bool
+
 config SIFIVE_TEST
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8e3facf348..7b2be2d11d 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -25,6 +25,7 @@ softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 # RISC-V devices
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
+softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
-- 
2.28.0


