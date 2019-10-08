Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A4C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:41:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D9121721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HFPkOIt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D9121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHz6P-0004ZF-TP
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz24-0000Ni-AY
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz22-0006Ny-L2
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:44 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz22-0006Mq-D4; Tue, 08 Oct 2019 19:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570577803; x=1602113803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rg3N8VIK2j7pN0XrZHKq2dkgVaGOQYXSYGDnzxy0r7I=;
 b=HFPkOIt7F14EbTUFsu5NpKm2JErYat/J/tRTdVW4ToMyJbJJT+oxgHBl
 YE+oGWlq6EdAmaSaLmc++kKLTrwSR4geBlh8iARHriia4PIQtrpAs5rJy
 VRILJ8oxAqnGjksfJ1U4wWq2njij1LzfKRfnMvkbIs1prqiiCCiyY/+P6
 CkOW5cuDXL0TvIujzbY4xwcArVtXQAbMI+ToPGySETNIvll2k+3Ul9hNh
 nNmriWhIHLgL2jLeAed6j9hYFa176vgSgiSzeluHL6xoEybZ2kC20iKHp
 0I2L3dFUsPOzLsHfu4W52Jj2FIl5RA5PemY/CQLzt5ws8+bA4+UUekVsq Q==;
IronPort-SDR: wkkf4574EZNMYnUSL1tvgUQZqktgE6bybEOi2w8dwNZK5+fyo+2Ks2QUYw0OjwGd09XnkpBRQJ
 CwWDXbZMY2BHb/7TAOvwNQAr/6+J9Ki0Gjwnoj5wScn3DiqReIhgDrx1XTfH/P6oiD7RYqDSu7
 IJ4iNb79nEGISR3Bjvm+XkYg+INo25XNT4KMPvr06Fxq4c0FnTNkODFhGMZgqLZHynJKqARkvi
 Rp+TjqpMvifDwU9cqeoltIqDEeLBC3zDHgV551dISbWHAWJE8aJ12PJ0loAhCeNJJgjiMsVZhA
 TOs=
X-IronPort-AV: E=Sophos;i="5.67,273,1566835200"; d="scan'208";a="124519175"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 07:36:42 +0800
IronPort-SDR: aokDl2Y142+UVlIV/SmHGiQM7TL8d2RqGvhDf4jwNONs/XD4Sqvri76HUUe00os3flYoSk4+w9
 4HIAiJDvnoJrs7Oz43ipJ9WDQN6gQzdEtpRGy4YNfPQGMF3hoHCHOzoy5nxU/mxnx0NGg+xt3E
 TSMJJNv8dPIqVNBJdr7YG2qBqWrHDt8cRqFNK4FfDWGiOSa1v3/z0IQeRxXTPxBN2OmJDqKwKD
 yiXrrgxwslcSZcjsUTqYvoSdZ9R7nFDy0tPWOVixIDPKruQqKwsdygg2iKTiOX8CTya0tNoGqM
 +EXAKlZ/gsWocM9Memc/6pLv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 16:32:36 -0700
IronPort-SDR: 19ypslduk4Gh8G2oWJe39OkBEGrIyjQyng9YOqzCs27YRkcXRiqLoNyhxv+E67Fjm4sJ0cXkEs
 rFs34Yjkpyo+Qx7ay1h4OjqZW087pUP65mgHkMk/VspXwi9rLwiE8MG4nfMy4yzmEQ42Pgx4aI
 TWxdNfndFgwDuoZFRjjfHRodqpBy56fAd6g0r5OTGkjc+DfmLjBOhN4j3qRoGTYGJzfAo8aoAf
 VwVEnwozMtSNBgzI/eaUK/Wfj1ObVtWUMx0zeyM0kO+ThHuuvwyhmOtaM3i+BpNunp2/lYxL3j
 vMg=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Oct 2019 16:36:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 2/7] riscv/sifive_u: Add QSPI memory region
Date: Tue,  8 Oct 2019 16:32:11 -0700
Message-Id: <3c821dfbfa3ffb9ec410016a0384c518a8ca49df.1570577500.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570577500.git.alistair.francis@wdc.com>
References: <cover.1570577500.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The HiFive Unleashed uses is25wp256 SPI NOR flash. There is currently no
model of this in QEMU, so to allow boot firmware developers to use QEMU
to target the Unleashed let's add a chunk of memory to represent the QSPI0
memory mapped flash. This can be targeted using QEMU's -device loader
command line option.

In the future we can look at adding a model for the is25wp256 flash.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 hw/riscv/sifive_u.c         | 8 ++++++++
 include/hw/riscv/sifive_u.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1d255ad13e..bc0e01242b 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -71,6 +71,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
+    [SIFIVE_U_FLASH0] =   { 0x20000000, 0x10000000 },
     [SIFIVE_U_DRAM] =     { 0x80000000,        0x0 },
     [SIFIVE_U_GEM] =      { 0x10090000,     0x2000 },
     [SIFIVE_U_GEM_MGMT] = { 0x100a0000,     0x1000 },
@@ -313,6 +314,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     SiFiveUState *s = g_new0(SiFiveUState, 1);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
+    MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     int i;
 
     /* Initialize SoC */
@@ -328,6 +330,12 @@ static void riscv_sifive_u_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_DRAM].base,
                                 main_mem);
 
+    /* register QSPI0 Flash */
+    memory_region_init_ram(flash0, NULL, "riscv.sifive.u.flash0",
+                           memmap[SIFIVE_U_FLASH0].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[SIFIVE_U_FLASH0].base,
+                                flash0);
+
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 50e3620c02..2a08e2a5db 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -64,6 +64,7 @@ enum {
     SIFIVE_U_UART0,
     SIFIVE_U_UART1,
     SIFIVE_U_OTP,
+    SIFIVE_U_FLASH0,
     SIFIVE_U_DRAM,
     SIFIVE_U_GEM,
     SIFIVE_U_GEM_MGMT
-- 
2.23.0


