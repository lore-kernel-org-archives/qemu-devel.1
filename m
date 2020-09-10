Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B950C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5D1821941
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GClyu0oB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5D1821941
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRUE-0004LU-L1
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCY-0005SV-M3
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28254)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRCL-0002kZ-UN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762089; x=1631298089;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YvOEbbp6ScBwUhApI8GBFOEg5ocmLn8l1tkl1H1frOc=;
 b=GClyu0oBmH2qQh3l9aHahLhUx5R2eQL3HpfKuP8YW/p3kllKeEtae0Zw
 uhgcjWTx6M8k7hMkQIRw0nFQTYE5DC0m/+IIBZSzQcBNx1tFa7nHOLgxp
 T7pVfzd0RSkTFLL3clcGtNg2T2nQrx8YYn7xIw7J9GqL6i8LeQZwJtpl9
 2sYd1GXwEzqc74vmElVhpAFfAkdLr2RX6dCgZk1sd2I2N8o7aL8Iy4jA0
 uILHxmsqT4V++ivRbrM8R9E1+WFCokrQkFZu3ccXe28OrvZG0lmS4VGrk
 /zhd2tsax48sBO7lkqshZVwxFPdy3fCzjP93bCdpu5y6vZsBKsjyIattj g==;
IronPort-SDR: KiCI/+aEXcW4lAGKyuaL0yvC5Nc1SbP27PzDBkzWkjdJkMjr9JmM7wxW4+wWnbu98wQ/eXfPY7
 7T9VLxOekXbPlEPZdxx6LNFFbH4o8YKiae3b/9+JJxieG14/cMj9QQCaSRQHixEih+xzq4J9CL
 K/BGC8rJHrV470lT2YbDCosVgQqat0I4V55PNfo3mCDdVgwq8j4cSFseBToYUaABq2QJHY4x85
 Pb0H0LUVyp7bUcP+/cKpJkXdOCWQQ1eyTTpZZxU/T/iCL8Rm5OYqQY7ZZQAHij9lF2XYnzAoEZ
 /7s=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979254"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:22 +0800
IronPort-SDR: ntYyqS91P4qAkg38gCkS98bTo4hTCgDWFiTGnRgZ/SZH5MublzeKxIA+d0FEt+QKqDq8ibDglK
 ZCmOcr3mRD5Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:39 -0700
IronPort-SDR: DHYDo/RUlrq3yvUpfSRA4KYUAqcGE8eWpC+/KG2eNKiq3u+ZReZ8GHQtc8XdwwPASRi3H/mnmu
 yYpR8KFV8YoQ==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:22 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 29/30] hw/riscv: Drop CONFIG_SIFIVE
Date: Thu, 10 Sep 2020 11:09:37 -0700
Message-Id: <20200910180938.584205-30-alistair.francis@wdc.com>
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

The name SIFIVE is too vague to convey the required component of
MSI_NONBROKEN. Let's drop the option, and select MSI_NONBROKEN in
each machine instead.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1599129623-68957-12-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 7d017bc7c3..e152fdc7d9 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -1,13 +1,9 @@
 config IBEX
     bool
 
-config SIFIVE
-    bool
-    select MSI_NONBROKEN
-
 config SIFIVE_E
     bool
-    select SIFIVE
+    select MSI_NONBROKEN
     select SIFIVE_CLINT
     select SIFIVE_GPIO
     select SIFIVE_PLIC
@@ -18,7 +14,7 @@ config SIFIVE_E
 config SIFIVE_U
     bool
     select CADENCE
-    select SIFIVE
+    select MSI_NONBROKEN
     select SIFIVE_CLINT
     select SIFIVE_GPIO
     select SIFIVE_PDMA
@@ -31,7 +27,7 @@ config SIFIVE_U
 config SPIKE
     bool
     select HTIF
-    select SIFIVE
+    select MSI_NONBROKEN
     select SIFIVE_CLINT
     select SIFIVE_PLIC
 
@@ -44,20 +40,20 @@ config RISCV_VIRT
     bool
     imply PCI_DEVICES
     imply TEST_DEVICES
+    select MSI_NONBROKEN
     select PCI
     select SERIAL
     select GOLDFISH_RTC
     select VIRTIO_MMIO
     select PCI_EXPRESS_GENERIC_BRIDGE
     select PFLASH_CFI01
-    select SIFIVE
     select SIFIVE_CLINT
     select SIFIVE_PLIC
     select SIFIVE_TEST
 
 config MICROCHIP_PFSOC
     bool
-    select SIFIVE
+    select MSI_NONBROKEN
     select SIFIVE_CLINT
     select UNIMP
     select MCHP_PFSOC_MMUART
-- 
2.28.0


