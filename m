Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15674C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:38:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7863920838
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q11QULw/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7863920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY94k-000379-SP
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sU-0001uf-Uj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:11 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sS-0005fG-RB
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981568; x=1635517568;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2q5eaqHnasSx88RF++/1bEt2K4A/LzHypBeMeKb6C/M=;
 b=q11QULw/jliQDRrBWiRmEZCSExxLzyt6IP1aROmIbCrRG099+L5Um3hQ
 gRE/gmyS3aOUW7Z+grBCG7AaG1OZzkS82SruNaFXkWMmXrg3rTrdQCJge
 MyKgGIBvsXyysvNOk5q8Gf/RpEFtuFsW84imw2iHWJnO905Cw7Uy2IQ2s
 RdhQ4ksD9+uh0PNT056veKog7xhxPVJrMPSJI9VyTPj0gkAQZiNKuIBmT
 gwHhrnbTWoFO7bSS5zTKCWFCcL6Q/cf9ipIx+rB0tx4HZhKiXqsNFqZZC
 U556MwJi2nQum51ThD9PStNpOYfxPuXND5ecG5djA89T9ox3hLAqpyHc3 w==;
IronPort-SDR: Re2wDyGlEE1V+zhRpFR6o1inOP6LR8rktdEdQiU1QLb1hKCri+jyEHwwqpFyBJhky2hDMj3zLc
 oFsE25d5EiVTUeXvqgCpycCaGJjapIeU0EijgYnzbDJNyRt/muBdy4a3xepmx8xsP5CygKHyp9
 n6uc2zCTszy+kt+3zSpn4FQD8ccT4Ee2jZFURYs+CeTRAr9YyitYiMaNYngZSuzh1BWoJCHVqr
 pOpK4r8s8yooyJumb1AlzmcGri4J1rZ/LlSII3M1DNFPUwwJnp3L5egJqDEERgYm7n/9ff+l2y
 OHg=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317898"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:29 +0800
IronPort-SDR: myBVfEWP1g2ggPmepO89DgLpYbzugyreMQ7nrQ4aJAJtBUFiDxk7eBCjr2i+i7tUIs7jw+jdOz
 a1jqDS5tUPMVprnwb9cPZQ741TUEajfakP8E6WlJVWCPzsU1wdFIz1VWwe16JA2TaiVxZqYa0A
 Oh/MtD7po/aDehlUXxWOwBgAAv4Aj/wq4CYmydXeCCh89PeO7zZpYMtvR8MnglN1/RO11P19DU
 Hzi8XPgfUJRvpZHW/6gmQ7vP1Fdl6FlyFiu3s1A/zPeO9Z1GGmut6QOkIizfCMcd17BvrQ5s23
 H34jA5DAV+3L6BaL+5Bs98ha
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:45 -0700
IronPort-SDR: NLDyq9gk4p51h9PTqA8DJAKJ7kkZfZq43RGCFGPC5LX6gio9jaumrsBTen1NQuT9lW5HMMrN5E
 rwoLUipgYwdCG+yZ0NYB5q9a/JevP/gt1riWFFe3McUN+INuw+f6HLLX58Vq9M7GeQwatv779C
 c+KQ6J0Ge2AcBFv85Nx2MH95bn+PKsNhrjtWbXbtot6Vwld0LTBhA9w+N4HofU9TF4To6bNW1+
 LeXk+zfxofpxeBl4y4toOniKltGxxjwEqQ9SsfwvySNshuaxwqwaPvrXtJdPYEC1ML0FgoorvL
 lCc=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 15/18] hw/riscv: microchip_pfsoc: Connect the SYSREG module
Date: Thu, 29 Oct 2020 07:13:55 -0700
Message-Id: <20201029141358.3102636-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029141358.3102636-1-alistair.francis@wdc.com>
References: <20201029141358.3102636-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=56447669b=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 10:25:26
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

Previously SYSREG was created as an unimplemented device. Now that
we have a simple SYSREG module, connect it.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-8-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h | 2 ++
 hw/riscv/microchip_pfsoc.c         | 9 ++++++---
 hw/riscv/Kconfig                   | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index a244ae6d39..245c82db61 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -26,6 +26,7 @@
 #include "hw/dma/sifive_pdma.h"
 #include "hw/misc/mchp_pfsoc_dmc.h"
 #include "hw/misc/mchp_pfsoc_ioscb.h"
+#include "hw/misc/mchp_pfsoc_sysreg.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/sd/cadence_sdhci.h"
 
@@ -47,6 +48,7 @@ typedef struct MicrochipPFSoCState {
     MchpPfSoCMMUartState *serial2;
     MchpPfSoCMMUartState *serial3;
     MchpPfSoCMMUartState *serial4;
+    MchpPfSoCSysregState sysreg;
     SiFivePDMAState dma;
     CadenceGEMState gem0;
     CadenceGEMState gem1;
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 438e0c464d..bc908e07d9 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -153,6 +153,9 @@ static void microchip_pfsoc_soc_instance_init(Object *obj)
     object_initialize_child(obj, "dma-controller", &s->dma,
                             TYPE_SIFIVE_PDMA);
 
+    object_initialize_child(obj, "sysreg", &s->sysreg,
+                            TYPE_MCHP_PFSOC_SYSREG);
+
     object_initialize_child(obj, "ddr-sgmii-phy", &s->ddr_sgmii_phy,
                             TYPE_MCHP_PFSOC_DDR_SGMII_PHY);
     object_initialize_child(obj, "ddr-cfg", &s->ddr_cfg,
@@ -280,9 +283,9 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* SYSREG */
-    create_unimplemented_device("microchip.pfsoc.sysreg",
-        memmap[MICROCHIP_PFSOC_SYSREG].base,
-        memmap[MICROCHIP_PFSOC_SYSREG].size);
+    sysbus_realize(SYS_BUS_DEVICE(&s->sysreg), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sysreg), 0,
+                    memmap[MICROCHIP_PFSOC_SYSREG].base);
 
     /* MPUCFG */
     create_unimplemented_device("microchip.pfsoc.mpucfg",
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 8f043e38e0..facb0cbacc 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -7,6 +7,7 @@ config MICROCHIP_PFSOC
     select MCHP_PFSOC_DMC
     select MCHP_PFSOC_IOSCB
     select MCHP_PFSOC_MMUART
+    select MCHP_PFSOC_SYSREG
     select MSI_NONBROKEN
     select SIFIVE_CLINT
     select SIFIVE_PDMA
-- 
2.28.0


