Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EA9C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:30:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64EBE2087C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kVOdcLZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64EBE2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRL4-00035k-D3
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRC5-00059L-Be
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRC0-0002j9-Bt
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762068; x=1631298068;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XFs0B0IupMJmQjlluThsikvJM1K6yOMFrXK9eLjk9M0=;
 b=kVOdcLZLOxF7ikIBnqlO6z5ouXbzP/bYoRD3NzVuxkFyqQCmhRksirN9
 oYnSHdjl/OiuxBYp2s7v+yTBlkPK+KHu+0V2vsEykadIl/tCO7l7sTpMW
 NzzQ/GAman00Ft0rfAw8s+LUocQ+tyalCccHQzoyh7xqvS6ad/pD3iwf+
 jCbEADD9fBencYB3c7BfFc9dPHPf8se9N74SvelUQgeK26TRRMGYIxjfv
 Qqs98Isdr32kG1NtMm4DQpPm57SN5Aw29yFgN0IBhf35ALwcnTaHiQHbN
 x9tNDqicjmdOgR+8FpThz2w12PbPFCS5b/WayqrUdtIENqXImzaG6ES7F A==;
IronPort-SDR: OxfKDBpEuLiI9Ism2eeJLX2iKXOxnJgqrMPXyXQ+uKi9SSe67llkjIG8dzz3BFR+3xQjHuBKki
 Fjimh/POx4Et1cpag6MeEVT6IO+NVfN4TDmT1kDmQJsA5TsmqBwC2UN9Kb6KY2RmWKX0pIZ3qK
 l1Ux9z+6GkuvnOZJWPfMwUQb3o6vh17sy3Vu8z6cRXaF3jkSHhRJ3fMGYJVW/a0GSdxamZuejB
 ZZcqh4udw8952dDHsK9LiPqID/fBsYb9kHglAPiqapxgO3wzbwL5kLvZRA+J7eKFfyx59DPsnP
 6/M=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979244"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:20 +0800
IronPort-SDR: cLz7r8vvqbidsyJ8MpyxVQ/12BBHfG96pEJanSkEkgEZaqT16i8jFTSiBwahLHoXSSLk7OCBeJ
 Oib+KG41a+ow==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:37 -0700
IronPort-SDR: RWzk+FLf21jpCCMoeQLWWyc/1IryBdU/8aeKIcgI2t61UurERy28txQ+WA8D+ca8cs4ks4lxP7
 shX2BqXSfvJg==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 21/30] hw/riscv: Move sifive_u_otp model to hw/misc
Date: Thu, 10 Sep 2020 11:09:29 -0700
Message-Id: <20200910180938.584205-22-alistair.francis@wdc.com>
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
codes. Let's move sifive_u_otp model to hw/misc directory.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-4-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/{riscv => misc}/sifive_u_otp.h | 0
 include/hw/riscv/sifive_u.h               | 2 +-
 hw/{riscv => misc}/sifive_u_otp.c         | 2 +-
 hw/misc/Kconfig                           | 3 +++
 hw/misc/meson.build                       | 1 +
 hw/riscv/Kconfig                          | 1 +
 hw/riscv/meson.build                      | 1 -
 7 files changed, 7 insertions(+), 3 deletions(-)
 rename include/hw/{riscv => misc}/sifive_u_otp.h (100%)
 rename hw/{riscv => misc}/sifive_u_otp.c (99%)

diff --git a/include/hw/riscv/sifive_u_otp.h b/include/hw/misc/sifive_u_otp.h
similarity index 100%
rename from include/hw/riscv/sifive_u_otp.h
rename to include/hw/misc/sifive_u_otp.h
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index cbeb2286d7..936a3bd0b1 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -24,7 +24,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
 #include "hw/riscv/sifive_gpio.h"
-#include "hw/riscv/sifive_u_otp.h"
+#include "hw/misc/sifive_u_otp.h"
 #include "hw/misc/sifive_u_prci.h"
 
 #define TYPE_RISCV_U_SOC "riscv.sifive.u.soc"
diff --git a/hw/riscv/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
similarity index 99%
rename from hw/riscv/sifive_u_otp.c
rename to hw/misc/sifive_u_otp.c
index f6ecbaa2ca..c2f3c8e129 100644
--- a/hw/riscv/sifive_u_otp.c
+++ b/hw/misc/sifive_u_otp.c
@@ -23,7 +23,7 @@
 #include "hw/sysbus.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "hw/riscv/sifive_u_otp.h"
+#include "hw/misc/sifive_u_otp.h"
 
 static uint64_t sifive_u_otp_read(void *opaque, hwaddr addr, unsigned int size)
 {
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 65f3fdd9e0..fa3d0f4723 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -137,6 +137,9 @@ config AVR_POWER
 config SIFIVE_E_PRCI
     bool
 
+config SIFIVE_U_OTP
+    bool
+
 config SIFIVE_U_PRCI
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 9e9550e30d..018a88c670 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -23,6 +23,7 @@ softmmu_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
 
 # RISC-V devices
 softmmu_ss.add(when: 'CONFIG_SIFIVE_E_PRCI', if_true: files('sifive_e_prci.c'))
+softmmu_ss.add(when: 'CONFIG_SIFIVE_U_OTP', if_true: files('sifive_u_otp.c'))
 softmmu_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 
 # PKUnity SoC devices
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 109364b814..76eaf77a80 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -24,6 +24,7 @@ config SIFIVE_U
     select HART
     select SIFIVE
     select SIFIVE_PDMA
+    select SIFIVE_U_OTP
     select SIFIVE_U_PRCI
     select UNIMP
 
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 3462cb5a28..74a73b2a44 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -11,7 +11,6 @@ riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
 riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
-riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_otp.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('riscv_htif.c'))
 riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
 riscv_ss.add(when: 'CONFIG_MICROCHIP_PFSOC', if_true: files('microchip_pfsoc.c'))
-- 
2.28.0


