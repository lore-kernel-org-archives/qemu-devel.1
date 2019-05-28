Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834ADC04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:51:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9EF208CB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 09:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jI7iqaXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9EF208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59947 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVYlu-0007j4-8f
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 05:51:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk2-0006D6-53
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVYk0-0008RD-Mb
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:58 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVYk0-0008Q6-GB
	for qemu-devel@nongnu.org; Tue, 28 May 2019 05:49:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id d9so19483205wrx.0
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=y87WCNRQrFtDdoTowj1xkvcHcjB3klhft84tA7PdQ58=;
	b=jI7iqaXqL2pQSsO7KcJtDML1hcVzEYQxjk/9AdwYObBtJjv60K/85Gjkbj/LWJxOVu
	yf/7qQoXNcgwhw8LexIv/LHAKee5oFG33WaW2EqvkvbBim4pDqaBebLd0n7Q4zu0k/x3
	5eafLeBtIhbYZjHZDozoVUZWBtm4SzwzAEBlMqCpgo4GqL0jObQuVXS9yL45AX+K819i
	aKtkeeeKfHlBx6jfFhkkKipxjIiJupGLawIIfPS4NXrTmffEmk+vb9ohbJuHoU7uvPb7
	qOG9PuMpkur9Z8o94fueU0z0bVhMyHg9/nxZHltzpm+WwKgo90GSubk0N5MUJg+92e6S
	W1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=y87WCNRQrFtDdoTowj1xkvcHcjB3klhft84tA7PdQ58=;
	b=q6zRUfispTZu3ociel9K69UHDckZ6ILNwiUTgFOhnOWkaFXm1QDaWS6yiI7W0Xellj
	Z79eucp6N/D6eu6dSnbo06llr4xENcKa6qPO9eoaFPdVqGhm4O89A9XH1RZfdyUU6WrF
	KWgv81yHM8szFThvTsi5Ya6fYtnKHb/u956w1PhPBuear6lji/7jwpRXej+Y1wZi3KhK
	g0Ydc+Px35zuxNh1NjfLAbBRV1pONEgr1iSXsu2jCMTx0xSkIqt8vLhGAojAUc15PKBW
	fQ5Tf3x1JPFnwBWI9F/QwKfP5c4puwq5mc6oBUVLheSpTGmUf7eK2G7GqTF7eH9xfooI
	YZZQ==
X-Gm-Message-State: APjAAAXWalnnQrhjWivPuDWpGcPpNQDkzluFNkg/Ljv07hcxTMDxzJHJ
	aOospUDCpGYRfEl+t017aEVYxw==
X-Google-Smtp-Source: APXvYqytrKJkZS2h7r64bAfNljyf0DG42WlbPp0+HCWJcq6RbYzyRaSA9NfgjIu+SD6xBfRaA0r6yA==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr1258454wrp.149.1559036995366; 
	Tue, 28 May 2019 02:49:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	i18sm1776582wml.33.2019.05.28.02.49.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 02:49:54 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9646A1FF8F;
	Tue, 28 May 2019 10:49:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 28 May 2019 10:49:27 +0100
Message-Id: <20190528094953.14898-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528094953.14898-1-alex.bennee@linaro.org>
References: <20190528094953.14898-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 02/28] semihosting: introduce CONFIG_SEMIHOSTING
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
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

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
index 73452ad2657..9c7393b08c8 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -40,3 +40,4 @@ stub-obj-y += pci-host-piix.o
 stub-obj-y += ram-block.o
 stub-obj-y += ramfb.o
 stub-obj-y += fw_cfg.o
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


