Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0E0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC50206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke7UsC3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC50206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmyr-0006Wh-Oa
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jCmy0-0005aK-M9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jCmxy-00015n-8l
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:15:19 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41875)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jCmxr-0000lR-BO; Fri, 13 Mar 2020 12:15:12 -0400
Received: by mail-pl1-x643.google.com with SMTP id t14so4469595plr.8;
 Fri, 13 Mar 2020 09:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=4/hgLoMnGBTI0E1XawADOqDcEXVKIJ4SAjx5/BtrQ2I=;
 b=ke7UsC3psEnWX03NTr0pb6sJNdl3iIAxgzwKWrT2W8TjtXXGjYG/RbTYRy2Xa0+666
 sABQtF3d1Ze1ojXn7eUlBHpGJCxOfbIUu15EFm+GunAWhBo1v3ZzTK34tsrlLcWFbySx
 UxGpEB5Vp13kAifKeVVk6HRLS1Jv9kXDYCPE5BOiTut9u6Qxubb7mFP/nuFRpTv6l29f
 lMgwMR6Wkqi6osaCLYK3eMiPpTd3ZZq/qqoVOiG1v5nJE6N1LOrpgxLPkdwX7UuQCkfo
 3YjiHiDQZJTA8JhLpERYGkAAGL48n+0RurqqDYI7QIxGlPVpq8YUj7BTGIZezT80LE/2
 rpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=4/hgLoMnGBTI0E1XawADOqDcEXVKIJ4SAjx5/BtrQ2I=;
 b=ggfwdaGJAZnX1PGs68OdczoItS/XzxFFnQfTCVC3EPWb3+C/vhVAjgK06FpyNa8JiD
 vZWVe+vYMn/6Rz4K8n08VKGwGD/TSRPsLUuzi4LqOvd7GGxLC6Kb2y/R5H8m4Xn6WpKS
 FElxHY5Y0ttwjkYrzMIQ0pjVrRJS+/3EhqFUVb9zXUp8+EB6AC8H2JCG4Swvr0G6A1fR
 CzqQQhLN1CbhakZdndamEMa9vBmATBlMYVKjfQMNU7jonSFyFHDfOUyyK82yOMmilTGK
 MlVSHMZBVIeVwNWMEqgKuneWWkkxFMs92jzb4TANYGmu88FpKZptWehxBNLxaNZtijkD
 K4hg==
X-Gm-Message-State: ANhLgQ3wuGe9XIkVgwTz/sLrF8fUkWUHhJEH6H+t3tVIkCjEfgU8Wnis
 8okl9rujKm6Zc4UFEDR2WSs=
X-Google-Smtp-Source: ADFU+vuDZhUm+Rtiqvo5eCg6GPBFUv2Jm88/+OdXyHzOYTnc31MZkw7sAcYWDsNsbBCc6CBgFEs16w==
X-Received: by 2002:a17:902:b183:: with SMTP id
 s3mr13928836plr.33.1584116109502; 
 Fri, 13 Mar 2020 09:15:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id v12sm3302376pgs.0.2020.03.13.09.15.08
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 13 Mar 2020 09:15:08 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/arm/fsl-imx7: Instantiate apbh_dma and ocotp as
 unimplemented devices
Date: Fri, 13 Mar 2020 09:15:06 -0700
Message-Id: <20200313161506.8834-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instantiating apbh_dma and ocotp as unimplemented devices prevents crashes
when booting Linux.

apbh_dma:

[   14.046518] Unhandled fault: external abort on non-linefetch (0x808) at 0xd0852008
[   14.047287] pgd = (ptrval)
[   14.047607] [d0852008] *pgd=8b028811, *pte=33000653, *ppte=33000453
[   14.050074] Internal error: : 808 [#1] SMP ARM
...
[   14.077029] [<c0856530>] (stmp_clear_poll_bit) from [<c0856580>] (stmp_reset_block+0x10/0xb8)
[   14.077642] [<c0856580>] (stmp_reset_block) from [<c1a9655c>] (mxs_dma_probe+0x1f4/0x370)
[   14.078158] [<c1a9655c>] (mxs_dma_probe) from [<c0b6a7e8>] (platform_drv_probe+0x48/0x98)
[   14.078641] [<c0b6a7e8>] (platform_drv_probe) from [<c0b685c4>] (really_probe+0x228/0x2d0)

ocotp:

[   71.286109] Unhandled fault: external abort on non-linefetch (0x008) at 0xd0ff0000
[   71.287891] pgd = (ptrval)
[   71.288449] [d0ff0000] *pgd=8b497811, *pte=30350653, *ppte=30350453
[   71.291389] Internal error: : 8 [#1] SMP ARM
[   71.292302] Modules linked in:
[   71.293583] CPU: 0 PID: 112 Comm: kworker/0:3 Not tainted 5.0.0-10153-g065b6c4c913d-dirty #2
[   71.294148] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   71.296728] Workqueue: events deferred_probe_work_func
[   71.297740] PC is at imx_ocotp_read+0x68/0x180
[   71.298154] LR is at mark_held_locks+0x48/0x74

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/fsl-imx7.c         | 11 +++++++++++
 include/hw/arm/fsl-imx7.h |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 119b281a50..a17136f83c 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -459,6 +459,17 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("sdma", FSL_IMX7_SDMA_ADDR, FSL_IMX7_SDMA_SIZE);
 
+    /*
+     * OCOTP
+     */
+    create_unimplemented_device("octop", FSL_IMX7_OCOTP_ADDR,
+                                FSL_IMX7_OCOTP_SIZE);
+
+    /*
+     * APBH_DMA
+     */
+    create_unimplemented_device("apbh_dma", FSL_IMX7_APBH_DMA_ADDR,
+                                FSL_IMX7_APBH_DMA_SIZE);
 
     object_property_set_bool(OBJECT(&s->gpr), true, "realized",
                              &error_abort);
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 706aef2e7e..f9faa16515 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -113,6 +113,9 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_IOMUXC_GPR_ADDR      = 0x30340000,
     FSL_IMX7_IOMUXCn_SIZE         = 0x1000,
 
+    FSL_IMX7_OCOTP_ADDR           = 0x30350000,
+    FSL_IMX7_OCOTP_SIZE           = 0x10000,
+
     FSL_IMX7_ANALOG_ADDR          = 0x30360000,
     FSL_IMX7_SNVS_ADDR            = 0x30370000,
     FSL_IMX7_CCM_ADDR             = 0x30380000,
@@ -177,6 +180,9 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_A7MPCORE_ADDR        = 0x31000000,
     FSL_IMX7_A7MPCORE_DAP_ADDR    = 0x30000000,
 
+    FSL_IMX7_APBH_DMA_ADDR        = 0x33000000,
+    FSL_IMX7_APBH_DMA_SIZE        = 0x2000,
+
     FSL_IMX7_PCIE_REG_ADDR        = 0x33800000,
     FSL_IMX7_PCIE_REG_SIZE        = 16 * 1024,
 
-- 
2.17.1


