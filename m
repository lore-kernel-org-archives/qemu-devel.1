Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1F9C2D0E1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB76214F1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="roQ4SZie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB76214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRNC-00078T-IM
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBt-0004lI-Bv
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBp-0002kZ-7x
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762057; x=1631298057;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3EvBgofHhd3e8pU9Pz1dQfsdWXOrxazWer918sREQ7s=;
 b=roQ4SZier+ZjU53bVV7GARIIdt8Cp2inQSOcWOeOby0SX4Ds8Fk90vV/
 zboB+uhvON4aozHmnxDGmdwFHJnFBD0g1Cm3qEhKl6QZl0UQwGU+jUpdI
 2aN2YBHmeNCRKNkzKpCdlddq4CwQ4wYnHulcOsOa/K1OGLzC/vMaU38Fe
 YgHl9VVyQFCttsK7qihfoJ9AtNdQR82yrRwiYyer76zpnk72ymzm8tZDG
 5vIbBtRLXF647cN/Z3egrv83jKB3I/FfiffO90fRi6iMhVgh17aJm9HU8
 4D4T3Omvz/fxKLP+MQ6u89HtoDxX0G5w+Tdu6YdY1FcjHMnns6G5aV7uu w==;
IronPort-SDR: Wlcoi66vwOti1IPenjateYrJ94evfPYNGbclsBSBYLS4n8V1FNeE9EeBgjNNxolP02rsl7R5JX
 bf3RtzrofVcvDZxecI8ZKqakBQEwNsIUe1/snLkJrLu3qOiYFM7AAl/UuCyum+fwm3q9i+Sz1i
 YN40JAFWJuu9NzVW7FlFONbCTQ1t5PsWN8oltHYI6aTQVg+QrG3aOBNKI6NYkSOOx7Sk2bTHPA
 3UnX6dUQGO2jvmfs9RCKUEhu2B6K03LgbQiCzpDFTk62bCsg18JdUn6DyZl/eJYtLffJ3hojuz
 ULM=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979242"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:19 +0800
IronPort-SDR: zmvR3GOQKb9bYgUfox0hHEHRb30glbmUFTi6erIjHNiZHTGD87wdF72MaHq7vGIYKyJJV/XHK7
 XFFV8QvrH5+w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:36 -0700
IronPort-SDR: yp6OmKw2dmPUPIW+/OFTTXoVbfP7rPcT5BboCK9MnSrVjOViFaiY7qbfiyQzj0jRzUA2//T/zV
 e1vZB9jC8b0g==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 19/30] hw/riscv: Move sifive_e_prci model to hw/misc
Date: Thu, 10 Sep 2020 11:09:27 -0700
Message-Id: <20200910180938.584205-20-alistair.francis@wdc.com>
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
codes. Let's move sifive_e_prci model to hw/misc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-2-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/{riscv => misc}/sifive_e_prci.h | 0
 hw/{riscv => misc}/sifive_e_prci.c         | 2 +-
 hw/riscv/sifive_e.c                        | 2 +-
 hw/misc/Kconfig                            | 3 +++
 hw/misc/meson.build                        | 3 +++
 hw/riscv/Kconfig                           | 1 +
 hw/riscv/meson.build                       | 1 -
 7 files changed, 9 insertions(+), 3 deletions(-)
 rename include/hw/{riscv => misc}/sifive_e_prci.h (100%)
 rename hw/{riscv => misc}/sifive_e_prci.c (99%)

diff --git a/include/hw/riscv/sifive_e_prci.h b/include/hw/misc/sifive_e_prci.h
similarity index 100%
rename from include/hw/riscv/sifive_e_prci.h
rename to include/hw/misc/sifive_e_prci.h
diff --git a/hw/riscv/sifive_e_prci.c b/hw/misc/sifive_e_prci.c
similarity index 99%
rename from hw/riscv/sifive_e_prci.c
rename to hw/misc/sifive_e_prci.c
index 17dfa74715..8ec4ee4b41 100644
--- a/hw/riscv/sifive_e_prci.c
+++ b/hw/misc/sifive_e_prci.c
@@ -24,7 +24,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/hw.h"
-#include "hw/riscv/sifive_e_prci.h"
+#include "hw/misc/sifive_e_prci.h"
 
 static uint64_t sifive_e_prci_read(void *opaque, hwaddr addr, unsigned int size)
 {
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 36ccfb2071..7f43ed953a 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -43,8 +43,8 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_e.h"
-#include "hw/riscv/sifive_e_prci.h"
 #include "hw/riscv/boot.h"
+#include "hw/misc/sifive_e_prci.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 92c397ca07..507398635b 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -134,4 +134,7 @@ config MAC_VIA
 config AVR_POWER
     bool
 
+config SIFIVE_E_PRCI
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index e1576b81cf..b6b2e5797f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -21,6 +21,9 @@ softmmu_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 # Mac devices
 softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 
+# RISC-V devices
+softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
+
 # PKUnity SoC devices
 softmmu_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3_pm.c'))
 
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e53ab1efa5..5855e99aaa 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -15,6 +15,7 @@ config SIFIVE_E
     bool
     select HART
     select SIFIVE
+    select SIFIVE_E_PRCI
     select UNIMP
 
 config SIFIVE_U
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index c29a48c3f1..003994d1ea 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -10,7 +10,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_plic.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e_prci.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_otp.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_prci.c'))
-- 
2.28.0


