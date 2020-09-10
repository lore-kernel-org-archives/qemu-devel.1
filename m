Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FC8C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AD021941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p/Sbst9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AD021941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRSF-0000yu-Oh
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCY-0005Qc-1l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCH-0002j9-Do
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762085; x=1631298085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=83CI6n2ELG/fVQomgA7VnyNY61J1Qy5pueTrmpjus1U=;
 b=p/Sbst9Pvg8YIYjg+NWpcwNjgxD0209j2hfzkvKotIJl19skoogz2QDY
 LBqYe+YRHQSaVGtxDeO+Lwlukenbpgpr1OVHI3uE1yEywD/knN4TpgdUn
 L2CuGiKZtg5T5uaaRNdn2lOOzNsRpA0EBcnVG6Wt2RKH3u+0crw/7kLxH
 Am65EUgC814BSuDlVnFyyNnjV3ECtGLy6cHt0nByouFNNtJgGbZL67EMD
 fG/HII7G3CoqZheUT5G2g25NrmXZOqS96uEo21IbpzwS2/2B1ByqWTPFN
 J3EmyVOj5JlvOx6v2GJn5aU/ZxOUV7cPr+OwmWaxJ+Nf9wFFe2dsk2n6A w==;
IronPort-SDR: GYsQ9X6plNRpBFeU3VqYZiZS19BGdg8X4SngllLd8F1iDq2+t6/JgkTH9jRyxfsyDSaaJFWP8x
 d3/38Q4RDSZruuV8bmpraT1k1sv5xa1kL8BSpOOKeR+tzyJehRaiQ+SH3euYwzSdf8C81WhoQt
 fhZfkrhBT7h1K417c0QoK2oc8h7omR4gqLtbLmelW966hDvpA+SyVXN9KNO+1VqP1KKYk+9mZR
 TIM7/GUnSYx+b0WHHAbafN4RSbKjUQNRaqmEeL9kq+93hcXB59cTw83jMbihZVWgadLSxNKI4p
 Fas=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979250"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:21 +0800
IronPort-SDR: VUvfy7ho2ml/b087SUy0YSm2hJYTgy+ADF7hPxwfdl709kaH75DdIozssG/IenXgSL91Hh4LEe
 vmZyENDtde+A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:38 -0700
IronPort-SDR: mS+xXSNWWA8kp6y2LIUzxwX46ILl1sMx6znFeeGDslrLz1Wum4upvkX+nzIfbG74sBRyOjgmrp
 jDGH4R0hqh6Q==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 26/30] hw/riscv: Move sifive_uart model to hw/char
Date: Thu, 10 Sep 2020 11:09:34 -0700
Message-Id: <20200910180938.584205-27-alistair.francis@wdc.com>
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
codes. Let's move sifive_uart model to hw/char directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-9-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index 9350482662..3a00ba7f00 100644
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
index 0ddcf1508d..40bbf530d4 100644
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
index faca2e829e..4f12a93188 100644
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
index 91da92f617..939bc44758 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -58,3 +58,6 @@ config AVR_USART
 
 config MCHP_PFSOC_MMUART
     bool
+
+config SIFIVE_UART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index 3db623eeec..196ac91fa2 100644
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
index a0e256c344..a0461578a6 100644
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
index 90df67acc7..967572d4f6 100644
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
2.28.0


