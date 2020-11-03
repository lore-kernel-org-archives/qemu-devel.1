Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055ACC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A08422264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o4UdPBo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A08422264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZylZ-0006TN-Jb
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyK2-0002MR-DT
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:10 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyK0-0001FT-AL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417648; x=1635953648;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2q5eaqHnasSx88RF++/1bEt2K4A/LzHypBeMeKb6C/M=;
 b=o4UdPBo5W1PlAdkBeu8gTf/SeW8qjVkF9bzpqQHSgPTiIedi64TUyLse
 10yLoYk7/BwTy/+lqAxF3iXAULxDwEilCncib/Imo11BbynxlvwkEpk9u
 t8su9b7nT5hsi/rJtSvmxK/Vv484T9nc1+65TE5226DZWxfEyLO6/wsr2
 RC9Ym6lbsvSOKPtX8sQ1DyolvKyL0BN39g/OwYqYjCQCDmsC7ja1nbSaL
 c16Tz0J+ZS/L9jwEOEENMpKYBV+pxkGtCs7PJoIjz7WdgbWxIiP+RSEXF
 1IJStw4YFb37mApN83KkZ4SPgAW//1FuQZmg4wS02ovI9ocIqqB7RNXVH A==;
IronPort-SDR: NXB2E02c/8KIAurU4N6QCn7FxVU4ptSUIoImsN79MSnzuz1+gd5z7sFX2OnNV3QaZiXYD4bZ/B
 P8+vGU2En0j4WFXKBU/PWWrq+AZL8ov5lXIGKh5QW5wp8CF+otTvRJqva/OTbdoYM2AsHkHZyI
 hPks67Mwbx9JHiyvKdrqczyMvwDMR3CfOWbAxiTMslTT4WhN+IbbylTu2vTo5kEQ6NxLzI8cMv
 Dbx2CV4TWAiy2vSpFvN3XGEYkkWcLbMl5t0SCkIu+GqbjFR907AGRpTnxqVwWOa+diOdtkykPS
 Fj4=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867482"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:27 +0800
IronPort-SDR: WCpHK4Cr6jekYe5exuiKuwMIUKXYQhitlN7t6dRplHcDyigubEHHQxFl+WvNrwkUZh2/CUEKXK
 lyOxo7R0ZfmGzCrnLmTk1AhPekNwYA26Zqv9AdMT0WMinN7iYVamwjCSrdTS3tVjW6YJDWwdCh
 2VgjoS0rGLWW9v3ZbmmVM1NGBzfGqp3l/Z9Sqeoxh01LlE+QuEiHgno4R+c87EgHI9SohFtEzh
 jCTg3dhOfeHhLIhOdHykFJktcWmmLAVTJ6KX8ciPTK2cVksMzwHCudOTwQoBYfbid8ZSffdQO+
 LdF3iIle55ZFJVF2TLNTSbQa
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:36 -0800
IronPort-SDR: vkgOX51/ypMSSMceV7JPU8nfABUyjr/u2M7GXOfzPahUihzXV1E+Yyl5e6/hWZd7eKXqH1o1Tj
 x2l8NHmEKtmE3tis2Ofzpv9T5y3FA8imofWTj9kGWfv78DXsmTovBDZvPF/K0YPvPguGaEI0jt
 AJYnfw9TqbQW+Vnen4zQvTVr/PgOIC6r+d2oc+yFZfAenxi7Gi5/Y2Rhtz7o5655lGKfdmdf7h
 jJUSIBfcFrSb1Kd3VR+58TAppZEG+acqRqbsOjdTgCcDUjV7XIjOteeKRtQ5vwod9L0nX1fkOf
 SEc=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:28 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 15/19] hw/riscv: microchip_pfsoc: Connect the SYSREG module
Date: Tue,  3 Nov 2020 07:21:46 -0800
Message-Id: <20201103152150.2677566-16-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
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


