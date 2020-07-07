Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901F3C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:18:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604B9206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 18:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7YeSOND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604B9206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jssAm-0000cJ-J2
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 14:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9e-0007FK-Mo
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jss9c-0002rK-TE
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 14:17:18 -0400
Received: by mail-wr1-x431.google.com with SMTP id z15so34957126wrl.8
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 11:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eCVeV9EHTE4NBr5vKzxQxX/KvFsPS1dOREom5c8IN8Q=;
 b=K7YeSOND20zH4mkJukgRKi15xoKP3OWgQXOQ9P9092X9N1mIrpdo1GYXdTRUCfeUI7
 pnv+DbXyfR5hiFdFG+ehV1vWLmT04ygpLbB7idMUkpc5iSgrB/nA0w1OYCeui8Nzow1p
 Uq48iHfRfYURRJOeVLKx0r3CdydTiU+zipjgzzFhZaze3nz7GMpORQJn1or3O9bbnbd0
 nIYbmovlfNkydcyuH94nE3hz7U+YSH9jZeVKtV2fTkHSmA72bB67iMybJJyERkECbztr
 r3o3TFYxn7Mr6Vv3hCm1FwMZ/kIcK+HAq9SSvKq8Ua1GEgOiuos/D4o4Wvq25YnJlTv9
 sTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=eCVeV9EHTE4NBr5vKzxQxX/KvFsPS1dOREom5c8IN8Q=;
 b=Hs2Fg26i6KTZSTrlzfIfDAEWpbif6RGNavcb9ScTJ8wBl/1ZYS4dy5n0k5DuyxzhYk
 cLrfXQkKsl3Ht5uizfxPqfsPtKKdV6iMW3COrXC+fNQd75n+AyUw7yWo4J3vBkBTge7q
 8Cemp4Al8fS/6p94uunqFNEzmAbySmThLDDMiZx6+5Q3YwU/HlmqRXTjVeD7IgFPW9Ut
 Z7DTY0J4n1XSxJTbTyXt9sv7jKgvXyoANyTAJcGk+2c4fhwyFdeixCkP0cuhJL0iXll8
 F7dNq+Aa6m2BWgTC6ec3HnwzhgnNssz3y8T6cw/FTKBNVQsDYOqRNit7Ad0psaJMwrF1
 DN7A==
X-Gm-Message-State: AOAM5304uevvnvhGJ4WxRtZG+Lt8W2SEp0LOp+BTtxE1GDThvt2/pq87
 uH7vMyT2Fxk/I8Jo7DVPgHFTxcwZ
X-Google-Smtp-Source: ABdhPJzjDrbqkIYKL9ODDJH9nhxHDD6CTMhgqUFIKcQczM4Z/5PJywkeMlNXc6hs+piGAYt+uwjMdg==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr53858750wrm.82.1594145834976; 
 Tue, 07 Jul 2020 11:17:14 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 65sm2253337wma.48.2020.07.07.11.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 11:17:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] target/avr: Add basic parameters of the new platform
Date: Tue,  7 Jul 2020 20:16:39 +0200
Message-Id: <20200707181710.30950-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200707181710.30950-1-f4bug@amsat.org>
References: <20200707181710.30950-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x431.google.com
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
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
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

From: Michael Rolnik <mrolnik@gmail.com>

This includes definitions of various basic parameters needed
for integration of a new platform into QEMU.

[AM: Split a larger AVR introduction patch into logical units]
Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[thuth: Simplify MAINTAINERS right from the start]
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
Message-Id: <20200705140315.260514-2-huth@tuxfamily.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/avr/cpu-param.h | 36 +++++++++++++++++++++++
 target/avr/cpu.h       | 66 ++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS            |  6 ++++
 3 files changed, 108 insertions(+)
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu.h

diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
new file mode 100644
index 0000000000..7ef4e7c679
--- /dev/null
+++ b/target/avr/cpu-param.h
@@ -0,0 +1,36 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016-2020 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#ifndef AVR_CPU_PARAM_H
+#define AVR_CPU_PARAM_H
+
+#define TARGET_LONG_BITS 32
+/*
+ * TARGET_PAGE_BITS cannot be more than 8 bits because
+ * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and they
+ *     should be implemented as a device and not memory
+ * 2.  SRAM starts at the address 0x0100
+ */
+#define TARGET_PAGE_BITS 8
+#define TARGET_PHYS_ADDR_SPACE_BITS 24
+#define TARGET_VIRT_ADDR_SPACE_BITS 24
+#define NB_MMU_MODES 2
+
+#endif
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
new file mode 100644
index 0000000000..45a87c5452
--- /dev/null
+++ b/target/avr/cpu.h
@@ -0,0 +1,66 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2016-2020 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * <http://www.gnu.org/licenses/lgpl-2.1.html>
+ */
+
+#ifndef QEMU_AVR_CPU_H
+#define QEMU_AVR_CPU_H
+
+#include "exec/cpu-defs.h"
+
+#define TCG_GUEST_DEFAULT_MO 0
+
+/*
+ * AVR has two memory spaces, data & code.
+ * e.g. both have 0 address
+ * ST/LD instructions access data space
+ * LPM/SPM and instruction fetching access code memory space
+ */
+#define MMU_CODE_IDX 0
+#define MMU_DATA_IDX 1
+
+#define EXCP_RESET 1
+#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
+
+/* Number of CPU registers */
+#define NUMBER_OF_CPU_REGISTERS 32
+/* Number of IO registers accessible by ld/st/in/out */
+#define NUMBER_OF_IO_REGISTERS 64
+
+/*
+ * Offsets of AVR memory regions in host memory space.
+ *
+ * This is needed because the AVR has separate code and data address
+ * spaces that both have start from zero but have to go somewhere in
+ * host memory.
+ *
+ * It's also useful to know where some things are, like the IO registers.
+ */
+/* Flash program memory */
+#define OFFSET_CODE 0x00000000
+/* CPU registers, IO registers, and SRAM */
+#define OFFSET_DATA 0x00800000
+/* CPU registers specifically, these are mapped at the start of data */
+#define OFFSET_CPU_REGISTERS OFFSET_DATA
+/*
+ * IO registers, including status register, stack pointer, and memory
+ * mapped peripherals, mapped just after CPU registers
+ */
+#define OFFSET_IO_REGISTERS (OFFSET_DATA + NUMBER_OF_CPU_REGISTERS)
+
+#endif /* !defined (QEMU_AVR_CPU_H) */
diff --git a/MAINTAINERS b/MAINTAINERS
index b6602dcde2..6a012646eb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -167,6 +167,12 @@ S: Maintained
 F: hw/arm/smmu*
 F: include/hw/arm/smmu*
 
+AVR TCG CPUs
+M: Michael Rolnik <mrolnik@gmail.com>
+R: Sarah Harris <S.E.Harris@kent.ac.uk>
+S: Maintained
+F: target/avr/
+
 CRIS TCG CPUs
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
-- 
2.21.3


