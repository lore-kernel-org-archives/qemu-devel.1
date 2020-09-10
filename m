Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AF8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8982720855
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xv4phEoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8982720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRcD-0001Lt-Js
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCn-0005ss-Ar
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCW-0002ls-T3
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762100; x=1631298100;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rO77UB4oLndqSP9kigufHZpDxo4ori3idNebpw70yeQ=;
 b=Xv4phEoUsDC2Kwfe3t3TnmX0Au1+8SMepHHARqT5Ho9P8JzzR/HCkR+V
 RZkadlw1xAb3YLJz4bMjmM4lJvT5e9a6w5Vi9Dmh14bDPVjH06EYdOPQ+
 b4TdqQZtpS7BXEB6M8Xj7xuy5ASNq9x5LHuU9xQdK1PpEt8KKxw1AWpwi
 9eWSczc8nbljcPPtKkXip6SIIO8lDKnF5fW7amZc2KrbG+9+8gQJ8GxOV
 FmOUjEmkU5Pz4bMVM+6HHYhMJ2POyWu+sLNIdDwvDESHQaOnS8Vyh3MH4
 ByO3iQspLZuK9d2mDLBOK2c+ovbNwjy0cVWrOQ/ai1Oo5vxas+7Ob4rVT w==;
IronPort-SDR: 79D+r/NYJZ2+llBlMxun++wR7kvCjjRaccxMx9EZukA+sG4WsMjb0WD9YHQvjiv35NOEgthjXG
 nRuMKj5hBvfA3AONvjxoiZexx5zwNaQq08MLeprKDfGotdJpXwXU+2JoPqp9MqwQXS1ASIAq76
 EQ5ZTySz0UTKXL1hzYxhGX8rg9bDxWR4H8YWK/SCxZcN5rHReW8PZ2FwtTWX+1RR8pjMKtrL86
 n/HMisgZxpMazfFoKZxegT2WUzHU61F4Nx+JPymyNu4Uf4XCjihCnCckaYdK3/aozPocotxBN0
 xFs=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979255"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:22 +0800
IronPort-SDR: OHfB8KMIISSuYRKgQioUcW3tKIG+dvSl0PDyB4h31fsL5u+sUVLqDstTK10OTQ3gkvIVjvZH+g
 KiLTGF0/8P0Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:39 -0700
IronPort-SDR: ndHYO1HeeHMH59PfsvaofL5DlMpewyuqv+mILSYtMwyp2byQMw/vR2QjRCxo+pauSQgwd3x3N0
 92BGKWE+f1Sw==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 30/30] hw/riscv: Sort the Kconfig options in alphabetical order
Date: Thu, 10 Sep 2020 11:09:38 -0700
Message-Id: <20200910180938.584205-31-alistair.francis@wdc.com>
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

At present the Kconfig file is in disorder. Let's sort the options.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-13-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig | 58 ++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e152fdc7d9..2df978fe8d 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,36 +1,16 @@
 config IBEX
     bool
 
-config SIFIVE_E
-    bool
-    select MSI_NONBROKEN
-    select SIFIVE_CLINT
-    select SIFIVE_GPIO
-    select SIFIVE_PLIC
-    select SIFIVE_UART
-    select SIFIVE_E_PRCI
-    select UNIMP
-
-config SIFIVE_U
+config MICROCHIP_PFSOC
     bool
-    select CADENCE
+    select CADENCE_SDHCI
+    select MCHP_PFSOC_MMUART
     select MSI_NONBROKEN
     select SIFIVE_CLINT
-    select SIFIVE_GPIO
     select SIFIVE_PDMA
     select SIFIVE_PLIC
-    select SIFIVE_UART
-    select SIFIVE_U_OTP
-    select SIFIVE_U_PRCI
     select UNIMP
 
-config SPIKE
-    bool
-    select HTIF
-    select MSI_NONBROKEN
-    select SIFIVE_CLINT
-    select SIFIVE_PLIC
-
 config OPENTITAN
     bool
     select IBEX
@@ -40,23 +20,43 @@ config RISCV_VIRT
     bool
     imply PCI_DEVICES
     imply TEST_DEVICES
+    select GOLDFISH_RTC
     select MSI_NONBROKEN
     select PCI
-    select SERIAL
-    select GOLDFISH_RTC
-    select VIRTIO_MMIO
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
+    select SERIAL
     select SIFIVE_CLINT
     select SIFIVE_PLIC
     select SIFIVE_TEST
+    select VIRTIO_MMIO
 
-config MICROCHIP_PFSOC
+config SIFIVE_E
     bool
     select MSI_NONBROKEN
     select SIFIVE_CLINT
+    select SIFIVE_GPIO
+    select SIFIVE_PLIC
+    select SIFIVE_UART
+    select SIFIVE_E_PRCI
     select UNIMP
-    select MCHP_PFSOC_MMUART
+
+config SIFIVE_U
+    bool
+    select CADENCE
+    select MSI_NONBROKEN
+    select SIFIVE_CLINT
+    select SIFIVE_GPIO
     select SIFIVE_PDMA
     select SIFIVE_PLIC
-    select CADENCE_SDHCI
+    select SIFIVE_UART
+    select SIFIVE_U_OTP
+    select SIFIVE_U_PRCI
+    select UNIMP
+
+config SPIKE
+    bool
+    select HTIF
+    select MSI_NONBROKEN
+    select SIFIVE_CLINT
+    select SIFIVE_PLIC
-- 
2.28.0


