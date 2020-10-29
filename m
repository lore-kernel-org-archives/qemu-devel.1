Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0218C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:41:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFAE20838
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 14:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U6OJzBYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFAE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY97G-0005s7-Rj
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 10:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8si-0002Jv-93
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56447669b=alistair.francis@wdc.com>)
 id 1kY8sf-0005fQ-Dz
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 10:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603981581; x=1635517581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=STjDto3OrzrwR+UlLZ+rkkDUhmEj1ftv6eTlgBXym1o=;
 b=U6OJzBYYmokTFDLS8MbOgtbOBpS/2PQFCnCDOb7zcpkdw70K1v0zwgOx
 bCw1OszjOi4pQIojdzy4tkGm084Gcp6IlP1LAnS5Iq0qAiGGy/oOWvMJ7
 ++z3xEvFsTMFYaODw0wV7MBD6E9tP/+ldCY5JN3wwdvWc1DhCEtpcGvqd
 jiB7XyptpiBeUHQoiMSZXzzofuslrawAn+/up4ZbczUSnbwapu3YqOwKK
 EOWHhT8eRf0Ei6YVNOV0WTafuTKuqdc6AURNUzcp7N62rnMC3UlVscb/j
 aNKWtjdQdELsvCp7uSc9O55UIeHQEHlO0Zi4BAI9KkxOmFO6At7qkRuvo Q==;
IronPort-SDR: dAxEcHq+zNwiGclpTuC3uq6mFdNkhhLrNTM0wMNJ8lBUVKHEIzgX3XmHFDfoFFbd+2KsuQF0d7
 R4zkto4oO/cLbKLeipvXlW9Bbww3A9dgQ3Q/jvFVmGi7wSjPe+qgqhTLX5n24n9AAbtyRQ7Kbh
 h1gMGP6r7wYBZYrGeyr9MDWubk2Z33Pu+fS8swJxnsyGXf74QpSCgKLIvL0+bmCAqHCSovnOnW
 +qqhw0wsXYxs5WcpIlKrYOHxvdvzRYJalmDwsp/unWRRsFnl1MucT0aWTb2rdf82n+J0NFl3cO
 D9s=
X-IronPort-AV: E=Sophos;i="5.77,430,1596470400"; d="scan'208";a="151317905"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 22:25:30 +0800
IronPort-SDR: C8d8dxfxBr6P1wLkZVTwp18aCfyzJfdt4EzlES+M5IUeHgOixXCN47pFANCHQeZy82uuijISEW
 fPmk1i6uhIYd+n1RMEyaYEWSL+2jAZxsfSQvF4ROmcf/ZXindlwtkEeoFI3t+J2GkjV8mfNGyX
 aEy6XB3MikZ0zrUeZ4LSeF5Wmm3fkmDE4uAZbbZnpWYc8o81goqHMnQRxxV5+LI2w6h8g1d8jG
 xtFbBQUWk29ZC+AQi2SYzUCgdJqYTsvY91iNoFArvRm/qCx+PA0TgL277pi0Yc7brOmumQ4DFW
 itdFLGjKdCRlHSzYktBxdkej
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 07:11:46 -0700
IronPort-SDR: ae8amOf9bvXSBRpomYir7LiXaFAJEN+bbohvgcy/fY65mUf3uMc2+3nDNBYwr90l0kXetzSNcj
 0uTD4OiKN/EBaulYs5bOSXFd+wWMMzsqQhKzFsl9wXKstioIN/Qe2eI/DldndgsOXMbr7nYkT0
 0LbwdsH8e3OdxF9zR0NDFNuWINhcA51oHkM1FnNsqPG54aMV7BSRDr9Hs47KtEK1xW8kOmATs5
 zNqziX2rkm3FR20fIXBQ/J8koSnd6Yt0b19J7X2BNi/cgYd68W/FsDZ+NiEp6et2+3d7+ksRO6
 TI4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Oct 2020 07:25:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 18/18] hw/riscv: microchip_pfsoc: Hook the I2C1 controller
Date: Thu, 29 Oct 2020 07:13:58 -0700
Message-Id: <20201029141358.3102636-19-alistair.francis@wdc.com>
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
index 5e31b84817..d13d6ba7b8 100644
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


