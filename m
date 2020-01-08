Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E927DC282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7C0D20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3cVL/WD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7C0D20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHY4-0003Xm-Gt
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVZ-0001NP-9p
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVX-0002cI-HZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:49 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ipHVX-0002bF-AF; Wed, 08 Jan 2020 15:00:47 -0500
Received: by mail-wm1-x343.google.com with SMTP id 20so209800wmj.4;
 Wed, 08 Jan 2020 12:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0WghLTvRQ8IcOw+NJuPyW+dwIBsiVMYEMjDtLCTg2F4=;
 b=A3cVL/WDUY9DsfaGrEP5KLWWrQxObeQqUjo3DFYnb+FNr9ju7LLU5emV5WIX/dOhfb
 qaGdQeCHevhFl00w8TccvTblprumxTxI9H+incSNlAFdkyj3bavFGv4MM64JPX7ZBXVM
 QMM4PGHaQu4SJgzCDNgfhsYy0Th9lodHG08aZ+8CZBzLpoISvLiNMP+0PoI4U3All0w9
 djyQIRBpfz8BasmBVGvYI/T2C0N1osw4TgHX41/bnKCK+95AfB1D5N8VfvUZPYI5CLyx
 LHqhBa5WhdY40rdKEteqqf83gzSiUWcq6Juf6Dx2c+Xn38KDIuWNwYFMMhcrL0EIPmbm
 4VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0WghLTvRQ8IcOw+NJuPyW+dwIBsiVMYEMjDtLCTg2F4=;
 b=QZm1cy8iiHVREcRlhCQhu7jP1zwHUIIsAEGOufiYG4q8LHWle2RQVPOgTWtuISkwZU
 sg2jpeLt52mt7uDjxggg6I0SKj5y6ZTjTP/c08F3THLr7pQVHpy3XGCLOsFgtuwjaUfz
 pM1XHqL/yROhhKmqpgEa2XZ2Rx7da7NkvFLCq7dHu77saQ7F+xMMQLD7dd2NVyba62UV
 TK6GBHAfCqsGMqj3W7EoWP40ORkDIMkZuR/wks+r2LMwd0r02m3chK4SiR9lGPkUeDX5
 cK0f7I7KkWiB2NCr7ER1XhIWaq2Gfm5MdfU+uYxzkgz14DOhugENp/kRl925raVMbV/W
 bo2Q==
X-Gm-Message-State: APjAAAWpQZZY1HFMEwld4d50HocZZgGwttDe9gCkaSMzyac83+1Do8Xv
 Qgc2urM2OJInSDafdKuc/u/pVN9d
X-Google-Smtp-Source: APXvYqxH4/S9qxIAYfV8rqgTGshvr24ly620wfCL3Pae3ZLOkHRhilrx9YGzh0IAl83+4RcMqi2X+w==
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr354753wmd.38.1578513646091; 
 Wed, 08 Jan 2020 12:00:46 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id u18sm4970099wrt.26.2020.01.08.12.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:00:45 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/17] hw/arm/allwinner-h3: add Boot ROM support
Date: Wed,  8 Jan 2020 21:00:13 +0100
Message-Id: <20200108200020.4745-11-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108200020.4745-1-nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A real Allwinner H3 SoC contains a Boot ROM which is the
first code that runs right after the SoC is powered on.
The Boot ROM is responsible for loading user code (e.g. a bootloader)
from any of the supported external devices and writing the downloaded
code to internal SRAM. After loading the SoC begins executing the code
written to SRAM. This commits adds emulation of the Boot ROM firmware
setup functionality by loading user code from SD card.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 include/hw/arm/allwinner-h3.h | 23 +++++++++++++++++++++++
 hw/arm/allwinner-h3.c         | 28 ++++++++++++++++++++++++++++
 hw/arm/orangepi.c             |  3 +++
 3 files changed, 54 insertions(+)

diff --git a/include/hw/arm/allwinner-h3.h b/include/hw/arm/allwinner-h3.h
index 5d74cca28e..4b66227ac4 100644
--- a/include/hw/arm/allwinner-h3.h
+++ b/include/hw/arm/allwinner-h3.h
@@ -50,6 +50,7 @@
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/net/allwinner-sun8i-emac.h"
 #include "target/arm/cpu.h"
+#include "sysemu/block-backend.h"
 
 /**
  * Allwinner H3 device list
@@ -130,4 +131,26 @@ typedef struct AwH3State {
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
index e692432b4e..e7b768ad5b 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -27,6 +27,7 @@
 #include "hw/char/serial.h"
 #include "hw/misc/unimp.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-h3.h"
 
@@ -168,6 +169,33 @@ enum {
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
index 0eb52eb813..b722f49485 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -93,6 +93,9 @@ static void orangepi_init(MachineState *machine)
     if (bios_name) {
         error_report("BIOS not supported for this machine");
         exit(1);
+    } else if (!machine->kernel_filename && blk_is_available(blk)) {
+        /* Use Boot ROM to copy data from SD card to SRAM */
+        allwinner_h3_bootrom_setup(s->h3, blk, &error_fatal);
     }
     orangepi_binfo.loader_start = s->h3->memmap[AW_H3_SDRAM];
     orangepi_binfo.ram_size = machine->ram_size;
-- 
2.17.1


