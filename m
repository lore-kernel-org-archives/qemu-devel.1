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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5603BC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098C820775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVTsZYB/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098C820775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmmw-0001mu-2a
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfv-00063b-1q; Thu, 03 Sep 2020 06:41:03 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40390)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmft-0002H2-1T; Thu, 03 Sep 2020 06:41:02 -0400
Received: by mail-pj1-x1043.google.com with SMTP id gf14so1266199pjb.5;
 Thu, 03 Sep 2020 03:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Bjt7/k4o145ugR9pJpMn6OkaWclyCj0SqUQ2K7UT0nQ=;
 b=YVTsZYB/NMVPkXRt7cS2WKL6n4Rgb9/27Tk7hkvn/mAX+6xldpqdqmc2Xj9pwfC6Yr
 FijeO7hfufcbkYNmSe5mehvsKmlTtm3DhPgF/brh2prk58Pb/jQ9g0aZMQFR7FqxrqYf
 2oAdhMQnheJ2IfgSd5+7C2l4AGZcXCdHGtnNNhNWf6q2pahYEDtwiC/JVUXfSIIqJTXC
 SOg7nnblPCGdFSrIz/SeAP2ZKxsEs5XTYEYTTLIFGD2whEN59UUVVpM7WANODBJEDzzS
 uSafn/rnm6ZIfgbqxHUkRozF/JcKW1vPp5Id4zvqqAb2E0AKO7x4vQR6EGRyRyIOoT4n
 owWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Bjt7/k4o145ugR9pJpMn6OkaWclyCj0SqUQ2K7UT0nQ=;
 b=aM1lHLdJWyKo2n8HAk5U/0Yc2BOHHmc0I8fnyywajY1e8noACO0RMp4b7DuQLtlgJZ
 CWbc/3GyHYI6a2pvZVr4p02au8bk8vu/7mmqb2UEn6DcMLFnlFfIrv2VnWr/A+8ZO0dH
 DrB7ESCP4QGnrGNR5LDeBi1R7VdQWWbkX4Z6WBqWpwmCoM5gN7NizKiO87wa2BlJLNub
 EuwwtTclsKnul4u7cJ//GKPjAWdX2fDQOgMrZZnJOTLkD/BnY7fBcD+fJDa5CpnXoruP
 JVyvWvgUqLmvNbmltchD8oWmUJXzUmdi893X5VBmM4PGf3tO+1qpZMWirFUd8CCZ1Njb
 wyog==
X-Gm-Message-State: AOAM532hQutQ6l9dPI4FVl4593RoYUC4OZGfOxTZ1RjcMzCH6JtUq2f0
 7IIjFZW28xtZGS0RXMK3wM0=
X-Google-Smtp-Source: ABdhPJz2S91eHhxsMfQJPN/k1KyLQyrMgaQ0UiVBcB47x2PGR9jxPtc1g0Q5I45ytBb9iSlMytuZqg==
X-Received: by 2002:a17:90b:4c03:: with SMTP id
 na3mr2711748pjb.29.1599129656965; 
 Thu, 03 Sep 2020 03:40:56 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id b18sm2137098pjq.3.2020.09.03.03.40.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:40:56 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 07/12] hw/riscv: Move riscv_htif model to hw/char
Date: Thu,  3 Sep 2020 18:40:18 +0800
Message-Id: <1599129623-68957-8-git-send-email-bmeng.cn@gmail.com>
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
codes. Let's move riscv_htif model to hw/char directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 include/hw/{riscv => char}/riscv_htif.h | 0
 hw/{riscv => char}/riscv_htif.c         | 2 +-
 hw/riscv/spike.c                        | 2 +-
 hw/char/Kconfig                         | 3 +++
 hw/char/meson.build                     | 1 +
 hw/riscv/Kconfig                        | 3 ---
 hw/riscv/meson.build                    | 1 -
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename include/hw/{riscv => char}/riscv_htif.h (100%)
 rename hw/{riscv => char}/riscv_htif.c (99%)

diff --git a/include/hw/riscv/riscv_htif.h b/include/hw/char/riscv_htif.h
similarity index 100%
rename from include/hw/riscv/riscv_htif.h
rename to include/hw/char/riscv_htif.h
diff --git a/hw/riscv/riscv_htif.c b/hw/char/riscv_htif.c
similarity index 99%
rename from hw/riscv/riscv_htif.c
rename to hw/char/riscv_htif.c
index ca87a5c..ba1af1c 100644
--- a/hw/riscv/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -24,10 +24,10 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "hw/sysbus.h"
+#include "hw/char/riscv_htif.h"
 #include "hw/char/serial.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
-#include "hw/riscv/riscv_htif.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 59d9d87..3fd152a 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -31,11 +31,11 @@
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
-#include "hw/riscv/riscv_htif.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/spike.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
+#include "hw/char/riscv_htif.h"
 #include "hw/intc/sifive_clint.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 1d64555..91da92f 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -1,6 +1,9 @@
 config ESCC
     bool
 
+config HTIF
+    bool
+
 config PARALLEL
     bool
     default y
diff --git a/hw/char/meson.build b/hw/char/meson.build
index ae27932..3db623e 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -34,6 +34,7 @@ softmmu_ss.add(when: 'CONFIG_SH4', if_true: files('sh_serial.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F2XX_USART', if_true: files('stm32f2xx_usart.c'))
 softmmu_ss.add(when: 'CONFIG_MCHP_PFSOC_MMUART', if_true: files('mchp_pfsoc_mmuart.c'))
 
+specific_ss.add(when: 'CONFIG_HTIF', if_true: files('riscv_htif.c'))
 specific_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('terminal3270.c'))
 specific_ss.add(when: 'CONFIG_VIRTIO', if_true: files('virtio-serial-bus.c'))
 specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_vty.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 23b7027..a0e256c 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,6 +1,3 @@
-config HTIF
-    bool
-
 config HART
     bool
 
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 535a142..619bf80 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -8,7 +8,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
-riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('riscv_htif.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
 
-- 
2.7.4


