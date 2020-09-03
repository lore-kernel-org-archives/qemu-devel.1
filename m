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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069F9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4DA20775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQgZSgtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4DA20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmlh-00083j-Pt
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmft-0005zP-Cd; Thu, 03 Sep 2020 06:41:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfl-0002GX-Ix; Thu, 03 Sep 2020 06:41:01 -0400
Received: by mail-pg1-x543.google.com with SMTP id v15so1800513pgh.6;
 Thu, 03 Sep 2020 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=j4GqdI2kBLXYKPblR8CoMHEGSszLQ6puCT6wgQ2l1hA=;
 b=iQgZSgtZMt6WHTdUdrTs0kHEiMr2H0rirjjxTLP3zCrnVtEz/uJiA/dsQLFPb4uo86
 WbvsiifbImPZuiTwD0xxAOtzjjzbeDpVs8K4DlBPYMhawhezqkaO8Db5fldlozhZKUfr
 5Y9epTQjUYOvGgDyldmEmYZOKQzWkOo/ciO4Af77zOW3UDdwynyiSFMFdHgPy/TaSLfL
 hh6cqwfmlu2a/kGFLRmqJ83YwOJ3jWbGXNIIOSV9W39bPP2ZqVsHyhBuoPqPytVo1k/c
 89e4fdUtd8rxQdyIjbHFgDXbxd460BGQEqY8sp5kiC0Wx0IXr5GPLBLBOBzTZs7TLZZK
 82nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=j4GqdI2kBLXYKPblR8CoMHEGSszLQ6puCT6wgQ2l1hA=;
 b=Z/iz439bvKHNTAC4UZBAF3v7jachhCoWqX41ymTbXuYvla2/pjqs4xM4+2YwuDD06M
 r3GgwabCf10UnR18Cw8GbdlZm7SSgkWnmKPw54WYDoEE+jgxt4WlzfBEpL/08QYLHKPi
 JDkPfIN1PaX0UCrR8QjC0BbDSnBpQrhcALknnc8KVcYo7FWSyHlXVOsWm5eNkhjnBNsa
 f291y6U4T3/mV6qT7H8Fz+Cf92B+loXPSRNvFG8ISSg72Ytp8GbRaLOYBJMtoehDSYhq
 FVDQjAzyG0uFsgcQMpghm0j36ZakWFnzW74odis4c+nt8btLHmyFZcbrxnMLz/lfonae
 EqDw==
X-Gm-Message-State: AOAM532NFW3lEOdNXCvhc1ed6SflaGBPHJXe5uxAN6Qo6bhrvvTzY6B1
 dWyGzA33jYy88awPnr5yUJ8=
X-Google-Smtp-Source: ABdhPJx0qQc8YkMdin7U+Zm5krgiflC7Jwr0wF2hro7MgdgOhr0tXlAUCrFYHb/5VT6uT6wMlTH7Zw==
X-Received: by 2002:a17:902:b58a:: with SMTP id
 a10mr3272865pls.269.1599129651981; 
 Thu, 03 Sep 2020 03:40:51 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id b18sm2137098pjq.3.2020.09.03.03.40.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:40:51 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 05/12] hw/riscv: Move sifive_clint model to hw/intc
Date: Thu,  3 Sep 2020 18:40:16 +0800
Message-Id: <1599129623-68957-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x543.google.com
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
codes. Let's move sifive_clint model to hw/intc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
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
index fa1ddf2..0f41e5e 100644
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
index da6bd29..131eea1 100644
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
index 7f43ed9..3bdb16e 100644
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
index 7997537..7187d1a 100644
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
index b54a396..59d9d87 100644
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
index c67a910..bce2020 100644
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
index 2ae1e89..f499d0f 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -67,3 +67,6 @@ config RX_ICU
 
 config LOONGSON_LIOINTC
     bool
+
+config SIFIVE_CLINT
+    bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index c16f7f0..1e20daa 100644
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
index 5a8335b..f8bb7e7 100644
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
index 24177ef..ea72178 100644
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
2.7.4


