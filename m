Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D29C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:23:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB0B21670
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 15:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB0B21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkrxa-0003Ma-Hw
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 11:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43293)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkrvV-0001SL-5W
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkrvR-0006xK-6x
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55100)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkrvP-0006w5-4f
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 11:21:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1556C2EED0C;
 Tue,  9 Jul 2019 15:20:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D270679582;
 Tue,  9 Jul 2019 15:20:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 65DCE1138660; Tue,  9 Jul 2019 17:20:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 17:20:52 +0200
Message-Id: <20190709152053.16670-2-armbru@redhat.com>
In-Reply-To: <20190709152053.16670-1-armbru@redhat.com>
References: <20190709152053.16670-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 09 Jul 2019 15:20:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] hw/core: Move cpu.c,
 cpu.h from qom/ to hw/core/
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                    | 6 ++----
 accel/tcg/user-exec-stub.c     | 2 +-
 cpus-common.c                  | 2 +-
 hw/acpi/cpu_hotplug.c          | 2 +-
 hw/acpi/piix4.c                | 2 +-
 hw/arm/smmu-common.c           | 2 +-
 hw/arm/virt-acpi-build.c       | 2 +-
 hw/core/Makefile.objs          | 1 +
 {qom =3D> hw/core}/cpu.c         | 2 +-
 hw/core/generic-loader.c       | 2 +-
 hw/core/null-machine.c         | 2 +-
 hw/cpu/a9mpcore.c              | 2 +-
 hw/cpu/cluster.c               | 2 +-
 hw/i386/acpi-build.c           | 2 +-
 hw/i386/pc.c                   | 2 +-
 hw/intc/arm_gic.c              | 2 +-
 hw/intc/arm_gicv3_common.c     | 2 +-
 hw/isa/lpc_ich9.c              | 2 +-
 hw/misc/imx6_src.c             | 2 +-
 hw/ppc/spapr.c                 | 2 +-
 hw/timer/a9gtimer.c            | 2 +-
 hw/timer/arm_mptimer.c         | 2 +-
 include/exec/cpu-all.h         | 2 +-
 include/exec/cpu-defs.h        | 2 +-
 include/exec/log.h             | 2 +-
 include/hw/boards.h            | 2 +-
 include/{qom =3D> hw/core}/cpu.h | 0
 include/hw/ppc/openpic.h       | 2 +-
 include/sysemu/hw_accel.h      | 2 +-
 include/sysemu/kvm.h           | 2 +-
 qom/Makefile.objs              | 1 -
 target/alpha/cpu-qom.h         | 2 +-
 target/arm/cpu-qom.h           | 2 +-
 target/cris/cpu-qom.h          | 2 +-
 target/hppa/cpu-qom.h          | 2 +-
 target/hppa/int_helper.c       | 2 +-
 target/hppa/mem_helper.c       | 2 +-
 target/i386/cpu-qom.h          | 2 +-
 target/lm32/cpu-qom.h          | 2 +-
 target/m68k/cpu-qom.h          | 2 +-
 target/microblaze/cpu-qom.h    | 2 +-
 target/mips/cpu-qom.h          | 2 +-
 target/moxie/cpu.h             | 2 +-
 target/nios2/cpu.h             | 2 +-
 target/openrisc/cpu.h          | 2 +-
 target/ppc/cpu-qom.h           | 2 +-
 target/riscv/cpu.h             | 2 +-
 target/s390x/cpu-qom.h         | 2 +-
 target/s390x/cpu_models.h      | 2 +-
 target/sh4/cpu-qom.h           | 2 +-
 target/sparc/cpu-qom.h         | 2 +-
 target/tilegx/cpu.h            | 2 +-
 target/tricore/cpu-qom.h       | 2 +-
 target/unicore32/cpu-qom.h     | 2 +-
 target/xtensa/cpu-qom.h        | 2 +-
 trace/control-internal.h       | 2 +-
 ui/cocoa.m                     | 2 +-
 57 files changed, 56 insertions(+), 58 deletions(-)
 rename {qom =3D> hw/core}/cpu.c (99%)
 rename include/{qom =3D> hw/core}/cpu.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc9636b43a..4c687d88d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1274,6 +1274,7 @@ Machine core
 M: Eduardo Habkost <ehabkost@redhat.com>
 M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
+F: hw/core/cpu.c
 F: hw/core/machine-qmp-cmds.c
 F: hw/core/machine.c
 F: hw/core/null-machine.c
@@ -1281,10 +1282,9 @@ F: hw/core/numa.c
 F: hw/cpu/cluster.c
 F: qapi/machine.json
 F: qapi/machine-target.json
-F: qom/cpu.c
 F: include/hw/boards.h
+F: include/hw/core/cpu.h
 F: include/hw/cpu/cluster.h
-F: include/qom/cpu.h
 F: include/sysemu/numa.h
 T: git https://github.com/ehabkost/qemu.git machine-next
=20
@@ -2046,12 +2046,10 @@ F: hw/core/qdev*
 F: include/hw/qdev*
 F: include/monitor/qdev.h
 F: include/qom/
-X: include/qom/cpu.h
 F: qapi/qom.json
 F: qapi/qdev.json
 F: qdev-monitor.c
 F: qom/
-X: qom/cpu.c
 F: tests/check-qom-interface.c
 F: tests/check-qom-proplist.c
 F: tests/test-qdev-global-props.c
diff --git a/accel/tcg/user-exec-stub.c b/accel/tcg/user-exec-stub.c
index 4bf00b8496..f6d8c8fb6f 100644
--- a/accel/tcg/user-exec-stub.c
+++ b/accel/tcg/user-exec-stub.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "sysemu/replay.h"
 #include "sysemu/sysemu.h"
=20
diff --git a/cpus-common.c b/cpus-common.c
index 3ca58c64e8..e742658e75 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu-common.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "sysemu/cpus.h"
=20
 static QemuMutex qemu_cpu_list_lock;
diff --git a/hw/acpi/cpu_hotplug.c b/hw/acpi/cpu_hotplug.c
index 5243918125..92b2c09f5a 100644
--- a/hw/acpi/cpu_hotplug.c
+++ b/hw/acpi/cpu_hotplug.c
@@ -13,7 +13,7 @@
 #include "hw/hw.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "qapi/error.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "hw/i386/pc.h"
 #include "qemu/error-report.h"
=20
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index ec4e186cec..16d113a676 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -38,7 +38,7 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/xen/xen.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "trace.h"
=20
 #define GPE_BASE 0xafe0
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 717d22bcbe..c7d7d0fee1 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -21,7 +21,7 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
 #include "exec/target_page.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/jhash.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 0afb372769..c3a6e98cd7 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -30,7 +30,7 @@
 #include "qapi/error.h"
 #include "qemu/bitmap.h"
 #include "trace.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8481d959f..1421a73df6 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -8,6 +8,7 @@ common-obj-y +=3D irq.o
 common-obj-y +=3D hotplug.o
 common-obj-$(CONFIG_SOFTMMU) +=3D nmi.o
 common-obj-$(CONFIG_SOFTMMU) +=3D vm-change-state-handler.o
+common-obj-y +=3D cpu.o
=20
 common-obj-$(CONFIG_EMPTY_SLOT) +=3D empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) +=3D stream.o
diff --git a/qom/cpu.c b/hw/core/cpu.c
similarity index 99%
rename from qom/cpu.c
rename to hw/core/cpu.c
index f376f782d8..f3ceac8500 100644
--- a/qom/cpu.c
+++ b/hw/core/cpu.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/notify.h"
 #include "qemu/log.h"
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 79a493e577..eb963e2a32 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -31,7 +31,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "hw/sysbus.h"
 #include "sysemu/dma.h"
 #include "hw/loader.h"
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 04a1e2b02a..194dac56fd 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -17,7 +17,7 @@
 #include "hw/boards.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 static void machine_none_init(MachineState *mch)
 {
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 187e4d939e..71103485c5 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -12,7 +12,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/cpu/a9mpcore.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 static void a9mp_priv_set_irq(void *opaque, int irq, int level)
 {
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 6f5f037b3c..c9a02fbbaf 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -20,7 +20,7 @@
=20
 #include "qemu/osdep.h"
 #include "hw/cpu/cluster.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/cutils.h"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d281ffa89e..5b25f256dd 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -27,7 +27,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "target/i386/cpu.h"
 #include "hw/misc/pvpanic.h"
 #include "hw/timer/hpet.h"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c33ce47578..599658b83a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,7 +73,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "hw/nmi.h"
 #include "hw/usb.h"
 #include "hw/i386/intel_iommu.h"
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 77427a4188..1a4a559925 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -22,7 +22,7 @@
 #include "hw/sysbus.h"
 #include "gic_internal.h"
 #include "qapi/error.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 5edabb928f..49edb08f3c 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index a7081bd52d..a54f8c6cad 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -45,7 +45,7 @@
 #include "hw/pci/pci_bus.h"
 #include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/cutils.h"
=20
diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 878ffcdc71..c1d0c614ef 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -15,7 +15,7 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "arm-powerctl.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #ifndef DEBUG_IMX6_SRC
 #define DEBUG_IMX6_SRC 0
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 821f0d4a49..e46d52224b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -46,7 +46,7 @@
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 #include "cpu-models.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #include "hw/boards.h"
 #include "hw/ppc/ppc.h"
diff --git a/hw/timer/a9gtimer.c b/hw/timer/a9gtimer.c
index 09e2a7b7bf..d35dd61696 100644
--- a/hw/timer/a9gtimer.c
+++ b/hw/timer/a9gtimer.c
@@ -27,7 +27,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #ifndef A9_GTIMER_ERR_DEBUG
 #define A9_GTIMER_ERR_DEBUG 0
diff --git a/hw/timer/arm_mptimer.c b/hw/timer/arm_mptimer.c
index 93044aacfd..75ebf047b8 100644
--- a/hw/timer/arm_mptimer.c
+++ b/hw/timer/arm_mptimer.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define PTIMER_POLICY                       \
     (PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |  \
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 536ea58f81..8323094648 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -22,7 +22,7 @@
 #include "exec/cpu-common.h"
 #include "exec/memory.h"
 #include "qemu/thread.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "qemu/rcu.h"
=20
 #define EXCP_INTERRUPT 	0x10000 /* async interruption */
diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 9bc713a70b..1b06865a24 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -33,7 +33,7 @@
 #include "exec/hwaddr.h"
 #endif
 #include "exec/memattrs.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #include "cpu-param.h"
=20
diff --git a/include/exec/log.h b/include/exec/log.h
index de067f173b..e2cfd436e6 100644
--- a/include/exec/log.h
+++ b/include/exec/log.h
@@ -2,7 +2,7 @@
 #define QEMU_EXEC_LOG_H
=20
 #include "qemu/log.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "disas/disas.h"
=20
 /* cpu_dump_state() logging functions: */
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a71d1a53a5..07a848cb10 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -9,7 +9,7 @@
 #include "qapi/qapi-types-machine.h"
 #include "qemu/module.h"
 #include "qom/object.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 /**
  * memory_region_allocate_system_memory - Allocate a board's main memory
diff --git a/include/qom/cpu.h b/include/hw/core/cpu.h
similarity index 100%
rename from include/qom/cpu.h
rename to include/hw/core/cpu.h
diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
index 7642a8ea1d..6931e7ccc4 100644
--- a/include/hw/ppc/openpic.h
+++ b/include/hw/ppc/openpic.h
@@ -3,7 +3,7 @@
=20
 #include "hw/sysbus.h"
 #include "hw/qdev-core.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define MAX_CPU     32
 #define MAX_MSI     8
diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
index d2ddfb5ad0..0ec2372477 100644
--- a/include/sysemu/hw_accel.h
+++ b/include/sysemu/hw_accel.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_HW_ACCEL_H
 #define QEMU_HW_ACCEL_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "sysemu/hax.h"
 #include "sysemu/kvm.h"
 #include "sysemu/whpx.h"
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index acd90aebb6..9e6b485945 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -15,7 +15,7 @@
 #define QEMU_KVM_H
=20
 #include "qemu/queue.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "exec/memattrs.h"
 #include "hw/irq.h"
=20
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index aae478fc21..f9d77350ac 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -1,5 +1,4 @@
 qom-obj-y =3D object.o container.o qom-qobject.o
 qom-obj-y +=3D object_interfaces.o
=20
-common-obj-y =3D cpu.o
 common-obj-$(CONFIG_SOFTMMU) +=3D qom-hmp-cmds.o qom-qmp-cmds.o
diff --git a/target/alpha/cpu-qom.h b/target/alpha/cpu-qom.h
index bae4945344..6f0a0adb9e 100644
--- a/target/alpha/cpu-qom.h
+++ b/target/alpha/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_ALPHA_CPU_QOM_H
 #define QEMU_ALPHA_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_ALPHA_CPU "alpha-cpu"
=20
diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 2049fa9612..7f5b244bde 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_ARM_CPU_QOM_H
 #define QEMU_ARM_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 struct arm_boot_info;
=20
diff --git a/target/cris/cpu-qom.h b/target/cris/cpu-qom.h
index 7556e9f97e..308c1f95bd 100644
--- a/target/cris/cpu-qom.h
+++ b/target/cris/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_CRIS_CPU_QOM_H
 #define QEMU_CRIS_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_CRIS_CPU "cris-cpu"
=20
diff --git a/target/hppa/cpu-qom.h b/target/hppa/cpu-qom.h
index 9084e4701d..6367dc4793 100644
--- a/target/hppa/cpu-qom.h
+++ b/target/hppa/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_HPPA_CPU_QOM_H
 #define QEMU_HPPA_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_HPPA_CPU "hppa-cpu"
=20
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index 89241c31e7..462747baf8 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -22,7 +22,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "exec/helper-proto.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #ifndef CONFIG_USER_ONLY
 static void eval_interrupt(HPPACPU *cpu)
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index b12c5b5054..5a465db0dd 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "trace.h"
=20
 #ifdef CONFIG_USER_ONLY
diff --git a/target/i386/cpu-qom.h b/target/i386/cpu-qom.h
index 1a52f02a4c..0efab2fc67 100644
--- a/target/i386/cpu-qom.h
+++ b/target/i386/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_I386_CPU_QOM_H
 #define QEMU_I386_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "qemu/notify.h"
=20
 #ifdef TARGET_X86_64
diff --git a/target/lm32/cpu-qom.h b/target/lm32/cpu-qom.h
index b423d2564b..dc9ac9ac9f 100644
--- a/target/lm32/cpu-qom.h
+++ b/target/lm32/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_LM32_CPU_QOM_H
 #define QEMU_LM32_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_LM32_CPU "lm32-cpu"
=20
diff --git a/target/m68k/cpu-qom.h b/target/m68k/cpu-qom.h
index 0c157251a2..b56da8a213 100644
--- a/target/m68k/cpu-qom.h
+++ b/target/m68k/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_M68K_CPU_QOM_H
 #define QEMU_M68K_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_M68K_CPU "m68k-cpu"
=20
diff --git a/target/microblaze/cpu-qom.h b/target/microblaze/cpu-qom.h
index 1a61db77d0..49b07cc697 100644
--- a/target/microblaze/cpu-qom.h
+++ b/target/microblaze/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_MICROBLAZE_CPU_QOM_H
 #define QEMU_MICROBLAZE_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_MICROBLAZE_CPU "microblaze-cpu"
=20
diff --git a/target/mips/cpu-qom.h b/target/mips/cpu-qom.h
index ee58606afe..a430c0fe4b 100644
--- a/target/mips/cpu-qom.h
+++ b/target/mips/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_MIPS_CPU_QOM_H
 #define QEMU_MIPS_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #ifdef TARGET_MIPS64
 #define TYPE_MIPS_CPU "mips64-cpu"
diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
index 91ef2dc25e..01dca548e5 100644
--- a/target/moxie/cpu.h
+++ b/target/moxie/cpu.h
@@ -46,7 +46,7 @@ typedef struct CPUMoxieState {
     struct {} end_reset_fields;
 } CPUMoxieState;
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_MOXIE_CPU "moxie-cpu"
=20
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 5d44b76389..361b06ffeb 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -22,7 +22,7 @@
 #define NIOS2_CPU_H
=20
 #include "exec/cpu-defs.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 typedef struct CPUNios2State CPUNios2State;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index f23b25262d..b4312c9dbb 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -21,7 +21,7 @@
 #define OPENRISC_CPU_H
=20
 #include "exec/cpu-defs.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 /* cpu_openrisc_map_address_* in CPUOpenRISCTLBContext need this decl.  =
*/
 struct OpenRISCCPU;
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index be9b4c30c3..e7e7c4d1bf 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_PPC_CPU_QOM_H
 #define QEMU_PPC_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #ifdef TARGET_PPC64
 #define TYPE_POWERPC_CPU "powerpc64-cpu"
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0adb307f32..a97d01a07c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -20,7 +20,7 @@
 #ifndef RISCV_CPU_H
 #define RISCV_CPU_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
 #include "fpu/softfloat.h"
=20
diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index b46217dc31..b809ec8418 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_S390_CPU_QOM_H
 #define QEMU_S390_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_S390_CPU "s390x-cpu"
=20
diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
index 174a99e561..88bd01a616 100644
--- a/target/s390x/cpu_models.h
+++ b/target/s390x/cpu_models.h
@@ -15,7 +15,7 @@
=20
 #include "cpu_features.h"
 #include "gen-features.h"
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 /* static CPU definition */
 struct S390CPUDef {
diff --git a/target/sh4/cpu-qom.h b/target/sh4/cpu-qom.h
index 0f9fb4dd31..0c56d055ba 100644
--- a/target/sh4/cpu-qom.h
+++ b/target/sh4/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_SUPERH_CPU_QOM_H
 #define QEMU_SUPERH_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_SUPERH_CPU "superh-cpu"
=20
diff --git a/target/sparc/cpu-qom.h b/target/sparc/cpu-qom.h
index af6d57a9e0..7442e2768e 100644
--- a/target/sparc/cpu-qom.h
+++ b/target/sparc/cpu-qom.h
@@ -20,7 +20,7 @@
 #ifndef QEMU_SPARC_CPU_QOM_H
 #define QEMU_SPARC_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #ifdef TARGET_SPARC64
 #define TYPE_SPARC_CPU "sparc64-cpu"
diff --git a/target/tilegx/cpu.h b/target/tilegx/cpu.h
index 6fcec06a9b..9cbec247d2 100644
--- a/target/tilegx/cpu.h
+++ b/target/tilegx/cpu.h
@@ -94,7 +94,7 @@ typedef struct CPUTLGState {
     struct {} end_reset_fields;
 } CPUTLGState;
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_TILEGX_CPU "tilegx-cpu"
=20
diff --git a/target/tricore/cpu-qom.h b/target/tricore/cpu-qom.h
index 93c9d77fe3..7c1e130b4e 100644
--- a/target/tricore/cpu-qom.h
+++ b/target/tricore/cpu-qom.h
@@ -18,7 +18,7 @@
 #ifndef QEMU_TRICORE_CPU_QOM_H
 #define QEMU_TRICORE_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
=20
 #define TYPE_TRICORE_CPU "tricore-cpu"
diff --git a/target/unicore32/cpu-qom.h b/target/unicore32/cpu-qom.h
index bc68e78045..7dd04515cb 100644
--- a/target/unicore32/cpu-qom.h
+++ b/target/unicore32/cpu-qom.h
@@ -11,7 +11,7 @@
 #ifndef QEMU_UC32_CPU_QOM_H
 #define QEMU_UC32_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_UNICORE32_CPU "unicore32-cpu"
=20
diff --git a/target/xtensa/cpu-qom.h b/target/xtensa/cpu-qom.h
index 403bd95721..9ac54241bd 100644
--- a/target/xtensa/cpu-qom.h
+++ b/target/xtensa/cpu-qom.h
@@ -29,7 +29,7 @@
 #ifndef QEMU_XTENSA_CPU_QOM_H
 #define QEMU_XTENSA_CPU_QOM_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #define TYPE_XTENSA_CPU "xtensa-cpu"
=20
diff --git a/trace/control-internal.h b/trace/control-internal.h
index c7fbe2d3bf..fe104b6f36 100644
--- a/trace/control-internal.h
+++ b/trace/control-internal.h
@@ -10,7 +10,7 @@
 #ifndef TRACE__CONTROL_INTERNAL_H
 #define TRACE__CONTROL_INTERNAL_H
=20
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
=20
 extern int trace_events_enabled_count;
diff --git a/ui/cocoa.m b/ui/cocoa.m
index c2984028c5..41ceb94bfc 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -38,7 +38,7 @@
 #include "qemu-version.h"
 #include "qemu/module.h"
 #include <Carbon/Carbon.h>
-#include "qom/cpu.h"
+#include "hw/core/cpu.h"
=20
 #ifndef MAC_OS_X_VERSION_10_5
 #define MAC_OS_X_VERSION_10_5 1050
--=20
2.21.0


