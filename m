Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609CAC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C7DD20707
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oYcbfj7p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C7DD20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAoz-0003Cf-A5
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbp-0005br-Jk
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:42 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAbl-00028f-4X
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548477; x=1624084477;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HF1JxGXWDSpTRfYKaMM0wJ4es08kDgUw2iC6UdUH7F8=;
 b=oYcbfj7pA+o2LMtfbSZRDWM0Ey3Nh8bgnQHUNoQEglzJQNkgW8yvU+Aq
 r+7dVr1uwfZrkXTHqex9XbyclJ8XGufJZYMsHTCLVnOMxHZaNPW89WFbL
 1Yc5G1kmhzXJWzqnuWSaoZm5QhSon4BmT6pyl9ltSCazF3TxURJ2BFgaE
 5Kld1p+u5FoAsWySpEikaRa9byeuuZHlAp5xy3l5zyBcjUzSWg8wA/FMJ
 EviSr+xNCWpapkdF3BgnX11im3AME8gwKo1t5vAjQYLIRlrp7u7KEo3nt
 ob+sSMpjNekIqTUFEJ2KZL6xmE+bprVxeXFIuHPVThUIxnpX/AAw7QqjD g==;
IronPort-SDR: 4yMVrBeNVTS7ka6p0qs4zhwxtQ1Q37IuRW+5GbxoD9o+3UEYdYdWVOOO+wif1gZhaQvN+IJDgw
 TMdGG2bEm9MPuiJPxbyCrJBgEv8Sc0n1TJcTuCLExGwgq5Xq/vGmkQJWGuxUwME8jg4yobkeaJ
 GL2RRu9GBTLA8gl34z063cVlAjCU7/W5L/wmcUT+lcxbGcnI7cvI9+O+Ykk8Iy7NW0RNdvjeiQ
 D7or0S17mMY9ok4w+BzOG2qr8KKkjKHntj2PLRZjhLlmnuCIunIk9KlnnCCSdkTIFcIT4KMFdE
 UJM=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781929"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:31 +0800
IronPort-SDR: 5XnfBk+JFbh97wQrIrIgIFZJNmN6tpEny2zjUL71zseVbYdE/aa7FViP4qOlqL/WFJwNk62t3l
 mKjhiixIMancXNmJ5k5jbSKzcvD+235mE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:41 -0700
IronPort-SDR: e47mLNcURc6qJyA3J6M2zAz5yom56ZfBOzq9LKu81bSop3pgTU6nr/ibm7MU63PPwBHOWmRm6Q
 /2BUlazKZ7yw==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:30 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 19/32] hw/riscv: sifive_u: Simplify the GEM IRQ connect code a
 little bit
Date: Thu, 18 Jun 2020 23:25:05 -0700
Message-Id: <20200619062518.1718523-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:29
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

There is no need to retrieve all PLIC IRQ information in order to
just connect the GEM IRQ. Use qdev_get_gpio_in() directly like
what is done for other peripherals.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-4-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-4-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ea197ab64f..20b0276ea3 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -514,7 +514,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
-    qemu_irq plic_gpios[SIFIVE_U_PLIC_NUM_SOURCES];
     char *plic_hart_config;
     size_t plic_hart_config_len;
     int i;
@@ -594,10 +593,6 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->otp), &err);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->otp), 0, memmap[SIFIVE_U_OTP].base);
 
-    for (i = 0; i < SIFIVE_U_PLIC_NUM_SOURCES; i++) {
-        plic_gpios[i] = qdev_get_gpio_in(DEVICE(s->plic), i);
-    }
-
     if (nd->used) {
         qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(DEVICE(&s->gem), nd);
@@ -611,7 +606,7 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem), 0, memmap[SIFIVE_U_GEM].base);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem), 0,
-                       plic_gpios[SIFIVE_U_GEM_IRQ]);
+                       qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_U_GEM_IRQ));
 
     create_unimplemented_device("riscv.sifive.u.gem-mgmt",
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
-- 
2.27.0


