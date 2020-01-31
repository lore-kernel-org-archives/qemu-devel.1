Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B94C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7C3206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 00:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7C3206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixJom-0000w7-DO
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 19:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ixJne-0007SD-9R
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ixJnc-0002up-A6
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:04:42 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46234 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ixJnb-0001wH-Vf
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 19:04:40 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id EEC301A1E05;
 Fri, 31 Jan 2020 01:03:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id D085B1A1DA4;
 Fri, 31 Jan 2020 01:03:36 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc4 01/29] target/avr: Add basic parameters for new AVR
 platform
Date: Fri, 31 Jan 2020 01:02:45 +0100
Message-Id: <1580428993-4767-2-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
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
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 target/avr/cpu-param.h | 37 ++++++++++++++++++++++++++
 target/avr/cpu.h       | 72 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 2 files changed, 109 insertions(+)
 create mode 100644 target/avr/cpu-param.h
 create mode 100644 target/avr/cpu.h

diff --git a/target/avr/cpu-param.h b/target/avr/cpu-param.h
new file mode 100644
index 0000000..0c29ce4
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
+ * 1.  all IO registers occupy [0x0000 .. 0x00ff] address range, and the=
y
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
index 0000000..d122611
--- /dev/null
+++ b/target/avr/cpu.h
@@ -0,0 +1,72 @@
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
+#include "cpu-qom.h"
+#include "exec/cpu-defs.h"
+
+#define TCG_GUEST_DEFAULT_MO 0
+#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
+#define AVR_CPU_TYPE_NAME(name) (name AVR_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
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
+ * It's also useful to know where some things are, like the IO registers=
.
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
+#define EF_AVR_MACH 0x7F
+
+#endif /* !defined (QEMU_AVR_CPU_H) */
--=20
2.7.4


