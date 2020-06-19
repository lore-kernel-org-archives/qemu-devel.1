Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3038AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4A920809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hWq8Vm6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4A920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKrS-0007TI-8X
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKV0-0002E4-MZ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:08:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUy-0004Pk-R9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586524; x=1624122524;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JwztKMtvyHRO+8rsE3rkWQvqEjJezYk1Ew7ePUs8op4=;
 b=hWq8Vm6j/LkEOan4CRm3NBXkO1f6KvS1Or7w4I++UoT3kcfeq/Bo2JRL
 cgLFu7Z/oWBoyT0mP8dFrEqNFN8UwoHOpyggQv5hgeRpP4MePUcMa9KAl
 T4zxL53W4VVG800dlvyrohgFRi0MkcwnNHWo4CCO/tH37ZoXwlgq3AlPf
 /KekH7Ru2z1fQbYBaCvIBnn3jr2Rwf2YIdVQhJU1Dgo9eWNWMupRCusqV
 OPl8jLUKKcB7EHR8wWl8BAymhjqU6qkri7L4MDQ9RdE7lO8e3a6jAOyr1
 GiM6rtBYBmWeX/gWtIvLHOGILOOtfhtdk/E+BOuG5+Yxg0n5BKPQb1toK A==;
IronPort-SDR: kicLeLw134wVzL3sSvHKrF3lLO/Xi8LYcycRx7RInZADCflmhHQC4Dp6lio2kppGo0+WBBK4dH
 VBzbfpO/deZ1gR7a1mV/ktbWd0ABHJeXfa1zKfc83dtPp4Tfshjaf9GegFgNJ/N7/RaJZFRfmL
 3w89FUDMqdS13IqJRA9BzDpIBHhawuMDZzsoqZNIdkGnhwHcejQvqdhdBkiYT3qdppmTfhISwc
 VPldXs4p2jX4cEYN8cblwVjOkXdVaS016P9iMJwk1bSs2gj3K3X7FMdtVkKmrITuftxztZuKM1
 1T8=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417022"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:32 +0800
IronPort-SDR: DCi/8Ay6onhUGjp286PAw1FE3djgSO5NoxNHiIjoyHeb1pZJfH09IDxYvfwZ6Ylj7pX825l8F0
 3DwbCV9OwxYloewdh+T5TDxxBWufNEEtI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:06 -0700
IronPort-SDR: tv78s7XmN5qRmP8lGC7jX34+eW36k5Ol0w4tD3eLTuwR1qWe3cm0kT6pubXftK+IfaiIL8Q4M8
 hkG+p+7t3N3w==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 32/32] hw/riscv: sifive_u: Add a dummy DDR memory controller
 device
Date: Fri, 19 Jun 2020 09:58:17 -0700
Message-Id: <20200619165817.4144200-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
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
index b9d0a6901a..7d051e7c92 100644
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


