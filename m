Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD27C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0EA21D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fD6IRFRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0EA21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRSM-0001DX-H0
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCV-0005Mt-Bw
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCI-0002iJ-IA
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762086; x=1631298086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qs06YQlTFYO+qXIoqrxfi5XUU5CHCKwYg0Y65IGrAts=;
 b=fD6IRFRnT+YsdBpTxfz35wZ5iFjAiTOjGQmwW+luY07gTN2xDwwiC0j3
 gKieVneQ/brO7j4+bYRWQTn6m7zjSt8Ie29rYCyTDxrXZyz76yicdgh2F
 PRGhT8LQ8CjQiRBcN8IJQX7/NN7X7rqZ+ozAjuWkk1utXg1dU8p2PLPwL
 FPjSA+3ixrYmYGM0V/USuVPo5VBKPbfQJchZL1XESccAdJ16FGY7SelQ6
 W+gy/z6Lx0q5zuUH67lZIL6Cekf7o9M3nLfu8FnBFsgwrF9UvBf0vfyKi
 yXATlAr6VF05i6LmdPMvDXTJPkPCoActJwcePNYrDOGvNLqfEq6NLl3Rm g==;
IronPort-SDR: Y6dR7/7JXQDoHEbCBWCOkdwrDwDeaS+9yw3zSkXaMilYAxkwLpyIyNCjVWtMNxPNGf4sawJRYy
 BYSSYKVEiotpDVzmifYLJN4NZmqr1lrxT/IHgEToK4frrFMDXrxYLXj0gPlRoau1GZngB445sw
 fLkq+VPn52uaMEZTfiCPlJpcAQpNYZ7NJiBD3+haE1cA/9FkoMtkoSKOSyse0RhegKnkZf9HfO
 qRhKuzIAI7/Doc59Fut7temj4BZNgqU9w6YGzz5RMjWtl61kM9bIfZBhb3LsC+6QfLBl9wuX1w
 fwQ=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979251"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:22 +0800
IronPort-SDR: HTRHOf+cxYwsAlmNosRuEd+j78yiWxh0N/RbCK6QZc4DaMYgcLg8ZSWv5gKf9WYvO3PqBEnt1S
 KFjRJomUNgwg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:38 -0700
IronPort-SDR: A6MW53vNYNCqSYylcDdfSMrcJcCKkmFMqyngF4lxWejq4VH20Bn/Z7xKXQt6hf8W+BTVYolKNo
 Na/T+9V6EuIQ==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 27/30] hw/riscv: Move sifive_test model to hw/misc
Date: Thu, 10 Sep 2020 11:09:35 -0700
Message-Id: <20200910180938.584205-28-alistair.francis@wdc.com>
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
codes. Let's move sifive_test model to hw/misc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-10-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/{riscv => misc}/sifive_test.h | 0
 hw/{riscv => misc}/sifive_test.c         | 2 +-
 hw/riscv/virt.c                          | 2 +-
 hw/misc/Kconfig                          | 3 +++
 hw/misc/meson.build                      | 1 +
 hw/riscv/Kconfig                         | 1 +
 hw/riscv/meson.build                     | 1 -
 7 files changed, 7 insertions(+), 3 deletions(-)
 rename include/hw/{riscv => misc}/sifive_test.h (100%)
 rename hw/{riscv => misc}/sifive_test.c (98%)

diff --git a/include/hw/riscv/sifive_test.h b/include/hw/misc/sifive_test.h
similarity index 100%
rename from include/hw/riscv/sifive_test.h
rename to include/hw/misc/sifive_test.h
diff --git a/hw/riscv/sifive_test.c b/hw/misc/sifive_test.c
similarity index 98%
rename from hw/riscv/sifive_test.c
rename to hw/misc/sifive_test.c
index 8c70dd69df..2deb2072cc 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/misc/sifive_test.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "sysemu/runstate.h"
 #include "hw/hw.h"
-#include "hw/riscv/sifive_test.h"
+#include "hw/misc/sifive_test.h"
 
 static uint64_t sifive_test_read(void *opaque, hwaddr addr, unsigned int size)
 {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0caab8e050..41bd2f38ba 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -30,12 +30,12 @@
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
-#include "hw/riscv/sifive_test.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "hw/intc/sifive_clint.h"
 #include "hw/intc/sifive_plic.h"
+#include "hw/misc/sifive_test.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fa3d0f4723..3185456110 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -134,6 +134,9 @@ config MAC_VIA
 config AVR_POWER
     bool
 
+config SIFIVE_TEST
+    bool
+
 config SIFIVE_E_PRCI
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 018a88c670..bd24132757 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -22,6 +22,7 @@ softmmu_ss.add(when: 'CONFIG_ARM11SCU', if_true: files('arm11scu.c'))
 softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 
 # RISC-V devices
+softmmu_ss.add(when: 'CONFIG_SIFIVE_TEST', if_true: files('sifive_test.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a0461578a6..8e0710001b 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -61,6 +61,7 @@ config RISCV_VIRT
     select SIFIVE
     select SIFIVE_CLINT
     select SIFIVE_PLIC
+    select SIFIVE_TEST
 
 config MICROCHIP_PFSOC
     bool
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 967572d4f6..f762623288 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -4,7 +4,6 @@ riscv_ss.add(files('numa.c'))
 riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
-- 
2.28.0


