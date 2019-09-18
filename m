Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B24C4CECE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA267206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 15:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA267206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAcDN-0000t1-Ml
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 11:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsX-0007GB-77
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iAbsV-0006tv-SD
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38547)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iAbsV-0006tJ-J0
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 11:28:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id w10so118913plq.5
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 08:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=1Aa/dt536fZQJDPGXIgu6PlloiU8ircw4pByaQneOdE=;
 b=KAk8U0WxuQkmMPyf7Gbzu3IEkRnTF4I/4HZBGLB1PMrMyYynbUIGtfAPNZf3ntNKQi
 O34e7CV/bgXQIFf02WIQ8xA4iiADjozH53FhLxeBTFyAHUQ7hswmz1CIbAtIxCrTpxja
 AigHnyqfWR/pM1562OY8kW82IORHJjVDdbYnXag/bh2nNUxpyChRInHzLFgw4oRmvzd7
 wctXqOzMG5lM2qsQ9gUei3MAi2HjA/ctiDqMfD0R84SY4pr/f4PQQW9Sr0VV9nHYcoZ4
 /wN3N0MDFVSNLqydtKwq6wN3vrFH4YdRyaJ1uxS3igqUNtHj+Upp5xh7RB/3aiNKck9u
 48ow==
X-Gm-Message-State: APjAAAWYYlTHmwDky4qshgcSuP9ERIPMXwuMrJdAm/GSPgcA8eBppYVS
 f+eX3x0A3Unps/h2Z1PdYXz3+w==
X-Google-Smtp-Source: APXvYqx8ub172HW999gq2z6BCRdxn5InVOK8kNH27xTtqtVhx0bjZZnTPvOwUwHe021Br+ZuIX16AQ==
X-Received: by 2002:a17:902:426:: with SMTP id
 35mr4924313ple.192.1568820502156; 
 Wed, 18 Sep 2019 08:28:22 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 127sm8104120pfy.56.2019.09.18.08.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2019 08:28:21 -0700 (PDT)
Date: Wed, 18 Sep 2019 07:56:18 -0700
Message-Id: <20190918145640.17349-27-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918145640.17349-1-palmer@sifive.com>
References: <20190918145640.17349-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.193
Subject: [Qemu-devel] [PULL 26/48] riscv: sifive_e: Drop
 sifive_mmio_emulate()
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

Use create_unimplemented_device() instead.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/Kconfig    |  1 +
 hw/riscv/sifive_e.c | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 8674211085..33e54b031d 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -12,6 +12,7 @@ config SIFIVE_E
     bool
     select HART
     select SIFIVE
+    select UNIMP
 
 config SIFIVE_U
     bool
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 1428a99fce..0f9d641a0e 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -36,6 +36,7 @@
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
+#include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
@@ -74,14 +75,6 @@ static const struct MemmapEntry {
     [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
 };
 
-static void sifive_mmio_emulate(MemoryRegion *parent, const char *name,
-                             uintptr_t offset, uintptr_t length)
-{
-    MemoryRegion *mock_mmio = g_new(MemoryRegion, 1);
-    memory_region_init_ram(mock_mmio, NULL, name, length, &error_fatal);
-    memory_region_add_subregion(parent, offset, mock_mmio);
-}
-
 static void riscv_sifive_e_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_e_memmap;
@@ -172,7 +165,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
     sifive_clint_create(memmap[SIFIVE_E_CLINT].base,
         memmap[SIFIVE_E_CLINT].size, ms->smp.cpus,
         SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
-    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
+    create_unimplemented_device("riscv.sifive.e.aon",
         memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
     sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
 
@@ -199,19 +192,19 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
 
     sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_IRQ));
-    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi0",
+    create_unimplemented_device("riscv.sifive.e.qspi0",
         memmap[SIFIVE_E_QSPI0].base, memmap[SIFIVE_E_QSPI0].size);
-    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm0",
+    create_unimplemented_device("riscv.sifive.e.pwm0",
         memmap[SIFIVE_E_PWM0].base, memmap[SIFIVE_E_PWM0].size);
     sifive_uart_create(sys_mem, memmap[SIFIVE_E_UART1].base,
         serial_hd(1), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART1_IRQ));
-    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi1",
+    create_unimplemented_device("riscv.sifive.e.qspi1",
         memmap[SIFIVE_E_QSPI1].base, memmap[SIFIVE_E_QSPI1].size);
-    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm1",
+    create_unimplemented_device("riscv.sifive.e.pwm1",
         memmap[SIFIVE_E_PWM1].base, memmap[SIFIVE_E_PWM1].size);
-    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.qspi2",
+    create_unimplemented_device("riscv.sifive.e.qspi2",
         memmap[SIFIVE_E_QSPI2].base, memmap[SIFIVE_E_QSPI2].size);
-    sifive_mmio_emulate(sys_mem, "riscv.sifive.e.pwm2",
+    create_unimplemented_device("riscv.sifive.e.pwm2",
         memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
 
     /* Flash memory */
-- 
2.21.0


