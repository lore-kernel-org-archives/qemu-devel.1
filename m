Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EF7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A034D20809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WPtebm8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A034D20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmArO-0007tb-Rc
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAcf-0006ic-BZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:12994)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAcY-00028T-Ro
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548527; x=1624084527;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KrLdk4zQ6MVNPPBqI4ML/epsof6zu66Zr/sSiWljDzo=;
 b=WPtebm8fiWhO44HlyxilMmUZedC6v4dcLQU8cu/RUnA3cwq34taHToRV
 t0LUa+tFMRiBVesUoNiaGIw9kJCCLUjksCXqH6F44YQRM4CdDA59MUSVE
 mnkwqGIlca9JjIF8fTPYFwHnTqZpkSMNynN+e4vp1sY8blmBr8AxWiPdu
 XqX3NL8fnXTOqu1WPYTjFUwzf9r2YHg9AA7FdoA0k5+xFUoeNt+u5R3tF
 rwtR/Uw68eMq89GG6EMPOCo94aD0xbeFW6Wj1hOV4EqUYDiAl+cQLB+Ol
 nAJ0wb9T7z7CsEvkv47JInPzcuCeMDrb/rQbGUp/6bJ2dUvzo8NvSqVrn Q==;
IronPort-SDR: aoVhdreP2+qImZDd4lll1GK85YGPjk9jsbRipBiN8mvy2h7oQsnWmTbqMsl6hiwKxoL32T8MHl
 C8o/sy6HboUN37+CrVMnTGCTDcVSvUHPKOu4bssv5ln2on7jJJVays8mE9hGxLGiwAIAW+yUVl
 lbq3cLA4gDNzl/QG2t1oU6taZDejBRCRDxUHKvqmJALHyKKwzLwawKdcLl0F0bveagMXQlN0my
 JLF3a/NRdzEHUEmWZFG448IdBxlZYd6jwOElVdY7w02h5HYmMh2lLJGrhglonQx/DPe5F+bMFB
 kY8=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781957"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:34 +0800
IronPort-SDR: zPT+NeNE+uUr7BbjJQQpzoYgOai+67TKtw0ELZjrqT3D5GOLSNDnK+b9LvXHhKQgbWklo6v5gD
 rse8IobRYGWMN2vPUWV3Bi3BdaKIX6EFo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:45 -0700
IronPort-SDR: PPhigWBa168wlRBR9ojg4KbQ9F+PfWM7PofgmKz8mRdg7+9Aw5HxdMeEjy7gw3V/wFcktVg7r7
 TSFNEui8Y4zQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:33 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 32/32] hw/riscv: sifive_u: Add a dummy DDR memory controller
 device
Date: Thu, 18 Jun 2020 23:25:18 -0700
Message-Id: <20200619062518.1718523-33-alistair.francis@wdc.com>
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

It is enough to simply map the SiFive FU540 DDR memory controller
into the MMIO space using create_unimplemented_device(), to make
the upstream U-Boot v2020.07 DDR memory initialization codes happy.

Note we do not generate device tree fragment for the DDR memory
controller. Since the controller data in device tree consumes a
very large space (see fu540-hifive-unleashed-a00-ddr.dtsi in the
U-Boot source), and it is only needed by U-Boot SPL but not any
operating system, we choose not to generate the fragment here.
This also means when testing with U-Boot SPL, the device tree has
to come from U-Boot SPL itself, but not the one generated by QEMU
on the fly. The memory has to be set to 8GiB to match the real
HiFive Unleashed board when invoking QEMU (-m 8G).

With this commit, QEMU can boot U-Boot SPL built for SiFive FU540
all the way up to loading U-Boot proper from MMC:

$ qemu-system-riscv64 -nographic -M sifive_u,msel=6 -m 8G -bios u-boot-spl.bin

U-Boot SPL 2020.07-rc3-00208-g88bd5b1 (Jun 08 2020 - 20:16:10 +0800)
Trying to boot from MMC1
Unhandled exception: Load access fault
EPC: 0000000008009be6 TVAL: 0000000010050014

The above exception is expected because QSPI is unsupported yet.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1592268641-7478-6-git-send-email-bmeng.cn@gmail.com
Message-Id: <1592268641-7478-6-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_u.h | 1 +
 hw/riscv/sifive_u.c         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 27dc35e0a3..aba4d0181f 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -78,6 +78,7 @@ enum {
     SIFIVE_U_UART1,
     SIFIVE_U_GPIO,
     SIFIVE_U_OTP,
+    SIFIVE_U_DMC,
     SIFIVE_U_FLASH0,
     SIFIVE_U_DRAM,
     SIFIVE_U_GEM,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 052ba85ec7..60f1cf990d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -82,6 +82,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
     [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
     [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
+    [SIFIVE_U_DMC] =      { 0x100b0000,    0x10000 },
     [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
 };
@@ -714,6 +715,9 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     create_unimplemented_device("riscv.sifive.u.gem-mgmt",
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
+
+    create_unimplemented_device("riscv.sifive.u.dmc",
+        memmap[SIFIVE_U_DMC].base, memmap[SIFIVE_U_DMC].size);
 }
 
 static Property sifive_u_soc_props[] = {
-- 
2.27.0


