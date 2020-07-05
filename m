Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA40DC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:04:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9883120720
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 14:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9883120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js5Fq-0000Ur-OE
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 10:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5Ez-00077b-OG
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:33 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1js5Ex-0008Hq-CX
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 10:03:33 -0400
Received: by mail-ej1-f66.google.com with SMTP id l12so39626062ejn.10
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2020 07:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GfvUm+eaEwDmCPg3KBZM20G5LKpXzuVCsLv4gBwb+3s=;
 b=ZiUXtozc/jsxdsKTvbx87HLklEQMG2PAwWEMIeS01h2SqTyiHXBvLQKMBGKX/I2Tqj
 a3f4EK1Y8Io1kRD+HaDzoOSSsGP0hKOB/lwYDQXBl1onY3w2QQT7hhKQ4PZ5p4U8DyOz
 zP2/UauPwoGtnLi7HdLN/p1xL+x39e7wY8/BEKgpxyoW2zd4zJHNLb1he9dj/9uh20a8
 ZAb63q6YHjdBcKtNGCXH01lvDuIym/tdgqZTMdq7pN5WeIV/v6uX6hn0M42KysPpN/j5
 yWKu/oZhN8mS2ONFMyhUDoV+rsJX6MQfqJRNUtNGRmnmMPXS2XPov+DdUZzD0arvbhSC
 AXAw==
X-Gm-Message-State: AOAM533ACVxgF/F/soytTnvhIvCxJX5CgDfRj8ogEPd8NFf6e9xHvRiR
 qpRKZyIoP+AXubht9ShlZujJkb8b
X-Google-Smtp-Source: ABdhPJzTrEzgh8ZOpnb+fKzZouNCWSNQI88GqFwU6gawO/ie1o8yLOoYZdFiCojzgDuu2COWq0P8Yg==
X-Received: by 2002:a17:906:f2d6:: with SMTP id
 gz22mr39241364ejb.407.1593957809605; 
 Sun, 05 Jul 2020 07:03:29 -0700 (PDT)
Received: from thl530.multi.box (pd9e83654.dip0.t-ipconnect.de.
 [217.232.54.84])
 by smtp.gmail.com with ESMTPSA id bq8sm10941776ejb.103.2020.07.05.07.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 07:03:29 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Subject: [PATCH rc6 01/30] target/avr: Add basic parameters of the new platform
Date: Sun,  5 Jul 2020 16:02:46 +0200
Message-Id: <20200705140315.260514-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
References: <20200705140315.260514-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.66; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f66.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 10:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=1,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
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
---
 MAINTAINERS            |  6 ++++
 target/avr/cpu-param.h | 37 +++++++++++++++++++++++
 target/avr/cpu.h       | 66 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c31c878c63..ee1f35edf5 100644
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
diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
new file mode 100644
index 0000000000..0c29ce4223
--- /dev/null
+++ b/target/avr/cpu-param.h
@@ -0,0 +1,37 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
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
+
+#endif
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
new file mode 100644
index 0000000000..ecdeafbbc5
--- /dev/null
+++ b/target/avr/cpu.h
@@ -0,0 +1,66 @@
+/*
+ * QEMU AVR CPU
+ *
+ * Copyright (c) 2019 Michael Rolnik
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
-- 
2.26.2


