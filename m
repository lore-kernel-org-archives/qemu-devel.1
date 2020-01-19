Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886FFC32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 563FE2467C
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAs9A+bW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563FE2467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isyv6-00008V-Ca
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 19:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyoH-0006z7-HP
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyoG-0008NK-2A
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:25 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isyoF-0008MS-Rn; Sat, 18 Jan 2020 19:51:24 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so10950082wmc.2;
 Sat, 18 Jan 2020 16:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=G999Gq0fdq01jCg9kAdMJxYO34Fu4j9UBCr1xo3cI5k=;
 b=OAs9A+bWJGTVAOqCUTsgDiAzmf9ZQR153PZppMVhV8aXPUquJrZtLaaADtSsp8hRGq
 EenQcMmMeHRtivQ7ueH9mvwNU3ZET2i/tKV12jYWaFU/yZkwK9kARKMLgwo/xbCpFI/A
 kZC9/mOCpXY0ZYviIWdLPpiAOOaTFnuga1C9s18SymQZD+u9oF1vYcksN4yPWXmqf7I+
 ldOoHAbIbQjCz8LHncd/hwYrsjaK0p/yKUdAonoZNoAMqz+At/Gh7OBq3bYJRALWtC8/
 XcRxhiWwsZHykw6CzLKT0W3ZrSUiUQdpzH4Vp3DmCR5KxN0OtcAulG1/WlAC3suopk1F
 E+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=G999Gq0fdq01jCg9kAdMJxYO34Fu4j9UBCr1xo3cI5k=;
 b=oBfW7VhV6MMtO8Kugt9Bk1sG2sZ4XfggMtMabrO/Wx0E/nKZidStIEmGmyu2kHs92V
 4LltFvZ1rNuJkt6KklJAMAQdwBKQGJyA0VpdEotR4kvzKQSY8lh6F0RYmGKcEZvwG4qk
 J2lwqpEOwphCLqbF31DyzL0RpWEEGgOwqfdpsJpsX83Lpjjrt9vc2x08m83VRp3iTTu0
 0JNC8ef2nqL/Z7b+BPYEbxPSxfzju+nit82Q8amYIQtOhaOxMIQZyZWULQiNzOBvUYO5
 0IaCudgtYeTp3+sm/pZFcEvnf4CZqH3hX0UDEjsXJEOmF14LD8v3JIVmrciXA7NRiIzf
 FiKQ==
X-Gm-Message-State: APjAAAX//p08E3SPPX7TyzY3PtP7TUXB80iRWzFzmFX72hTV3CKfkmwp
 s1nz6XVkbhtWOIDBaj8CQ39AzJ9mWs0=
X-Google-Smtp-Source: APXvYqzYDxCVT2pxd8F0m0NvTAR9nISPI1QY1+aeYXJggx8iFuKLxK9Q/EOjnd/9fRRvZQ/QmkHr3w==
X-Received: by 2002:a1c:7203:: with SMTP id n3mr11810175wmc.119.1579395082611; 
 Sat, 18 Jan 2020 16:51:22 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id h2sm41763568wrv.66.2020.01.18.16.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 16:51:22 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/20] hw/arm/allwinner-h3: add Boot ROM support
Date: Sun, 19 Jan 2020 01:50:52 +0100
Message-Id: <20200119005102.3847-11-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119005102.3847-1-nieklinnenbank@gmail.com>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A real Allwinner H3 SoC contains a Boot ROM which is the
first code that runs right after the SoC is powered on.
The Boot ROM is responsible for loading user code (e.g. a bootloader)
from any of the supported external devices and writing the downloaded
code to internal SRAM. After loading the SoC begins executing the code
written to SRAM.

This commits adds emulation of the Boot ROM firmware setup functionality
by loading user code from SD card in the A1 SRAM. While the A1 SRAM is
64KiB, we limit the size to 32KiB because the real H3 Boot ROM also rejects
sizes larger than 32KiB. For reference, this behaviour is documented
by the Linux Sunxi project wiki at:

  https://linux-sunxi.org/BROM#U-Boot_SPL_limitations

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++
 hw/arm/allwinner-h3.c         | 28 ++++++++++++++++++++++++++++
 hw/arm/orangepi.c             |  5 +++++
 3 files changed, 56 insertions(+)

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index f9b9a02373..f5e16266cd 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -46,6 +46,7 @@
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/net/allwinner-sun8i-emac.h"
 #include "target/arm/cpu.h"
+#include "sysemu/block-backend.h"
 
 /**
  * Allwinner H3 device list
@@ -129,4 +130,26 @@ typedef struct AwH3State {
     MemoryRegion sram_c;
 } AwH3State;
 
+/**
+ * Emulate Boot ROM firmware setup functionality.
+ *
+ * A real Allwinner H3 SoC contains a Boot ROM
+ * which is the first code that runs right after
+ * the SoC is powered on. The Boot ROM is responsible
+ * for loading user code (e.g. a bootloader) from any
+ * of the supported external devices and writing the
+ * downloaded code to internal SRAM. After loading the SoC
+ * begins executing the code written to SRAM.
+ *
+ * This function emulates the Boot ROM by copying 32 KiB
+ * of data from the given block device and writes it to
+ * the start of the first internal SRAM memory.
+ *
+ * @s: Allwinner H3 state object pointer
+ * @blk: Block backend device object pointer
+ * @errp: Error object pointer for raising errors
+ */
+void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk,
+                                Error **errp);
+
 #endif /* HW_ARM_ALLWINNER_H3_H */
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index 1085223812..3d0470825a 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -29,6 +29,7 @@
 #include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
 
@@ -170,6 +171,33 @@ enum {
     AW_H3_GIC_NUM_SPI       = 128
 };
 
+void allwinner_h3_bootrom_setup(AwH3State *s, BlockBackend *blk, Error **errp)
+{
+    uint8_t *buffer;
+    int64_t rom_size = 32 * KiB;
+
+    int64_t blk_size = blk_getlength(blk);
+    if (blk_size <= 0) {
+        error_setg(errp, "%s: failed to get BlockBackend size", __func__);
+        return;
+    }
+
+    if (rom_size > blk_size) {
+        rom_size = blk_size;
+    }
+
+    buffer = g_new0(uint8_t, rom_size);
+    if (blk_pread(blk, 8 * KiB, buffer, rom_size) < 0) {
+        error_setg(errp, "%s: failed to read BlockBackend data", __func__);
+        return;
+    }
+
+    rom_add_blob("allwinner-h3.bootrom", buffer, rom_size,
+                  rom_size, s->memmap[AW_H3_SRAM_A1],
+                  NULL, NULL, NULL, NULL, false);
+    g_free(buffer);
+}
+
 static void allwinner_h3_init(Object *obj)
 {
     AwH3State *s = AW_H3(obj);
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 25bf85f8fc..9d4c79885e 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -95,6 +95,11 @@ static void orangepi_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), s->h3->memmap[AW_H3_SDRAM],
                                 &s->sdram);
 
+    /* Load target kernel or start using BootROM */
+    if (!machine->kernel_filename && blk_is_available(blk)) {
+        /* Use Boot ROM to copy data from SD card to SRAM */
+        allwinner_h3_bootrom_setup(s->h3, blk, &error_fatal);
+    }
     orangepi_binfo.loader_start = s->h3->memmap[AW_H3_SDRAM];
     orangepi_binfo.ram_size = machine->ram_size;
     arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
-- 
2.17.1


