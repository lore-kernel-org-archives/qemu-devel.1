Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEC2C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929CC21783
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Rlz1bISl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929CC21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeZm-0000KW-HT
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:57:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRN-00074w-6d
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRL-0008Vu-ML
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRL-0008Tk-Ck; Thu, 26 Sep 2019 20:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545335; x=1601081335;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=osDHEAXClaZ6mredChAvHiJiJSFIw/RBOyE8dcpXHzI=;
 b=Rlz1bISlsFCppJnl38TpOud1Szhu9z8AXSyZFRrez8gdijOFv6Qn88je
 ioEroC8lxfQX4BQrLJ7I1LYwPNMyIPodwUMXkbQd2O0+drJc/A0LH4r+v
 lYMA2G6AwtQVAglWVlTJVWDEaXXcb5z8nRB93qslKftPkqV2SWbRs3gvD
 7yNFzyrZz9jMEn6jkGI8XUgZmD2pgnrT2FDawSVjWEl9A5/72VUOp9laX
 x2vmgKegSUfLohWxww/hLt+LgjQ9SuLTFS7xSr7eAS4JfnTpdtzy1PmTL
 xp4d5n3buCU7k/qEn8LmvsFnQTc+xt7phP8TYyOpDAxsB5Hzit0iiNrGv g==;
IronPort-SDR: rhF/IrZ+yFxLF3NeUjc9oCPf8UcU4rjdFWYUSxWqZ1kdg7F2pjuaMpcPy2eH1HhJc+aroCcMnP
 JVnCjKrN6M2KPf6xXznKmypq0aAKMzL/YT09vody+fSzthhs6XfzpWiIzQoM7mSuqjmvZ0bgeF
 gFHJyiVD1MD2TeZ1m3MbbmZYmVB+OKn3pR5LM05QyFCmj5zIR8vp4xHHx/A+JYqynZwNxsmW6/
 21w6P5YVlpksbuQx3A7ScE4h7nZKwPzDPYiXUozmdmp3Hn+C3P8G8X5d7iwxRwNJMEgR/T/rPq
 qF0=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="120012193"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:48:52 +0800
IronPort-SDR: 7xouPCupfsNKMwu4hXZZ4hT4+c4WPZtbKYtWP/96ATMvV81G7ft9QJWJt33YCxRAWtkIjAwcHT
 0xLSzlZl7esO95vXhs3cJuvBN6haSh8NwBVvVfQABxU9lWvEM0+sgs41ZGFS/WUAbIrcHrNbOH
 NtmMul7iQiazaL0JTTazwqATG4HEsHLcpZYy4FCCTI/Md8Ugx0s292bKiMmFwPyvPGDQmkGYKg
 LuZqdi5rK799jQy7B14ZKKIfHKhgTuf7/seIo9DgCSAJvh2yrOkVw5UiAwYwp2UzT/6bbDfs0n
 dvwaaRIaoP2GehnwlURM3ppS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:45:12 -0700
IronPort-SDR: Vn3NwHD6/OL5e5vWXMlId+OU9e2HOFXFYD7E2/QakIfEr5AMXHFg6m8KygVJvTqEzMyLmRsv/X
 /iCN+ikzL89ea24M2cjp34Ci9x0xLHAiWAAiwWpB3hplhi2pgDTARsaXPUbB46vjnfcrxTSp5A
 FkEXYZADx81vVstpf0brVKyUf+se3vScYpbT6p4Lg3OTwTKhQpl8idH0OKrbH2U9V1ayF8fexn
 4/ZUEZLfiJkrC3gRAz+d0kxju5Euz4y+2d4OOVp2zPKq13q4R28lJ4ymcvv0hKq6sFo4ke7VKO
 UQA=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2019 17:48:52 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 6/7] riscv/virt: Add the PFlash CFI01 device
Date: Thu, 26 Sep 2019 17:44:33 -0700
Message-Id: <c890a46c575894db0d06c2efeb7083f2f3b240a2.1569545046.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569545046.git.alistair.francis@wdc.com>
References: <cover.1569545046.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.144
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

Add the CFI01 PFlash to the RISC-V virt board. This is the same PFlash
from the ARM Virt board and the implementation is based on the ARM Virt
board. This allows users to specify flash files from the command line.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 86 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h |  3 ++
 3 files changed, 90 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index fb19b2df3a..b12660b9f8 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -36,4 +36,5 @@ config RISCV_VIRT
     select SERIAL
     select VIRTIO_MMIO
     select PCI_EXPRESS_GENERIC_BRIDGE
+    select PFLASH_CFI01
     select SIFIVE
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e4dcbadcb5..ad29e14d5f 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -26,6 +26,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
 #include "hw/char/serial.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/riscv_hart.h"
@@ -61,12 +62,77 @@ static const struct MemmapEntry {
     [VIRT_PLIC] =        {  0xc000000,     0x4000000 },
     [VIRT_UART0] =       { 0x10000000,         0x100 },
     [VIRT_VIRTIO] =      { 0x10001000,        0x1000 },
+    [VIRT_FLASH] =       { 0x20000000,     0x2000000 },
     [VIRT_DRAM] =        { 0x80000000,           0x0 },
     [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
     [VIRT_PCIE_PIO] =    { 0x03000000,    0x00010000 },
     [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
 };
 
+#define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
+
+static PFlashCFI01 *virt_flash_create1(RISCVVirtState *s,
+                                       const char *name,
+                                       const char *alias_prop_name)
+{
+    /*
+     * Create a single flash device.  We use the same parameters as
+     * the flash devices on the ARM virt board.
+     */
+    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
+
+    qdev_prop_set_uint64(dev, "sector-length", VIRT_FLASH_SECTOR_SIZE);
+    qdev_prop_set_uint8(dev, "width", 4);
+    qdev_prop_set_uint8(dev, "device-width", 2);
+    qdev_prop_set_bit(dev, "big-endian", false);
+    qdev_prop_set_uint16(dev, "id0", 0x89);
+    qdev_prop_set_uint16(dev, "id1", 0x18);
+    qdev_prop_set_uint16(dev, "id2", 0x00);
+    qdev_prop_set_uint16(dev, "id3", 0x00);
+    qdev_prop_set_string(dev, "name", name);
+
+    object_property_add_child(OBJECT(s), name, OBJECT(dev),
+                              &error_abort);
+    object_property_add_alias(OBJECT(s), alias_prop_name,
+                              OBJECT(dev), "drive", &error_abort);
+
+    return PFLASH_CFI01(dev);
+}
+
+static void virt_flash_create(RISCVVirtState *s)
+{
+    s->flash[0] = virt_flash_create1(s, "virt.flash0", "pflash0");
+    s->flash[1] = virt_flash_create1(s, "virt.flash1", "pflash1");
+}
+
+static void virt_flash_map1(PFlashCFI01 *flash,
+                            hwaddr base, hwaddr size,
+                            MemoryRegion *sysmem)
+{
+    DeviceState *dev = DEVICE(flash);
+
+    assert(size % VIRT_FLASH_SECTOR_SIZE == 0);
+    assert(size / VIRT_FLASH_SECTOR_SIZE <= UINT32_MAX);
+    qdev_prop_set_uint32(dev, "num-blocks", size / VIRT_FLASH_SECTOR_SIZE);
+    qdev_init_nofail(dev);
+
+    memory_region_add_subregion(sysmem, base,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       0));
+}
+
+static void virt_flash_map(RISCVVirtState *s,
+                           MemoryRegion *sysmem)
+{
+    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
+
+    virt_flash_map1(s->flash[0], flashbase, flashsize,
+                    sysmem);
+    virt_flash_map1(s->flash[1], flashbase + flashsize, flashsize,
+                    sysmem);
+}
+
 static void create_pcie_irq_map(void *fdt, char *nodename,
                                 uint32_t plic_phandle)
 {
@@ -121,6 +187,8 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     char *nodename;
     uint32_t plic_phandle, phandle = 1;
     int i;
+    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -316,6 +384,15 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
         qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
     }
     g_free(nodename);
+
+    nodename = g_strdup_printf("/flash@%" PRIx64, flashbase);
+    qemu_fdt_add_subnode(s->fdt, nodename);
+    qemu_fdt_setprop_string(s->fdt, nodename, "compatible", "cfi-flash");
+    qemu_fdt_setprop_sized_cells(s->fdt, nodename, "reg",
+                                 2, flashbase, 2, flashsize,
+                                 2, flashbase + flashsize, 2, flashsize);
+    qemu_fdt_setprop_cell(s->fdt, nodename, "bank-width", 4);
+    g_free(nodename);
 }
 
 
@@ -495,6 +572,15 @@ static void riscv_virt_board_init(MachineState *machine)
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    virt_flash_create(s);
+
+    for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
+        /* Map legacy -drive if=pflash to machine properties */
+        pflash_cfi01_legacy_drive(s->flash[i],
+                                  drive_get(IF_PFLASH, 0, i));
+    }
+    virt_flash_map(s, system_memory);
+
     g_free(plic_hart_config);
 }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index ffcdcc6dcc..8630f84592 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -21,6 +21,7 @@
 
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
+#include "hw/block/flash.h"
 
 #define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
 #define RISCV_VIRT_MACHINE(obj) \
@@ -33,6 +34,7 @@ typedef struct {
     /*< public >*/
     RISCVHartArrayState soc;
     DeviceState *plic;
+    PFlashCFI01 *flash[2];
 
     void *fdt;
     int fdt_size;
@@ -46,6 +48,7 @@ enum {
     VIRT_PLIC,
     VIRT_UART0,
     VIRT_VIRTIO,
+    VIRT_FLASH,
     VIRT_DRAM,
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
-- 
2.23.0


