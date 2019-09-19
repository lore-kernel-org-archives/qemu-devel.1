Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3106CC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFF82208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 22:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G+23GMny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF82208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB52D-0001K3-55
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 18:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vf-0001cq-LF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vd-00056g-EY
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 18:29:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:16350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1583187f4=alistair.francis@wdc.com>)
 id 1iB4vd-000561-60; Thu, 19 Sep 2019 18:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1568932173; x=1600468173;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ONujjvyc7FulJzERadVRcPRBa/fvTjMfmj7qX8NCcow=;
 b=G+23GMnyfkjKjd+zr8V0W+ava1aFj5e1d9RjrYGt4cgu1WaTQswo+YGy
 in/8yZFLN72matG+XH3RiqXWthDDq7InUa1T6XJQ0wFI3Tv9W/JUjbb8E
 jRctNst61SANbm14/XJX3SYQmkEyE6pC4mlGu2yd/6RAsyKva4+OQdOkr
 7TRCUR2B/XRG2uFHWZGO+AFWtdYUbvQSJ4ocXd2zzPeZSto3QPGFfdMcl
 yCYZnwChG3UWR8eLVHlgKCy3+UG+Be5y+A0bxsiG7na58enwA/Ettw+Wv
 uMcCmtgN+3Kfbakhaljjh8wW5dh5FEMmrynP6PrjqH2ju8yKi+VsAqKpJ g==;
IronPort-SDR: z1BZHVE2xOQsC42Nk6cgPaxPRM78zNZB82WxNW3LW3wtORdnL6KhEZ9jGE9nIkvzrTkR3B7aKx
 DSeBgUoEnsrqxv7PA/tUb3DZ/9NM6fkp8PvgXyosOtQ0t2d+ksWn0HYgF1pqFVJNZE6qF3Q1HY
 qj/Xa0ohcAJMzITpjmrd6pmb8zORR/r1JQBaDOLWPrb66PM81+m8hPOzrC7d+I7uWoMo7JBI1q
 EbbFRt3z2WhTOGNRTH+ADsHNf0KkCMyOIm16iYBZ0jcSeuaqwIEKesf+yTjL+niM/ZtGPW6VAA
 mMg=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; d="scan'208";a="123146905"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 06:29:14 +0800
IronPort-SDR: FIesWdPQ7XMPR2qh3R3rTLDijVqGFzcxalFFK3DfdmACYWohqaIKasV0T2a053hB/L+cgQ/vfk
 X7abmbXweYWs6natcWFF/UlvkQrme9Xtb+bU8h2vE9/D93qJuf1X+LV0hFvYH6ykWyHh4B97YD
 RGckFph07ZFopMuRuaYUeurQz0GQBHcn9Sgd7ztHYF5B8XKnc/Gyrp0sTo9Rexh6DRSWabPAJi
 TnfUIvmJ/4UXtEGzUJ59WC+XNyn6HWCCREtxKd0mWceX8EsdIrQ5Mj3bdRMypkOEPvIRx7aP4r
 h80lcmHJvGcLa0sUhbV7P0Hc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2019 15:25:40 -0700
IronPort-SDR: Uq51xKAiDYDnVEQjZ+o0YKS0HFlASIAY1+osXEnDqVBehMNbcH34Rza8EIbAMqbxjdrp42qURr
 DrLh1BAkh5b0wDaPl7UlG9e3Ql/FxvesuM0DQiAp8E6nISum4LUaBLOJ6ovy9m8gkBw/Y+UjMm
 FnvuP6O5g9ZAsv0prvShzC0pzcM2X6cPkHbfiNvqQ3sXBsvCEJX+1e8kqJerSc5ZYD2FlwMNZO
 W0cVrtKB8EnVNerwKsFTBpIuu9KJF7Q5dZryup/MzP24gcYX3kVtJyLUHEfZhbk45uq78cOM6H
 D0M=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Sep 2019 15:29:14 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 5/6] riscv/virt: Add the PFlash CFI01 device
Date: Thu, 19 Sep 2019 15:25:06 -0700
Message-Id: <0a5c141a26fada6d93d06e996a2f24e1b269ec50.1568931866.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1568931866.git.alistair.francis@wdc.com>
References: <cover.1568931866.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
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

Add the CFI01 PFlash to the RISC-V virt board. This is the same PFlash
from the ARM Virt board and the implementation is based on the ARM Virt
board. This allows users to specify flash files from the command line.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/Kconfig        |  1 +
 hw/riscv/virt.c         | 81 +++++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h |  3 ++
 3 files changed, 85 insertions(+)

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
index d36f5625ec..ca002ecea7 100644
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
@@ -61,12 +62,72 @@ static const struct MemmapEntry {
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
@@ -121,6 +182,8 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
     char *nodename;
     uint32_t plic_phandle, phandle = 1;
     int i;
+    hwaddr flashsize = virt_memmap[VIRT_FLASH].size / 2;
+    hwaddr flashbase = virt_memmap[VIRT_FLASH].base;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
     if (!fdt) {
@@ -316,6 +379,15 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
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
 
 
@@ -496,6 +568,15 @@ static void riscv_virt_board_init(MachineState *machine)
         0, qdev_get_gpio_in(DEVICE(s->plic), UART0_IRQ), 399193,
         serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
+    virt_flash_create(s);
+
+    /* Map legacy -drive if=pflash to machine properties */
+    for (i = 0; i < ARRAY_SIZE(s->flash); i++) {
+        pflash_cfi01_legacy_drive(s->flash[i],
+                                  drive_get(IF_PFLASH, 0, i));
+    }
+    virt_flash_map(s, system_memory);
+
     g_free(plic_hart_config);
 }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 6e5fbe5d3b..2ca8bd3512 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -21,6 +21,7 @@
 
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
+#include "hw/block/flash.h"
 
 typedef struct {
     /*< private >*/
@@ -29,6 +30,7 @@ typedef struct {
     /*< public >*/
     RISCVHartArrayState soc;
     DeviceState *plic;
+    PFlashCFI01 *flash[2];
     void *fdt;
     int fdt_size;
 } RISCVVirtState;
@@ -41,6 +43,7 @@ enum {
     VIRT_PLIC,
     VIRT_UART0,
     VIRT_VIRTIO,
+    VIRT_FLASH,
     VIRT_DRAM,
     VIRT_PCIE_MMIO,
     VIRT_PCIE_PIO,
-- 
2.23.0


