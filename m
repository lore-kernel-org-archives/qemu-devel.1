Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B878C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:18:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29749207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29749207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56204 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYE1A-00010N-8s
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 14:18:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYDz0-00088z-Jg
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYDyv-0002wd-K4
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYDyv-0002vi-8U
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98468C04FFF1
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 18:16:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4F1B5C224
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 18:16:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 41CBF11386B0; Tue,  4 Jun 2019 20:16:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 20:16:18 +0200
Message-Id: <20190604181618.19980-5-armbru@redhat.com>
In-Reply-To: <20190604181618.19980-1-armbru@redhat.com>
References: <20190604181618.19980-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 04 Jun 2019 18:16:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] Supply missing header guards
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/9pfs/xen-9pfs.h                    | 6 +++++-
 hw/hppa/hppa_hardware.h               | 5 +++++
 hw/input/adb-internal.h               | 4 ++++
 hw/net/e1000e_core.h                  | 5 +++++
 hw/net/e1000x_common.h                | 5 +++++
 hw/net/vmxnet3_defs.h                 | 6 +++++-
 hw/usb/hcd-xhci.h                     | 5 +++++
 hw/usb/quirks.h                       | 5 +++++
 include/fpu/softfloat-macros.h        | 5 +++++
 include/hw/arm/raspi_platform.h       | 5 +++++
 include/hw/kvm/clock.h                | 6 +++++-
 include/hw/m68k/mcf_fec.h             | 5 +++++
 include/hw/mips/bios.h                | 5 +++++
 include/hw/pci-bridge/simba.h         | 5 +++++
 include/hw/pci/pci_regs.h             | 5 +++++
 include/hw/qdev-dma.h                 | 6 ++++++
 include/hw/sparc/sparc64.h            | 4 ++++
 include/hw/timer/xlnx-zynqmp-rtc.h    | 5 +++++
 include/ui/spice-display.h            | 5 +++++
 linux-user/aarch64/syscall_nr.h       | 4 ++++
 linux-user/aarch64/termbits.h         | 5 +++++
 linux-user/alpha/syscall_nr.h         | 5 +++++
 linux-user/alpha/termbits.h           | 5 +++++
 linux-user/arm/syscall_nr.h           | 5 +++++
 linux-user/arm/termbits.h             | 5 +++++
 linux-user/cris/syscall_nr.h          | 5 +++++
 linux-user/cris/termbits.h            | 5 +++++
 linux-user/errno_defs.h               | 6 ++++++
 linux-user/flat.h                     | 5 +++++
 linux-user/hppa/sockbits.h            | 5 +++++
 linux-user/hppa/syscall_nr.h          | 5 +++++
 linux-user/hppa/termbits.h            | 5 +++++
 linux-user/i386/syscall_nr.h          | 5 +++++
 linux-user/i386/termbits.h            | 5 +++++
 linux-user/m68k/syscall_nr.h          | 5 +++++
 linux-user/m68k/termbits.h            | 5 +++++
 linux-user/microblaze/syscall_nr.h    | 5 +++++
 linux-user/microblaze/termbits.h      | 5 +++++
 linux-user/mips/syscall_nr.h          | 6 ++++++
 linux-user/mips/termbits.h            | 5 +++++
 linux-user/mips64/syscall_nr.h        | 5 +++++
 linux-user/nios2/syscall_nr.h         | 5 +++++
 linux-user/nios2/termbits.h           | 5 +++++
 linux-user/openrisc/syscall_nr.h      | 5 +++++
 linux-user/openrisc/termbits.h        | 5 +++++
 linux-user/ppc/syscall_nr.h           | 6 ++++++
 linux-user/ppc/termbits.h             | 5 +++++
 linux-user/riscv/syscall_nr.h         | 5 +++++
 linux-user/riscv/target_syscall.h     | 5 +++++
 linux-user/riscv/termbits.h           | 5 +++++
 linux-user/s390x/syscall_nr.h         | 5 +++++
 linux-user/s390x/termbits.h           | 4 ++++
 linux-user/sh4/syscall_nr.h           | 5 +++++
 linux-user/sh4/termbits.h             | 5 +++++
 linux-user/socket.h                   | 5 +++++
 linux-user/sparc/syscall_nr.h         | 5 +++++
 linux-user/sparc/termbits.h           | 5 +++++
 linux-user/sparc64/syscall_nr.h       | 5 +++++
 linux-user/sparc64/termbits.h         | 5 +++++
 linux-user/target_flat.h              | 6 ++++++
 linux-user/x86_64/syscall_nr.h        | 5 +++++
 linux-user/x86_64/termbits.h          | 5 +++++
 linux-user/xtensa/target_flat.h       | 8 +++++---
 target/cris/crisv10-decode.h          | 4 ++++
 target/cris/mmu.h                     | 5 +++++
 target/microblaze/microblaze-decode.h | 4 ++++
 target/microblaze/mmu.h               | 5 +++++
 target/moxie/mmu.h                    | 5 +++++
 target/riscv/cpu_bits.h               | 5 +++++
 target/riscv/cpu_user.h               | 5 +++++
 target/riscv/instmap.h                | 5 +++++
 target/tricore/tricore-opcodes.h      | 5 +++++
 tcg/tcg-gvec-desc.h                   | 5 +++++
 tcg/tcg-op-gvec.h                     | 5 +++++
 tests/crypto-tls-psk-helpers.h        | 5 +++++
 tests/crypto-tls-x509-helpers.h       | 5 +++++
 tests/libqos/virtio-9p.h              | 5 +++++
 tests/libqos/virtio-balloon.h         | 5 +++++
 tests/libqos/virtio-blk.h             | 5 +++++
 tests/libqos/virtio-net.h             | 5 +++++
 tests/libqos/virtio-rng.h             | 5 +++++
 tests/libqos/virtio-scsi.h            | 5 +++++
 tests/libqos/virtio-serial.h          | 5 +++++
 tests/socket-helpers.h                | 6 +++++-
 84 files changed, 419 insertions(+), 7 deletions(-)

diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
index 2d6ef7828c..fbdee3d843 100644
--- a/hw/9pfs/xen-9pfs.h
+++ b/hw/9pfs/xen-9pfs.h
@@ -8,9 +8,11 @@
  *
  * This work is licensed under the terms of the GNU GPL version 2 or
  * later. See the COPYING file in the top-level directory.
- *
  */
=20
+#ifndef HW_9PFS_XEN_9PFS_H
+#define HW_9PFS_XEN_9PFS_H
+
 #include <xen/io/protocols.h>
 #include "hw/xen/io/ring.h"
=20
@@ -19,3 +21,5 @@
  * inline functions in c files.
  */
 DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
+
+#endif
diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index af2f5ee2bd..507f91e05d 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -1,5 +1,8 @@
 /* HPPA cores and system support chips.  */
=20
+#ifndef HW_HPPA_HPPA_HARDWARE_H
+#define HW_HPPA_HPPA_HARDWARE_H
+
 #define FIRMWARE_START  0xf0000000
 #define FIRMWARE_END    0xf0800000
=20
@@ -38,3 +41,5 @@
=20
 #define HPPA_MAX_CPUS   8       /* max. number of SMP CPUs */
 #define CPU_CLOCK_MHZ   250     /* emulate a 250 MHz CPU */
+
+#endif
diff --git a/hw/input/adb-internal.h b/hw/input/adb-internal.h
index 2a779b8a0a..8d92165c46 100644
--- a/hw/input/adb-internal.h
+++ b/hw/input/adb-internal.h
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
=20
+#ifndef HW_INPUT_ADB_INTERNAL_H
+#define HW_INPUT_ADB_INTERNAL_H
+
 /* ADB commands */
=20
 #define ADB_BUSRESET            0x00
@@ -47,3 +50,4 @@
=20
 extern const VMStateDescription vmstate_adb_device;
=20
+#endif
diff --git a/hw/net/e1000e_core.h b/hw/net/e1000e_core.h
index 63a15510cc..49abb136dd 100644
--- a/hw/net/e1000e_core.h
+++ b/hw/net/e1000e_core.h
@@ -33,6 +33,9 @@
 * License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
 */
=20
+#ifndef HW_NET_E1000E_CORE_H
+#define HW_NET_E1000E_CORE_H
+
 #define E1000E_PHY_PAGE_SIZE    (0x20)
 #define E1000E_PHY_PAGES        (0x07)
 #define E1000E_MAC_SIZE         (0x8000)
@@ -151,3 +154,5 @@ e1000e_receive_iov(E1000ECore *core, const struct iov=
ec *iov, int iovcnt);
=20
 void
 e1000e_start_recv(E1000ECore *core);
+
+#endif
diff --git a/hw/net/e1000x_common.h b/hw/net/e1000x_common.h
index 0268884e72..19c56f409f 100644
--- a/hw/net/e1000x_common.h
+++ b/hw/net/e1000x_common.h
@@ -22,6 +22,9 @@
 * License along with this library; if not, see <http://www.gnu.org/licen=
ses/>.
 */
=20
+#ifndef HW_NET_E1000X_COMMON_H
+#define HW_NET_E1000X_COMMON_H
+
 #include "e1000_regs.h"
=20
 #define defreg(x)   x =3D (E1000_##x >> 2)
@@ -209,3 +212,5 @@ typedef struct e1000x_txd_props {
=20
 void e1000x_read_tx_ctx_descr(struct e1000_context_desc *d,
                               e1000x_txd_props *props);
+
+#endif
diff --git a/hw/net/vmxnet3_defs.h b/hw/net/vmxnet3_defs.h
index 6c19d29b12..65780c576d 100644
--- a/hw/net/vmxnet3_defs.h
+++ b/hw/net/vmxnet3_defs.h
@@ -12,9 +12,11 @@
  *
  * This work is licensed under the terms of the GNU GPL, version 2.
  * See the COPYING file in the top-level directory.
- *
  */
=20
+#ifndef HW_NET_VMXNET3_DEFS_H
+#define HW_NET_VMXNET3_DEFS_H
+
 #include "net/net.h"
 #include "hw/net/vmxnet3.h"
=20
@@ -131,3 +133,5 @@ typedef struct {
         /* Compatibility flags for migration */
         uint32_t compat_flags;
 } VMXNET3State;
+
+#endif
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
index 240caa4e51..2fad4df2a7 100644
--- a/hw/usb/hcd-xhci.h
+++ b/hw/usb/hcd-xhci.h
@@ -19,6 +19,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+#ifndef HW_USB_HCD_XHCI_H
+#define HW_USB_HCD_XHCI_H
+
 #define TYPE_XHCI "base-xhci"
 #define TYPE_NEC_XHCI "nec-usb-xhci"
 #define TYPE_QEMU_XHCI "qemu-xhci"
@@ -225,3 +228,5 @@ struct XHCIState {
=20
     bool nec_quirks;
 };
+
+#endif
diff --git a/hw/usb/quirks.h b/hw/usb/quirks.h
index 8dc6065527..89480befd7 100644
--- a/hw/usb/quirks.h
+++ b/hw/usb/quirks.h
@@ -12,6 +12,9 @@
  * (at your option) any later version.
  */
=20
+#ifndef HW_USB_QUIRKS_H
+#define HW_USB_QUIRKS_H
+
 /* 1 on 1 copy of linux/drivers/usb/serial/ftdi_sio_ids.h */
 #include "quirks-ftdi-ids.h"
 /* 1 on 1 copy of linux/drivers/usb/serial/pl2303.h */
@@ -908,3 +911,5 @@ static const struct usb_device_id usbredir_ftdi_seria=
l_ids[] =3D {
=20
 #undef USB_DEVICE
 #undef USB_DEVICE_AND_INTERFACE_INFO
+
+#endif
diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macro=
s.h
index bd5b6418e3..c55aa6d174 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -79,6 +79,9 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */
=20
+#ifndef FPU_SOFTFLOAT_MACROS_H
+#define FPU_SOFTFLOAT_MACROS_H
+
 /*----------------------------------------------------------------------=
------
 | Shifts `a' right by the number of bits given in `count'.  If any nonze=
ro
 | bits are shifted off, they are ``jammed'' into the least significant b=
it of
@@ -796,3 +799,5 @@ static inline flag ne128( uint64_t a0, uint64_t a1, u=
int64_t b0, uint64_t b1 )
     return ( a0 !=3D b0 ) || ( a1 !=3D b1 );
=20
 }
+
+#endif
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platf=
orm.h
index 6467e88ae6..10083d33df 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -22,6 +22,9 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA
  */
=20
+#ifndef HW_ARM_RASPI_PLATFORM_H
+#define HW_ARM_RASPI_PLATFORM_H
+
 #define MCORE_OFFSET            0x0000   /* Fake frame buffer device
                                           * (the multicore sync block) *=
/
 #define IC0_OFFSET              0x2000
@@ -126,3 +129,5 @@
 #define INTERRUPT_VPU1_HALTED          5
 #define INTERRUPT_ILLEGAL_TYPE0        6
 #define INTERRUPT_ILLEGAL_TYPE1        7
+
+#endif
diff --git a/include/hw/kvm/clock.h b/include/hw/kvm/clock.h
index 252ea13461..81c66b2302 100644
--- a/include/hw/kvm/clock.h
+++ b/include/hw/kvm/clock.h
@@ -8,9 +8,11 @@
  *
  * This work is licensed under the terms of the GNU GPL version 2.
  * See the COPYING file in the top-level directory.
- *
  */
=20
+#ifndef HW_KVM_CLOCK_H
+#define HW_KVM_CLOCK_H
+
 #ifdef CONFIG_KVM
=20
 void kvmclock_create(void);
@@ -22,3 +24,5 @@ static inline void kvmclock_create(void)
 }
=20
 #endif /* !CONFIG_KVM */
+
+#endif
diff --git a/include/hw/m68k/mcf_fec.h b/include/hw/m68k/mcf_fec.h
index 7f029f7b59..eeb471f9c9 100644
--- a/include/hw/m68k/mcf_fec.h
+++ b/include/hw/m68k/mcf_fec.h
@@ -7,7 +7,12 @@
  * (at your option) any later version.
  */
=20
+#ifndef HW_M68K_MCF_FEC_H
+#define HW_M68K_MCF_FEC_H
+
 #define TYPE_MCF_FEC_NET "mcf-fec"
 #define MCF_FEC_NET(obj) OBJECT_CHECK(mcf_fec_state, (obj), TYPE_MCF_FEC=
_NET)
=20
 #define FEC_NUM_IRQ 13
+
+#endif
diff --git a/include/hw/mips/bios.h b/include/hw/mips/bios.h
index d67ef33e83..c03007999a 100644
--- a/include/hw/mips/bios.h
+++ b/include/hw/mips/bios.h
@@ -1,3 +1,6 @@
+#ifndef HW_MIPS_BIOS_H
+#define HW_MIPS_BIOS_H
+
 #include "qemu/units.h"
 #include "cpu.h"
=20
@@ -7,3 +10,5 @@
 #else
 #define BIOS_FILENAME "mipsel_bios.bin"
 #endif
+
+#endif
diff --git a/include/hw/pci-bridge/simba.h b/include/hw/pci-bridge/simba.=
h
index e13ba27d0b..d8649973ee 100644
--- a/include/hw/pci-bridge/simba.h
+++ b/include/hw/pci-bridge/simba.h
@@ -24,6 +24,9 @@
  * THE SOFTWARE.
  */
=20
+#ifndef HW_PCI_BRIDGE_SIMBA_H
+#define HW_PCI_BRIDGE_SIMBA_H
+
 #include "hw/pci/pci_bridge.h"
=20
=20
@@ -35,3 +38,5 @@ typedef struct SimbaPCIBridge {
 #define TYPE_SIMBA_PCI_BRIDGE "pbm-bridge"
 #define SIMBA_PCI_BRIDGE(obj) \
     OBJECT_CHECK(SimbaPCIBridge, (obj), TYPE_SIMBA_PCI_BRIDGE)
+
+#endif
diff --git a/include/hw/pci/pci_regs.h b/include/hw/pci/pci_regs.h
index 7a83142578..77ba64b931 100644
--- a/include/hw/pci/pci_regs.h
+++ b/include/hw/pci/pci_regs.h
@@ -1,3 +1,8 @@
+#ifndef HW_PCI_PCI_REGS_H
+#define HW_PCI_PCI_REGS_H
+
 #include "standard-headers/linux/pci_regs.h"
=20
 #define  PCI_PM_CAP_VER_1_1     0x0002  /* PCI PM spec ver. 1.1 */
+
+#endif
diff --git a/include/hw/qdev-dma.h b/include/hw/qdev-dma.h
index 8cfb0f348e..b00391aa0c 100644
--- a/include/hw/qdev-dma.h
+++ b/include/hw/qdev-dma.h
@@ -6,5 +6,11 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
+
+#ifndef HW_QDEV_DMA_H
+#define HW_QDEV_DMA_H
+
 #define DEFINE_PROP_DMAADDR(_n, _s, _f, _d)                             =
  \
     DEFINE_PROP_UINT64(_n, _s, _f, _d)
+
+#endif
diff --git a/include/hw/sparc/sparc64.h b/include/hw/sparc/sparc64.h
index 5af4344459..21ab79e343 100644
--- a/include/hw/sparc/sparc64.h
+++ b/include/hw/sparc/sparc64.h
@@ -1,6 +1,10 @@
+#ifndef HW_SPARC_SPARC64_H
+#define HW_SPARC_SPARC64_H
=20
 #define IVEC_MAX             0x40
=20
 SPARCCPU *sparc64_cpu_devinit(const char *cpu_type, uint64_t prom_addr);
=20
 void sparc64_cpu_set_ivec_irq(void *opaque, int irq, int level);
+
+#endif
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-z=
ynqmp-rtc.h
index 5ba4d8bc4a..6e9134edf6 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/timer/xlnx-zynqmp-rtc.h
@@ -24,6 +24,9 @@
  * THE SOFTWARE.
  */
=20
+#ifndef HW_TIMER_XLNX_ZYNQMP_RTC_H
+#define HW_TIMER_XLNX_ZYNQMP_RTC_H
+
 #include "hw/register.h"
=20
 #define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"
@@ -84,3 +87,5 @@ typedef struct XlnxZynqMPRTC {
     uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
     RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
 } XlnxZynqMPRTC;
+
+#endif
diff --git a/include/ui/spice-display.h b/include/ui/spice-display.h
index 53c3612c32..eed60e4fae 100644
--- a/include/ui/spice-display.h
+++ b/include/ui/spice-display.h
@@ -15,6 +15,9 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
+#ifndef UI_SPICE_DISPLAY_H
+#define UI_SPICE_DISPLAY_H
+
 #include <spice/ipc_ring.h>
 #include <spice/enums.h>
 #include <spice/qxl_dev.h>
@@ -183,3 +186,5 @@ int qemu_spice_display_is_running(SimpleSpiceDisplay =
*ssd);
 bool qemu_spice_fill_device_address(QemuConsole *con,
                                     char *device_address,
                                     size_t size);
+
+#endif
diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall=
_nr.h
index a3c9a3b679..f00ffd7fb8 100644
--- a/linux-user/aarch64/syscall_nr.h
+++ b/linux-user/aarch64/syscall_nr.h
@@ -2,6 +2,9 @@
  * This file contains the system call numbers.
  */
=20
+#ifndef LINUX_USER_AARCH64_SYSCALL_NR_H
+#define LINUX_USER_AARCH64_SYSCALL_NR_H
+
 #define TARGET_NR_io_setup 0
 #define TARGET_NR_io_destroy 1
 #define TARGET_NR_io_submit 2
@@ -274,3 +277,4 @@
 #define TARGET_NR_mlock2 284
 #define TARGET_NR_copy_file_range 285
=20
+#endif
diff --git a/linux-user/aarch64/termbits.h b/linux-user/aarch64/termbits.=
h
index f9f80f0f37..0ab448d090 100644
--- a/linux-user/aarch64/termbits.h
+++ b/linux-user/aarch64/termbits.h
@@ -1,6 +1,9 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
=20
+#ifndef LINUX_USER_AARCH64_TERMBITS_H
+#define LINUX_USER_AARCH64_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -220,3 +223,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP           32
=20
 #define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/alpha/syscall_nr.h b/linux-user/alpha/syscall_nr.=
h
index fbb1ed288b..2e5541bbf9 100644
--- a/linux-user/alpha/syscall_nr.h
+++ b/linux-user/alpha/syscall_nr.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_ALPHA_SYSCALL_NR_H
+#define LINUX_USER_ALPHA_SYSCALL_NR_H
+
 #define TARGET_NR_osf_syscall	  0	/* not implemented */
 #define TARGET_NR_exit		  1
 #define TARGET_NR_fork		  2
@@ -450,3 +453,5 @@
 #define TARGET_NR_getrandom                     511
 #define TARGET_NR_memfd_create                  512
 #define TARGET_NR_execveat                      513
+
+#endif
diff --git a/linux-user/alpha/termbits.h b/linux-user/alpha/termbits.h
index 139bc87fa6..a71425174a 100644
--- a/linux-user/alpha/termbits.h
+++ b/linux-user/alpha/termbits.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_ALPHA_TERMBITS_H
+#define LINUX_USER_ALPHA_TERMBITS_H
+
 typedef unsigned char	target_cc_t;
 typedef unsigned int	target_speed_t;
 typedef unsigned int	target_tcflag_t;
@@ -263,3 +266,5 @@ struct target_termios {
 #define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt c=
ounts */
 #define TARGET_TIOCGHAYESESP	0x545E  /* Get Hayes ESP configuration */
 #define TARGET_TIOCSHAYESESP	0x545F  /* Set Hayes ESP configuration */
+
+#endif
diff --git a/linux-user/arm/syscall_nr.h b/linux-user/arm/syscall_nr.h
index cc9089ccdc..e7eda0d766 100644
--- a/linux-user/arm/syscall_nr.h
+++ b/linux-user/arm/syscall_nr.h
@@ -2,6 +2,9 @@
  * This file contains the system call numbers.
  */
=20
+#ifndef LINUX_USER_ARM_SYSCALL_NR_H
+#define LINUX_USER_ARM_SYSCALL_NR_H
+
 #define TARGET_NR_restart_syscall		(  0)
 #define TARGET_NR_exit			(  1)
 #define TARGET_NR_fork			(  2)
@@ -396,3 +399,5 @@
 #define TARGET_NR_userfaultfd                  (388)
 #define TARGET_NR_membarrier                   (389)
 #define TARGET_NR_mlock2                       (390)
+
+#endif
diff --git a/linux-user/arm/termbits.h b/linux-user/arm/termbits.h
index a61e138ec4..e555cff105 100644
--- a/linux-user/arm/termbits.h
+++ b/linux-user/arm/termbits.h
@@ -1,6 +1,9 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
=20
+#ifndef LINUX_USER_ARM_TERMBITS_H
+#define LINUX_USER_ARM_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -215,3 +218,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP		32
=20
 #define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/cris/syscall_nr.h b/linux-user/cris/syscall_nr.h
index 44f0b645b4..4b6cf65c42 100644
--- a/linux-user/cris/syscall_nr.h
+++ b/linux-user/cris/syscall_nr.h
@@ -2,6 +2,9 @@
  * This file contains the system call numbers, and stub macros for libc.
  */
=20
+#ifndef LINUX_USER_CRIS_SYSCALL_NR_H
+#define LINUX_USER_CRIS_SYSCALL_NR_H
+
 #define TARGET_NR_restart_syscall      0
 #define TARGET_NR_exit		  1
 #define TARGET_NR_fork		  2
@@ -360,3 +363,5 @@
 #define TARGET_NR_memfd_create       357
 #define TARGET_NR_bpf                358
 #define TARGET_NR_execveat           359
+
+#endif
diff --git a/linux-user/cris/termbits.h b/linux-user/cris/termbits.h
index c825cd2f5e..475ee70fed 100644
--- a/linux-user/cris/termbits.h
+++ b/linux-user/cris/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_CRIS_TERMBITS_H
+#define LINUX_USER_CRIS_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -212,3 +215,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP		32
=20
 #define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/errno_defs.h b/linux-user/errno_defs.h
index 55fbebda51..aaf5208d62 100644
--- a/linux-user/errno_defs.h
+++ b/linux-user/errno_defs.h
@@ -4,6 +4,10 @@
  *
  * Taken from asm-generic/errno-base.h and asm-generic/errno.h
  */
+
+#ifndef LINUX_USER_ERRNO_DEFS_H
+#define LINUX_USER_ERRNO_DEFS_H
+
 #define TARGET_EPERM            1      /* Operation not permitted */
 #define TARGET_ENOENT           2      /* No such file or directory */
 #define TARGET_ESRCH            3      /* No such process */
@@ -159,3 +163,5 @@
  * clash with a valid guest errno now or in the future.
  */
 #define TARGET_QEMU_ESIGRETURN 513     /* Return from signal */
+
+#endif
diff --git a/linux-user/flat.h b/linux-user/flat.h
index 6f2d0c4b2d..1e44b33443 100644
--- a/linux-user/flat.h
+++ b/linux-user/flat.h
@@ -7,6 +7,9 @@
  * support uClinux flat-format executables.
  */
=20
+#ifndef LINUX_USER_FLAT_H
+#define LINUX_USER_FLAT_H
+
 #define	FLAT_VERSION			0x00000004L
=20
 #ifdef CONFIG_BINFMT_SHARED_FLAT
@@ -65,3 +68,5 @@ struct flat_hdr {
 #define OLD_FLAT_RELOC_TYPE_BSS		2
=20
 #   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM *=
/
+
+#endif
diff --git a/linux-user/hppa/sockbits.h b/linux-user/hppa/sockbits.h
index 2641aea859..23f69a3293 100644
--- a/linux-user/hppa/sockbits.h
+++ b/linux-user/hppa/sockbits.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_HPPA_SOCKBITS_H
+#define LINUX_USER_HPPA_SOCKBITS_H
+
 #define TARGET_SOL_SOCKET      0xffff
=20
 #define TARGET_SO_DEBUG        0x0001
@@ -68,3 +71,5 @@
  * have to define SOCK_NONBLOCK to a different value here.
  */
 #define TARGET_SOCK_NONBLOCK   0x40000000
+
+#endif
diff --git a/linux-user/hppa/syscall_nr.h b/linux-user/hppa/syscall_nr.h
index 9c1d0a195d..ae41e94321 100644
--- a/linux-user/hppa/syscall_nr.h
+++ b/linux-user/hppa/syscall_nr.h
@@ -2,6 +2,9 @@
  * This file contains the system call numbers.
  */
=20
+#ifndef LINUX_USER_HPPA_SYSCALL_NR_H
+#define LINUX_USER_HPPA_SYSCALL_NR_H
+
 #define TARGET_NR_restart_syscall 0
 #define TARGET_NR_exit            1
 #define TARGET_NR_fork            2
@@ -351,3 +354,5 @@
 #define TARGET_NR_copy_file_range   346
 #define TARGET_NR_preadv2           347
 #define TARGET_NR_pwritev2          348
+
+#endif
diff --git a/linux-user/hppa/termbits.h b/linux-user/hppa/termbits.h
index ad51c9c911..8fba839dd4 100644
--- a/linux-user/hppa/termbits.h
+++ b/linux-user/hppa/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_HPPA_TERMBITS_H
+#define LINUX_USER_HPPA_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -219,3 +222,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP           32
=20
 #define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/i386/syscall_nr.h b/linux-user/i386/syscall_nr.h
index bc1bc233ed..3234ec21c6 100644
--- a/linux-user/i386/syscall_nr.h
+++ b/linux-user/i386/syscall_nr.h
@@ -2,6 +2,9 @@
  * This file contains the system call numbers.
  */
=20
+#ifndef LINUX_USER_I386_SYSCALL_NR_H
+#define LINUX_USER_I386_SYSCALL_NR_H
+
 #define TARGET_NR_restart_syscall      0
 #define TARGET_NR_exit		  1
 #define TARGET_NR_fork		  2
@@ -380,3 +383,5 @@
 #define TARGET_NR_membarrier            375
 #define TARGET_NR_mlock2                376
 #define TARGET_NR_copy_file_range       377
+
+#endif
diff --git a/linux-user/i386/termbits.h b/linux-user/i386/termbits.h
index 32dd0dde5d..88264bbde7 100644
--- a/linux-user/i386/termbits.h
+++ b/linux-user/i386/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_I386_TERMBITS_H
+#define LINUX_USER_I386_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -225,3 +228,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP		32
=20
 #define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/m68k/syscall_nr.h b/linux-user/m68k/syscall_nr.h
index d239551b34..d33d8e98a7 100644
--- a/linux-user/m68k/syscall_nr.h
+++ b/linux-user/m68k/syscall_nr.h
@@ -2,6 +2,9 @@
  * This file contains the system call numbers.
  */
=20
+#ifndef LINUX_USER_M68K_SYSCALL_NR_H
+#define LINUX_USER_M68K_SYSCALL_NR_H
+
 #define TARGET_NR_exit                 1
 #define TARGET_NR_fork                 2
 #define TARGET_NR_read                 3
@@ -379,3 +382,5 @@
 #define TARGET_NR_copy_file_range       376
 #define TARGET_NR_preadv2               377
 #define TARGET_NR_pwritev2              378
+
+#endif
diff --git a/linux-user/m68k/termbits.h b/linux-user/m68k/termbits.h
index 9df58dc5cb..23840aa968 100644
--- a/linux-user/m68k/termbits.h
+++ b/linux-user/m68k/termbits.h
@@ -1,6 +1,9 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
=20
+#ifndef LINUX_USER_M68K_TERMBITS_H
+#define LINUX_USER_M68K_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -226,3 +229,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP		32
=20
 #define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/microblaze/syscall_nr.h b/linux-user/microblaze/s=
yscall_nr.h
index 5d1a47a9a9..aa2eb93881 100644
--- a/linux-user/microblaze/syscall_nr.h
+++ b/linux-user/microblaze/syscall_nr.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_MICROBLAZE_SYSCALL_NR_H
+#define LINUX_USER_MICROBLAZE_SYSCALL_NR_H
+
 #define TARGET_NR_restart_syscall	0 /* ok */
 #define TARGET_NR_exit		1 /* ok */
 #define TARGET_NR_fork		2 /* not for no MMU - weird */
@@ -390,3 +393,5 @@
 #define TARGET_NR_memfd_create          386
 #define TARGET_NR_bpf                   387
 #define TARGET_NR_execveat              388
+
+#endif
diff --git a/linux-user/microblaze/termbits.h b/linux-user/microblaze/ter=
mbits.h
index c825cd2f5e..17db8a4473 100644
--- a/linux-user/microblaze/termbits.h
+++ b/linux-user/microblaze/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_MICROBLAZE_TERMBITS_H
+#define LINUX_USER_MICROBLAZE_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -212,3 +215,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP		32
=20
 #define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.h
index e70adfc2fe..7fa7fa5a86 100644
--- a/linux-user/mips/syscall_nr.h
+++ b/linux-user/mips/syscall_nr.h
@@ -1,6 +1,10 @@
 /*
  * Linux o32 style syscalls are in the range from 4000 to 4999.
  */
+
+#ifndef LINUX_USER_MIPS_SYSCALL_NR_H
+#define LINUX_USER_MIPS_SYSCALL_NR_H
+
 #define TARGET_NR_Linux			4000
 #define TARGET_NR_syscall		(TARGET_NR_Linux +   0)
 #define TARGET_NR_exit			(TARGET_NR_Linux +   1)
@@ -372,3 +376,5 @@
 #define TARGET_NR_statx                 (TARGET_NR_Linux + 366)
 #define TARGET_NR_rseq                  (TARGET_NR_Linux + 367)
 #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 368)
+
+#endif
diff --git a/linux-user/mips/termbits.h b/linux-user/mips/termbits.h
index 49a72c5539..3287cf6df8 100644
--- a/linux-user/mips/termbits.h
+++ b/linux-user/mips/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_MIPS_TERMBITS_H
+#define LINUX_USER_MIPS_TERMBITS_H
+
 #define TARGET_NCCS 23
=20
 struct target_termios {
@@ -256,3 +259,5 @@ struct target_termios {
 #define TARGET_TIOCGICOUNT     0x5492 /* read serial port inline interru=
pt counts */
 #define TARGET_TIOCGHAYESESP	0x5493 /* Get Hayes ESP configuration */
 #define TARGET_TIOCSHAYESESP	0x5494 /* Set Hayes ESP configuration */
+
+#endif
diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall_n=
r.h
index ff218a9bf2..db40f69ca2 100644
--- a/linux-user/mips64/syscall_nr.h
+++ b/linux-user/mips64/syscall_nr.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_MIPS64_SYSCALL_NR_H
+#define LINUX_USER_MIPS64_SYSCALL_NR_H
+
 #ifdef TARGET_ABI32
 /*
  * Linux N32 syscalls are in the range from 6000 to 6999.
@@ -672,3 +675,5 @@
 #define TARGET_NR_rseq                  (TARGET_NR_Linux + 327)
 #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 328)
 #endif
+
+#endif
diff --git a/linux-user/nios2/syscall_nr.h b/linux-user/nios2/syscall_nr.=
h
index 8b46763673..8fb87864ca 100644
--- a/linux-user/nios2/syscall_nr.h
+++ b/linux-user/nios2/syscall_nr.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_NIOS2_SYSCALL_NR_H
+#define LINUX_USER_NIOS2_SYSCALL_NR_H
+
 #define TARGET_NR_io_setup                  0
 #define TARGET_NR_io_destroy                1
 #define TARGET_NR_io_submit                 2
@@ -327,3 +330,5 @@
 #define TARGET_NR_uselib                    1077
 #define TARGET_NR__sysctl                   1078
 #define TARGET_NR_fork                      1079
+
+#endif
diff --git a/linux-user/nios2/termbits.h b/linux-user/nios2/termbits.h
index f9f80f0f37..425a2fe6ef 100644
--- a/linux-user/nios2/termbits.h
+++ b/linux-user/nios2/termbits.h
@@ -1,6 +1,9 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
=20
+#ifndef LINUX_USER_NIOS2_TERMBITS_H
+#define LINUX_USER_NIOS2_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -220,3 +223,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP           32
=20
 #define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/openrisc/syscall_nr.h b/linux-user/openrisc/sysca=
ll_nr.h
index 04059d020c..7763dbcfd8 100644
--- a/linux-user/openrisc/syscall_nr.h
+++ b/linux-user/openrisc/syscall_nr.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_OPENRISC_SYSCALL_NR_H
+#define LINUX_USER_OPENRISC_SYSCALL_NR_H
+
 #define TARGET_NR_io_setup 0
 #define TARGET_NR_io_destroy 1
 #define TARGET_NR_io_submit 2
@@ -502,3 +505,5 @@
 #define TARGET_NR_stat64 TARGET_NR_3264_stat
 #define TARGET_NR_lstat64 TARGET_NR_3264_lstat
 #endif
+
+#endif
diff --git a/linux-user/openrisc/termbits.h b/linux-user/openrisc/termbit=
s.h
index 231a49806b..7a635ffbc6 100644
--- a/linux-user/openrisc/termbits.h
+++ b/linux-user/openrisc/termbits.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_OPENRISC_TERMBITS_H
+#define LINUX_USER_OPENRISC_TERMBITS_H
+
 typedef unsigned char   target_openrisc_cc;        /*cc_t*/
 typedef unsigned int    target_openrisc_speed;     /*speed_t*/
 typedef unsigned int    target_openrisc_tcflag;    /*tcflag_t*/
@@ -294,3 +297,5 @@ struct target_termios3 {
 #define TARGET_TIOCPKT_IOCTL           64
=20
 #define TARGET_TIOCSER_TEMT    0x01    /* Transmitter physically empty *=
/
+
+#endif
diff --git a/linux-user/ppc/syscall_nr.h b/linux-user/ppc/syscall_nr.h
index afa36544f1..b57a07b931 100644
--- a/linux-user/ppc/syscall_nr.h
+++ b/linux-user/ppc/syscall_nr.h
@@ -1,6 +1,10 @@
 /*
  * This file contains the system call numbers.
  */
+
+#ifndef LINUX_USER_PPC_SYSCALL_NR_H
+#define LINUX_USER_PPC_SYSCALL_NR_H
+
 #define TARGET_NR_restart_syscall          0
 #define TARGET_NR_exit                     1
 #define TARGET_NR_fork                     2
@@ -394,3 +398,5 @@
 #define TARGET_NR_shmget                376
 #define TARGET_NR_shmctl                377
 #define TARGET_NR_mlock2                378
+
+#endif
diff --git a/linux-user/ppc/termbits.h b/linux-user/ppc/termbits.h
index a5b1bb783b..19e4c6eda8 100644
--- a/linux-user/ppc/termbits.h
+++ b/linux-user/ppc/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_PPC_TERMBITS_H
+#define LINUX_USER_PPC_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -235,3 +238,5 @@ struct target_termios {
=20
 #define TARGET_TIOCMIWAIT	0x545C	/* wait for a change on serial input li=
ne(s) */
 #define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt c=
ounts */
+
+#endif
diff --git a/linux-user/riscv/syscall_nr.h b/linux-user/riscv/syscall_nr.=
h
index 7e30f1f1ef..dab6509e3a 100644
--- a/linux-user/riscv/syscall_nr.h
+++ b/linux-user/riscv/syscall_nr.h
@@ -3,6 +3,9 @@
  * of recently-added arches including RISC-V.
  */
=20
+#ifndef LINUX_USER_RISCV_SYSCALL_NR_H
+#define LINUX_USER_RISCV_SYSCALL_NR_H
+
 #define TARGET_NR_io_setup 0
 #define TARGET_NR_io_destroy 1
 #define TARGET_NR_io_submit 2
@@ -285,3 +288,5 @@
 #define TARGET_NR_copy_file_range 285
=20
 #define TARGET_NR_syscalls (TARGET_NR_copy_file_range + 1)
+
+#endif
diff --git a/linux-user/riscv/target_syscall.h b/linux-user/riscv/target_=
syscall.h
index ee81d8bc88..a88e821f73 100644
--- a/linux-user/riscv/target_syscall.h
+++ b/linux-user/riscv/target_syscall.h
@@ -5,6 +5,9 @@
  * Reference: linux/arch/riscv/include/uapi/asm/ptrace.h
  */
=20
+#ifndef LINUX_USER_RISCV_TARGET_SYSCALL_H
+#define LINUX_USER_RISCV_TARGET_SYSCALL_H
+
 struct target_pt_regs {
     abi_long sepc;
     abi_long ra;
@@ -54,3 +57,5 @@ struct target_pt_regs {
 /* clone(flags, newsp, ptidptr, tls, ctidptr) for RISC-V */
 /* This comes from linux/kernel/fork.c, CONFIG_CLONE_BACKWARDS */
 #define TARGET_CLONE_BACKWARDS
+
+#endif
diff --git a/linux-user/riscv/termbits.h b/linux-user/riscv/termbits.h
index 7e4e230588..5e0af0dd3f 100644
--- a/linux-user/riscv/termbits.h
+++ b/linux-user/riscv/termbits.h
@@ -1,6 +1,9 @@
 /* from asm/termbits.h */
 /* NOTE: exactly the same as i386 */
=20
+#ifndef LINUX_USER_RISCV_TERMBITS_H
+#define LINUX_USER_RISCV_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -220,3 +223,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP           32
=20
 #define TARGET_TIOCSER_TEMT    0x01 /* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/s390x/syscall_nr.h b/linux-user/s390x/syscall_nr.=
h
index 1a66c5561d..b1553a0810 100644
--- a/linux-user/s390x/syscall_nr.h
+++ b/linux-user/s390x/syscall_nr.h
@@ -2,6 +2,9 @@
  * This file contains the system call numbers.
  */
=20
+#ifndef LINUX_USER_S390X_SYSCALL_NR_H
+#define LINUX_USER_S390X_SYSCALL_NR_H
+
 #define TARGET_NR_exit                 1
 #define TARGET_NR_fork                 2
 #define TARGET_NR_read                 3
@@ -391,3 +394,5 @@
 #define TARGET_NR_newfstatat		293
=20
 #endif
+
+#endif
diff --git a/linux-user/s390x/termbits.h b/linux-user/s390x/termbits.h
index 8bcca89cd7..9affa8f41a 100644
--- a/linux-user/s390x/termbits.h
+++ b/linux-user/s390x/termbits.h
@@ -6,6 +6,9 @@
  *  Derived from "include/asm-i386/termbits.h"
  */
=20
+#ifndef LINUX_USER_S390X_TERMBITS_H
+#define LINUX_USER_S390X_TERMBITS_H
+
 #define TARGET_NCCS 19
 struct target_termios {
     unsigned int c_iflag;		/* input mode flags */
@@ -282,3 +285,4 @@ struct target_ktermios {
=20
 #define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
=20
+#endif
diff --git a/linux-user/sh4/syscall_nr.h b/linux-user/sh4/syscall_nr.h
index d6c1e059f6..d53a2a07dd 100644
--- a/linux-user/sh4/syscall_nr.h
+++ b/linux-user/sh4/syscall_nr.h
@@ -2,6 +2,9 @@
  * This file contains the system call numbers.
  */
=20
+#ifndef LINUX_USER_SH4_SYSCALL_NR_H
+#define LINUX_USER_SH4_SYSCALL_NR_H
+
 #define TARGET_NR_restart_syscall	  0
 #define TARGET_NR_exit		  1
 #define TARGET_NR_fork		  2
@@ -386,3 +389,5 @@
 #define TARGET_NR_copy_file_range       380
 #define TARGET_NR_preadv2               381
 #define TARGET_NR_pwritev2              382
+
+#endif
diff --git a/linux-user/sh4/termbits.h b/linux-user/sh4/termbits.h
index 5723ed7752..dd125b6a2b 100644
--- a/linux-user/sh4/termbits.h
+++ b/linux-user/sh4/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_SH4_TERMBITS_H
+#define LINUX_USER_SH4_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -273,3 +276,5 @@ tus register */
 serial input line(s) */
 #define TARGET_TIOCGICOUNT     TARGET_IOR('T', 93, int) /* 0x545D */ /* =
read
 serial port inline interrupt counts */
+
+#endif
diff --git a/linux-user/socket.h b/linux-user/socket.h
index 4c0b5c2dfa..680a9218a9 100644
--- a/linux-user/socket.h
+++ b/linux-user/socket.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_SOCKET_H
+#define LINUX_USER_SOCKET_H
+
 #include "sockbits.h"
=20
 #ifndef TARGET_ARCH_HAS_SOCKET_TYPES
@@ -35,3 +38,5 @@ enum sock_type {
 #define TARGET_SOCK_NONBLOCK   TARGET_O_NONBLOCK
 #endif
 #endif /* TARGET_ARCH_HAS_SOCKET_TYPES */
+
+#endif
diff --git a/linux-user/sparc/syscall_nr.h b/linux-user/sparc/syscall_nr.=
h
index 2d77e19bec..162099f9ce 100644
--- a/linux-user/sparc/syscall_nr.h
+++ b/linux-user/sparc/syscall_nr.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_SPARC_SYSCALL_NR_H
+#define LINUX_USER_SPARC_SYSCALL_NR_H
+
 #define TARGET_NR_exit                 1 /* Common                      =
                */
 #define TARGET_NR_fork                 2 /* Common                      =
                */
 #define TARGET_NR_read                 3 /* Common                      =
                */
@@ -356,3 +359,5 @@
 #define TARGET_NR_preadv2               358
 #define TARGET_NR_pwritev2              359
 #define TARGET_NR_statx                 360
+
+#endif
diff --git a/linux-user/sparc/termbits.h b/linux-user/sparc/termbits.h
index 113d6dfbdb..f85219ed71 100644
--- a/linux-user/sparc/termbits.h
+++ b/linux-user/sparc/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_SPARC_TERMBITS_H
+#define LINUX_USER_SPARC_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -278,3 +281,5 @@ struct target_termios {
 #define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
 #define TARGET_TIOCMIWAIT	0x545C /* Wait input */
 #define TARGET_TIOCGICOUNT	0x545D /* Read serial port inline interrupt c=
ounts */
+
+#endif
diff --git a/linux-user/sparc64/syscall_nr.h b/linux-user/sparc64/syscall=
_nr.h
index 0b91b896da..6b088c9862 100644
--- a/linux-user/sparc64/syscall_nr.h
+++ b/linux-user/sparc64/syscall_nr.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_SPARC64_SYSCALL_NR_H
+#define LINUX_USER_SPARC64_SYSCALL_NR_H
+
 #define TARGET_NR_restart_syscall      0 /* Linux Specific				   */
 #define TARGET_NR_exit                 1 /* Common                      =
                */
 #define TARGET_NR_fork                 2 /* Common                      =
                */
@@ -359,3 +362,5 @@
 #define TARGET_NR_preadv2               358
 #define TARGET_NR_pwritev2              359
 #define TARGET_NR_statx                 360
+
+#endif
diff --git a/linux-user/sparc64/termbits.h b/linux-user/sparc64/termbits.=
h
index 113d6dfbdb..11b5abcf84 100644
--- a/linux-user/sparc64/termbits.h
+++ b/linux-user/sparc64/termbits.h
@@ -1,5 +1,8 @@
 /* from asm/termbits.h */
=20
+#ifndef LINUX_USER_SPARC64_TERMBITS_H
+#define LINUX_USER_SPARC64_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 struct target_termios {
@@ -278,3 +281,5 @@ struct target_termios {
 #define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
 #define TARGET_TIOCMIWAIT	0x545C /* Wait input */
 #define TARGET_TIOCGICOUNT	0x545D /* Read serial port inline interrupt c=
ounts */
+
+#endif
diff --git a/linux-user/target_flat.h b/linux-user/target_flat.h
index 0ba6bdd12e..8fe189ea6f 100644
--- a/linux-user/target_flat.h
+++ b/linux-user/target_flat.h
@@ -1,6 +1,10 @@
 /* If your arch needs to do custom stuff, create your own target_flat.h
  * header file in linux-user/<your arch>/
  */
+
+#ifndef LINUX_USER_TARGET_FLAT_H
+#define LINUX_USER_TARGET_FLAT_H
+
 #define flat_argvp_envp_on_stack()                           1
 #define flat_reloc_valid(reloc, size)                        ((reloc) <=3D=
 (size))
 #define flat_old_ram_flag(flag)                              (flag)
@@ -8,3 +12,5 @@
 #define flat_get_addr_from_rp(rp, relval, flags, persistent) (rp)
 #define flat_set_persistent(relval, persistent)              (*persisten=
t)
 #define flat_put_addr_at_rp(rp, addr, relval)                put_user_ua=
l(addr, rp)
+
+#endif
diff --git a/linux-user/x86_64/syscall_nr.h b/linux-user/x86_64/syscall_n=
r.h
index 16397b3e8f..9b6981e74c 100644
--- a/linux-user/x86_64/syscall_nr.h
+++ b/linux-user/x86_64/syscall_nr.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_X86_64_SYSCALL_NR_H
+#define LINUX_USER_X86_64_SYSCALL_NR_H
+
 #define TARGET_NR_read                                0
 #define TARGET_NR_write                               1
 #define TARGET_NR_open                                2
@@ -325,3 +328,5 @@
 #define TARGET_NR_membarrier            324
 #define TARGET_NR_mlock2                325
 #define TARGET_NR_copy_file_range       326
+
+#endif
diff --git a/linux-user/x86_64/termbits.h b/linux-user/x86_64/termbits.h
index f5776a8aa6..c8bb5996b1 100644
--- a/linux-user/x86_64/termbits.h
+++ b/linux-user/x86_64/termbits.h
@@ -1,3 +1,6 @@
+#ifndef LINUX_USER_X86_64_TERMBITS_H
+#define LINUX_USER_X86_64_TERMBITS_H
+
 #define TARGET_NCCS 19
=20
 typedef unsigned char	target_cc_t;
@@ -246,3 +249,5 @@ struct target_termios {
 #define TARGET_TIOCPKT_DOSTOP		32
=20
 #define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
+
+#endif
diff --git a/linux-user/xtensa/target_flat.h b/linux-user/xtensa/target_f=
lat.h
index 732adddb0d..25fe3f5f3b 100644
--- a/linux-user/xtensa/target_flat.h
+++ b/linux-user/xtensa/target_flat.h
@@ -1,6 +1,6 @@
-/* If your arch needs to do custom stuff, create your own target_flat.h
- * header file in linux-user/<your arch>/
- */
+#ifndef LINUX_USER_XTENSA_TARGET_FLAT_H
+#define LINUX_USER_XTENSA_TARGET_FLAT_H
+
 #define flat_argvp_envp_on_stack()                           0
 #define flat_reloc_valid(reloc, size)                        ((reloc) <=3D=
 (size))
 #define flat_old_ram_flag(flag)                              (flag)
@@ -8,3 +8,5 @@
 #define flat_get_addr_from_rp(rp, relval, flags, persistent) (rp)
 #define flat_set_persistent(relval, persistent)              (*persisten=
t)
 #define flat_put_addr_at_rp(rp, addr, relval)                put_user_ua=
l(addr, rp)
+
+#endif
diff --git a/target/cris/crisv10-decode.h b/target/cris/crisv10-decode.h
index bdb4b6d318..028179bd0f 100644
--- a/target/cris/crisv10-decode.h
+++ b/target/cris/crisv10-decode.h
@@ -18,6 +18,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+#ifndef TARGET_CRIS_CRISV10_DECODE_H
+#define TARGET_CRIS_CRISV10_DECODE_H
+
 #define CRISV10_MODE_QIMMEDIATE  0
 #define CRISV10_MODE_REG         1
 #define CRISV10_MODE_INDIRECT    2
@@ -106,3 +109,4 @@
 #define CRISV10_IND_MOVEM_M_R    14
 #define CRISV10_IND_MOVEM_R_M    15
=20
+#endif
diff --git a/target/cris/mmu.h b/target/cris/mmu.h
index 0217f476de..9ab1642b96 100644
--- a/target/cris/mmu.h
+++ b/target/cris/mmu.h
@@ -1,3 +1,6 @@
+#ifndef TARGET_CRIS_MMU_H
+#define TARGET_CRIS_MMU_H
+
 #define CRIS_MMU_ERR_EXEC  0
 #define CRIS_MMU_ERR_READ  1
 #define CRIS_MMU_ERR_WRITE 2
@@ -15,3 +18,5 @@ void cris_mmu_flush_pid(CPUCRISState *env, uint32_t pid=
);
 int cris_mmu_translate(struct cris_mmu_result *res,
                        CPUCRISState *env, uint32_t vaddr,
                        int rw, int mmu_idx, int debug);
+
+#endif
diff --git a/target/microblaze/microblaze-decode.h b/target/microblaze/mi=
croblaze-decode.h
index 401319ed46..17b2f29fff 100644
--- a/target/microblaze/microblaze-decode.h
+++ b/target/microblaze/microblaze-decode.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+#ifndef TARGET_MICROBLAZE_MICROBLAZE_DECODE_H
+#define TARGET_MICROBLAZE_MICROBLAZE_DECODE_H
+
 /* Convenient binary macros.  */
 #define HEX__(n) 0x##n##LU
 #define B8__(x) ((x&0x0000000FLU)?1:0) \
@@ -53,3 +56,4 @@
=20
 #define DEC_STREAM  {B8(00010011), B8(00110111)}
=20
+#endif
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index a4272b6356..75e5301c79 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+#ifndef TARGET_MICROBLAZE_MMU_H
+#define TARGET_MICROBLAZE_MMU_H
+
 #define MMU_R_PID    0
 #define MMU_R_ZPR    1
 #define MMU_R_TLBX   2
@@ -93,3 +96,5 @@ unsigned int mmu_translate(struct microblaze_mmu *mmu,
 uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
 void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
 void mmu_init(struct microblaze_mmu *mmu);
+
+#endif
diff --git a/target/moxie/mmu.h b/target/moxie/mmu.h
index 284a44d18e..d80690f4d2 100644
--- a/target/moxie/mmu.h
+++ b/target/moxie/mmu.h
@@ -1,3 +1,6 @@
+#ifndef TARGET_MOXIE_MMU_H
+#define TARGET_MOXIE_MMU_H
+
 #define MOXIE_MMU_ERR_EXEC  0
 #define MOXIE_MMU_ERR_READ  1
 #define MOXIE_MMU_ERR_WRITE 2
@@ -12,3 +15,5 @@ typedef struct {
 int moxie_mmu_translate(MoxieMMUResult *res,
                         CPUMoxieState *env, uint32_t vaddr,
                         int rw, int mmu_idx);
+
+#endif
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index dc9d53d4be..47450a3cdb 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -1,5 +1,8 @@
 /* RISC-V ISA constants */
=20
+#ifndef TARGET_RISCV_CPU_BITS_H
+#define TARGET_RISCV_CPU_BITS_H
+
 #define get_field(reg, mask) (((reg) & \
                  (target_ulong)(mask)) / ((mask) & ~((mask) << 1)))
 #define set_field(reg, mask, val) (((reg) & ~(target_ulong)(mask)) | \
@@ -527,3 +530,5 @@
 #define SIP_SSIP                           MIP_SSIP
 #define SIP_STIP                           MIP_STIP
 #define SIP_SEIP                           MIP_SEIP
+
+#endif
diff --git a/target/riscv/cpu_user.h b/target/riscv/cpu_user.h
index 52d380aa98..02afad608b 100644
--- a/target/riscv/cpu_user.h
+++ b/target/riscv/cpu_user.h
@@ -1,3 +1,6 @@
+#ifndef TARGET_RISCV_CPU_USER_H
+#define TARGET_RISCV_CPU_USER_H
+
 #define xRA 1   /* return address (aka link register) */
 #define xSP 2   /* stack pointer */
 #define xGP 3   /* global pointer */
@@ -12,3 +15,5 @@
 #define xA6 16
 #define xA7 17  /* syscall number for RVI ABI */
 #define xT0 5   /* syscall number for RVE ABI */
+
+#endif
diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
index 58baa1ba1f..f8ad7d60fd 100644
--- a/target/riscv/instmap.h
+++ b/target/riscv/instmap.h
@@ -16,6 +16,9 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
+#ifndef TARGET_RISCV_INSTMAP_H
+#define TARGET_RISCV_INSTMAP_H
+
 #define MASK_OP_MAJOR(op)  (op & 0x7F)
 enum {
     /* rv32i, rv64i, rv32m */
@@ -362,3 +365,5 @@ enum {
 #define GET_C_RS2(inst)             extract32(inst, 2, 5)
 #define GET_C_RS1S(inst)            (8 + extract32(inst, 7, 3))
 #define GET_C_RS2S(inst)            (8 + extract32(inst, 2, 3))
+
+#endif
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-op=
codes.h
index 40bc121ba4..f7135f183d 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -15,6 +15,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+#ifndef TARGET_TRICORE_TRICORE_OPCODES_H
+#define TARGET_TRICORE_TRICORE_OPCODES_H
+
 /*
  * Opcode Masks for Tricore
  * Format MASK_OP_InstrFormatName_Field
@@ -1467,3 +1470,5 @@ enum {
     OPC2_32_SYS_RESTORE                          =3D 0x0e,
     OPC2_32_SYS_FRET                             =3D 0x03,
 };
+
+#endif
diff --git a/tcg/tcg-gvec-desc.h b/tcg/tcg-gvec-desc.h
index 2dda7d6ba1..0224ac3e78 100644
--- a/tcg/tcg-gvec-desc.h
+++ b/tcg/tcg-gvec-desc.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+#ifndef TCG_TCG_GVEC_DESC_H
+#define TCG_TCG_GVEC_DESC_H
+
 /* ??? These bit widths are set for ARM SVE, maxing out at 256 byte vect=
ors. */
 #define SIMD_OPRSZ_SHIFT   0
 #define SIMD_OPRSZ_BITS    5
@@ -47,3 +50,5 @@ static inline int32_t simd_data(uint32_t desc)
 {
     return sextract32(desc, SIMD_DATA_SHIFT, SIMD_DATA_BITS);
 }
+
+#endif
diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 2a9e0c7c0a..830d68f697 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -17,6 +17,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
+#ifndef TCG_TCG_OP_GVEC_H
+#define TCG_TCG_OP_GVEC_H
+
 /*
  * "Generic" vectors.  All operands are given as offsets from ENV,
  * and therefore cannot also be allocated via tcg_global_mem_new_*.
@@ -373,3 +376,5 @@ void tcg_gen_vec_shr8i_i64(TCGv_i64 d, TCGv_i64 a, in=
t64_t);
 void tcg_gen_vec_shr16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
 void tcg_gen_vec_sar8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
 void tcg_gen_vec_sar16i_i64(TCGv_i64 d, TCGv_i64 a, int64_t);
+
+#endif
diff --git a/tests/crypto-tls-psk-helpers.h b/tests/crypto-tls-psk-helper=
s.h
index 9aec29f1a0..966aacab76 100644
--- a/tests/crypto-tls-psk-helpers.h
+++ b/tests/crypto-tls-psk-helpers.h
@@ -18,6 +18,9 @@
  * Author: Richard W.M. Jones <rjones@redhat.com>
  */
=20
+#ifndef TESTS_CRYPTO_TLS_PSK_HELPERS_H
+#define TESTS_CRYPTO_TLS_PSK_HELPERS_H
+
 #include <gnutls/gnutls.h>
=20
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
@@ -27,3 +30,5 @@ void test_tls_psk_init(const char *keyfile);
 void test_tls_psk_cleanup(const char *keyfile);
=20
 #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
+
+#endif
diff --git a/tests/crypto-tls-x509-helpers.h b/tests/crypto-tls-x509-help=
ers.h
index 88c30d7c94..1c07607928 100644
--- a/tests/crypto-tls-x509-helpers.h
+++ b/tests/crypto-tls-x509-helpers.h
@@ -18,6 +18,9 @@
  * Author: Daniel P. Berrange <berrange@redhat.com>
  */
=20
+#ifndef TESTS_CRYPTO_TLS_X509_HELPERS_H
+#define TESTS_CRYPTO_TLS_X509_HELPERS_H
+
 #include <gnutls/gnutls.h>
 #include <gnutls/x509.h>
=20
@@ -126,3 +129,5 @@ void test_tls_cleanup(const char *keyfile);
 extern const ASN1_ARRAY_TYPE pkix_asn1_tab[];
=20
 #endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
+
+#endif
diff --git a/tests/libqos/virtio-9p.h b/tests/libqos/virtio-9p.h
index dba22772b5..b54e89b3a1 100644
--- a/tests/libqos/virtio-9p.h
+++ b/tests/libqos/virtio-9p.h
@@ -16,6 +16,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+#ifndef TESTS_LIBQOS_VIRTIO_9P_H
+#define TESTS_LIBQOS_VIRTIO_9P_H
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
@@ -40,3 +43,5 @@ struct QVirtio9PDevice {
     QOSGraphObject obj;
     QVirtio9P v9p;
 };
+
+#endif
diff --git a/tests/libqos/virtio-balloon.h b/tests/libqos/virtio-balloon.=
h
index e8066c42bb..52661cc87d 100644
--- a/tests/libqos/virtio-balloon.h
+++ b/tests/libqos/virtio-balloon.h
@@ -16,6 +16,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+#ifndef TESTS_LIBQOS_VIRTIO_BALLOON_H
+#define TESTS_LIBQOS_VIRTIO_BALLOON_H
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
@@ -37,3 +40,5 @@ struct QVirtioBalloonDevice {
     QOSGraphObject obj;
     QVirtioBalloon balloon;
 };
+
+#endif
diff --git a/tests/libqos/virtio-blk.h b/tests/libqos/virtio-blk.h
index dc258496ba..c05adc659d 100644
--- a/tests/libqos/virtio-blk.h
+++ b/tests/libqos/virtio-blk.h
@@ -16,6 +16,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+#ifndef TESTS_LIBQOS_VIRTIO_BLK_H
+#define TESTS_LIBQOS_VIRTIO_BLK_H
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
@@ -38,3 +41,5 @@ struct QVirtioBlkDevice {
     QOSGraphObject obj;
     QVirtioBlk blk;
 };
+
+#endif
diff --git a/tests/libqos/virtio-net.h b/tests/libqos/virtio-net.h
index 28238a1b20..a5697d7326 100644
--- a/tests/libqos/virtio-net.h
+++ b/tests/libqos/virtio-net.h
@@ -16,6 +16,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+#ifndef TESTS_LIBQOS_VIRTIO_NET_H
+#define TESTS_LIBQOS_VIRTIO_NET_H
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
@@ -39,3 +42,5 @@ struct QVirtioNetDevice {
     QOSGraphObject obj;
     QVirtioNet net;
 };
+
+#endif
diff --git a/tests/libqos/virtio-rng.h b/tests/libqos/virtio-rng.h
index fbba988875..9e192f11f7 100644
--- a/tests/libqos/virtio-rng.h
+++ b/tests/libqos/virtio-rng.h
@@ -16,6 +16,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+#ifndef TESTS_LIBQOS_VIRTIO_RNG_H
+#define TESTS_LIBQOS_VIRTIO_RNG_H
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
@@ -37,3 +40,5 @@ struct QVirtioRngDevice {
     QOSGraphObject obj;
     QVirtioRng rng;
 };
+
+#endif
diff --git a/tests/libqos/virtio-scsi.h b/tests/libqos/virtio-scsi.h
index 17a47beddc..4ca19a6a7a 100644
--- a/tests/libqos/virtio-scsi.h
+++ b/tests/libqos/virtio-scsi.h
@@ -16,6 +16,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+#ifndef TESTS_LIBQOS_VIRTIO_SCSI_H
+#define TESTS_LIBQOS_VIRTIO_SCSI_H
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
@@ -37,3 +40,5 @@ struct QVirtioSCSIDevice {
     QOSGraphObject obj;
     QVirtioSCSI scsi;
 };
+
+#endif
diff --git a/tests/libqos/virtio-serial.h b/tests/libqos/virtio-serial.h
index b7e2a5d178..080fa8428d 100644
--- a/tests/libqos/virtio-serial.h
+++ b/tests/libqos/virtio-serial.h
@@ -16,6 +16,9 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
+#ifndef TESTS_LIBQOS_VIRTIO_SERIAL_H
+#define TESTS_LIBQOS_VIRTIO_SERIAL_H
+
 #include "libqos/qgraph.h"
 #include "libqos/virtio.h"
 #include "libqos/virtio-pci.h"
@@ -37,3 +40,5 @@ struct QVirtioSerialDevice {
     QOSGraphObject obj;
     QVirtioSerial serial;
 };
+
+#endif
diff --git a/tests/socket-helpers.h b/tests/socket-helpers.h
index 1c07d6d656..9de0e6b151 100644
--- a/tests/socket-helpers.h
+++ b/tests/socket-helpers.h
@@ -15,9 +15,11 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
- *
  */
=20
+#ifndef TESTS_SOCKET_HELPERS_H
+#define TESTS_SOCKET_HELPERS_H
+
 /*
  * @hostname: a DNS name or numeric IP address
  *
@@ -40,3 +42,5 @@ int socket_can_bind_connect(const char *hostname);
  * Returns 0 on success, -1 on fatal error
  */
 int socket_check_protocol_support(bool *has_ipv4, bool *has_ipv6);
+
+#endif
--=20
2.21.0


