Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F2FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285CC2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 05:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285CC2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx2vN-0000BV-F1
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 01:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57224)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hx2oY-0000Ki-Fg
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hx2oU-00069L-AU
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34708)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hx2oU-00067t-1g
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 01:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5FF26309C389;
 Mon, 12 Aug 2019 05:24:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3B2B10001BB;
 Mon, 12 Aug 2019 05:24:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C178113642E; Mon, 12 Aug 2019 07:24:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 12 Aug 2019 07:23:52 +0200
Message-Id: <20190812052359.30071-23-armbru@redhat.com>
In-Reply-To: <20190812052359.30071-1-armbru@redhat.com>
References: <20190812052359.30071-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 12 Aug 2019 05:24:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 22/29] Include hw/boards.h a bit less
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw/boards.h pulls in almost 60 headers.  The less we include it into
headers, the better.  As a first step, drop superfluous inclusions,
and downgrade some more to what's actually needed.  Gets rid of just
one inclusion into a header.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/mem/pc-dimm.h        | 1 -
 backends/cryptodev-builtin.c    | 1 -
 backends/cryptodev-vhost-user.c | 1 -
 backends/cryptodev.c            | 1 -
 hw/acpi/ich9.c                  | 1 +
 hw/alpha/dp264.c                | 1 -
 hw/alpha/typhoon.c              | 1 +
 hw/arm/boot.c                   | 1 -
 hw/arm/exynos4210.c             | 2 +-
 hw/arm/fsl-imx25.c              | 1 -
 hw/arm/fsl-imx31.c              | 1 -
 hw/arm/msf2-soc.c               | 1 -
 hw/arm/nrf51_soc.c              | 1 -
 hw/arm/omap1.c                  | 1 +
 hw/arm/omap2.c                  | 1 +
 hw/arm/smmuv3.c                 | 1 -
 hw/arm/virt.c                   | 1 +
 hw/core/numa.c                  | 2 ++
 hw/i386/pc_piix.c               | 1 -
 hw/i386/pc_q35.c                | 1 -
 hw/i386/pc_sysfw.c              | 1 -
 hw/ppc/e500plat.c               | 1 -
 hw/ppc/mpc8544ds.c              | 1 -
 hw/ppc/pnv.c                    | 1 +
 hw/ppc/ppc405_uc.c              | 1 -
 hw/ppc/spapr_cpu_core.c         | 1 -
 hw/ppc/spapr_vio.c              | 1 -
 hw/riscv/boot.c                 | 2 +-
 hw/s390x/s390-stattrib.c        | 1 -
 hw/xtensa/xtensa_memory.c       | 1 -
 monitor/qmp-cmds.c              | 1 -
 target/alpha/machine.c          | 1 -
 target/arm/machine.c            | 1 -
 target/arm/monitor.c            | 1 -
 target/hppa/machine.c           | 1 -
 target/i386/hvf/hvf.c           | 1 -
 target/i386/hvf/x86_task.c      | 1 -
 target/i386/machine.c           | 1 -
 target/i386/whpx-all.c          | 1 -
 target/lm32/machine.c           | 1 -
 target/moxie/machine.c          | 1 -
 target/openrisc/machine.c       | 1 -
 target/ppc/machine.c            | 1 -
 target/sparc/machine.c          | 1 -
 44 files changed, 10 insertions(+), 37 deletions(-)

diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 66dee284ac..47b246f95c 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -19,7 +19,6 @@
 #include "exec/memory.h"
 #include "sysemu/hostmem.h"
 #include "hw/qdev-core.h"
-#include "hw/boards.h"
=20
 #define TYPE_PC_DIMM "pc-dimm"
 #define PC_DIMM(obj) \
diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 9fb0bd57a6..c8ae3b9742 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -23,7 +23,6 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/cryptodev.h"
-#include "hw/boards.h"
 #include "qapi/error.h"
 #include "standard-headers/linux/virtio_crypto.h"
 #include "crypto/cipher.h"
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-u=
ser.c
index 1052a5d0e9..b344283940 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -22,7 +22,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index f35be377ef..3c071eab95 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -23,7 +23,6 @@
=20
 #include "qemu/osdep.h"
 #include "sysemu/cryptodev.h"
-#include "hw/boards.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "qemu/config-file.h"
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 39649cbe6a..c1aaa07d43 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -31,6 +31,7 @@
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
+#include "qom/cpu.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index 546b89bbcc..51feee8558 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -11,7 +11,6 @@
 #include "cpu.h"
 #include "elf.h"
 #include "hw/loader.h"
-#include "hw/boards.h"
 #include "alpha_sys.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index 5d7f8f3342..1c0565acc1 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -11,6 +11,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "hw/boards.h"
 #include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "alpha_sys.h"
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 8563672942..eff89ab80e 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -18,7 +18,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
-#include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "sysemu/device_tree.h"
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 0e403f3e78..a9f8a5c868 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -27,7 +27,7 @@
 #include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/irq.h"
-#include "hw/boards.h"
+#include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 098e84c84d..532d088298 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -28,7 +28,6 @@
 #include "hw/arm/fsl-imx25.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
-#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "chardev/char.h"
=20
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 093ad40984..1a37a7b997 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -25,7 +25,6 @@
 #include "hw/arm/fsl-imx31.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
-#include "hw/boards.h"
 #include "hw/qdev-properties.h"
 #include "chardev/char.h"
=20
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 4e5251c92e..8ae763f99f 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -28,7 +28,6 @@
 #include "exec/address-spaces.h"
 #include "hw/char/serial.h"
 #include "hw/irq.h"
-#include "hw/boards.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
=20
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index fc067cd8ee..d9e54fefbb 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -12,7 +12,6 @@
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
 #include "hw/sysbus.h"
-#include "hw/boards.h"
 #include "hw/misc/unimp.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 19fca4159a..d28ad2b9ff 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -29,6 +29,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/omap.h"
+#include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/soc_dma.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index dccb5707f8..e0a9c2da83 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -22,6 +22,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "cpu.h"
+#include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
 #include "hw/boards.h"
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0634a398d2..0ccc772390 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -17,7 +17,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/boards.h"
 #include "hw/irq.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e9fddec058..226e810d06 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -34,6 +34,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
+#include "hw/boards.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
 #include "hw/arm/virt.h"
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 67548064ee..d817f06ead 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -32,8 +32,10 @@
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-visit-machine.h"
 #include "sysemu/qtest.h"
+#include "qom/cpu.h"
 #include "hw/mem/pc-dimm.h"
 #include "migration/vmstate.h"
+#include "hw/boards.h"
 #include "hw/mem/memory-device.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2fbb581c46..9e187f856a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -35,7 +35,6 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/usb.h"
 #include "net/net.h"
-#include "hw/boards.h"
 #include "hw/ide.h"
 #include "hw/irq.h"
 #include "sysemu/kvm.h"
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8777c9618b..be3464f485 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -33,7 +33,6 @@
 #include "hw/loader.h"
 #include "sysemu/arch_init.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/boards.h"
 #include "hw/timer/mc146818rtc.h"
 #include "hw/xen/xen.h"
 #include "sysemu/kvm.h"
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 235928452b..a9983f0bfb 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -32,7 +32,6 @@
 #include "qemu/units.h"
 #include "hw/sysbus.h"
 #include "hw/i386/pc.h"
-#include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
index 2b82a58592..7078386300 100644
--- a/hw/ppc/e500plat.c
+++ b/hw/ppc/e500plat.c
@@ -13,7 +13,6 @@
 #include "qemu/units.h"
 #include "e500.h"
 #include "hw/net/fsl_etsec/etsec.h"
-#include "hw/boards.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/kvm.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/mpc8544ds.c b/hw/ppc/mpc8544ds.c
index 6a4657c3cd..c2c5e11fa1 100644
--- a/hw/ppc/mpc8544ds.c
+++ b/hw/ppc/mpc8544ds.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "e500.h"
-#include "hw/boards.h"
 #include "sysemu/device_tree.h"
 #include "hw/ppc/openpic.h"
 #include "qemu/error-report.h"
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index cf31830655..fc7d24830a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -45,6 +45,7 @@
 #include "hw/ppc/pnv_xscom.h"
=20
 #include "hw/isa/isa.h"
+#include "hw/boards.h"
 #include "hw/char/serial.h"
 #include "hw/timer/mc146818rtc.h"
=20
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index ba092f2931..381720aced 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -27,7 +27,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "hw/ppc/ppc.h"
-#include "hw/boards.h"
 #include "hw/i2c/ppc4xx_i2c.h"
 #include "hw/irq.h"
 #include "ppc405.h"
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 920bc365ef..bf47fbdf6f 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -14,7 +14,6 @@
 #include "migration/vmstate.h"
 #include "target/ppc/cpu.h"
 #include "hw/ppc/spapr.h"
-#include "hw/boards.h"
 #include "qapi/error.h"
 #include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 31ff0be189..910c57fce5 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -26,7 +26,6 @@
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
-#include "hw/boards.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "hw/sysbus.h"
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 6b7d322e85..4c63b5cf8a 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -22,9 +22,9 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
+#include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/riscv/boot.h"
-#include "hw/boards.h"
 #include "elf.h"
 #include "sysemu/qtest.h"
=20
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 766f2015a4..eda5ca3bb6 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -11,7 +11,6 @@
=20
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/boards.h"
 #include "cpu.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
diff --git a/hw/xtensa/xtensa_memory.c b/hw/xtensa/xtensa_memory.c
index 394d0cf227..40334db441 100644
--- a/hw/xtensa/xtensa_memory.c
+++ b/hw/xtensa/xtensa_memory.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
-#include "hw/boards.h"
 #include "exec/memory.h"
 #include "qemu/error-report.h"
 #include "xtensa_memory.h"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index b9ae40eec7..330558f332 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -35,7 +35,6 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qerror.h"
-#include "hw/boards.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi_dev_interface.h"
=20
diff --git a/target/alpha/machine.c b/target/alpha/machine.c
index b26ec29f0f..9d20169d4f 100644
--- a/target/alpha/machine.c
+++ b/target/alpha/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/boards.h"
 #include "migration/cpu.h"
=20
 static int get_fpcr(QEMUFile *f, void *opaque, size_t size,
diff --git a/target/arm/machine.c b/target/arm/machine.c
index bf2a0a6a09..5c36707a7c 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 6ec6dd04ac..6457c3c87f 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -21,7 +21,6 @@
  */
=20
 #include "qemu/osdep.h"
-#include "hw/boards.h"
 #include "kvm_arm.h"
 #include "qapi/qapi-commands-misc-target.h"
=20
diff --git a/target/hppa/machine.c b/target/hppa/machine.c
index 9fb82a53db..7030101724 100644
--- a/target/hppa/machine.c
+++ b/target/hppa/machine.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/boards.h"
 #include "migration/cpu.h"
=20
 #if TARGET_REGISTER_BITS =3D=3D 64
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index dc4bb63536..6863cf2de4 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -66,7 +66,6 @@
=20
 #include "exec/address-spaces.h"
 #include "hw/i386/apic_internal.h"
-#include "hw/boards.h"
 #include "qemu/main-loop.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 7099335e89..73cd5d2817 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -27,7 +27,6 @@
 #include <Hypervisor/hv_vmx.h>
=20
 #include "hw/i386/apic_internal.h"
-#include "hw/boards.h"
 #include "qemu/main-loop.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
diff --git a/target/i386/machine.c b/target/i386/machine.c
index f8c6feea08..ce55755f0f 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "hw/boards.h"
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index 2cf66f7804..b57d1c6683 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -18,7 +18,6 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
-#include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "migration/blocker.h"
diff --git a/target/lm32/machine.c b/target/lm32/machine.c
index db43ef0631..365eaa2e47 100644
--- a/target/lm32/machine.c
+++ b/target/lm32/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/boards.h"
 #include "migration/cpu.h"
=20
 static const VMStateDescription vmstate_env =3D {
diff --git a/target/moxie/machine.c b/target/moxie/machine.c
index 675272f9e0..d0f177048c 100644
--- a/target/moxie/machine.c
+++ b/target/moxie/machine.c
@@ -1,6 +1,5 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/boards.h"
 #include "machine.h"
 #include "migration/cpu.h"
=20
diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index 99c0470a44..0a96404dc6 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -19,7 +19,6 @@
=20
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/boards.h"
 #include "migration/cpu.h"
=20
 static const VMStateDescription vmstate_tlb_entry =3D {
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index d6638ee60e..109d071162 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "hw/boards.h"
 #include "sysemu/kvm.h"
 #include "helper_regs.h"
 #include "mmu-hash64.h"
diff --git a/target/sparc/machine.c b/target/sparc/machine.c
index 7309c27319..f38cf229af 100644
--- a/target/sparc/machine.c
+++ b/target/sparc/machine.c
@@ -1,7 +1,6 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "hw/boards.h"
 #include "qemu/timer.h"
=20
 #include "migration/cpu.h"
--=20
2.21.0


