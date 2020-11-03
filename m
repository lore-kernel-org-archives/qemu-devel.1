Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B77BC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8356C2236F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AHdX+xyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8356C2236F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZykS-0004sf-Iv
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:01:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyK2-0002M1-11
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:10 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:14996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyJz-0001EJ-Gi
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417648; x=1635953648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZFmgjHUuJNXRrAu1T34hiTrmmtdxLEyK19w6m80jsqM=;
 b=AHdX+xyTs7zOyY0WCEgmdGd4swRvnbkmMPywXLunxy7Smkxobt11B8fj
 /BmjBINGq0L7fOvkWV11335qTVc1ExUgZMNRUFECVXAcaauTdHGJKUSxe
 R4WPJ4zBU26zE2RnpE1EMSo32LoG3cYBnLeUmjPS5fHzrQAnMDZh4tOXj
 ygc4LyCnZktN8WKg5uctvhi1DBnqnOfabiKQoal9XyQ5hCZ2RtpNlP689
 X0wN+tmKhpnC8GQjJMPY7FkROMqfNlvBe7aVuySSaOBp/zsE+xCpJXJ6W
 lDWXixab1FXcFyVeLygHsDod2akd3SIdBbb43KRbGUeLyeZmxS7HaRJW1 g==;
IronPort-SDR: zQUOQ8EXw2n0jJUQfR4pi38kHX01lk897GdBiyCYR0m69MhccvcrG8fZb4U4ncT9IAbGaJtqQU
 jEHJPoCccBnDn+9IiOF+elmS0OVBG96h12GAmAOnf+1yZqQ5zwVecKlOegJay9cjN5Oqaewfw2
 OaIrlbPsiK/EWxZtbWeUTA/Peu1gL5vYLzI/+qpNqiXV72zXsaEp4xI4r1Afup7uF6CY9g6nu5
 6csu66LSFeRMGbkfYXCgmoSZp/sgTbcVXoOUq204GI3pl1ts6hEwNldd61vvRCSJeTjjJPjW0z
 3X8=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867479"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:27 +0800
IronPort-SDR: 9O+FYCZGVku1hZdqHyQnX0M1F+g/Rb92C+qnYNFtwa60MuqbGKVsrDpCq3BzY0GHuBd9b5M21t
 GXRKhNjRrzOTxO1vg+2+sX7+vpT/jN27ZeSNBLyZe30sq0MvtEU/Qzc8EtWbCyYTsiTXUIzmUY
 HnEym5nb3fVTvFHrJDwZ8N0w45b/KQD3ljK/pItc+FrWRoEJzq44gJdzVCoeqDVXVdbX1EQNlF
 Q49cYS4TDVhfSrZbiXi3thS56lFGdWrVXicIlXcR/To/X6AuKY5Lulue6APDGmvQz7VsjkkJCl
 1kJBN9vtBbqHb/XQwQL3fDLg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:36 -0800
IronPort-SDR: Za2g24C+nHDgN/tWucdTFaqAw/MBS4fMm5kT8+p0JSvmU5yzuN3XRCu/LAv9Hx/ulriRHrSfnp
 O5DRRpEjuq0cw/ZPfOoNENmMGrDeWr0E1cmVgDFVEQAxWbIDFacpcb7qcrce/u4W5D/MmpIZfj
 EkHD6DyMI7WO0P3afP0ni+8V4GrwSyRmUBalmjwZz2G89WgWypzXSK+LjfnkeXWmJgQp8weFOa
 2Vyc6k3NlKUlZmAPv5SODNCygfPIuopbx4vGJdbxkb0kYMsOfyWgDkoKya5O8n1ttHSMdFqLVq
 YkU=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:27 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 14/19] hw/misc: Add Microchip PolarFire SoC SYSREG module
 support
Date: Tue,  3 Nov 2020 07:21:45 -0800
Message-Id: <20201103152150.2677566-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
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
index 0e597c2989..dd16606bcd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1329,10 +1329,12 @@ F: hw/riscv/microchip_pfsoc.c
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
index 770149e47a..1cd48e8a0f 100644
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


