Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C85C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F3BF21019
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpmUbgTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3BF21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTkwn-0006mn-EN
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:27:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkuu-0005Qc-2i
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hTkuo-0000ui-1B
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:41 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hTkul-0000rX-VQ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:25:36 -0400
Received: by mail-wm1-x344.google.com with SMTP id t5so5200855wmh.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 03:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=VPYoDDTghYG2/LL0n9irfzSxJnK/tqgoLIbho5rYvV8=;
	b=fpmUbgTP8m0B7hMdU7nymRbgU9OHxbXqRMb0US7extFNgplo5xSF8kLWC7+I6RVogM
	NXnfdZbTG4+AbKlkkEJZczf2XoLeelI1EzpevITj5+wj/mpi0k0HdI9mZqtiIT4MFCAa
	JX75HeTOu788/y19GGRtjSkbH/NNEL3XtYzbPOWvvgfpTOcj3t/8UtJp0jAEMiypClIn
	4L2Z7+pM9g7g3I2eVAP2XZqxUMMTEErji6/Pbj9hPkC2n5h3QF3mIIpqTZHomWBe6SXJ
	4V/xT6S6iMum3pXmGRvIAk0Dc2g/l0O7hNn8FqJkKfqbHZ1jKxQlE9MY3XL7+prrrgHf
	fLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=VPYoDDTghYG2/LL0n9irfzSxJnK/tqgoLIbho5rYvV8=;
	b=tpWuw2k3AwVEjZNttitcdRRjChVl09pb1Nt1fHZbYqPGD3TGHivXB2iIPf+TF6qwo4
	xAIhHK0ww2Xeb5P7piWNNY1enUpLFhR9t9sebDGrrn7Y3AKtRskoLRfyxy9hYAVTUMGD
	I+8JBkyLKqPlCA1SVKobFTBsCIadDBrYFn9/n1vvBa+6z24b84rq4cHxBDWzbA0WYL7l
	cC6w/lUbym6nciOAq64gVnlIdNWd4qBVxqxY3extABkYU/dyFmcm8sG9wwW8tsuhaPTY
	HKU8MA6e2fObeaLVJpkG5eH6tD740KHUDAfwkuhwFvp8Rz4ok+jrFMsPtVo2vtpqwMfy
	xeRw==
X-Gm-Message-State: APjAAAXnjhEl2FlB2s4PRrmgEbR91sF6oPgvu4WBRX0Hp7zVkGQF9/th
	IEQ55h2R6CoyJmg1V39WTwCPsw==
X-Google-Smtp-Source: APXvYqxHYgEBP+46zycp7AdJI/PJuDFOIxYxieiUJC75bgKJ0Eg3maGMDRqct8TVK3Pz72PbHMHGfQ==
X-Received: by 2002:a1c:1f95:: with SMTP id f143mr11864734wmf.16.1558607134510;
	Thu, 23 May 2019 03:25:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b18sm25054186wrx.75.2019.05.23.03.25.32
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 03:25:33 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 96F531FF8F;
	Thu, 23 May 2019 11:25:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 11:25:06 +0100
Message-Id: <20190523102532.10486-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102532.10486-1-alex.bennee@linaro.org>
References: <20190523102532.10486-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v2 02/28] semihosting: introduce
 CONFIG_SEMIHOSTING
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Marek Vasut <marex@denx.de>, Aleksandar Rikalo <arikalo@wavecomp.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Chris Wulff <crwulff@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There isn't much point building semihosting for platforms that don't
support it. Introduce a new symbol and enable it only for the softmmu
targets that need it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 default-configs/arm-softmmu.mak         |  1 +
 default-configs/lm32-softmmu.mak        |  2 +
 default-configs/m68k-softmmu.mak        |  2 +
 default-configs/mips-softmmu-common.mak |  1 +
 default-configs/nios2-softmmu.mak       |  2 +
 default-configs/xtensa-softmmu.mak      |  2 +
 hw/Kconfig                              |  1 +
 hw/semihosting/Kconfig                  |  3 ++
 hw/semihosting/Makefile.objs            |  2 +-
 stubs/Makefile.objs                     |  1 +
 stubs/semihost.c                        | 66 +++++++++++++++++++++++++
 11 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 hw/semihosting/Kconfig
 create mode 100644 stubs/semihost.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index f23ecfd5c58..1f2e0e7fdeb 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -39,3 +39,4 @@ CONFIG_MICROBIT=y
 CONFIG_FSL_IMX25=y
 CONFIG_FSL_IMX7=y
 CONFIG_FSL_IMX6UL=y
+CONFIG_SEMIHOSTING=y
diff --git a/default-configs/lm32-softmmu.mak b/default-configs/lm32-softmmu.mak
index 6d259665d60..115b3e34c98 100644
--- a/default-configs/lm32-softmmu.mak
+++ b/default-configs/lm32-softmmu.mak
@@ -4,6 +4,8 @@
 #
 #CONFIG_MILKYMIST_TMU2=n        # disabling it actually causes compile-time failures
 
+CONFIG_SEMIHOSTING=y
+
 # Boards:
 #
 CONFIG_LM32=y
diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index e17495e2a0b..4049a8f2ba9 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -1,5 +1,7 @@
 # Default configuration for m68k-softmmu
 
+CONFIG_SEMIHOSTING=y
+
 # Boards:
 #
 CONFIG_AN5206=y
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 8e54a74b7a5..e10ac4b20c0 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -35,6 +35,7 @@ CONFIG_MIPS_CPS=y
 CONFIG_MIPS_ITU=y
 CONFIG_R4K=y
 CONFIG_MALTA=y
+CONFIG_SEMIHOSTING=y
 CONFIG_PCNET_PCI=y
 CONFIG_MIPSSIM=y
 CONFIG_ACPI_SMBUS=y
diff --git a/default-configs/nios2-softmmu.mak b/default-configs/nios2-softmmu.mak
index e130d024e62..1bc4082ea99 100644
--- a/default-configs/nios2-softmmu.mak
+++ b/default-configs/nios2-softmmu.mak
@@ -1,5 +1,7 @@
 # Default configuration for nios2-softmmu
 
+CONFIG_SEMIHOSTING=y
+
 # Boards:
 #
 CONFIG_NIOS2_10M50=y
diff --git a/default-configs/xtensa-softmmu.mak b/default-configs/xtensa-softmmu.mak
index 7e4d1cc0979..3aa20a47a7f 100644
--- a/default-configs/xtensa-softmmu.mak
+++ b/default-configs/xtensa-softmmu.mak
@@ -1,5 +1,7 @@
 # Default configuration for Xtensa
 
+CONFIG_SEMIHOSTING=y
+
 # Boards:
 #
 CONFIG_XTENSA_SIM=y
diff --git a/hw/Kconfig b/hw/Kconfig
index 88b9f150070..195f541e50c 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -29,6 +29,7 @@ source pci/Kconfig
 source rdma/Kconfig
 source scsi/Kconfig
 source sd/Kconfig
+source semihosting/Kconfig
 source smbios/Kconfig
 source ssi/Kconfig
 source timer/Kconfig
diff --git a/hw/semihosting/Kconfig b/hw/semihosting/Kconfig
new file mode 100644
index 00000000000..efe0a30734c
--- /dev/null
+++ b/hw/semihosting/Kconfig
@@ -0,0 +1,3 @@
+
+config SEMIHOSTING
+       bool
diff --git a/hw/semihosting/Makefile.objs b/hw/semihosting/Makefile.objs
index 546954f4ff4..09c19bf19ed 100644
--- a/hw/semihosting/Makefile.objs
+++ b/hw/semihosting/Makefile.objs
@@ -1 +1 @@
-common-obj-$(CONFIG_SOFTMMU) += config.o
+obj-$(CONFIG_SEMIHOSTING) += config.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 269dfa58326..e0d4f11b348 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -39,3 +39,4 @@ stub-obj-y += xen-hvm.o
 stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
 stub-obj-y += ramfb.o
+stub-obj-$(CONFIG_SOFTMMU) += semihost.o
diff --git a/stubs/semihost.c b/stubs/semihost.c
new file mode 100644
index 00000000000..1a4e88e5326
--- /dev/null
+++ b/stubs/semihost.c
@@ -0,0 +1,66 @@
+/*
+ * Semihosting Stubs for SoftMMU
+ *
+ * Copyright (c) 2019 Linaro Ltd
+ *
+ * Stubs for SoftMMU targets that don't actually do semihosting.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/option.h"
+#include "qemu/error-report.h"
+#include "hw/semihosting/semihost.h"
+
+/* Empty config */
+QemuOptsList qemu_semihosting_config_opts = {
+    .name = "",
+    .head = QTAILQ_HEAD_INITIALIZER(qemu_semihosting_config_opts.head),
+    .desc = {
+        { /* end of list */ }
+    },
+};
+
+/* Queries to config status default to off */
+bool semihosting_enabled(void)
+{
+    return false;
+}
+
+SemihostingTarget semihosting_get_target(void)
+{
+    return SEMIHOSTING_TARGET_AUTO;
+}
+
+/*
+ * All the rest are empty subs. We could g_assert_not_reached() but
+ * that adds extra weight to the final binary. Waste not want not.
+ */
+void qemu_semihosting_enable(void)
+{
+}
+
+int qemu_semihosting_config_options(const char *optarg)
+{
+    return 1;
+}
+
+const char *semihosting_get_arg(int i)
+{
+    return NULL;
+}
+
+int semihosting_get_argc(void)
+{
+    return 0;
+}
+
+const char *semihosting_get_cmdline(void)
+{
+    return NULL;
+}
+
+void semihosting_arg_fallback(const char *file, const char *cmd)
+{
+}
-- 
2.20.1


