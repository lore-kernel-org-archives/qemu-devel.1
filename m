Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74DDC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2194922267
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 05:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKYYpslc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2194922267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXeAM-0005k3-Kh
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 01:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2o-0005Jg-32; Wed, 28 Oct 2020 01:30:46 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:44924)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kXe2l-0000dQ-4P; Wed, 28 Oct 2020 01:30:45 -0400
Received: by mail-pg1-x533.google.com with SMTP id o3so2098760pgr.11;
 Tue, 27 Oct 2020 22:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=j/5zRvyDLwKSrISeiJ/ESPnFS4E7AXqsSOBYVI0H/Sk=;
 b=FKYYpslcxzc1kBmChAPP4fSsbnMeOQtDhrtZ6XK1ptd1i3CHGEfIPZgI75L5y7VEK9
 08gWFkX7v+eEp/iIeTFsaiwlDJ0PPtmCNyl/ieuyzWFv1lFvrO94VDksuKg6UvUVnhcz
 iXRvFZWKLd0af6AWcV/QXK9+hCue2MNGPGcUnx3uJqhv+oycRO+C3dZ67vqM4n2adnIM
 zvU650Wgkb66ERofJKlnyEr4mI65MGdbPpzC8u2hqymyuszD4zd/LPekcHbgsTwJmclA
 xdyYq/kjSXti9wq7/k6b/tf2IBKIqNHqrER/cX8GcFtblygTi/wLHLWQcH4gQVD8X05J
 2HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=j/5zRvyDLwKSrISeiJ/ESPnFS4E7AXqsSOBYVI0H/Sk=;
 b=Pe8m+fChWFQN98MO7z+6+dANxQcLKvm1x6HTI/Y20mEAXBwL0szzN+nAbNIagJfX9C
 iHe5vo5TBwBGQIUp1oMsxPhrPbJ/9LCNvLI4K4dejanZrs8MNkRn3qT3mDd+GpZ3QSrE
 16GQriTaKeVX02YsipwSc+R8LPzrUuiwoJOj+EkMgPKIGTqgG+s6ZSw/fKsj9OC2c422
 KGOxo9JgrBlJ6MOtie6hWkXMFCM9b+l967hKX3FzQNBUyMmurKSx+tmuDUFUWns4P0qT
 31XxbSok3dMLFrXPpVpTqVNYBeuuL2WV22IhVWrMi9YpWgDxVBtdn46Ai8L9ceV07A4E
 d1zQ==
X-Gm-Message-State: AOAM53129JgDjWfPoOnen5DnD0YP3MfHDpO9ZaDZjs9e2ykXMFoAwF6n
 qdl8H5ya94RIC8pTzmt5aRvmGlVZzhA=
X-Google-Smtp-Source: ABdhPJzY6oAimbXq56bJfsWNrIgjte6x0P1Hq6ftRjk4z483JdrfMIDyYfpDuuJwV7HDt+osAjuVKg==
X-Received: by 2002:aa7:9905:0:b029:155:73b6:6f7d with SMTP id
 z5-20020aa799050000b029015573b66f7dmr5932305pff.78.1603863040745; 
 Tue, 27 Oct 2020 22:30:40 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id 9sm5031887pjs.1.2020.10.27.22.30.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Oct 2020 22:30:40 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v2 06/10] hw/misc: Add Microchip PolarFire SoC SYSREG module
 support
Date: Wed, 28 Oct 2020 13:30:06 +0800
Message-Id: <1603863010-15807-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
References: <1603863010-15807-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x533.google.com
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
Cc: Bin Meng <bin.meng@windriver.com>, Atish Patra <atish.patra@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, Ivan Griffin <ivan.griffin@emdalo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This creates a minimum model for Microchip PolarFire SoC SYSREG
module. It only implements the ENVM_CR register to tell guest
software that eNVM is running at the configured divider rate.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---

(no changes since v1)

 MAINTAINERS                         |  2 +
 hw/misc/Kconfig                     |  3 ++
 hw/misc/mchp_pfsoc_sysreg.c         | 99 +++++++++++++++++++++++++++++++++++++
 hw/misc/meson.build                 |  1 +
 include/hw/misc/mchp_pfsoc_sysreg.h | 39 +++++++++++++++
 5 files changed, 144 insertions(+)
 create mode 100644 hw/misc/mchp_pfsoc_sysreg.c
 create mode 100644 include/hw/misc/mchp_pfsoc_sysreg.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ebbc62a..e82f2b3 100644
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
index 3db15e0..546e2fa 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -140,6 +140,9 @@ config MCHP_PFSOC_DMC
 config MCHP_PFSOC_IOSCB
     bool
 
+config MCHP_PFSOC_SYSREG
+    bool
+
 config SIFIVE_TEST
     bool
 
diff --git a/hw/misc/mchp_pfsoc_sysreg.c b/hw/misc/mchp_pfsoc_sysreg.c
new file mode 100644
index 0000000..248a313
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
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 6d3c1a3..8ed7525 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -24,6 +24,7 @@ softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 # RISC-V devices
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_DMC', if_true: files('mchp_pfsoc_dmc.c'))
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_IOSCB', if_true: files('mchp_pfsoc_ioscb.c'))
+softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_SYSREG', if_true: files('mchp_pfsoc_sysreg.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
diff --git a/include/hw/misc/mchp_pfsoc_sysreg.h b/include/hw/misc/mchp_pfsoc_sysreg.h
new file mode 100644
index 0000000..546ba68
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
-- 
2.7.4


