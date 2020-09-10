Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8E0C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA43214F1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jywiFn4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA43214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRSE-0000tq-02
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCM-0005Hz-74
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCE-0002ls-7C
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762082; x=1631298082;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D/Vi8w9Jjuz5TlcL5r2ZU35tp8D8/sf5gxMBjeekNSc=;
 b=jywiFn4QCfKe8tpelczXbN8q8+MThKYyeMVDnGJdyNC+dv6+gvID2HkM
 b9oBBRO1ePKAio7g6IU39xyKZGRirEXoxCQuPgWTdyhsjVyjrNc4oWAUV
 cFjfjy8JYmzaAKudyUdkSQP5/JhsrSTHcwtB+afpMhnw8JKzp5LhAAaWH
 7IlNo0Vcb+2d1ZPLrYQ+8eBCIyZ/LQsg7w3MB07Hi1hkhyQm+o92+8SjI
 PF1NM6Dg1SnC3lojx3U+nNFabxymnC/+wyWliDOSL4E7gME8UldDhpvdm
 Y2mY8VmbgmJtMn5YZ1zr+Hc46whRCNlw+GLqSqXr880DBcL6P7L6W43zr g==;
IronPort-SDR: /9fscl00KEd97CgvH6mvdKDvT6Ct2uKrOaSA23b2hgRzdQqfnOSAh0EXCU+/JNttLQoM7h9sfH
 n8Ghz7N0X67/42ARuFmb/itg5HUKvWNDiAMoXwmj/Jw05f2BXr4CiXWCQRXNXAcxehM63IwtwL
 HjaqgPy+HzppD4/Ear0ljltsdDt9KAh81OAUqpfKz8SQBm/vxJ0UxuX3C2gNkk5bH6kFFwR4AO
 /ojFZ9vkj9erLGiqp8gn9dfcajVZZLUsskAi4p1J1Rw2ZJEM3GTBt2WmJrLnENUbM8czfh5Ypr
 Z9c=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979248"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:21 +0800
IronPort-SDR: D+HFplrhZwOxHdGYU1LObsf/TBSypyBfnc6iyKcaKAW9JyYV3Qu1pZy6XsihHMJ/QHVOb207Jo
 BH5uM66MdQjQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:38 -0700
IronPort-SDR: vK8szX08sEINtCs0GHWJLn99JQx/0nlpvfTD3Nds6fRNqTfMAyDCGKsDQt2meC5rbH/xU3VWaF
 HbGA9AkUltbw==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 24/30] hw/riscv: Move sifive_plic model to hw/intc
Date: Thu, 10 Sep 2020 11:09:32 -0700
Message-Id: <20200910180938.584205-25-alistair.francis@wdc.com>
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
codes. Let's move sifive_plic model to hw/intc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-7-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index 11ef147606..af611f8db8 100644
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
index 131eea1ef3..4627179cd3 100644
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
index 3bdb16e697..0ddcf1508d 100644
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
index 7187d1ad17..faca2e829e 100644
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
index bce2020d02..0caab8e050 100644
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
index f499d0f8df..d07954086a 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -70,3 +70,6 @@ config LOONGSON_LIOINTC
 
 config SIFIVE_CLINT
     bool
+
+config SIFIVE_PLIC
+    bool
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 1e20daab77..3f82cc230a 100644
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
index f8bb7e7a05..23b7027e11 100644
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
index d0b4cafaec..df3f89d062 100644
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
2.28.0


