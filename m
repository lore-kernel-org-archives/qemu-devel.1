Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3ECC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59682217D6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="E8WHwWZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59682217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB4xi-0003tZ-Pu
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vE-0001Ff-TA
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vD-0004z4-IW
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vD-0004yW-AT; Thu, 19 Sep 2019 18:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568932162; x=1600468162;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7MGs1WM/6RxP9Z4usOtR7QOoV1fbDZIHF4Cqz/uLULA=;
 b=E8WHwWZ3Qn6mj9yXfe6iawJ4LBN+wxC6TQQo0kCF2Vnzr9+ED3zjcXDr
 +uO+Yt7mBELqg2Kp/W+eXxXqz3glwz23MIMtkGk46Ek3fyHvIP3VFSEJH
 GVRe03Kbn32UCZ+bLya9je2BT2iB1OeT7euzJws1V63nQEAjL39kg8RHa
 GQE2nzucB6/unZjD/aRzY5eI9opSp+IubBHRW0vQPkI9f6T2RZreldENM
 eI5fOQ4sjlQVHzghlpHeLUcgMToeqFe4w8BG9VEApojuVnf319V55xY4e
 SGHtdDIL7GOrcDcJ1RvHTASWsDw0tnXbZEr1Ds4L0TpKFckYp3KI+KBVT A==;
IronPort-SDR: 1eRLMk0xS2Uf/6WUBMw7lXcuvU//zQuQNcMV5GgmfN34MkvnlDFllrcNa4A6HaH+1fMW9g0UT9
 pM+ONw/GzJmjU6oz+8O9LvhWdmPXQVx3aOXIlYBCB/UkyAluFrAIBLKlx3De+FaL27KOAyYxhF
 zHMyxasOV1BDVZDezFycbt3m3yF8iDrUWGqXQI8kQxSQrMUu8/kJi1D1A5lnos/RMm4WvpbTEi
 HDPv8S6tCsoT8rK4ZpnBYSbEvodDAuaWlyiLc0b1Fq8jJrNqEl81g3ZDLM3SGgUzW78GKfn+Kw
 vro=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; d="scan'208";a="219490589"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 06:29:20 +0800
IronPort-SDR: Km2WdYtDJoApy/rb6PwrlQB5vfET/AjBF2liPMPPhBQ7VEgcaggjJ4Cq4tY9Ci1yBd+UmlKKw7
 WctBgy8LMIJd7gdnt71waTuJ7xSGqLdG0V3l/VxdqE5CX+zMWX9NVieT7UL6nYIY/BGMbrXiKU
 m37e8ye+k5TUeq8dlGQnzdvSAnJA97GUXCeKfHDi3B9HMHk4eXh43STesYbmDgKqpfS6s5sGPu
 8pYRQyzkimhvqJldqZvLXMHeOFKO+T2dFxbt86yamjWc8AC72Gnl4agP/Aj56uHK3JVI+h1dTK
 2z6VskXZsA6nBjhB8qfroQqz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:25:38 -0700
IronPort-SDR: OOgCCSHJ+1uRU+uYr5Ix222BOIRGNkDwPPObyN66ek/XgutSGT5Vcfq2F85d0EL7pbg1D1iNxG
 bQ7hSd44j+Puwra0oCr0CT0MWEm3TawrC/rsHK/MfR/gB4AKQxPi0hkODDnKPGtBur46ZNxndA
 zeNdbEp2hAts7bC38UVnO1p+JkbS1RPMgLPRg9KLQKBBAkce7OHeXQ6F/a2KSlyyuMJRArupNt
 /p/lTwQ9c6zgoDYHJOwfMdOTDNmLfSYXVyVF2Ssn1hwww5+HuPtDWaC89Dw9mETZxG2a8pz8Cj
 lkg=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Sep 2019 15:29:07 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 2/6] riscv/sifive_u: Add QSPI memory region
Date: Thu, 19 Sep 2019 15:24:58 -0700
Message-Id: <f72e3c4ebbfa0f8fb08b7c8cb0bafd48ca41cad5.1568931866.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568931866.git.alistair.francis@wdc.com>
References: <cover.1568931866.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.143.124
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

There doesn't seem to be details on what QSPI the HiFive Unleashed uses.
To allow boot firmware developers to use QEMU to target the Unleashed
let's add a chunk of memory to represent the QSPI. This can be targeted
using QEMU's -device loader command line option.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c         | 8 ++++++++
 include/hw/riscv/sifive_u.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index de6e197882..9c5d791320 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -71,6 +71,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_UART0] =    { 0x10010000,     0x1000 },
     [SIFIVE_U_UART1] =    { 0x10011000,     0x1000 },
     [SIFIVE_U_OTP] =      { 0x10070000,     0x1000 },
+    [SIFIVE_U_FLASH0] =   { 0x20000000,  0x2000000 },
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


