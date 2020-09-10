Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D003C07548
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3CB6207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nYaQlkdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CB6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRJt-0000T3-NJ
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBp-0004cB-RD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:57 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBm-0002j9-8P
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762054; x=1631298054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZSNUdGWzbfvdxQavD7gQjSlgG/H9StMasknxBw5lrC4=;
 b=nYaQlkdG2wehc+q6INweNaSpdpF3vO6NJNeOz2qQIx8VvpgW0ptyqV8x
 +hXHWlFAvnOR045IOTlAZsKvBiswaBnxG9hUsE0yxzQMcIt8cFN515/lp
 K3du89VR1lQTgbxA0bg/q+cdQrwXmn3bibUbp/WR2qVx6XsD0Oz68cIeP
 Uuk39vT/w5JB+ePLBXfyvryWiYb8bzOYtxJrP0lH+VBWDsoaWx8MN+yq4
 U2j2VFeD1kyFnYVFqDOoRjN2DWvAYeD8BveLY2Tu4epn05729kuePA3Q+
 TOVnHEh9485yTHxAWyeScvZWOtPt9taY26ihN8yaQKgF63B0H45l6WT+k w==;
IronPort-SDR: tFuQt80LBCkXqmi1pDNq3DxrA7lePWC9iMhVDM3quzMpU9pgp00fNV2ya/DD68WxlITRy6KiJw
 jUkWNqZA2VMR5RqiDxz3Nvvog0ZZ/5Xe0ll3rRfMPnyuSWzL+e4Wv7K/bwzo77ekpQOrzBhoqQ
 iUeXYD7QMzCuIJPEVRHsDuBMcC6lCurHLdUleCHep8SfFmag4bHxDk1i85FNjpJipi4Nt/Ho4U
 iUt30k7Ch2hH7Ew5k9tDWRAIuWbiG33U5WtnYdJ38JBsNELJBc4NZKjrsSXOy999DQs57GbcSd
 7qc=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979238"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:19 +0800
IronPort-SDR: wmHyCWq4ThtVvNnKgLwFotHJgHvAv5Bw0Ktxld6QY1jr7mprBB+TBfbOSwe30Yj2pURrCnJZ1X
 SaKEeKKfbMcg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:35 -0700
IronPort-SDR: jdyzLfpMyt9NdOPi+L1zC0z+f+FV6Uk3WxZx1FlJLqRyf78/2eAdvtmUgjlHMMNbWqSOurR9Gr
 JRgiMYC46diA==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/30] hw/riscv: microchip_pfsoc: Hook GPIO controllers
Date: Thu, 10 Sep 2020 11:09:24 -0700
Message-Id: <20200910180938.584205-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Microchip PolarFire SoC integrates 3 GPIOs controllers. It seems
enough to create unimplemented devices to cover their register
spaces at this point.

With this commit, QEMU can boot to U-Boot (2nd stage bootloader)
all the way to the Linux shell login prompt, with a modified HSS
(1st stage bootloader).

For detailed instructions on how to create images for the Icicle
Kit board, please check QEMU RISC-V WiKi page at:
https://wiki.qemu.org/Documentation/Platforms/RISCV

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <1598924352-89526-15-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  3 +++
 hw/riscv/microchip_pfsoc.c         | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 6d20853039..8bfc7e1a85 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -89,6 +89,9 @@ enum {
     MICROCHIP_PFSOC_MMUART4,
     MICROCHIP_PFSOC_GEM0,
     MICROCHIP_PFSOC_GEM1,
+    MICROCHIP_PFSOC_GPIO0,
+    MICROCHIP_PFSOC_GPIO1,
+    MICROCHIP_PFSOC_GPIO2,
     MICROCHIP_PFSOC_ENVM_CFG,
     MICROCHIP_PFSOC_ENVM_DATA,
     MICROCHIP_PFSOC_IOSCB_CFG,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 7f25609182..11ebdd1aa8 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -89,6 +89,9 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
     [MICROCHIP_PFSOC_GEM0] =            { 0x20110000,     0x2000 },
     [MICROCHIP_PFSOC_GEM1] =            { 0x20112000,     0x2000 },
+    [MICROCHIP_PFSOC_GPIO0] =           { 0x20120000,     0x1000 },
+    [MICROCHIP_PFSOC_GPIO1] =           { 0x20121000,     0x1000 },
+    [MICROCHIP_PFSOC_GPIO2] =           { 0x20122000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
     [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
@@ -311,6 +314,17 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem1), 0,
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_GEM1_IRQ));
 
+    /* GPIOs */
+    create_unimplemented_device("microchip.pfsoc.gpio0",
+        memmap[MICROCHIP_PFSOC_GPIO0].base,
+        memmap[MICROCHIP_PFSOC_GPIO0].size);
+    create_unimplemented_device("microchip.pfsoc.gpio1",
+        memmap[MICROCHIP_PFSOC_GPIO1].base,
+        memmap[MICROCHIP_PFSOC_GPIO1].size);
+    create_unimplemented_device("microchip.pfsoc.gpio2",
+        memmap[MICROCHIP_PFSOC_GPIO2].base,
+        memmap[MICROCHIP_PFSOC_GPIO2].size);
+
     /* eNVM */
     memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
                            memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
-- 
2.28.0


