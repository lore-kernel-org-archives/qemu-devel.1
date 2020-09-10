Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A7C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40A072080A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kzg8Ah67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40A072080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRMt-0006XS-1n
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRC8-0005Cs-TJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRC1-0002lX-KR
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762069; x=1631298069;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ov3bj3OzgEsMtry51ZXp6+8csJeMVO3LF47JbLSfTb8=;
 b=Kzg8Ah67+N8HqoCutIR2uvrZptyY52hT5Q9pckwFkSeVNEU0B6x0h5S0
 K0i3UVmAR1ruizpB5f1S63nuUTLkB8DaABQHYGuCNj9V7Cb7t53B/DKKP
 /xTeSlHYCvCrTQp+hyee1a+xGb5JKi68YaiLo4x34W2xm8GHkLckiZFFq
 BohBDkM842aeX8GeGWK0wcWWztrOgqcB8DySUrjWY58gPTcnLKhIMkhQb
 j7+x4vU4ZBjbFxJpjyPQB/4mBf+KzuyTHb6XSbE2JMortDtGvwh56fcJS
 f9DDMuSr2DPvN849iMSAQagYKI5mqdpFkmNDWwYtyz+NlEieHz43lIzNo g==;
IronPort-SDR: otAtNpf7nOTWOuAG8a08VX9OGNXweAYww1yC8QppQv3zxhnCwQbKd8lT8IKXwPWE8LBf8X/wgF
 i/7aFTb/WbyPUw1jKQR6yMZuAML42PaoI+nvzmaPbbd5GJCBGPsqIA46+wDgH1VfgbFAQO6Kw9
 VIkbZnxmpavZw5QHtrkfN5no4ex9UZ/KrhRUuJbaPzAHSDKLrxpGOnfWDErMuZR3d7fa/8h6IK
 KjCm2Ftr2dwDxYGTgBrpMd/4bG0Qv+Q6yL9yrOJJhL47R4Six/UXLsOXIJWzpaeBxRJRYXbMjO
 X4Y=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979246"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:21 +0800
IronPort-SDR: CJKr6PIl6js6Nvg4hvEfd9ezx9LWsgLsi4uAidXx3xfNX16w2IqoSXF4jwPLS7nLOumarah1Zf
 Lie5pQiVjdag==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:37 -0700
IronPort-SDR: 8YikdC/I3xZsrKfJp2eYuJMckAm+D46SN+hqFIQr7ECdKOBnm/yVYtBeCzmlFADqNR/fbaQT9S
 etLWBgcup4og==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 23/30] hw/riscv: Move sifive_clint model to hw/intc
Date: Thu, 10 Sep 2020 11:09:31 -0700
Message-Id: <20200910180938.584205-24-alistair.francis@wdc.com>
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
codes. Let's move sifive_clint model to hw/intc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-6-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/{riscv => intc}/sifive_clint.h | 0
 hw/{riscv => intc}/sifive_clint.c         | 2 +-
 hw/riscv/microchip_pfsoc.c                | 2 +-
 hw/riscv/sifive_e.c                       | 2 +-
 hw/riscv/sifive_u.c                       | 2 +-
 hw/riscv/spike.c                          | 2 +-
 hw/riscv/virt.c                           | 2 +-
 hw/intc/Kconfig                           | 3 +++
 hw/intc/meson.build                       | 1 +
 hw/riscv/Kconfig                          | 5 +++++
 hw/riscv/meson.build                      | 1 -
 11 files changed, 15 insertions(+), 7 deletions(-)
 rename include/hw/{riscv => intc}/sifive_clint.h (100%)
 rename hw/{riscv => intc}/sifive_clint.c (99%)

diff --git a/include/hw/riscv/sifive_clint.h b/include/hw/intc/sifive_clint.h
similarity index 100%
rename from include/hw/riscv/sifive_clint.h
rename to include/hw/intc/sifive_clint.h
diff --git a/hw/riscv/sifive_clint.c b/hw/intc/sifive_clint.c
similarity index 99%
rename from hw/riscv/sifive_clint.c
rename to hw/intc/sifive_clint.c
index fa1ddf2ccd..0f41e5ea1c 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/intc/sifive_clint.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "target/riscv/cpu.h"
 #include "hw/qdev-properties.h"
-#include "hw/riscv/sifive_clint.h"
+#include "hw/intc/sifive_clint.h"
 #include "qemu/timer.h"
 
 static uint64_t cpu_riscv_read_rtc(uint32_t timebase_freq)
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index da6bd295ce..131eea1ef3 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -48,9 +48,9 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/microchip_pfsoc.h"
+#include "hw/intc/sifive_clint.h"
 #include "sysemu/sysemu.h"
 
 /*
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 7f43ed953a..3bdb16e697 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -40,10 +40,10 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
-#include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_e.h"
 #include "hw/riscv/boot.h"
+#include "hw/intc/sifive_clint.h"
 #include "hw/misc/sifive_e_prci.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 79975372ef..7187d1ad17 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -47,10 +47,10 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
-#include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
+#include "hw/intc/sifive_clint.h"
 #include "chardev/char.h"
 #include "net/eth.h"
 #include "sysemu/arch_init.h"
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index b54a396107..59d9d87c56 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -33,10 +33,10 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_htif.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/spike.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
+#include "hw/intc/sifive_clint.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c67a910e48..bce2020d02 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -31,11 +31,11 @@
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_plic.h"
-#include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_test.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
+#include "hw/intc/sifive_clint.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 2ae1e89497..f499d0f8df 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -67,3 +67,6 @@ config RX_ICU
 
 config LOONGSON_LIOINTC
     bool
+
+config SIFIVE_CLINT
+    bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index c16f7f036e..1e20daab77 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -47,6 +47,7 @@ specific_ss.add(when: 'CONFIG_RX_ICU', if_true: files('rx_icu.c'))
 specific_ss.add(when: 'CONFIG_S390_FLIC', if_true: files('s390_flic.c'))
 specific_ss.add(when: 'CONFIG_S390_FLIC_KVM', if_true: files('s390_flic_kvm.c'))
 specific_ss.add(when: 'CONFIG_SH4', if_true: files('sh_intc.c'))
+specific_ss.add(when: 'CONFIG_SIFIVE_CLINT', if_true: files('sifive_clint.c'))
 specific_ss.add(when: 'CONFIG_XICS', if_true: files('xics.c'))
 specific_ss.add(when: 'CONFIG_XICS_KVM', if_true: files('xics_kvm.c'))
 specific_ss.add(when: 'CONFIG_XICS_SPAPR', if_true: files('xics_spapr.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 5a8335bfec..f8bb7e7a05 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -15,6 +15,7 @@ config SIFIVE_E
     bool
     select HART
     select SIFIVE
+    select SIFIVE_CLINT
     select SIFIVE_GPIO
     select SIFIVE_E_PRCI
     select UNIMP
@@ -24,6 +25,7 @@ config SIFIVE_U
     select CADENCE
     select HART
     select SIFIVE
+    select SIFIVE_CLINT
     select SIFIVE_GPIO
     select SIFIVE_PDMA
     select SIFIVE_U_OTP
@@ -35,6 +37,7 @@ config SPIKE
     select HART
     select HTIF
     select SIFIVE
+    select SIFIVE_CLINT
 
 config OPENTITAN
     bool
@@ -54,11 +57,13 @@ config RISCV_VIRT
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
     select SIFIVE
+    select SIFIVE_CLINT
 
 config MICROCHIP_PFSOC
     bool
     select HART
     select SIFIVE
+    select SIFIVE_CLINT
     select UNIMP
     select MCHP_PFSOC_MMUART
     select SIFIVE_PDMA
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 90003793d4..d0b4cafaec 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -4,7 +4,6 @@ riscv_ss.add(files('numa.c'))
 riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_clint.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_plic.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
-- 
2.28.0


