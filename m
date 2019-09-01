Return-Path: <SRS0=Jh9c=W4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:08:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A46D21852
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2019 03:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGgoaQ1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A46D21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4GE7-00057K-OF
	for qemu-devel@archiver.kernel.org; Sat, 31 Aug 2019 23:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzk-0007gO-B8
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i4Fzi-0006VI-7B
 for qemu-devel@nongnu.org; Sat, 31 Aug 2019 22:53:36 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38741)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i4Fzg-0006Sp-Pu; Sat, 31 Aug 2019 22:53:34 -0400
Received: by mail-pf1-x444.google.com with SMTP id h195so373063pfe.5;
 Sat, 31 Aug 2019 19:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=iJz2oy3/r4Vo4pDQEeE5a6lFCZ/MoVnft6l4RWY5HAQ=;
 b=VGgoaQ1P9Nz+qpw7DRhKxSbuA041JOUA8mLtvpO6EvAwwhdW8+9n0kGj879mjVfPLD
 s7e+h7/dt2Su6WHtnq9jyjmM2mJ3TspbXu4GgjrSv7HTPFKk1qRHR2PhXcLD8T7Kml0v
 lTewORYY1aNDbQRgnw8Pfe/n0jnZ/cmdhsApmn+KVN+Fcf9OOjTWLHvABaA4gXT3buPj
 fTbuxA97u97nzFEKKAH6k9TjV4apjO5H9/7p07mjG3eO0TvHzW5klnDfuiDNg2PRSDy4
 l+Y7mRM9JFWyHxc/bQdwdTXmt4YdEKONUv/JofoLLasV3wfYXfU6jmWFFP5uYF+bQhaI
 ZZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=iJz2oy3/r4Vo4pDQEeE5a6lFCZ/MoVnft6l4RWY5HAQ=;
 b=UtgvKu4caBTQpYm0XHmDVhIzNmiHfdaWv0AQRF7VfUb6FQ2U1a1UN0c6dRZ845kxth
 4LnNHCSAYg+pSwTRrW4Zs+dxK5vRX3vlC97fdxYapzz/VkC90yLlA7NNxfL6TF2RDRqd
 nWDxqgVNI/PPXsOBii1E1aaVXkobRWx8yLRBPWm4DU5g+XfplUNUl2NrrBdpYXd39KS/
 PQfxYI29dDz0AZroRo1cr9ba7ZoIl2duGzsxICR1iePfC2MjliJQCAeuagZzTGAdxtyg
 VUZgaM7L4Q1/vxy2AhroRV0W/3AkHdAbogUJVGEpwIO7Eyhx6wLfSer7ujzEw+QvoYnm
 1DLA==
X-Gm-Message-State: APjAAAV02rMK6fpAlu6cm4L0VcPd+lxmuVYdl1x12bjcTpFVtANzs0CL
 DLfo6qUFMETMQNdDfB75uUM=
X-Google-Smtp-Source: APXvYqz5EOvp3/zDhxdifwKtr2wdKFb0M6AW40Jk0HpSE71tO2ZDpIMHYoai/tVz0hezNn7du2LGIA==
X-Received: by 2002:a17:90a:1b62:: with SMTP id
 q89mr6431944pjq.80.1567306411971; 
 Sat, 31 Aug 2019 19:53:31 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id p10sm11453307pff.132.2019.08.31.19.53.30
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Sat, 31 Aug 2019 19:53:31 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Sat, 31 Aug 2019 19:52:53 -0700
Message-Id: <1567306391-2682-13-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
References: <1567306391-2682-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH v7 12/30] riscv: sifive_e: Drop
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

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
- drop patch "riscv: sifive: Move sifive_mmio_emulate() to a common place"
- new patch "riscv: sifive_e: Drop sifive_mmio_emulate()"

 hw/riscv/sifive_e.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 2d67670..040d59f 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -37,6 +37,7 @@
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


