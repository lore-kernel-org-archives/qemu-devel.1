Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E660AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1262074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqQUMTrP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1262074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYon-00026h-FC
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkD-000478-O0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYkC-0007Wu-Qp
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:32:25 -0400
Received: by mail-wr1-x432.google.com with SMTP id l10so20054054wrr.10
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SlkPl6cNOYs8vWt7/HaIVNoEzcGik+jCQKxQU11fHF0=;
 b=MqQUMTrPHQz5Txx1o8EskLvAcSENSXgFKBf+fEHOJjsLFv6Anf2lZMtt7KRQ+vNWwA
 yzcsUQGm5f0bAemuzDnmA0FDPTes7+wI4or1hlxAFkkrnJCTbfGCy/Z/4YMqPVkzaZE1
 LLx6zjkCFnuNrkq6w3PUsY2Xlv/zNlDkW9OmmXxttPB+576PbspA7cJscSlp+OBMBIQs
 HC+xL5x65HjVitBWttd3b02v7ce9M4D4gBfkBwEVw+6el8fAkjZvvUCK/j7AifOSBv+O
 K6elWAUxcyJ1htwUE2RY+aKw+sczqx/aF8QiuqkNjjcTb2ABbfeFP2dF5jP/Vkg3YCp1
 viWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=SlkPl6cNOYs8vWt7/HaIVNoEzcGik+jCQKxQU11fHF0=;
 b=UaP9gwt3DW2VqjVakZGIfCzwXUGxjrtXO2ZeeYIHhMRpLqLsQAqNWOOqFG6IsW/4WW
 0iOeMT4DxJTvj/i09mlsn459nXb/OY0Dbcut9sEttN6JH46JRAfioOxgSE2oiTKHzGeR
 e8/B9ZHnuudNkHAEMzo5H23VgQK4ybj9r27Gh3YXw6az3AZKyHtZnBOTWlrW8ideG0bb
 t3vY8i/3ETuaP/SPpUPU0ZsSgZjxQXft796JB9eWjHINpx6/2cSyakCVTV6YOqIDa19A
 XVMkfbMYzOjpOQPtm7UA/wCVifk/clhdG5TMTrNUsIjhrv/Eol2jA7fB6QVHAZJrsF3G
 WRgA==
X-Gm-Message-State: AOAM533n89i4gYDDUrCGoEJJJLqCLVu+tYQ08XpAKxGCYSTYcTTCKf98
 H9/7WeYdMSbg0EWf+67OW/lqCXfR
X-Google-Smtp-Source: ABdhPJzW5LmaDIN6qSinzHcDg+sapUfsuyjxaOsRHeglo5azO6WXg5UgGRyQ2KCqKJJcEO+rFmX69w==
X-Received: by 2002:adf:f988:: with SMTP id f8mr3120462wrr.81.1591687943032;
 Tue, 09 Jun 2020 00:32:23 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id m3sm2036192wmc.0.2020.06.09.00.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 00:32:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/16] hw/misc/empty_slot: Move the 'hw/misc' and cover in
 MAINTAINERS
Date: Tue,  9 Jun 2020 09:32:04 +0200
Message-Id: <20200609073214.14079-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609073214.14079-1-f4bug@amsat.org>
References: <20200609073214.14079-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add an entry for the 'empty_slot' device.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>
Message-Id: <20200510152840.13558-7-f4bug@amsat.org>
---
 include/hw/empty_slot.h        |  9 ---------
 include/hw/misc/empty_slot.h   | 19 +++++++++++++++++++
 hw/mips/malta.c                |  2 +-
 hw/{core => misc}/empty_slot.c |  4 ++--
 hw/sparc/sun4m.c               |  2 +-
 MAINTAINERS                    |  7 +++++++
 hw/core/Makefile.objs          |  1 -
 hw/core/trace-events           |  4 ----
 hw/misc/Makefile.objs          |  1 +
 hw/misc/trace-events           |  4 ++++
 10 files changed, 35 insertions(+), 18 deletions(-)
 delete mode 100644 include/hw/empty_slot.h
 create mode 100644 include/hw/misc/empty_slot.h
 rename hw/{core => misc}/empty_slot.c (96%)

diff --git a/include/hw/empty_slot.h b/include/hw/empty_slot.h
deleted file mode 100644
index cb9a221aa6..0000000000
--- a/include/hw/empty_slot.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef HW_EMPTY_SLOT_H
-#define HW_EMPTY_SLOT_H
-
-#include "exec/hwaddr.h"
-
-/* empty_slot.c */
-void empty_slot_init(hwaddr addr, uint64_t slot_size);
-
-#endif
diff --git a/include/hw/misc/empty_slot.h b/include/hw/misc/empty_slot.h
new file mode 100644
index 0000000000..b023bc2d91
--- /dev/null
+++ b/include/hw/misc/empty_slot.h
@@ -0,0 +1,19 @@
+/*
+ * QEMU Empty Slot
+ *
+ * The empty_slot device emulates known to a bus but not connected devices.
+ *
+ * Copyright (c) 2010 Artyom Tarasenko
+ *
+ * This code is licensed under the GNU GPL v2 or (at your option) any later
+ * version.
+ */
+
+#ifndef HW_EMPTY_SLOT_H
+#define HW_EMPTY_SLOT_H
+
+#include "exec/hwaddr.h"
+
+void empty_slot_init(hwaddr addr, uint64_t slot_size);
+
+#endif
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 636c95d1fe..c973c76b2a 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -52,7 +52,7 @@
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/empty_slot.h"
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
diff --git a/hw/core/empty_slot.c b/hw/misc/empty_slot.c
similarity index 96%
rename from hw/core/empty_slot.c
rename to hw/misc/empty_slot.c
index d28f7f99c9..54be085189 100644
--- a/hw/core/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -11,9 +11,8 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "qemu/module.h"
 #include "hw/qdev-properties.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/empty_slot.h"
 #include "trace.h"
 
 #define TYPE_EMPTY_SLOT "empty_slot"
@@ -90,6 +89,7 @@ static void empty_slot_class_init(ObjectClass *klass, void *data)
 
     dc->realize = empty_slot_realize;
     device_class_set_props(dc, empty_slot_properties);
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static const TypeInfo empty_slot_info = {
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index fa3dd7775f..a16e667bee 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -46,7 +46,7 @@
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/empty_slot.h"
 #include "hw/misc/unimp.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7890ce82..3abe3faa4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1864,6 +1864,13 @@ S: Maintained
 F: include/hw/misc/unimp.h
 F: hw/misc/unimp.c
 
+Empty slot
+M: Artyom Tarasenko <atar4qemu@gmail.com>
+R: Philippe Mathieu-Daudé <f4bug@amsat.org>
+S: Maintained
+F: include/hw/misc/empty_slot.h
+F: hw/misc/empty_slot.c
+
 Standard VGA
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Maintained
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 1d540ed6e7..d8fee8effe 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -24,7 +24,6 @@ common-obj-$(CONFIG_SOFTMMU) += numa.o
 common-obj-$(CONFIG_SOFTMMU) += clock-vmstate.o
 obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
 
-common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
 common-obj-$(CONFIG_PTIMER) += ptimer.o
 common-obj-$(CONFIG_FITLOADER) += loader-fit.o
diff --git a/hw/core/trace-events b/hw/core/trace-events
index bbb68fb6f0..1ac60ede6b 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -34,7 +34,3 @@ clock_disconnect(const char *clk) "'%s'"
 clock_set(const char *clk, uint64_t old, uint64_t new) "'%s', ns=%"PRIu64"->%"PRIu64
 clock_propagate(const char *clk) "'%s'"
 clock_update(const char *clk, const char *src, uint64_t val, int cb) "'%s', src='%s', ns=%"PRIu64", cb=%d"
-
-# empty_slot.c
-empty_slot_read(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "rd addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
-empty_slot_write(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "wr addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 60a9d80b74..5aaca8a039 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -10,6 +10,7 @@ common-obj-$(CONFIG_EDU) += edu.o
 common-obj-$(CONFIG_PCA9552) += pca9552.o
 
 common-obj-$(CONFIG_UNIMP) += unimp.o
+common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
 
 # ARM devices
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index a5862b2bed..0cb4c64ae7 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -39,6 +39,10 @@ ecc_mem_readl_ecr1(uint32_t ret) "Read event count 2 0x%08x"
 ecc_diag_mem_writeb(uint64_t addr, uint32_t val) "Write diagnostic %"PRId64" = 0x%02x"
 ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= 0x%02x"
 
+# empty_slot.c
+empty_slot_read(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "rd addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
+empty_slot_write(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "wr addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
+
 # slavio_misc.c
 slavio_misc_update_irq_raise(void) "Raise IRQ"
 slavio_misc_update_irq_lower(void) "Lower IRQ"
-- 
2.21.3


