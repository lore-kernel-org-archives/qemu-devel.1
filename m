Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BE0C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234C4206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW5eELTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234C4206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssN5-0003PF-Ax
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAG-0000Cs-Mb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:56 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51448)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jssAE-0002ww-JV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:55 -0400
Received: by mail-wm1-x343.google.com with SMTP id 22so98567wmg.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HbsTKp/p4cEpKC8gDBC3GLx2PfsjnhiMt227ELg1lQQ=;
 b=hW5eELTRQ1vN7XsTdY+DVD7zjvYq9mawplQxUkIAcxYJAX0GEhKFKsFuiWQK0+X7yG
 k66Gdb3Et9eOIxJdgT23fHDDMOo44ZirOSwsYMGmW6+al7kLI4l27ivoLuLZ+FBkRW86
 ClsainyOxWaGD3+VYszBKccXoOezYlQZEIaTyx5vW9Si+21YhVG///EAF3Vh5wS8ED9K
 rj8hSCBKsvvv/6XjjqVrq/aUFIKPM988zjhhaiFhJU+taHu63TnBVnVc1qoHFA0p7Y3B
 ifY5NtQRorQkMfFJov5q5T4GXM2hTuAiVbFM7HL8RglVfLkG801v7+R7FI32F7pWmOs9
 /D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HbsTKp/p4cEpKC8gDBC3GLx2PfsjnhiMt227ELg1lQQ=;
 b=PW9zZh4gAnedncqc/iSS+kP14NmLvz2v1wAmYyve+1RFCLyFqeyDNc0eSmZ/fhQWvD
 gx/cHH9yYRiH9HYalgDY6zgnjtvcqQ37d2oS+dRg6gweL8eXZScCfFHc713oqUhA5flv
 wJbz5NORAsgqBaipGKpCn6RTr3GlhPbmebh69Ihc8vtX9WCdhgaiBTcUWLzkGHv93MvV
 DH3x+H7VwVpWwn4Le7NsTfQQwCc+T7E2GcvFS3iK9S/dm/GCI7AdW4BxT9SPIxPfdrSm
 TzKoPivAkFBru+K4OtlHC7iNofPZFi75/fByhn+imlJGXrVAUDQ83jYu8MDD6SkQpLw7
 58rA==
X-Gm-Message-State: AOAM532yFX6M3nX4e0nEYWgRnDtmrPjRo0KmJirRzLB1bmHPDE517Vm1
 ptUw3FwnDw4xVSqLNx9x+6jhJrDt
X-Google-Smtp-Source: ABdhPJw/ue8XCB8OirYiKhW1nIBACUuPrB60bhN5cJlRiqRy79zPOrbyqjVzJKR1b6BI4BqEnRiIJg==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr5678446wmh.77.1594145871548;
 Tue, 07 Jul 2020 11:17:51 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/32] hw/avr: Add support for loading ELF/raw binaries
Date: Tue,  7 Jul 2020 20:17:02 +0200
Message-Id: <20200707181710.30950-25-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add avr_load_firmware() function to load firmware in ELF or
raw binary format.

[AM: Corrected the type of the variable containing e_flags]
[AM: Moved definition of e_flags conversion function to boot.c]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Reviewed-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-24-huth@tuxfamily.org>
[PMD: Replace load_image_targphys() by load_image_mr()]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/avr/boot.h        |  33 +++++++++++++
 include/elf.h        |   4 ++
 hw/avr/boot.c        | 115 +++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |   1 +
 hw/avr/Makefile.objs |   1 +
 5 files changed, 154 insertions(+)
 create mode 100644 hw/avr/boot.h
 create mode 100644 hw/avr/boot.c
 create mode 100644 hw/avr/Makefile.objs

diff --git a/hw/avr/boot.h b/hw/avr/boot.h
new file mode 100644
index 0000000000..684d553322
--- /dev/null
+++ b/hw/avr/boot.h
@@ -0,0 +1,33 @@
+/*
+ * AVR loader helpers
+ *
+ * Copyright (c) 2019-2020 Philippe Mathieu-Daudé
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
index 8fbfe60e09..5b06b55f28 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -160,6 +160,8 @@ typedef struct mips_elf_abiflags_v0 {
 
 #define EM_CRIS         76      /* Axis Communications 32-bit embedded processor */
 
+#define EM_AVR          83      /* AVR 8-bit microcontroller */
+
 #define EM_V850		87	/* NEC v850 */
 
 #define EM_H8_300H      47      /* Hitachi H8/300H */
@@ -202,6 +204,8 @@ typedef struct mips_elf_abiflags_v0 {
 #define EM_MOXIE           223     /* Moxie processor family */
 #define EM_MOXIE_OLD       0xFEED
 
+#define EF_AVR_MACH     0x7F       /* Mask for AVR e_flags to get core type */
+
 /* This is the info that is needed to parse the dynamic section of the file */
 #define DT_NULL		0
 #define DT_NEEDED	1
diff --git a/hw/avr/boot.c b/hw/avr/boot.c
new file mode 100644
index 0000000000..6fbcde4061
--- /dev/null
+++ b/hw/avr/boot.c
@@ -0,0 +1,115 @@
+/*
+ * AVR loader helpers
+ *
+ * Copyright (c) 2019-2020 Philippe Mathieu-Daudé
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
+static const char *avr_elf_e_flags_to_cpu_type(uint32_t flags)
+{
+    switch (flags & EF_AVR_MACH) {
+    case bfd_mach_avr1:
+        return AVR_CPU_TYPE_NAME("avr1");
+    case bfd_mach_avr2:
+        return AVR_CPU_TYPE_NAME("avr2");
+    case bfd_mach_avr25:
+        return AVR_CPU_TYPE_NAME("avr25");
+    case bfd_mach_avr3:
+        return AVR_CPU_TYPE_NAME("avr3");
+    case bfd_mach_avr31:
+        return AVR_CPU_TYPE_NAME("avr31");
+    case bfd_mach_avr35:
+        return AVR_CPU_TYPE_NAME("avr35");
+    case bfd_mach_avr4:
+        return AVR_CPU_TYPE_NAME("avr4");
+    case bfd_mach_avr5:
+        return AVR_CPU_TYPE_NAME("avr5");
+    case bfd_mach_avr51:
+        return AVR_CPU_TYPE_NAME("avr51");
+    case bfd_mach_avr6:
+        return AVR_CPU_TYPE_NAME("avr6");
+    case bfd_mach_avrtiny:
+        return AVR_CPU_TYPE_NAME("avrtiny");
+    case bfd_mach_avrxmega2:
+        return AVR_CPU_TYPE_NAME("xmega2");
+    case bfd_mach_avrxmega3:
+        return AVR_CPU_TYPE_NAME("xmega3");
+    case bfd_mach_avrxmega4:
+        return AVR_CPU_TYPE_NAME("xmega4");
+    case bfd_mach_avrxmega5:
+        return AVR_CPU_TYPE_NAME("xmega5");
+    case bfd_mach_avrxmega6:
+        return AVR_CPU_TYPE_NAME("xmega6");
+    case bfd_mach_avrxmega7:
+        return AVR_CPU_TYPE_NAME("xmega7");
+    default:
+        return NULL;
+    }
+}
+
+bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
+                       MemoryRegion *program_mr, const char *firmware)
+{
+    const char *filename;
+    int bytes_loaded;
+    uint64_t entry;
+    uint32_t e_flags;
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
+        const char *elf_cpu = avr_elf_e_flags_to_cpu_type(e_flags);
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
+        bytes_loaded = load_image_mr(filename, program_mr);
+    }
+    if (bytes_loaded < 0) {
+        error_report("Unable to load firmware image %s as ELF or raw binary",
+                     firmware);
+        return false;
+    }
+    return true;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 443b377a72..a78d4e56ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -983,6 +983,7 @@ M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
 F: default-configs/avr-softmmu.mak
+F: hw/avr/
 F: include/hw/char/avr_usart.h
 F: hw/char/avr_usart.c
 F: include/hw/timer/avr_timer16.h
diff --git a/hw/avr/Makefile.objs b/hw/avr/Makefile.objs
new file mode 100644
index 0000000000..123f174f0e
--- /dev/null
+++ b/hw/avr/Makefile.objs
@@ -0,0 +1 @@
+obj-y += boot.o
-- 
2.21.3


