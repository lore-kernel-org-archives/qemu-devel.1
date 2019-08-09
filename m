Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708B3C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375CC2085A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 06:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375CC2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvykI-0006UT-HP
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 02:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48284)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hvyg8-0000sG-A3
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hvyg4-0001lQ-1N
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46350)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hvyg3-0001iE-5C
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 02:47:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0DE1530820DD
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:46:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8025060BF4
 for <qemu-devel@nongnu.org>; Fri,  9 Aug 2019 06:46:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F63A1136421; Fri,  9 Aug 2019 08:46:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  9 Aug 2019 08:46:25 +0200
Message-Id: <20190809064645.22656-10-armbru@redhat.com>
In-Reply-To: <20190809064645.22656-1-armbru@redhat.com>
References: <20190809064645.22656-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 09 Aug 2019 06:46:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 09/29] Include migration/qemu-file-types.h a
 lot less
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In my "build everything" tree, changing migration/qemu-file-types.h
triggers a recompile of some 2600 out of 6600 objects (not counting
tests and objects that don't depend on qemu/osdep.h).

The culprit is again hw/hw.h, which supposedly includes it for
convenience.

Include migration/qemu-file-types.h only where it's needed.  Touching
it now recompiles less than 200 objects.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/acpi/piix4.c             | 1 +
 hw/block/virtio-blk.c       | 1 +
 hw/char/virtio-serial-bus.c | 1 +
 hw/display/virtio-gpu.c     | 1 +
 hw/intc/apic_common.c       | 1 +
 hw/intc/s390_flic.c         | 1 +
 hw/nvram/eeprom93xx.c       | 1 +
 hw/nvram/fw_cfg.c           | 1 +
 hw/pci-host/piix.c          | 1 +
 hw/pci/msix.c               | 1 +
 hw/pci/pci.c                | 1 +
 hw/pci/shpc.c               | 1 +
 hw/ppc/spapr.c              | 1 +
 hw/s390x/s390-skeys.c       | 1 +
 hw/s390x/tod.c              | 1 +
 hw/s390x/virtio-ccw.c       | 1 +
 hw/scsi/mptsas.c            | 1 +
 hw/scsi/scsi-bus.c          | 1 +
 hw/scsi/scsi-disk.c         | 1 +
 hw/scsi/scsi-generic.c      | 1 +
 hw/scsi/virtio-scsi.c       | 1 +
 hw/timer/i8254_common.c     | 1 +
 hw/timer/twl92230.c         | 1 +
 hw/usb/redirect.c           | 1 +
 hw/virtio/vhost.c           | 1 +
 hw/virtio/virtio-mmio.c     | 1 +
 hw/virtio/virtio-pci.c      | 1 +
 hw/virtio/virtio.c          | 1 +
 include/hw/hw.h             | 1 -
 include/migration/cpu.h     | 1 +
 target/ppc/kvm.c            | 1 +
 31 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index a59e58d937..0d8c821f37 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -40,6 +40,7 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/acpi_dev_interface.h"
 #include "hw/xen/xen.h"
+#include "migration/qemu-file-types.h"
 #include "qom/cpu.h"
 #include "trace.h"
=20
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index cbb3729158..1f40834d27 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -26,6 +26,7 @@
 # include <scsi/sg.h>
 #endif
 #include "hw/virtio/virtio-bus.h"
+#include "migration/qemu-file-types.h"
 #include "hw/virtio/virtio-access.h"
=20
 /* Config size before the discard support (hide associated config fields=
) */
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index f7a54f261b..b868e54d72 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
+#include "migration/qemu-file-types.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 25d9e327fc..ed92071963 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -18,6 +18,7 @@
 #include "trace.h"
 #include "sysemu/dma.h"
 #include "hw/virtio/virtio.h"
+#include "migration/qemu-file-types.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-gpu-bswap.h"
 #include "hw/virtio/virtio-gpu-pixman.h"
diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index e764a2bb03..7045761281 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -31,6 +31,7 @@
 #include "sysemu/kvm.h"
 #include "hw/qdev.h"
 #include "hw/sysbus.h"
+#include "migration/qemu-file-types.h"
=20
 static int apic_irq_delivered;
 bool apic_report_tpr_access;
diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
index d0be755c82..83c72ee18d 100644
--- a/hw/intc/s390_flic.c
+++ b/hw/intc/s390_flic.c
@@ -22,6 +22,7 @@
 #include "hw/qdev.h"
 #include "qapi/error.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "migration/qemu-file-types.h"
=20
 S390FLICStateClass *s390_get_flic_class(S390FLICState *fs)
 {
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 2db3d7cce6..5fc23df1d4 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -38,6 +38,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/nvram/eeprom93xx.h"
+#include "migration/qemu-file-types.h"
=20
 /* Debug EEPROM emulation. */
 //~ #define DEBUG_EEPROM
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 3032f1c65f..8db0297d59 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -31,6 +31,7 @@
 #include "hw/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/sysbus.h"
+#include "migration/qemu-file-types.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index f3671d28b7..e5955457ab 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -32,6 +32,7 @@
 #include "qapi/error.h"
 #include "qemu/range.h"
 #include "hw/xen/xen.h"
+#include "migration/qemu-file-types.h"
 #include "hw/pci-host/pam.h"
 #include "sysemu/reset.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index d39dcf32e8..ebe804b473 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -20,6 +20,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
 #include "hw/xen/xen.h"
+#include "migration/qemu-file-types.h"
 #include "qemu/range.h"
 #include "qapi/error.h"
 #include "trace.h"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8076a80ab3..43a3cac138 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -29,6 +29,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_host.h"
+#include "migration/qemu-file-types.h"
 #include "monitor/monitor.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 5a10c6e9a5..7f0aa28e44 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -4,6 +4,7 @@
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "hw/pci/shpc.h"
+#include "migration/qemu-file-types.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/msi.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5cade1a374..76e815ceee 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -42,6 +42,7 @@
 #include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
 #include "migration/misc.h"
+#include "migration/qemu-file-types.h"
 #include "migration/global_state.h"
 #include "migration/register.h"
 #include "mmu-hash64.h"
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index e5bd92c0c7..d4807f7777 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -18,6 +18,7 @@
 #include "qapi/qmp/qdict.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "migration/qemu-file-types.h"
 #include "migration/register.h"
=20
 #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage key=
s */
diff --git a/hw/s390x/tod.c b/hw/s390x/tod.c
index a9fca8eb0b..1bf0875afa 100644
--- a/hw/s390x/tod.c
+++ b/hw/s390x/tod.c
@@ -14,6 +14,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
+#include "migration/qemu-file-types.h"
 #include "migration/register.h"
=20
 void s390_init_tod(void)
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 43d3a1b029..fa537bfba3 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -17,6 +17,7 @@
 #include "sysemu/kvm.h"
 #include "net/net.h"
 #include "hw/virtio/virtio.h"
+#include "migration/qemu-file-types.h"
 #include "hw/virtio/virtio-net.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index 3f94d5ab55..6d2c15a2bc 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -34,6 +34,7 @@
 #include "trace.h"
 #include "qapi/error.h"
 #include "mptsas.h"
+#include "migration/qemu-file-types.h"
 #include "mpi.h"
=20
 #define NAA_LOCALLY_ASSIGNED_ID 0x3ULL
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index fdc3a0e4e0..81fe7c3301 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -5,6 +5,7 @@
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "hw/scsi/scsi.h"
+#include "migration/qemu-file-types.h"
 #include "scsi/constants.h"
 #include "hw/qdev.h"
 #include "sysemu/block-backend.h"
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index af3e622dc5..558fa11511 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -25,6 +25,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
+#include "migration/qemu-file-types.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index c11a0c9a84..44430b6ea6 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -17,6 +17,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/scsi/scsi.h"
+#include "migration/qemu-file-types.h"
 #include "hw/scsi/emulation.h"
 #include "sysemu/block-backend.h"
 #include "trace.h"
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 8b9e5e2b49..a6d61aacdb 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "standard-headers/linux/virtio_ids.h"
 #include "hw/virtio/virtio-scsi.h"
+#include "migration/qemu-file-types.h"
 #include "qemu/error-report.h"
 #include "qemu/iov.h"
 #include "qemu/module.h"
diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
index 76ca6ec444..3e980f2dee 100644
--- a/hw/timer/i8254_common.c
+++ b/hw/timer/i8254_common.c
@@ -30,6 +30,7 @@
 #include "qemu/timer.h"
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
+#include "migration/qemu-file-types.h"
=20
 /* val must be 0 or 1 */
 void pit_set_gate(ISADevice *dev, int channel, int val)
diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
index 0ef4fc1fc1..91ae7bf203 100644
--- a/hw/timer/twl92230.c
+++ b/hw/timer/twl92230.c
@@ -24,6 +24,7 @@
 #include "hw/hw.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
+#include "migration/qemu-file-types.h"
 #include "sysemu/sysemu.h"
 #include "ui/console.h"
 #include "qemu/bcd.h"
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index 998fc6e4b0..846e60f3bb 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -41,6 +41,7 @@
 #include <usbredirfilter.h>
=20
 #include "hw/usb.h"
+#include "migration/qemu-file-types.h"
=20
 /* ERROR is defined below. Remove any previous definition. */
 #undef ERROR
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index bc899fc60e..ba1006ad96 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -26,6 +26,7 @@
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
+#include "migration/qemu-file-types.h"
 #include "sysemu/dma.h"
 #include "trace.h"
=20
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 97b7f35496..d4c0997074 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -23,6 +23,7 @@
 #include "standard-headers/linux/virtio_mmio.h"
 #include "hw/sysbus.h"
 #include "hw/virtio/virtio.h"
+#include "migration/qemu-file-types.h"
 #include "qemu/host-utils.h"
 #include "qemu/module.h"
 #include "sysemu/kvm.h"
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f6d2223e78..1117f2347b 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -19,6 +19,7 @@
=20
 #include "standard-headers/linux/virtio_pci.h"
 #include "hw/virtio/virtio.h"
+#include "migration/qemu-file-types.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "qapi/error.h"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a94ea18a9c..79c7a910cc 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -19,6 +19,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/virtio/virtio.h"
+#include "migration/qemu-file-types.h"
 #include "qemu/atomic.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
diff --git a/include/hw/hw.h b/include/hw/hw.h
index a4fb2390e8..b399627cbe 100644
--- a/include/hw/hw.h
+++ b/include/hw/hw.h
@@ -11,7 +11,6 @@
 #include "exec/memory.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
-#include "migration/qemu-file-types.h"
=20
 void QEMU_NORETURN hw_error(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
=20
diff --git a/include/migration/cpu.h b/include/migration/cpu.h
index da1618d620..2a22470d0d 100644
--- a/include/migration/cpu.h
+++ b/include/migration/cpu.h
@@ -4,6 +4,7 @@
 #define MIGRATION_CPU_H
=20
 #include "exec/cpu-defs.h"
+#include "migration/qemu-file-types.h"
=20
 #if TARGET_LONG_BITS =3D=3D 64
 #define qemu_put_betl qemu_put_be64
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8a06d3171e..4bd95be9cd 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -38,6 +38,7 @@
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_cpu_core.h"
 #include "hw/ppc/ppc.h"
+#include "migration/qemu-file-types.h"
 #include "sysemu/watchdog.h"
 #include "trace.h"
 #include "exec/gdbstub.h"
--=20
2.21.0


