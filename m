Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87457C35242
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5471B2071E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHK64CCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5471B2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iunGS-0002N2-Aw
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCy-0002dl-84
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCw-0005bS-8P
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:52:24 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iunCw-0005ZT-1b; Thu, 23 Jan 2020 19:52:22 -0500
Received: by mail-wm1-x342.google.com with SMTP id p17so146748wma.1;
 Thu, 23 Jan 2020 16:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Wn/b5e0hYxjWbkJVXyQPyX2UxO9y0IeO0Qmgm+3sqXU=;
 b=DHK64CCEwniEBPz36VcJhwTa1sb6g9uNqsyRPJI1yA2fGEfny1zU3i9i0DrTrEGn9d
 TSLUh7AzaWJ1984CZsHnOgE5RYyTeStk5zHg14w1NW4+qZWdiVqAqWUZwwFj8Gv70wQb
 PmzUze64oBRWLxdYMaLRTUvQ5Ti70gGD9xGyxgFIc34kUmL3vLmwIB0OQJ2w8uSmFpGE
 yIZoehrAIYopuQOGF3G5/cDL/kSEC0trDjIvK7kVAXjfUwAjuL9Z1o6I18aWyy2dc+kX
 qJsvk5OWbDEq1GHiUQIEvGlBp7lcAlu3aUbh9CmO5dbIZlz8vrJrvizkQTOvMuFj+HSu
 DG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Wn/b5e0hYxjWbkJVXyQPyX2UxO9y0IeO0Qmgm+3sqXU=;
 b=t1ULE9Sdqp7p1T+upAepkglsXD2QoPeF3azdBSD8KpPzog4BhOeNxEnCrCMDC5/KsD
 RsGuxN4StcBUR6eKeZRxne8+scgZ2RvyB82MV2RSHIzSMFusBs6+VSBboOxuEO45bCBe
 /KRLPLrnN50K4RJ8cBhXu7LrnCnU4/K0s2bY437Sp475ysE8r4wAWwJNcHgCwexxzAMd
 WgMzFhFy6Xzw6L9A15i89bCMoIYIwc4G20+Z84SahJ1VGwGY7K15Z2RkF8wmAu/mMWZQ
 fdDyOrHSym0VxG1rt09/rXHVQ45c00hkI1AX0S71gEKkwpvg5VB7bRcueSX3sExarudZ
 fPWg==
X-Gm-Message-State: APjAAAXp2fq+26iMIE2b+kgH0FqHD3uvv7evN3pDOmhh7Evoa3TTdk34
 5LzD8+wjKH7kB8leqsnaoIcxbLao
X-Google-Smtp-Source: APXvYqx4MdJ5ovjlpVfAtGzGfuaL+KumnswpemnAk2jS7XrGPHVQpAPD6HXtTo228S56ZPU7Al5Q4A==
X-Received: by 2002:a05:600c:1009:: with SMTP id
 c9mr554909wmc.162.1579827138366; 
 Thu, 23 Jan 2020 16:52:18 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id s139sm4598271wme.35.2020.01.23.16.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 16:52:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, mrolnik@gmail.com, richard.henderson@linaro.org,
 me@xcancerberox.com.ar
Subject: [PATCH rc2 19/25] hw/avr: Add helper to load raw/ELF firmware binaries
Date: Fri, 24 Jan 2020 01:51:25 +0100
Message-Id: <20200124005131.16276-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
References: <20200124005131.16276-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 S.E.Harris@kent.ac.uk, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, dovgaluk@ispras.ru,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, thuth@redhat.com,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, imammedo@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, aleksandar.m.mail@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add avr_load_firmware() function to load firmware in ELF or
raw binary format.

Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/avr/boot.h        | 33 ++++++++++++++++++++
 include/elf.h        |  2 ++
 hw/avr/boot.c        | 74 ++++++++++++++++++++++++++++++++++++++++++++
 hw/avr/Makefile.objs |  1 +
 4 files changed, 110 insertions(+)
 create mode 100644 hw/avr/boot.h
 create mode 100644 hw/avr/boot.c
 create mode 100644 hw/avr/Makefile.objs

diff --git a/hw/avr/boot.h b/hw/avr/boot.h
new file mode 100644
index 0000000000..62bc10c922
--- /dev/null
+++ b/hw/avr/boot.h
@@ -0,0 +1,33 @@
+/*
+ * AVR loader helpers
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPLv2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_AVR_BOOT_H
+#define HW_AVR_BOOT_H
+
+#include "hw/boards.h"
+#include "cpu.h"
+
+/**
+ * avr_load_firmware:   load an image into a memory region
+ *
+ * @cpu:        Handle a AVR CPU object
+ * @ms:         A MachineState
+ * @mr:         Memory Region to load into
+ * @firmware:   Path to the firmware file (raw binary or ELF format)
+ *
+ * Load a firmware supplied by the machine or by the user  with the
+ * '-bios' command line option, and put it in target memory.
+ *
+ * Returns: true on success, false on error.
+ */
+bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
+                       MemoryRegion *mr, const char *firmware);
+
+#endif
diff --git a/include/elf.h b/include/elf.h
index 3501e0c8d0..53cdfa23b7 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -202,6 +202,8 @@ typedef struct mips_elf_abiflags_v0 {
 #define EM_MOXIE           223     /* Moxie processor family */
 #define EM_MOXIE_OLD       0xFEED
 
+#define EM_AVR 83 /* AVR 8-bit microcontroller */
+
 /* This is the info that is needed to parse the dynamic section of the file */
 #define DT_NULL		0
 #define DT_NEEDED	1
diff --git a/hw/avr/boot.c b/hw/avr/boot.c
new file mode 100644
index 0000000000..2d9bd0fe59
--- /dev/null
+++ b/hw/avr/boot.c
@@ -0,0 +1,74 @@
+/*
+ * AVR loader helpers
+ *
+ * Copyright (c) 2019 Philippe Mathieu-Daudé
+ *
+ * This work is licensed under the terms of the GNU GPLv2 or later.
+ * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "boot.h"
+#include "qemu/error-report.h"
+
+bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
+                       MemoryRegion *mr, const char *firmware)
+{
+    const char *filename;
+    int bytes_loaded;
+    uint64_t entry;
+    int e_flags;
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+    if (filename == NULL) {
+        error_report("Unable to find %s", firmware);
+        return false;
+    }
+
+    bytes_loaded = load_elf_ram_sym(filename,
+                                    NULL, NULL, NULL,
+                                    &entry, NULL, NULL,
+                                    &e_flags, 0, EM_AVR, 0, 0,
+                                    NULL, true, NULL);
+    if (bytes_loaded >= 0) {
+        /* If ELF file is provided, determine CPU type reading ELF e_flags. */
+        const char *elf_cpu = avr_flags_to_cpu_type(e_flags, NULL);
+        const char *mcu_cpu_type = object_get_typename(OBJECT(cpu));
+        int cpu_len = strlen(mcu_cpu_type) - strlen(AVR_CPU_TYPE_SUFFIX);
+
+        if (entry) {
+            error_report("BIOS entry_point must be 0x0000 "
+                         "(ELF image '%s' has entry_point 0x%04" PRIx64 ")",
+                         firmware, entry);
+            return false;
+        }
+        if (!elf_cpu) {
+            warn_report("Could not determine CPU type for ELF image '%s', "
+                        "assuming '%.*s' CPU",
+                         firmware, cpu_len, mcu_cpu_type);
+            return true;
+        }
+        if (strcmp(elf_cpu, mcu_cpu_type)) {
+            error_report("Current machine: %s with '%.*s' CPU",
+                         MACHINE_GET_CLASS(ms)->desc, cpu_len, mcu_cpu_type);
+            error_report("ELF image '%s' is for '%.*s' CPU",
+                         firmware,
+                         (int)(strlen(elf_cpu) - strlen(AVR_CPU_TYPE_SUFFIX)),
+                         elf_cpu);
+            return false;
+        }
+    } else {
+        bytes_loaded = load_image_targphys(filename, OFFSET_CODE,
+                                           memory_region_size(mr));
+    }
+    if (bytes_loaded < 0) {
+        error_report("Unable to load firmware image %s as ELF or raw binary",
+                     firmware);
+        return false;
+    }
+    return true;
+}
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
new file mode 100644
index 0000000000..123f174f0e
--- /dev/null
+++ b/hw/avr/Makefile.objs
@@ -0,0 +1 @@
+obj-y += boot.o
-- 
2.21.1


