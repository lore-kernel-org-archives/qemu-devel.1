Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2D0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3E1207FC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ok1ab90t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3E1207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6H8L-00085Y-4g
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyY-0004Oj-FP
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i6GyW-0004O8-U5
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:20:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i6GyW-0004MK-NB; Fri, 06 Sep 2019 12:20:40 -0400
Received: by mail-pf1-x442.google.com with SMTP id b13so4812627pfo.8;
 Fri, 06 Sep 2019 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=/RN9nZXvP0uSw1tz5BCNyGHsFKQ0hz+y0eelBzez5L0=;
 b=ok1ab90tU1vuv2m98ZmRJZlsv0BoDcwgP2BEKMd4e/qsIWZO1Kd/7n6/j91AsfsfRJ
 Uj/2bT9gBHgcgZKBvUbc+8d+Y4kyNFzIVC9Xq3VU+B10xbwNDnCg66bmaZXV6UcWLR3I
 nByaGPLX6SukP3tvaJS+/JrX8uOyEit6zE7NLfPyh+sBj7OBf4Oa3efV4i2ogktHsTLQ
 GqSo9CgCAmVNysnpXog3jp0lTPoQxGh8cjU7d8vMJTMK6R3EbeFZQ/aYeQfAj8JJ9yIm
 dvhBt9sdzolShzCw7X0s7KqJxlJ8IZ2KMZRaRJ4cct+ggvoPEYEX7IkF3Blb1ZFIH6b3
 xBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=/RN9nZXvP0uSw1tz5BCNyGHsFKQ0hz+y0eelBzez5L0=;
 b=pjjhtCVlfJA5rtKPbaaNC033eSsRhKQqQNrHm12pdbwHl33xUkS2Wr4q09W3cvaRBG
 Cw/LpUaV9PCM8srY8CJFR/9J4cl2guiSo0HJG/vlS+Y4kw3eqACRdENRuDfYivISTGlO
 FMWKZV2lple2PsskiNrdxqzVSkQvZbUFGarenLHOi0JyLVRy9bUTFinbcIN7cLFE8Q2j
 VyOBnm2RxhQKbsYdlTPGuRRbukduuKUd+QqetrF9dUxr48AcLEeoQvyFI497g/amc3TX
 ozEmbujT6PkH9yVCRcGSIUZ5KOf/8UcZMxRK6Tdd1y1ZxuS7vC+OxwTViA1EmVU1VB0l
 6PQg==
X-Gm-Message-State: APjAAAWEBo7jPX/FBjX67WM+7G41GrHzCuLVIocsWHAzVb24JfbdJ1jS
 qhGtrBBsenZp6TLVJhflDh4=
X-Google-Smtp-Source: APXvYqzH9YKyplTZTx7Je0P0PfWF5mIhwSCL+lMr/1tTdlV24JHRy3QC42tFF35U5iRNMEaMtMlD8g==
X-Received: by 2002:a62:7684:: with SMTP id r126mr11227610pfc.26.1567786839992; 
 Fri, 06 Sep 2019 09:20:39 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id f89sm11146228pje.20.2019.09.06.09.20.38
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Fri, 06 Sep 2019 09:20:39 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Fri,  6 Sep 2019 09:20:01 -0700
Message-Id: <1567786819-22142-15-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH v8 14/32] riscv: sifive_e: Drop
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use create_unimplemented_device() instead.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

---

Changes in v8:
- select UNIMP in sifive_e Kconfig due to applied commit
  "hw/misc: Add a config switch for the "unimplemented" device"
  in latest qemu/master

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- drop patch "riscv: sifive: Move sifive_mmio_emulate() to a common place"
- new patch "riscv: sifive_e: Drop sifive_mmio_emulate()"

 hw/riscv/Kconfig    |  1 +
 hw/riscv/sifive_e.c | 23 ++++++++---------------
 2 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 8674211..33e54b0 100644
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
index 1428a99..0f9d641 100644
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
2.7.4


