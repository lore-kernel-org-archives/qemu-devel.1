Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3DAC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0E020775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 10:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNSIF1bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0E020775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDmjm-0005Gh-Tt
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 06:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmft-0005yd-1i; Thu, 03 Sep 2020 06:41:01 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kDmfo-0002Gr-63; Thu, 03 Sep 2020 06:41:00 -0400
Received: by mail-pg1-x541.google.com with SMTP id 5so1809038pgl.4;
 Thu, 03 Sep 2020 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VVHGFoHo2QIB2V4Pjw5ItIdHbPQBAH4Nd1LvnzoicGs=;
 b=uNSIF1bknDOHmynukwxVg0CLa2V646H7kuv+P0KrDfJCyQV7PGbxsGuKSmEmj9Iwny
 Scl+BLL3lzQ6fhiOCoivNPiBvvtEYtA03JufSYrLhekobIBzbAKa/36ZyMlxgT5HXu4I
 AhZxShxJzDEYn+asBq7QpaV68+/YkiRBiEru4T81KMCn8nOk1/ObHG4yyoQts4Wha+2V
 nQNwgNYWv8J25VU+GLsaLdIrsVNZBVwZzJ7COODrTJkLOIandvY5SlSzsuwnXWDM++HE
 laX/UuRjr6rrWl93dNrPY1swZoFiWqiiMddECcS4QyNGSRzrCw2la/OW7RzeJJUnHdmv
 ugLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VVHGFoHo2QIB2V4Pjw5ItIdHbPQBAH4Nd1LvnzoicGs=;
 b=Ju4e9t6UWL1Y1Y2DZZaz8lu/zMK/Ttyfp4SuuGTOiyDjQt+83nCL/MMjXZZt0QLMrh
 +EFRZByAlL2GFptr84yTRMT2+y1wXojFNdlV8BqoMlHBrq2+yufuc3WUne4NwfouL8Kl
 i7c12wZRCdFaHXzYX9GktH5Hc85mDRsXddBcNnNawz2+BwwFphXCtwGu4MzdUPV8AHF/
 KHg0p55QgGYZ8Rcx9WgjX7T9LCOrHG2v2Wy37VQYrPnkevV3yFy2h+H1yMdWrxvsPs12
 bRitb7cNuPIhVc4n3OYr/65gonyI1sB4Qj2cuT+hxJmfgxX9SwrF8C5EwyhBED28Fdgb
 x7RQ==
X-Gm-Message-State: AOAM530X+5nSYmmsmUbRMPkCjr9PqzY1G7J3F4fh2l/lTFlypbf6+Wnh
 oQf9o/Pns4oOQFM7rYkvCGQ=
X-Google-Smtp-Source: ABdhPJxuDzzsBymX0tTn0HnhRnbpkqj32RWlamu7y+HhHNERLmVQYWe3YeaHNDt/dW7KHVyfNxT4Rw==
X-Received: by 2002:a05:6a00:811:: with SMTP id
 m17mr3216044pfk.20.1599129654540; 
 Thu, 03 Sep 2020 03:40:54 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (unknown-146-144.windriver.com.
 [147.11.146.144])
 by smtp.gmail.com with ESMTPSA id b18sm2137098pjq.3.2020.09.03.03.40.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 03 Sep 2020 03:40:54 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 06/12] hw/riscv: Move sifive_plic model to hw/intc
Date: Thu,  3 Sep 2020 18:40:17 +0800
Message-Id: <1599129623-68957-7-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
References: <1599129623-68957-1-git-send-email-bmeng.cn@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=bmeng.cn@gmail.com; helo=mail-pg1-x541.google.com
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
codes. Let's move sifive_plic model to hw/intc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 {include/hw/riscv => hw/intc}/sifive_plic.h | 0
 hw/{riscv => intc}/sifive_plic.c            | 2 +-
 hw/riscv/microchip_pfsoc.c                  | 2 +-
 hw/riscv/sifive_e.c                         | 2 +-
 hw/riscv/sifive_u.c                         | 2 +-
 hw/riscv/virt.c                             | 2 +-
 hw/intc/Kconfig                             | 3 +++
 hw/intc/meson.build                         | 1 +
 hw/riscv/Kconfig                            | 5 +++++
 hw/riscv/meson.build                        | 1 -
 10 files changed, 14 insertions(+), 6 deletions(-)
 rename {include/hw/riscv => hw/intc}/sifive_plic.h (100%)
 rename hw/{riscv => intc}/sifive_plic.c (99%)

diff --git a/include/hw/riscv/sifive_plic.h b/hw/intc/sifive_plic.h
similarity index 100%
rename from include/hw/riscv/sifive_plic.h
rename to hw/intc/sifive_plic.h
diff --git a/hw/riscv/sifive_plic.c b/hw/intc/sifive_plic.c
similarity index 99%
rename from hw/riscv/sifive_plic.c
rename to hw/intc/sifive_plic.c
index 11ef147..af611f8 100644
--- a/hw/riscv/sifive_plic.c
+++ b/hw/intc/sifive_plic.c
@@ -27,9 +27,9 @@
 #include "hw/pci/msi.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
+#include "hw/intc/sifive_plic.h"
 #include "target/riscv/cpu.h"
 #include "sysemu/sysemu.h"
-#include "hw/riscv/sifive_plic.h"
 
 #define RISCV_DEBUG_PLIC 0
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 131eea1..4627179 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -48,9 +48,9 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/microchip_pfsoc.h"
 #include "hw/intc/sifive_clint.h"
+#include "hw/intc/sifive_plic.h"
 #include "sysemu/sysemu.h"
 
 /*
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 3bdb16e..0ddcf15 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -39,11 +39,11 @@
 #include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_e.h"
 #include "hw/riscv/boot.h"
 #include "hw/intc/sifive_clint.h"
+#include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_e_prci.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7187d1a..faca2e8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -46,11 +46,11 @@
 #include "hw/misc/unimp.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_u.h"
 #include "hw/riscv/boot.h"
 #include "hw/intc/sifive_clint.h"
+#include "hw/intc/sifive_plic.h"
 #include "chardev/char.h"
 #include "net/eth.h"
 #include "sysemu/arch_init.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index bce2020..0caab8e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -30,12 +30,12 @@
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/sifive_test.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "hw/intc/sifive_clint.h"
+#include "hw/intc/sifive_plic.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index f499d0f..d079540 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -70,3 +70,6 @@ config LOONGSON_LIOINTC
 
 config SIFIVE_CLINT
     bool
+
+config SIFIVE_PLIC
+    bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 1e20daa..3f82cc2 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -48,6 +48,7 @@ specific_ss.add(when: 'CONFIG_S390_FLIC', if_true: files('s390_flic.c'))
 specific_ss.add(when: 'CONFIG_S390_FLIC_KVM', if_true: files('s390_flic_kvm.c'))
 specific_ss.add(when: 'CONFIG_SH4', if_true: files('sh_intc.c'))
 specific_ss.add(when: 'CONFIG_SIFIVE_CLINT', if_true: files('sifive_clint.c'))
+specific_ss.add(when: 'CONFIG_SIFIVE_PLIC', if_true: files('sifive_plic.c'))
 specific_ss.add(when: 'CONFIG_XICS', if_true: files('xics.c'))
 specific_ss.add(when: 'CONFIG_XICS_KVM', if_true: files('xics_kvm.c'))
 specific_ss.add(when: 'CONFIG_XICS_SPAPR', if_true: files('xics_spapr.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index f8bb7e7..23b7027 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -17,6 +17,7 @@ config SIFIVE_E
     select SIFIVE
     select SIFIVE_CLINT
     select SIFIVE_GPIO
+    select SIFIVE_PLIC
     select SIFIVE_E_PRCI
     select UNIMP
 
@@ -28,6 +29,7 @@ config SIFIVE_U
     select SIFIVE_CLINT
     select SIFIVE_GPIO
     select SIFIVE_PDMA
+    select SIFIVE_PLIC
     select SIFIVE_U_OTP
     select SIFIVE_U_PRCI
     select UNIMP
@@ -38,6 +40,7 @@ config SPIKE
     select HTIF
     select SIFIVE
     select SIFIVE_CLINT
+    select SIFIVE_PLIC
 
 config OPENTITAN
     bool
@@ -58,6 +61,7 @@ config RISCV_VIRT
     select PFLASH_CFI01
     select SIFIVE
     select SIFIVE_CLINT
+    select SIFIVE_PLIC
 
 config MICROCHIP_PFSOC
     bool
@@ -67,4 +71,5 @@ config MICROCHIP_PFSOC
     select UNIMP
     select MCHP_PFSOC_MMUART
     select SIFIVE_PDMA
+    select SIFIVE_PLIC
     select CADENCE_SDHCI
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index ea72178..535a142 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -4,7 +4,6 @@ riscv_ss.add(files('numa.c'))
 riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_plic.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
-- 
2.7.4


