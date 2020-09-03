Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7296C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:49:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7443C20775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u86Kz2ls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7443C20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmnm-0002h8-Id
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfw-00067K-BB; Thu, 03 Sep 2020 06:41:04 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmft-0002HF-38; Thu, 03 Sep 2020 06:41:03 -0400
Received: by mail-pj1-x1043.google.com with SMTP id k15so1323431pji.3;
 Thu, 03 Sep 2020 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vLhkFcPRPjbFUkxZmeoav+dAcg9EN0kbL/fECyuDRas=;
 b=u86Kz2lsxqQ/2Fe2BOBRNaITiyZFjrkREy/6ThAPKzKVFRDKu4R+SfReEY7Kt3xOdg
 RDzZMFoWsAWi8LNp4hrqHYTDcGzLhhZhNbWZTlTntJBl+kmGUkxwrSMH3VTGAz5JeCxW
 vedtjtkEPttKP/iIgGsPkO4lXhljprZCGYQjHmC0pvQ+WRtgoAsxEN2t2hIq6i7AD0he
 +U+sy4Xkmx9/qPhu8ix94OR6kEAbOMsJkcDrRh4Wirzq3XYH+wGo83cauYK9YtoKFS9k
 56VPm3ncXY/6qnMwOAnRsKOkn+5newtdOW8TTj1rgNAe4+GYHKBoLhAKlAiu3d4iuX3C
 9jJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vLhkFcPRPjbFUkxZmeoav+dAcg9EN0kbL/fECyuDRas=;
 b=NNjP+BmcoyONpZl0lw0iiOC/UCilTtXSf1L3t8ZlHb51kT1aLpMdx9uaSGUCpndQnN
 JFj6/aXMXSQWX0ge8rwq7fcNkyn25nk9zHySEBHr6LLxRRRwy+d1J+KU0J3Tn1PcYVCv
 MOsRsea9JX5eQrAvuT9UX/930ybZMt6FdkI+rL4rwBcuvIDYxkcDuGNGzemdwaNqr3fj
 tX4xpG5qj6RLiQPf7d4hWZ/jdRjwj/GaKduU81XO9CyJl7owkFEI7Yir3VqH/YdR8osb
 N8EF1C2Urx5xQCS+lWJEnDIT4JY/aEYvmtN4SyD0Z9cvQSPXbmt/VAiSS1hSUT0xjL8R
 4kuw==
X-Gm-Message-State: AOAM533KvAan5BzPgrJCUZVqz3PNtTemTCM0wAmmY6dicGaUpsfRTeSd
 GC9rZdYwJviyc+vO8VImDMc=
X-Google-Smtp-Source: ABdhPJx42XnrIqMOwceeXVXYoF6MUeWxHWsztreuUZoeDlmSdMu6BsWkALXhyUi/CO3kiio5J5+H5w==
X-Received: by 2002:a17:90b:1a89:: with SMTP id
 ng9mr2637439pjb.202.1599129659384; 
 Thu, 03 Sep 2020 03:40:59 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id b18sm2137098pjq.3.2020.09.03.03.40.57
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:40:58 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 08/12] hw/riscv: Move sifive_uart model to hw/char
Date: Thu,  3 Sep 2020 18:40:19 +0800
Message-Id: <1599129623-68957-9-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pj1-x1043.google.com
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
codes. Let's move sifive_uart model to hw/char directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 include/hw/{riscv => char}/sifive_uart.h | 0
 hw/{riscv => char}/sifive_uart.c         | 2 +-
 hw/riscv/sifive_e.c                      | 2 +-
 hw/riscv/sifive_u.c                      | 2 +-
 hw/char/Kconfig                          | 3 +++
 hw/char/meson.build                      | 1 +
 hw/riscv/Kconfig                         | 2 ++
 hw/riscv/meson.build                     | 1 -
 8 files changed, 9 insertions(+), 4 deletions(-)
 rename include/hw/{riscv => char}/sifive_uart.h (100%)
 rename hw/{riscv => char}/sifive_uart.c (99%)

diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/char/sifive_uart.h
similarity index 100%
rename from include/hw/riscv/sifive_uart.h
rename to include/hw/char/sifive_uart.h
diff --git a/hw/riscv/sifive_uart.c b/hw/char/sifive_uart.c
similarity index 99%
rename from hw/riscv/sifive_uart.c
rename to hw/char/sifive_uart.c
index 9350482..3a00ba7 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/char/sifive_uart.c
@@ -24,7 +24,7 @@
 #include "chardev/char-fe.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
-#include "hw/riscv/sifive_uart.h"
+#include "hw/char/sifive_uart.h"
 
 /*
  * Not yet implemented:
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 0ddcf15..40bbf53 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -39,9 +39,9 @@
 #include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_e.h"
 #include "hw/riscv/boot.h"
+#include "hw/char/sifive_uart.h"
 #include "hw/intc/sifive_clint.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_e_prci.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index faca2e8..4f12a93 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -46,9 +46,9 @@
 #include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
+#include "hw/char/sifive_uart.h"
 #include "hw/intc/sifive_clint.h"
 #include "hw/intc/sifive_plic.h"
 #include "chardev/char.h"
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 91da92f..939bc44 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -58,3 +58,6 @@ config AVR_USART
 
 config MCHP_PFSOC_MMUART
     bool
+
+config SIFIVE_UART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 3db623e..196ac91 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -30,6 +30,7 @@ softmmu_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_uart.c'))
 softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_uart.c'))
 softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_aux.c'))
 softmmu_ss.add(when: 'CONFIG_RENESAS_SCI', if_true: files('renesas_sci.c'))
+softmmu_ss.add(when: 'CONFIG_SIFIVE_UART', if_true: files('sifive_uart.c'))
 softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('sh_serial.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a0e256c..a046157 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -15,6 +15,7 @@ config SIFIVE_E
     select SIFIVE_CLINT
     select SIFIVE_GPIO
     select SIFIVE_PLIC
+    select SIFIVE_UART
     select SIFIVE_E_PRCI
     select UNIMP
 
@@ -27,6 +28,7 @@ config SIFIVE_U
     select SIFIVE_GPIO
     select SIFIVE_PDMA
     select SIFIVE_PLIC
+    select SIFIVE_UART
     select SIFIVE_U_OTP
     select SIFIVE_U_PRCI
     select UNIMP
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 619bf80..da32148 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -5,7 +5,6 @@ riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
-- 
2.7.4


