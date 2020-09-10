Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3194BC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BBB2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WJdvdJpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BBB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGROc-0001Ur-6W
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57674)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCA-0005Dr-SX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRC3-0002kZ-KX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762071; x=1631298071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m4Psi2fGHIvIHYNecXt278/fZ9XwT1VoR3tJMpMyo7k=;
 b=WJdvdJpoN3KjiQxFt7DdVafHV6cwDyHeqFFdibcVBBc+LFGimV19p0UX
 v/hKrTOJYvE8RfchhJthRnCfFgqQBy0ejolsPsWSjyJB5lMqKSth6nT17
 CPLn7HMkJrERfEnc6BgVsR8EEp5ZBKxQ7b4oV/yz42rSn46FP6YT2ppQq
 11Orv7OZXONFHTWkwuPs7LlSlivQCeQ9Oc3BdOFsSUCqlR0pU7Kyimh3a
 bMSO+uLi6dS1flgRpirhue6ptcFC0FnQQzt5l94WEb64n0V7+ywkfQ+B8
 XwSKK9sIf3LBwtyQ5qX/6P79rbc8mrbAWHzLLDJCug0cP5euVVmkrRPdm Q==;
IronPort-SDR: oRmCEjcpOob889nvzqlcpT/CX6K6j3lt25vMLYsjaexgC3wPuiXRDMjsjXkwzZzvL3WHjKuCKm
 ew8MXjuvBF8cpFcycXdc4TeIiA0MPPkGnuYUX6amep0KOtPr979UvaaPG93CgiMIF54sc8j0qV
 JULfjVUBS1WNpRA3IyomvQ4908F4J3iu8OWAQ8zOpyxw8utY9/wyxTMUMTl5BW/CeZcRdj66yb
 v8sMWT30zhfg5ofgnmQdjLR3rJqOhG5fQTHxwuUCuwmGiJc5U8+TNtGCQxw1sU+BiNhAqSBTJl
 YSA=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979249"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:21 +0800
IronPort-SDR: GZQgmgoOl9Rrc/cEA19isCHD1Q0KoJbcZgcVK4EoRImlgikZ83+2FOCHZIKV1cb4SL/g+WIqWS
 b63DdvaAUAZQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:38 -0700
IronPort-SDR: ta/gvY420dGgATrcqUihxNVWRN0FaeTTP6yfGKk2iONN+qB4PK6pXzYMELSZw/Y5QONaikmfBg
 0y4v77oINfNA==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:21 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 25/30] hw/riscv: Move riscv_htif model to hw/char
Date: Thu, 10 Sep 2020 11:09:33 -0700
Message-Id: <20200910180938.584205-26-alistair.francis@wdc.com>
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
codes. Let's move riscv_htif model to hw/char directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-8-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index ca87a5cf9f..ba1af1cfc4 100644
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
index 59d9d87c56..3fd152a035 100644
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
index 1d645554c7..91da92f617 100644
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
index ae27932d00..3db623eeec 100644
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
index 23b7027e11..a0e256c344 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,6 +1,3 @@
-config HTIF
-    bool
-
 config HART
     bool
 
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index df3f89d062..90df67acc7 100644
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
2.28.0


