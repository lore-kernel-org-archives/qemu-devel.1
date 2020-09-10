Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07704C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:38:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73ED621D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HrkZNXQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73ED621D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRSd-0001co-DO
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRC7-0005Ai-Vz
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:16 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRC1-0002iJ-2b
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762068; x=1631298068;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=azIj7Grzk9u7U4SLkM89iVKUP+j6O4QSjeJGv0fKma4=;
 b=HrkZNXQH+WveMq62I9aVEVRKA4YG2YTAyxAAg2NgLP1V1iVuddfRSTbD
 hUiLxOSR0I9gLynkkPAGqEr9rJ9KlzXDgilmekWi0UTzqRj7jWC3+gkMO
 PG1D5IP8oiCA0szbZy68LKY1+5M3XeptoIJlbS4xbN19HTdS/Ies2Jk0N
 o/M77vSA/ddjh/nnCPc+pApYIh28ohLg3pNvcWtBMuWPq166tRbuR+c90
 J8z0+sWU7MfOX4lLJSYHmaz5DuUKYZCJ1VXD7CzN2Ut3mctbOK+T3GIuW
 G+A6/waBrkCpQNX/vk4wRLrotdhybxE9oNueeBYhY2/h9EUWYlmSx0G+i w==;
IronPort-SDR: MROGCePjbFYiQxjdzbfR2qr/kq1iVPjCY+TaOR9i3yj6oRPOBXzbPR99V+yS2YJTupi4mneH2P
 B8gdFxAA5FLFtynT5sXEPiBQRLkAUcPxSM8W1RIb4nSaRX/1Oej5xN2Zrs7Ozf+glbAWrKMHNE
 cIIL0rsISE0FHZBgxsdMIqCeVmf4otrdCpMO2Uq9wojh3+kl53Q1UVJDvAwsY1vIO+hWk5+EUt
 J2/4tSnUjBielsSDU6dIWLm3A6GV2eIF0aZx6o1ADWG9Poz0ZLj4K8pAXQDwVvO5u/gIsvoGem
 ZAQ=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979245"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:20 +0800
IronPort-SDR: Gqm7GMAE9nnqEUsql+XmeGzw+B95WoWC0X0s8ci+AirFCMr4s3fA7cunJfwFaQp2GV4t8qFYcI
 jaG6MukNy8Pw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:37 -0700
IronPort-SDR: 7zZuISMb1Wy86kCmQq90uiBSWIQ8RN653dTwe1YmsZcPFAO8NF3Aqmd/knUVnjljZqZBOxjZVb
 SP36ydEG0WIw==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 22/30] hw/riscv: Move sifive_gpio model to hw/gpio
Date: Thu, 10 Sep 2020 11:09:30 -0700
Message-Id: <20200910180938.584205-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This is an effort to clean up the hw/riscv directory. Ideally it
should only contain the RISC-V SoC / machine codes plus generic
codes. Let's move sifive_gpio model to hw/gpio directory.

Note this also removes the trace-events in the hw/riscv directory,
since gpio is the only supported trace target in that directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-5-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/trace.h                         | 1 -
 include/hw/{riscv => gpio}/sifive_gpio.h | 0
 include/hw/riscv/sifive_e.h              | 2 +-
 include/hw/riscv/sifive_u.h              | 2 +-
 hw/{riscv => gpio}/sifive_gpio.c         | 2 +-
 hw/gpio/Kconfig                          | 3 +++
 hw/gpio/meson.build                      | 1 +
 hw/gpio/trace-events                     | 6 ++++++
 hw/riscv/Kconfig                         | 2 ++
 hw/riscv/meson.build                     | 1 -
 hw/riscv/trace-events                    | 7 -------
 meson.build                              | 1 -
 12 files changed, 15 insertions(+), 13 deletions(-)
 delete mode 100644 hw/riscv/trace.h
 rename include/hw/{riscv => gpio}/sifive_gpio.h (100%)
 rename hw/{riscv => gpio}/sifive_gpio.c (99%)
 delete mode 100644 hw/riscv/trace-events

diff --git a/hw/riscv/trace.h b/hw/riscv/trace.h
deleted file mode 100644
index 8c0e3ca1f3..0000000000
--- a/hw/riscv/trace.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "trace/trace-hw_riscv.h"
diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/gpio/sifive_gpio.h
similarity index 100%
rename from include/hw/riscv/sifive_gpio.h
rename to include/hw/gpio/sifive_gpio.h
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 637414130b..b1400843c2 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -21,7 +21,7 @@
 
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
-#include "hw/riscv/sifive_gpio.h"
+#include "hw/gpio/sifive_gpio.h"
 
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
 #define RISCV_E_SOC(obj) \
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 936a3bd0b1..fe5c580845 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -23,7 +23,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
-#include "hw/riscv/sifive_gpio.h"
+#include "hw/gpio/sifive_gpio.h"
 #include "hw/misc/sifive_u_otp.h"
 #include "hw/misc/sifive_u_prci.h"
 
diff --git a/hw/riscv/sifive_gpio.c b/hw/gpio/sifive_gpio.c
similarity index 99%
rename from hw/riscv/sifive_gpio.c
rename to hw/gpio/sifive_gpio.c
index aac6b44cac..78bf29e996 100644
--- a/hw/riscv/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -15,7 +15,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
-#include "hw/riscv/sifive_gpio.h"
+#include "hw/gpio/sifive_gpio.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index 9227cb5598..b6fdaa2586 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -7,3 +7,6 @@ config PL061
 
 config GPIO_KEY
     bool
+
+config SIFIVE_GPIO
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 6bcdfa6b1d..86cae9a0f3 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -10,3 +10,4 @@ softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index c1271fdfb2..6e3f048745 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -5,3 +5,9 @@ nrf51_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PR
 nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
 nrf51_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
 nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
+
+# sifive_gpio.c
+sifive_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PRIx64
+sifive_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
+sifive_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
+sifive_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 76eaf77a80..5a8335bfec 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -15,6 +15,7 @@ config SIFIVE_E
     bool
     select HART
     select SIFIVE
+    select SIFIVE_GPIO
     select SIFIVE_E_PRCI
     select UNIMP
 
@@ -23,6 +24,7 @@ config SIFIVE_U
     select CADENCE
     select HART
     select SIFIVE
+    select SIFIVE_GPIO
     select SIFIVE_PDMA
     select SIFIVE_U_OTP
     select SIFIVE_U_PRCI
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 74a73b2a44..90003793d4 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -5,7 +5,6 @@ riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_clint.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_gpio.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_plic.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
diff --git a/hw/riscv/trace-events b/hw/riscv/trace-events
deleted file mode 100644
index 6d59233e23..0000000000
--- a/hw/riscv/trace-events
+++ /dev/null
@@ -1,7 +0,0 @@
-# See docs/devel/tracing.txt for syntax documentation.
-
-# hw/gpio/sifive_gpio.c
-sifive_gpio_read(uint64_t offset, uint64_t r) "offset 0x%" PRIx64 " value 0x%" PRIx64
-sifive_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x%" PRIx64
-sifive_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
-sifive_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
diff --git a/meson.build b/meson.build
index 5421eca66a..bc869c676a 100644
--- a/meson.build
+++ b/meson.build
@@ -773,7 +773,6 @@ if have_system
     'hw/watchdog',
     'hw/xen',
     'hw/gpio',
-    'hw/riscv',
     'migration',
     'net',
     'ui',
-- 
2.28.0


