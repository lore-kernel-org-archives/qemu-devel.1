Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9EEC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2525220775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnNTrrQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2525220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmia-0002dC-7P
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfl-0005nx-Gv; Thu, 03 Sep 2020 06:40:53 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfj-0002F1-2U; Thu, 03 Sep 2020 06:40:53 -0400
Received: by mail-pg1-x542.google.com with SMTP id 7so1785366pgm.11;
 Thu, 03 Sep 2020 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qQK4Q73IL7xwz6GT5kF24FIl94aRcZAS3deAznVQ+Ps=;
 b=fnNTrrQHwl6jyFtGkFSzu45jahwrjH3O7zRRxb6ovQKwgFdbnBckLVji8twrgLIJkp
 S571nJM0HoYFZCnfMWkqLhZHBxVMcbdEZap2wLwc3m6S4rRulZDpmA3LzCBEPYMcyScT
 wbmGP24PfLHVAd0NzU6240ysBtVmQSqP2pTOjVDGxtYQcnsrTjorP5P0rRs4KBW+C+1U
 jY+Eltfff87woarCZw/13vh0SVa9cG5Uo2uGkTllVhGvr4bk1UCZyqZjT+PTX2OBk6HM
 01WOHPj4H+e0+Rn39FsbNLwJ5lS9KndnJv/0ORSktSis+qKSWnDDHYK8kTNAM0PHFCJg
 fPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qQK4Q73IL7xwz6GT5kF24FIl94aRcZAS3deAznVQ+Ps=;
 b=ZbwiNeevk9bjcPKtwMlNcBO7bKZ9PZwZwyejI2A0vU9+uS4lpZRAiZuMwXYHHknr09
 n1BjhFumEmDrd2+AM1kvc+dbFeEeGlS6cLm5bMGArF658LkaOOCkDLFDiYVqWykbToY7
 XvnUn7BCu6tl1Q0HF1WncOauDi7slPw6G65U1U+JB8rHAQsw2XOaAua45UT/Cm0r5OiH
 rUFqo2LNWhHgphALfEg51qYlGGWwUiDhzytc0h+DhCfHe1U6bmLc/wrfrAEO0cDIjh4b
 mFlt8rnVq+TUEmhy6AplbIDH8eXlP4YuXB6ZLiu0B+RS3YyyRZe0W6uFXVV/FB2z/JSE
 fAqA==
X-Gm-Message-State: AOAM531Y2zNWM43d+5GcOllhiUkqzUFWy0DCsNUx66rxXn4NSHB+EOAv
 VhAQ3/8HdZQlXK7py1hppN8=
X-Google-Smtp-Source: ABdhPJzUGNnIU/+tNIQSE7hEUlFSmy5kzmxM6Rf8xQ+nbADQ6hoZtHrcYvD3OZJSwir/bDLwJzbJ9g==
X-Received: by 2002:a17:902:868b:: with SMTP id
 g11mr3313851plo.9.1599129649465; 
 Thu, 03 Sep 2020 03:40:49 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id b18sm2137098pjq.3.2020.09.03.03.40.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:40:49 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 04/12] hw/riscv: Move sifive_gpio model to hw/gpio
Date: Thu,  3 Sep 2020 18:40:15 +0800
Message-Id: <1599129623-68957-5-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Bin Meng <bin.meng@windriver.com>
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
index 8c0e3ca..0000000
--- a/hw/riscv/trace.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "trace/trace-hw_riscv.h"
diff --git a/include/hw/riscv/sifive_gpio.h b/include/hw/gpio/sifive_gpio.h
similarity index 100%
rename from include/hw/riscv/sifive_gpio.h
rename to include/hw/gpio/sifive_gpio.h
diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 6374141..b140084 100644
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
index 936a3bd..fe5c580 100644
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
index aac6b44..78bf29e 100644
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
index 9227cb5..b6fdaa2 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -7,3 +7,6 @@ config PL061
 
 config GPIO_KEY
     bool
+
+config SIFIVE_GPIO
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 6bcdfa6..86cae9a 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -10,3 +10,4 @@ softmmu_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
 softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
+softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index c1271fd..6e3f048 100644
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
index 76eaf77..5a8335b 100644
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
index 2ba4757..24177ef 100644
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
index 6d59233..0000000
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
index 1e7aee8..66bbb75 100644
--- a/meson.build
+++ b/meson.build
@@ -706,7 +706,6 @@ if have_system
     'hw/watchdog',
     'hw/xen',
     'hw/gpio',
-    'hw/riscv',
     'migration',
     'net',
     'ui',
-- 
2.7.4


