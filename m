Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89616C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:29:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F9892085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9892085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx2tt-00077h-Jg
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 01:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hx2oa-0000S0-Hq
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hx2oW-0006CL-3d
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hx2oV-0006Ae-Q5
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2C4E3016F4A
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:24:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59C8B646B4;
 Mon, 12 Aug 2019 05:24:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 035481136428; Mon, 12 Aug 2019 07:24:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 07:23:46 +0200
Message-Id: <20190812052359.30071-17-armbru@redhat.com>
In-Reply-To: <20190812052359.30071-1-armbru@redhat.com>
References: <20190812052359.30071-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 12 Aug 2019 05:24:11 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 16/29] Include exec/memory.h slightly less
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Drop unnecessary inclusions from headers.  Downgrade a few more to
exec/hwaddr.h.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/audio/lm4549.h                   | 1 +
 hw/net/can/can_sja1000.h            | 1 +
 hw/xtensa/xtensa_memory.h           | 1 -
 include/hw/arm/boot.h               | 1 -
 include/hw/arm/fsl-imx7.h           | 1 -
 include/hw/arm/soc_dma.h            | 2 +-
 include/hw/block/flash.h            | 2 +-
 include/hw/boards.h                 | 1 +
 include/hw/char/parallel.h          | 1 -
 include/hw/display/milkymist_tmu2.h | 1 +
 include/hw/display/tc6393xb.h       | 2 --
 include/hw/display/vga.h            | 2 +-
 include/hw/hw.h                     | 1 -
 include/hw/i2c/pm_smbus.h           | 1 +
 include/hw/i2c/smbus_eeprom.h       | 1 +
 include/hw/misc/auxbus.h            | 1 +
 include/hw/ppc/xics.h               | 1 +
 include/hw/usb.h                    | 1 +
 include/hw/virtio/virtio.h          | 1 +
 migration/migration.h               | 1 +
 hw/display/edid-region.c            | 1 +
 hw/display/tc6393xb.c               | 1 +
 hw/net/ne2000.c                     | 1 +
 migration/colo.c                    | 1 +
 migration/postcopy-ram.c            | 1 +
 migration/rdma.c                    | 1 +
 26 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/audio/lm4549.h b/hw/audio/lm4549.h
index 74c3ee8934..aba9bb5b07 100644
--- a/hw/audio/lm4549.h
+++ b/hw/audio/lm4549.h
@@ -13,6 +13,7 @@
 #define HW_LM4549_H
=20
 #include "audio/audio.h"
+#include "exec/hwaddr.h"
=20
 typedef void (*lm4549_callback)(void *opaque);
=20
diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h
index 4731cbbd2a..220a622087 100644
--- a/hw/net/can/can_sja1000.h
+++ b/hw/net/can/can_sja1000.h
@@ -27,6 +27,7 @@
 #ifndef HW_CAN_SJA1000_H
 #define HW_CAN_SJA1000_H
=20
+#include "exec/hwaddr.h"
 #include "net/can_emu.h"
=20
 #define CAN_SJA_MEM_SIZE      128
diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
index d50a3cccc0..af7e8025e3 100644
--- a/hw/xtensa/xtensa_memory.h
+++ b/hw/xtensa/xtensa_memory.h
@@ -29,7 +29,6 @@
 #define XTENSA_MEMORY_H
=20
 #include "cpu.h"
-#include "exec/memory.h"
=20
 void xtensa_create_memory_regions(const XtensaMemory *memory,
                                   const char *name,
diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
index 350d4b0498..5714dea1a2 100644
--- a/include/hw/arm/boot.h
+++ b/include/hw/arm/boot.h
@@ -11,7 +11,6 @@
 #ifndef HW_ARM_BOOT_H
 #define HW_ARM_BOOT_H
=20
-#include "exec/memory.h"
 #include "target/arm/cpu-qom.h"
 #include "qemu/notify.h"
=20
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 8003d45d1e..706aef2e7e 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -38,7 +38,6 @@
 #include "hw/net/imx_fec.h"
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
-#include "exec/memory.h"
 #include "cpu.h"
=20
 #define TYPE_FSL_IMX7 "fsl,imx7"
diff --git a/include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h
index 7886291d54..e93a7499a8 100644
--- a/include/hw/arm/soc_dma.h
+++ b/include/hw/arm/soc_dma.h
@@ -21,7 +21,7 @@
 #ifndef HW_SOC_DMA_H
 #define HW_SOC_DMA_H
=20
-#include "exec/memory.h"
+#include "exec/hwaddr.h"
=20
 struct soc_dma_s;
 struct soc_dma_ch_s;
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 1acaf7de80..2136a2d5e4 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -3,7 +3,7 @@
=20
 /* NOR flash devices */
=20
-#include "exec/memory.h"
+#include "exec/hwaddr.h"
=20
 /* pflash_cfi01.c */
=20
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a71d1a53a5..3a0be3131a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -3,6 +3,7 @@
 #ifndef HW_BOARDS_H
 #define HW_BOARDS_H
=20
+#include "exec/memory.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/accel.h"
 #include "hw/qdev.h"
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index d6dd62fb9f..0a23c0f57e 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -1,7 +1,6 @@
 #ifndef HW_PARALLEL_H
 #define HW_PARALLEL_H
=20
-#include "exec/memory.h"
 #include "hw/isa/isa.h"
 #include "chardev/char.h"
=20
diff --git a/include/hw/display/milkymist_tmu2.h b/include/hw/display/mil=
kymist_tmu2.h
index 148a119a1d..1fd978dcc5 100644
--- a/include/hw/display/milkymist_tmu2.h
+++ b/include/hw/display/milkymist_tmu2.h
@@ -27,6 +27,7 @@
 #ifndef HW_DISPLAY_MILKYMIST_TMU2_H
 #define HW_DISPLAY_MILKYMIST_TMU2_H
=20
+#include "exec/hwaddr.h"
 #include "hw/qdev.h"
=20
 #if defined(CONFIG_X11) && defined(CONFIG_OPENGL)
diff --git a/include/hw/display/tc6393xb.h b/include/hw/display/tc6393xb.=
h
index c653ef717b..f9263bf98a 100644
--- a/include/hw/display/tc6393xb.h
+++ b/include/hw/display/tc6393xb.h
@@ -12,8 +12,6 @@
 #ifndef HW_DISPLAY_TC6393XB_H
 #define HW_DISPLAY_TC6393XB_H
=20
-#include "exec/memory.h"
-
 typedef struct TC6393xbState TC6393xbState;
=20
 TC6393xbState *tc6393xb_init(struct MemoryRegion *sysmem,
diff --git a/include/hw/display/vga.h b/include/hw/display/vga.h
index 0401a3a292..ca0003dbfd 100644
--- a/include/hw/display/vga.h
+++ b/include/hw/display/vga.h
@@ -9,7 +9,7 @@
 #ifndef QEMU_HW_DISPLAY_VGA_H
 #define QEMU_HW_DISPLAY_VGA_H
=20
-#include "exec/memory.h"
+#include "exec/hwaddr.h"
=20
 enum vga_retrace_method {
     VGA_RETRACE_DUMB,
diff --git a/include/hw/hw.h b/include/hw/hw.h
index e547008b17..8e18358e6a 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -7,7 +7,6 @@
 #endif
=20
 #include "qom/object.h"
-#include "exec/memory.h"
=20
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
=20
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index fb55c44444..0d74207efb 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -1,6 +1,7 @@
 #ifndef PM_SMBUS_H
 #define PM_SMBUS_H
=20
+#include "exec/memory.h"
 #include "hw/i2c/smbus_master.h"
=20
 #define PM_SMBUS_MAX_MSG_SIZE 32
diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.=
h
index 0f96836bab..15e2151b50 100644
--- a/include/hw/i2c/smbus_eeprom.h
+++ b/include/hw/i2c/smbus_eeprom.h
@@ -23,6 +23,7 @@
 #ifndef HW_SMBUS_EEPROM_H
 #define HW_SMBUS_EEPROM_H
=20
+#include "exec/cpu-common.h"
 #include "hw/i2c/i2c.h"
=20
 void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom=
_buf);
diff --git a/include/hw/misc/auxbus.h b/include/hw/misc/auxbus.h
index c15b444748..ee0ca3dd51 100644
--- a/include/hw/misc/auxbus.h
+++ b/include/hw/misc/auxbus.h
@@ -25,6 +25,7 @@
 #ifndef HW_MISC_AUXBUS_H
 #define HW_MISC_AUXBUS_H
=20
+#include "exec/memory.h"
 #include "hw/qdev.h"
=20
 typedef struct AUXBus AUXBus;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1eb7b5cd68..457aa98f81 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -28,6 +28,7 @@
 #ifndef XICS_H
 #define XICS_H
=20
+#include "exec/memory.h"
 #include "hw/qdev.h"
=20
 #define XICS_IPI        0x2
diff --git a/include/hw/usb.h b/include/hw/usb.h
index c21f41c8a9..96971a4c26 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -25,6 +25,7 @@
  * THE SOFTWARE.
  */
=20
+#include "exec/memory.h"
 #include "hw/qdev.h"
 #include "qemu/iov.h"
 #include "qemu/queue.h"
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 5da749e2b0..e6a2a0a6e0 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -14,6 +14,7 @@
 #ifndef QEMU_VIRTIO_H
 #define QEMU_VIRTIO_H
=20
+#include "exec/memory.h"
 #include "hw/hw.h"
 #include "net/net.h"
 #include "hw/qdev.h"
diff --git a/migration/migration.h b/migration/migration.h
index 26f01d00f6..a7882af67a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -14,6 +14,7 @@
 #ifndef QEMU_MIGRATION_H
 #define QEMU_MIGRATION_H
=20
+#include "exec/cpu-common.h"
 #include "qapi/qapi-types-migration.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine_int.h"
diff --git a/hw/display/edid-region.c b/hw/display/edid-region.c
index d0d31bad3d..675429dc18 100644
--- a/hw/display/edid-region.c
+++ b/hw/display/edid-region.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "exec/memory.h"
 #include "hw/display/edid.h"
=20
 static uint64_t edid_region_read(void *ptr, hwaddr addr, unsigned size)
diff --git a/hw/display/tc6393xb.c b/hw/display/tc6393xb.c
index 10e7f74c74..74a77eb43b 100644
--- a/hw/display/tc6393xb.c
+++ b/hw/display/tc6393xb.c
@@ -17,6 +17,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/display/tc6393xb.h"
+#include "exec/memory.h"
 #include "hw/block/flash.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 7731b5acd1..a1a1046494 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "net/eth.h"
 #include "qemu/module.h"
+#include "exec/memory.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "ne2000.h"
diff --git a/migration/colo.c b/migration/colo.c
index 9f84b1fa3c..0b5b620391 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -23,6 +23,7 @@
 #include "io/channel-buffer.h"
 #include "trace.h"
 #include "qemu/error-report.h"
+#include "qemu/rcu.h"
 #include "migration/failover.h"
 #ifdef CONFIG_REPLICATION
 #include "replication.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 9faacacc9e..56054d0a73 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -25,6 +25,7 @@
 #include "ram.h"
 #include "qapi/error.h"
 #include "qemu/notify.h"
+#include "qemu/rcu.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/balloon.h"
 #include "qemu/error-report.h"
diff --git a/migration/rdma.c b/migration/rdma.c
index 3036221ee8..b0e27b6174 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -25,6 +25,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "qemu/rcu.h"
 #include "qemu/sockets.h"
 #include "qemu/bitmap.h"
 #include "qemu/coroutine.h"
--=20
2.21.0


