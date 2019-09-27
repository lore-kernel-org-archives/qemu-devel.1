Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A3C352A9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:51:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F1C20872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rqk9rldt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F1C20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeTQ-0000He-F1
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRB-0006wb-Nj
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRA-0008IB-6K
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12533)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeR9-0008F4-DB; Thu, 26 Sep 2019 20:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545323; x=1601081323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ByVctfOFp3GmvnsjvFnqViPbrZ48vEkqMXYB+oy5B7s=;
 b=Rqk9rldtvJovFnkgkq3GkKELevhPBc0zj79h/5laaa1S38YkjeHIqGPA
 hWSesY2FJpDrxUHn241ZJIEDLk71TkA/U/PmlOqpn5J3gOQ7fH0cw8w9y
 il2uzxwxUlgbJKLeSIe/UkJBdwEzVx8xheEJBjeqSmIK2GSnIrgZGiuVU
 DyVv9uin5zizlut6OKd2QmWvJsvUIW07iVrmC/Ipa4ldi20ADORliUlB8
 c6b7kzrNfYECvbXAbUqeGO/vWISFGNTUor8dX0KSG4BTvXcNZAmUZFxot
 NJw4hR0vXfxWVDwBThiuPamX/LFyN3EYWPbTrMxxeE3FTZMcSSmt/veQj Q==;
IronPort-SDR: XBS4T90bMsNE93facn6Em7koEbNID9kNKsygj1s/4M/kDpXvFNGZcS9WNLqq2G9bd5CF2tCvJA
 qGTEGmkLiT7U5gB3YAmjbnH//Wx2yAUD8C0n2AhgKbbOYXElGoQa5SNCO/QcezaJJ7g4VZQoco
 CnpJDixgDwa+OtKf68zjE2jjKhOeApu3EPRWyJ3BEEuHtqzQhOWnEYXHFcV3JMeQPE+7n5Y4pf
 Jwf808WIj8HIShSgOxdkuVAa2QXqnXE13PfRICethRVBQ4LjAqCtb9//cTjI635zju0Am5E99D
 kRY=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="119225541"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:48:42 +0800
IronPort-SDR: WSe2CGvPvB/RSUTL7fBRlvZxMuGZi/jCR+vBfs1cVDiyrDCqHb3hjb6ZEtTBLAE3xGCICLGMYn
 9MGyk/8i+kYU6FXKPSXDtM/cTth6ZGtHbfpXqW6S7Tc5W3N0RELSbUFrnkBlppuzj6aXDe+sl3
 w4zkd4euysbDUFR/h6FuWJm7P3a1daW506s703yyPCRW/N/nOJWppIrqqrHMochkYuaoRVo8PU
 /Mpsbkpno0ly6W8mvzyF+AEqAQrx9D3WdVbyH8VPoau9xshfcmHFEWU8yovK1IPh246rxALK8y
 oVqGNK/QFIlgKjnxCoSowFHt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:44:56 -0700
IronPort-SDR: ySZRYLhIKlnzkk+/8EnbqBsdRpdAcpNP3SQlhlAbbmNcTveKVh9okBseO1LFLIL0A72T2M5pkA
 h6plM4+Z+H9JMrg5Gcy/ftijCLvI4WvvujJmgdkZ/W08Jp5bOxbkP5b0heTz6EdTCxQeaGk+Hl
 da+6IGMay3yEjwLlpLSlqVC/vBvQyu9f3HSIWuDFwwt7GSBHo1fk1aaamTsYiJ62rdR5E3/bPh
 8eNWmk61qrlMRT6nCfAbQ154Z8lwoWL+8PR4DIIw+4XnsxTnehRbPj6D2u2aM+9xTiS3YEl8/O
 Xyw=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Sep 2019 17:48:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 2/7] riscv/sifive_u: Add QSPI memory region
Date: Thu, 26 Sep 2019 17:44:23 -0700
Message-Id: <427130d2510a6c3dd7a4266bd586b15ecefba103.1569545046.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569545046.git.alistair.francis@wdc.com>
References: <cover.1569545046.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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


