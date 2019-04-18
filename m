Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0050C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B632E214C6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B632E214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46940 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDpv-0005y5-06
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:40:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDo0-0001Sp-3x
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnw-0002gE-V7
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHDnw-0002eM-L4
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E506FC053B34
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 68AC85D70A
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 827131132B3B; Thu, 18 Apr 2019 22:38:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:38:37 +0200
Message-Id: <20190418203840.10528-7-armbru@redhat.com>
In-Reply-To: <20190418203840.10528-1-armbru@redhat.com>
References: <20190418203840.10528-1-armbru@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 18 Apr 2019 20:38:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 6/9] Clean up header guards that don't
 match their file name
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418203837.COPwnBiSXUa95-JdTVBQ_snYTRLV_zRPrAbsx3mBKqY@z>

Header guard symbols should match their file name to make guard
collisions less likely.

Cleaned up with scripts/clean-header-guards.pl, followed by some
renaming of new guard symbols picked by the script to better ones.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190315145123.28030-6-armbru@redhat.com>
---
 contrib/elf2dmp/qemu_elf.h            | 6 +++---
 disas/nanomips.h                      | 4 ++--
 fsdev/qemu-fsdev-throttle.h           | 7 ++++---
 hw/arm/smmuv3-internal.h              | 4 ++--
 hw/display/vga_regs.h                 | 6 +++---
 hw/rdma/vmw/pvrdma_qp_ops.h           | 4 ++--
 hw/sd/sdmmc-internal.h                | 5 +++--
 include/authz/listfile.h              | 8 +++-----
 include/authz/pamacct.h               | 7 +++----
 include/hw/audio/soundhw.h            | 4 ++--
 include/hw/i386/x86-iommu.h           | 4 ++--
 include/hw/intc/heathrow_pic.h        | 6 +++---
 include/hw/intc/xlnx-pmu-iomod-intc.h | 6 +++---
 include/hw/misc/armsse-mhu.h          | 4 ++--
 include/hw/pci-host/sabre.h           | 4 ++--
 include/hw/watchdog/wdt_aspeed.h      | 7 ++++---
 include/hw/xen/xen-legacy-backend.h   | 6 +++---
 include/hw/xtensa/xtensa-isa.h        | 6 +++---
 include/migration/qemu-file-types.h   | 4 ++--
 include/qemu/filemonitor.h            | 6 +++---
 include/scsi/constants.h              | 4 ++--
 net/colo.h                            | 6 +++---
 target/i386/hax-posix.h               | 6 +++---
 target/i386/hvf/x86_task.h            | 6 ++++--
 target/nios2/cpu.h                    | 7 ++++---
 target/nios2/mmu.h                    | 7 ++++---
 target/ppc/mmu-book3s-v3.h            | 6 +++---
 tests/libqos/qgraph_internal.h        | 4 ++--
 tests/migration/migration-test.h      | 7 ++++---
 29 files changed, 83 insertions(+), 78 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index 2a7963821a..66ee1f0ed5 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -5,8 +5,8 @@
  *
  */
 
-#ifndef ELF2DMP_ELF_H
-#define ELF2DMP_ELF_H
+#ifndef EMPF2DMP_QEMU_ELF_H
+#define EMPF2DMP_QEMU_ELF_H
 
 #include "elf.h"
 
@@ -47,4 +47,4 @@ void QEMU_Elf_exit(QEMU_Elf *qe);
 Elf64_Phdr *elf64_getphdr(void *map);
 Elf64_Half elf_getphdrnum(void *map);
 
-#endif /* ELF2DMP_ELF_H */
+#endif /* ELF2DMP_QEMU_ELF_H */
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 243c3e38d2..a0a2225301 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -20,8 +20,8 @@
  *
  */
 
-#ifndef NANOMIPS_DISASSEMBLER_H
-#define NANOMIPS_DISASSEMBLER_H
+#ifndef DISAS_NANOMIPS_H
+#define DISAS_NANOMIPS_H
 
 #include <string>
 
diff --git a/fsdev/qemu-fsdev-throttle.h b/fsdev/qemu-fsdev-throttle.h
index 4e83bdac25..7d6211d499 100644
--- a/fsdev/qemu-fsdev-throttle.h
+++ b/fsdev/qemu-fsdev-throttle.h
@@ -12,8 +12,8 @@
  *
  */
 
-#ifndef _FSDEV_THROTTLE_H
-#define _FSDEV_THROTTLE_H
+#ifndef QEMU_FSDEV_THROTTLE_H
+#define QEMU_FSDEV_THROTTLE_H
 
 #include "block/aio.h"
 #include "qemu/main-loop.h"
@@ -35,4 +35,5 @@ void coroutine_fn fsdev_co_throttle_request(FsThrottle *, bool ,
                                             struct iovec *, int);
 
 void fsdev_throttle_cleanup(FsThrottle *);
-#endif /* _FSDEV_THROTTLE_H */
+
+#endif /* QEMU_FSDEV_THROTTLE_H */
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 19540f8f41..b160289cd1 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -18,8 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef HW_ARM_SMMU_V3_INTERNAL_H
-#define HW_ARM_SMMU_V3_INTERNAL_H
+#ifndef HW_ARM_SMMUV3_INTERNAL_H
+#define HW_ARM_SMMUV3_INTERNAL_H
 
 #include "hw/arm/smmu-common.h"
 
diff --git a/hw/display/vga_regs.h b/hw/display/vga_regs.h
index 16886f5eed..30a98b8736 100644
--- a/hw/display/vga_regs.h
+++ b/hw/display/vga_regs.h
@@ -14,8 +14,8 @@
  *
  */
 
-#ifndef LINUX_VIDEO_VGA_H
-#define LINUX_VIDEO_VGA_H
+#ifndef HW_VGA_REGS_H
+#define HW_VGA_REGS_H
 
 /* Some of the code below is taken from SVGAlib.  The original,
    unmodified copyright notice for that code is below. */
@@ -156,4 +156,4 @@
 /* VGA graphics controller bit masks */
 #define VGA_GR06_GRAPHICS_MODE  0x01
 
-#endif /* LINUX_VIDEO_VGA_H */
+#endif /* HW_VGA_REGS_H */
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.h b/hw/rdma/vmw/pvrdma_qp_ops.h
index 31cb48ba29..3a76a59c87 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.h
+++ b/hw/rdma/vmw/pvrdma_qp_ops.h
@@ -13,8 +13,8 @@
  *
  */
 
-#ifndef PVRDMA_QP_H
-#define PVRDMA_QP_H
+#ifndef PVRDMA_QP_OPS_H
+#define PVRDMA_QP_OPS_H
 
 #include "pvrdma.h"
 
diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
index 9aa04766fc..d8bf17d204 100644
--- a/hw/sd/sdmmc-internal.h
+++ b/hw/sd/sdmmc-internal.h
@@ -7,8 +7,9 @@
  * See the COPYING file in the top-level directory.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
-#ifndef SD_INTERNAL_H
-#define SD_INTERNAL_H
+
+#ifndef SDMMC_INTERNAL_H
+#define SDMMC_INTERNAL_H
 
 #define SDMMC_CMD_MAX 64
 
diff --git a/include/authz/listfile.h b/include/authz/listfile.h
index 0d618c903c..33b728d873 100644
--- a/include/authz/listfile.h
+++ b/include/authz/listfile.h
@@ -18,8 +18,8 @@
  *
  */
 
-#ifndef QAUTHZ_LIST_FILE_H__
-#define QAUTHZ_LIST_FILE_H__
+#ifndef QAUTHZ_LISTFILE_H
+#define QAUTHZ_LISTFILE_H
 
 #include "authz/list.h"
 #include "qapi/qapi-types-authz.h"
@@ -106,6 +106,4 @@ QAuthZListFile *qauthz_list_file_new(const char *id,
                                      bool refresh,
                                      Error **errp);
 
-
-#endif /* QAUTHZ_LIST_FILE_H__ */
-
+#endif /* QAUTHZ_LISTFILE_H */
diff --git a/include/authz/pamacct.h b/include/authz/pamacct.h
index cad5b11d47..f3a7ef1011 100644
--- a/include/authz/pamacct.h
+++ b/include/authz/pamacct.h
@@ -18,8 +18,8 @@
  *
  */
 
-#ifndef QAUTHZ_PAM_H__
-#define QAUTHZ_PAM_H__
+#ifndef QAUTHZ_PAMACCT_H
+#define QAUTHZ_PAMACCT_H
 
 #include "authz/base.h"
 
@@ -96,5 +96,4 @@ QAuthZPAM *qauthz_pam_new(const char *id,
                           const char *service,
                           Error **errp);
 
-
-#endif /* QAUTHZ_PAM_H__ */
+#endif /* QAUTHZ_PAMACCT_H */
diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
index 119f7d78d5..c8eef82418 100644
--- a/include/hw/audio/soundhw.h
+++ b/include/hw/audio/soundhw.h
@@ -1,5 +1,5 @@
-#ifndef HW_AUDIO_H
-#define HW_AUDIO_H
+#ifndef HW_SOUNDHW_H
+#define HW_SOUNDHW_H
 
 void isa_register_soundhw(const char *name, const char *descr,
                           int (*init_isa)(ISABus *bus));
diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index dcd9719a2c..8e10383b11 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -17,8 +17,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef IOMMU_COMMON_H
-#define IOMMU_COMMON_H
+#ifndef HW_I386_X86_IOMMU_H
+#define HW_I386_X86_IOMMU_H
 
 #include "hw/sysbus.h"
 #include "hw/pci/pci.h"
diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pic.h
index 56c2ef339f..6c91ec91bb 100644
--- a/include/hw/intc/heathrow_pic.h
+++ b/include/hw/intc/heathrow_pic.h
@@ -23,8 +23,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef HEATHROW_H
-#define HEATHROW_H
+#ifndef HW_INTC_HEATHROW_PIC_H
+#define HW_INTC_HEATHROW_PIC_H
 
 #define TYPE_HEATHROW "heathrow"
 #define HEATHROW(obj) OBJECT_CHECK(HeathrowState, (obj), TYPE_HEATHROW)
@@ -46,4 +46,4 @@ typedef struct HeathrowState {
 
 #define HEATHROW_NUM_IRQS 64
 
-#endif /* HEATHROW_H */
+#endif /* HW_INTC_HEATHROW_PIC_H */
diff --git a/include/hw/intc/xlnx-pmu-iomod-intc.h b/include/hw/intc/xlnx-pmu-iomod-intc.h
index 01c9d040b8..0bd118884a 100644
--- a/include/hw/intc/xlnx-pmu-iomod-intc.h
+++ b/include/hw/intc/xlnx-pmu-iomod-intc.h
@@ -22,8 +22,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef XLNX_PMU_IO_INTC_H
-#define XLNX_PMU_IO_INTC_H
+#ifndef HW_INTC_XLNX_PMU_IOMOD_INTC_H
+#define HW_INTC_XLNX_PMU_IOMOD_INTC_H
 
 #include "hw/sysbus.h"
 #include "hw/register.h"
@@ -54,4 +54,4 @@ typedef struct XlnxPMUIOIntc {
     RegisterInfo regs_info[XLNXPMUIOINTC_R_MAX];
 } XlnxPMUIOIntc;
 
-#endif /* XLNX_PMU_IO_INTC_H */
+#endif /* HW_INTC_XLNX_PMU_IOMOD_INTC_H */
diff --git a/include/hw/misc/armsse-mhu.h b/include/hw/misc/armsse-mhu.h
index e57eafc252..cf5d8a73e6 100644
--- a/include/hw/misc/armsse-mhu.h
+++ b/include/hw/misc/armsse-mhu.h
@@ -20,8 +20,8 @@
  *  + sysbus IRQ 1: interrupt for CPU 1
  */
 
-#ifndef HW_MISC_SSE_MHU_H
-#define HW_MISC_SSE_MHU_H
+#ifndef HW_MISC_ARMSSE_MHU_H
+#define HW_MISC_ARMSSE_MHU_H
 
 #include "hw/sysbus.h"
 
diff --git a/include/hw/pci-host/sabre.h b/include/hw/pci-host/sabre.h
index 0f2ccc01c6..9afa4938fd 100644
--- a/include/hw/pci-host/sabre.h
+++ b/include/hw/pci-host/sabre.h
@@ -1,5 +1,5 @@
-#ifndef PCI_HOST_APB_H
-#define PCI_HOST_APB_H
+#ifndef HW_PCI_HOST_SABRE_H
+#define HW_PCI_HOST_SABRE_H
 
 #include "hw/sparc/sun4u_iommu.h"
 
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index 7de3e5c224..88d8be4f78 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -6,8 +6,9 @@
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
  */
-#ifndef ASPEED_WDT_H
-#define ASPEED_WDT_H
+
+#ifndef WDT_ASPEED_H
+#define WDT_ASPEED_H
 
 #include "hw/sysbus.h"
 
@@ -31,4 +32,4 @@ typedef struct AspeedWDTState {
     uint32_t ext_pulse_width_mask;
 } AspeedWDTState;
 
-#endif  /* ASPEED_WDT_H */
+#endif /* WDT_ASPEED_H */
diff --git a/include/hw/xen/xen-legacy-backend.h b/include/hw/xen/xen-legacy-backend.h
index 20cb47b5bf..07d4176ac1 100644
--- a/include/hw/xen/xen-legacy-backend.h
+++ b/include/hw/xen/xen-legacy-backend.h
@@ -1,5 +1,5 @@
-#ifndef QEMU_HW_XEN_BACKEND_H
-#define QEMU_HW_XEN_BACKEND_H
+#ifndef HW_XEN_LEGACY_BACKEND_H
+#define HW_XEN_LEGACY_BACKEND_H
 
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_pvdev.h"
@@ -101,4 +101,4 @@ int xen_config_dev_vfb(int vdev, const char *type);
 int xen_config_dev_vkbd(int vdev);
 int xen_config_dev_console(int vdev);
 
-#endif /* QEMU_HW_XEN_BACKEND_H */
+#endif /* HW_XEN_LEGACY_BACKEND_H */
diff --git a/include/hw/xtensa/xtensa-isa.h b/include/hw/xtensa/xtensa-isa.h
index bd68ada640..a289531bdc 100644
--- a/include/hw/xtensa/xtensa-isa.h
+++ b/include/hw/xtensa/xtensa-isa.h
@@ -22,8 +22,8 @@
  * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#ifndef XTENSA_LIBISA_H
-#define XTENSA_LIBISA_H
+#ifndef HW_XTENSA_XTENSA_ISA_H
+#define HW_XTENSA_XTENSA_ISA_H
 
 #ifdef __cplusplus
 extern "C" {
@@ -833,4 +833,4 @@ int xtensa_funcUnit_num_copies(xtensa_isa isa, xtensa_funcUnit fun);
 #ifdef __cplusplus
 }
 #endif
-#endif /* XTENSA_LIBISA_H */
+#endif /* HW_XTENSA_XTENSA_ISA_H */
diff --git a/include/migration/qemu-file-types.h b/include/migration/qemu-file-types.h
index bbe04d4484..c0a1988155 100644
--- a/include/migration/qemu-file-types.h
+++ b/include/migration/qemu-file-types.h
@@ -22,8 +22,8 @@
  * THE SOFTWARE.
  */
 
-#ifndef QEMU_FILE_H
-#define QEMU_FILE_H
+#ifndef MIGRATION_QEMU_FILE_TYPES_H
+#define MIGRATION_QEMU_FILE_TYPES_H
 
 int qemu_file_get_error(QEMUFile *f);
 
diff --git a/include/qemu/filemonitor.h b/include/qemu/filemonitor.h
index 64267d09b2..70e613dfe3 100644
--- a/include/qemu/filemonitor.h
+++ b/include/qemu/filemonitor.h
@@ -18,8 +18,8 @@
  *
  */
 
-#ifndef QEMU_FILE_MONITOR_H
-#define QEMU_FILE_MONITOR_H
+#ifndef QEMU_FILEMONITOR_H
+#define QEMU_FILEMONITOR_H
 
 #include "qemu-common.h"
 
@@ -125,4 +125,4 @@ void qemu_file_monitor_remove_watch(QFileMonitor *mon,
                                     const char *dirpath,
                                     int64_t id);
 
-#endif /* QEMU_FILE_MONITOR_H */
+#endif /* QEMU_FILEMONITOR_H */
diff --git a/include/scsi/constants.h b/include/scsi/constants.h
index 0dc550732d..874176019e 100644
--- a/include/scsi/constants.h
+++ b/include/scsi/constants.h
@@ -20,8 +20,8 @@
  * the scsi code for linux.
  */
 
-#ifndef BLOCK_SCSI_H
-#define BLOCK_SCSI_H
+#ifndef SCSI_CONSTANTS_H
+#define SCSI_CONSTANTS_H
 
 /*
  *      SCSI opcodes
diff --git a/net/colo.h b/net/colo.h
index b21c6830b5..679314b1ca 100644
--- a/net/colo.h
+++ b/net/colo.h
@@ -12,8 +12,8 @@
  * later.  See the COPYING file in the top-level directory.
  */
 
-#ifndef QEMU_COLO_PROXY_H
-#define QEMU_COLO_PROXY_H
+#ifndef NET_COLO_H
+#define NET_COLO_H
 
 #include "qemu/jhash.h"
 #include "qemu/timer.h"
@@ -103,4 +103,4 @@ void connection_hashtable_reset(GHashTable *connection_track_table);
 Packet *packet_new(const void *data, int size, int vnet_hdr_len);
 void packet_destroy(void *opaque, void *user_data);
 
-#endif /* QEMU_COLO_PROXY_H */
+#endif /* NET_COLO_H */
diff --git a/target/i386/hax-posix.h b/target/i386/hax-posix.h
index 51af0e8c88..fb7c64426d 100644
--- a/target/i386/hax-posix.h
+++ b/target/i386/hax-posix.h
@@ -12,8 +12,8 @@
  *
  */
 
-#ifndef TARGET_I386_HAX_DARWIN_H
-#define TARGET_I386_HAX_DARWIN_H
+#ifndef TARGET_I386_HAX_POSIX_H
+#define TARGET_I386_HAX_POSIX_H
 
 #include <sys/ioctl.h>
 
@@ -58,4 +58,4 @@ static inline void hax_close_fd(hax_fd fd)
 #define HAX_VCPU_SET_REGS       _IOWR(0, 0xc7, struct vcpu_state_t)
 #define HAX_VCPU_GET_REGS       _IOWR(0, 0xc8, struct vcpu_state_t)
 
-#endif /* TARGET_I386_HAX_DARWIN_H */
+#endif /* TARGET_I386_HAX_POSIX_H */
diff --git a/target/i386/hvf/x86_task.h b/target/i386/hvf/x86_task.h
index 4f1b188d2e..4eaa61a7de 100644
--- a/target/i386/hvf/x86_task.h
+++ b/target/i386/hvf/x86_task.h
@@ -11,8 +11,10 @@
  * You should have received a copy of the GNU General Public License along
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
-#ifndef HVF_TASK
-#define HVF_TASK
+
+#ifndef HVF_X86_TASK_H
+#define HVF_X86_TASK_H
+
 void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel,
         int reason, bool gate_valid, uint8_t gate, uint64_t gate_type);
 #endif
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 047f3764b7..3656048be1 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -17,8 +17,9 @@
  * License along with this library; if not, see
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
-#ifndef CPU_NIOS2_H
-#define CPU_NIOS2_H
+
+#ifndef NIOS2_CPU_H
+#define NIOS2_CPU_H
 
 #include "qemu-common.h"
 
@@ -269,4 +270,4 @@ static inline void cpu_get_tb_cpu_state(CPUNios2State *env, target_ulong *pc,
     *flags = (env->regs[CR_STATUS] & (CR_STATUS_EH | CR_STATUS_U));
 }
 
-#endif /* CPU_NIOS2_H */
+#endif /* NIOS2_CPU_H */
diff --git a/target/nios2/mmu.h b/target/nios2/mmu.h
index 51d3d1f43a..4f46fbb82e 100644
--- a/target/nios2/mmu.h
+++ b/target/nios2/mmu.h
@@ -17,8 +17,9 @@
  * License along with this library; if not, see
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
-#ifndef MMU_NIOS2_H
-#define MMU_NIOS2_H
+
+#ifndef NIOS2_MMU_H
+#define NIOS2_MMU_H
 
 typedef struct Nios2TLBEntry {
     target_ulong tag;
@@ -47,4 +48,4 @@ void mmu_read_debug(CPUNios2State *env, uint32_t rn);
 void mmu_write(CPUNios2State *env, uint32_t rn, uint32_t v);
 void mmu_init(CPUNios2State *env);
 
-#endif /* MMU_NIOS2_H */
+#endif /* NIOS2_MMU_H */
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index ee8288e32d..0f3c9d09c6 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -17,8 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef MMU_BOOOK3S_V3_H
-#define MMU_BOOOK3S_V3_H
+#ifndef PPC_MMU_BOOK3S_V3_H
+#define PPC_MMU_BOOK3S_V3_H
 
 #include "mmu-hash64.h"
 
@@ -118,4 +118,4 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
 
 #endif /* CONFIG_USER_ONLY */
 
-#endif /* MMU_BOOOK3S_V3_H */
+#endif /* PPC_MMU_BOOK3S_V3_H */
diff --git a/tests/libqos/qgraph_internal.h b/tests/libqos/qgraph_internal.h
index 2ef748baf6..f4734c8681 100644
--- a/tests/libqos/qgraph_internal.h
+++ b/tests/libqos/qgraph_internal.h
@@ -16,8 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>
  */
 
-#ifndef QGRAPH_EXTRA_H
-#define QGRAPH_EXTRA_H
+#ifndef QGRAPH_INTERNAL_H
+#define QGRAPH_INTERNAL_H
 
 /* This header is declaring additional helper functions defined in
  * libqos/qgraph.c
diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
index 03c252368a..aa3c3a9625 100644
--- a/tests/migration/migration-test.h
+++ b/tests/migration/migration-test.h
@@ -4,8 +4,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
  */
-#ifndef _TEST_MIGRATION_H_
-#define _TEST_MIGRATION_H_
+
+#ifndef MIGRATION_TEST_H
+#define MIGRATION_TEST_H
 
 /* Common */
 #define TEST_MEM_PAGE_SIZE 4096
@@ -31,4 +32,4 @@
  */
 #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
 
-#endif /* _TEST_MIGRATION_H_ */
+#endif /* _MIGRATION_TEST_H */
-- 
2.17.2


