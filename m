Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0137C55178
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:05:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCAA223AB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:05:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gdDejzMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCAA223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyoF-0000As-5Z
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyKN-0002UH-SE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:33 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyKD-0001FT-GW
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417662; x=1635953662;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gfyFOauU6Gej1Dn0hI4aczlzFeYXPNOkCE53IqC40bY=;
 b=gdDejzMwv3YPaFgsTgYX1WaCX/J8xoFvgaSIroRCs7qQGXx55GJGJ9SW
 iKiR4wCiViII5KjWzYuAKcWDOcoo2h+Yhf9aVF9phj20GpgBmb+ERDM8D
 woDBc3IU661hLYEXG1sOoUxApeAYh0RIcV4xUGLUERqLyxNctxbeq7GGE
 oCIvL2dxugoogzoC2Y/FmBjluPQS7T7HilKy+yPUl8KKc8wUD14xl1avf
 u6ItYNU/WF9rGFGvf/7TNieVc57I5Obfi7yjqQ/rcviXiUvZj8FsJitqB
 D0kpHc1wYI/vKKxGHnwPDdjehfkMgegp0SrkG2mPGfVrln2lXosegbN85 Q==;
IronPort-SDR: UXa88enkiHN9SWtIIH8g+bUc7t6Km8EmeA76DFpz0yXFypHrCEo4iknLEwSUPhFWDp9OIXruZW
 /Bbg/0Jni/7+nTIVbi1bpNpamYSVRtr8LsIPQqBxY9m+JwUpHb83rotK9aee2Yjif/YXwFqXGp
 XThpx985tSl4GIz4WSFbeBy1gwl5t5QLYHB+alS4cLMJ9jieNH8ViXse+HSId7NhqtForIovTW
 cqkevWEYThRrK5B0V4w744udIKvHfj/otI8roWvQcEMK6ghzV7vYXKVo1wug7eKlewc0ga/WYE
 Orw=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867488"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:28 +0800
IronPort-SDR: 75I30xPdcWm6L+50XsVplSRYW86pD+PduwmJ4pbHPCN/FV+/mj0fN7CD8T8uATFRURJjhBWwyO
 2X7+iG7rKcqQZFeD+HLGi9soAkPJ9hOhhu7oq3ficq/1+G5kNPzOq3OQhs/JfZGrux5N3ikXr5
 Dj8wqCIsmSTS67mXmkrVTiee4zX1oA8EoTufdKQ9+y8Ibf0n3BfLS+ObpVtA8ZYLjS0ATKvidJ
 G8ap6Ylug84sHCuWfnkW5/Qdpgf2Q3Cu5x/tW6rrAJai9YId8VG6G91UxMQZjbLodeoEkxyIJ2
 S26CcqjvVUJfWYBGKtdCxRqI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:37 -0800
IronPort-SDR: mnZtCmTsqEFzU18mCjIXP9pXVXu33b4ClzdI/2A9WDlD8AqjD+IXsNMm1wptEIKnKJw6hPwAGB
 C6jl3VkJJXV7+yMoB/tXVN5RMA47YIf3gwAmN9ffvp//QA86kz/u9FJv2RPxdkddjMnXtN2JTr
 lvizXMaitmanU3aSeKvxWbVmHV0bz9nDNmOqyRuHDPoeExBt5i7YTiIBQKL426fIGiVwhpCkh2
 O65Z6E/Zm7VN2Q5c7holByzfrq7zVzy1+e0nWJCWA99zbrvJjklbYJZV8eOT5DIqOgPcYJmaNb
 oag=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:29 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 18/19] hw/riscv: microchip_pfsoc: Hook the I2C1 controller
Date: Tue,  3 Nov 2020 07:21:49 -0800
Message-Id: <20201103152150.2677566-19-alistair.francis@wdc.com>
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

The latest SD card image [1] released by Microchip ships a Linux
kernel with built-in PolarFire SoC I2C driver support. The device
tree file includes the description for the I2C1 node hence kernel
tries to probe the I2C1 device during boot.

It is enough to create an unimplemented device for I2C1 to allow
the kernel to continue booting to the shell.

[1] ftp://ftpsoc.microsemi.com/outgoing/core-image-minimal-dev-icicle-kit-es-sd-20201009141623.rootfs.wic.gz

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-11-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h | 1 +
 hw/riscv/microchip_pfsoc.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index db77e9c84a..51d44637db 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -97,6 +97,7 @@ enum {
     MICROCHIP_PFSOC_MMUART2,
     MICROCHIP_PFSOC_MMUART3,
     MICROCHIP_PFSOC_MMUART4,
+    MICROCHIP_PFSOC_I2C1,
     MICROCHIP_PFSOC_GEM0,
     MICROCHIP_PFSOC_GEM1,
     MICROCHIP_PFSOC_GPIO0,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index 96cb8b983a..37ac46a1af 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -113,6 +113,7 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
     [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
+    [MICROCHIP_PFSOC_I2C1] =            { 0x2010b000,     0x1000 },
     [MICROCHIP_PFSOC_GEM0] =            { 0x20110000,     0x2000 },
     [MICROCHIP_PFSOC_GEM1] =            { 0x20112000,     0x2000 },
     [MICROCHIP_PFSOC_GPIO0] =           { 0x20120000,     0x1000 },
@@ -343,6 +344,11 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART4_IRQ),
         serial_hd(4));
 
+    /* I2C1 */
+    create_unimplemented_device("microchip.pfsoc.i2c1",
+        memmap[MICROCHIP_PFSOC_I2C1].base,
+        memmap[MICROCHIP_PFSOC_I2C1].size);
+
     /* GEMs */
 
     nd = &nd_table[0];
-- 
2.28.0


