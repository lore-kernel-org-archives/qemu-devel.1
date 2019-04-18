Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC1C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3439E214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3439E214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDur-0002YC-HB
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:45:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDo0-0001U3-Ee
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnw-0002gL-Vq
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHDnw-0002eP-MU
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E97C0C04AC4B
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B5111001DC5
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8B7121132A03; Thu, 18 Apr 2019 22:38:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:38:38 +0200
Message-Id: <20190418203840.10528-8-armbru@redhat.com>
In-Reply-To: <20190418203840.10528-1-armbru@redhat.com>
References: <20190418203840.10528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Thu, 18 Apr 2019 20:38:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 7/9] Clean up ill-advised or unusual
 header guards
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
Message-ID: <20190418203838.erh1qax5TEfkoV69hvCPGWuPHhDVLYOpkMuQpqprKFM@z>

Leading underscores are ill-advised because such identifiers are
reserved.  Trailing underscores are merely ugly.  Strip both.

Our header guards commonly end in _H.  Normalize the exceptions.

Done with scripts/clean-header-guards.pl.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190315145123.28030-7-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[Changes to slirp/ dropped, as we're about to spin it off]
---
 block/crypto.h                     | 6 +++---
 hw/i386/amd_iommu.h                | 4 ++--
 hw/tpm/tpm_ioctl.h                 | 7 ++++---
 hw/xtensa/xtensa_memory.h          | 4 ++--
 include/authz/base.h               | 7 +++----
 include/authz/list.h               | 7 +++----
 include/authz/simple.h             | 7 +++----
 include/chardev/spice.h            | 4 ++--
 include/hw/ppc/pnv.h               | 7 ++++---
 include/hw/ppc/pnv_core.h          | 7 ++++---
 include/hw/ppc/pnv_lpc.h           | 7 ++++---
 include/hw/ppc/pnv_occ.h           | 7 ++++---
 include/hw/ppc/pnv_psi.h           | 7 ++++---
 include/hw/ppc/pnv_xscom.h         | 7 ++++---
 include/hw/ppc/spapr_ovec.h        | 7 ++++---
 include/hw/timer/pl031.h           | 4 ++--
 include/hw/virtio/vhost-vsock.h    | 6 +++---
 include/hw/virtio/virtio-crypto.h  | 6 +++---
 include/hw/xen/start_info.h        | 6 +++---
 include/hw/xtensa/mx_pic.h         | 4 ++--
 include/qemu/drm.h                 | 4 ++--
 include/qemu/jhash.h               | 6 +++---
 include/sysemu/hvf.h               | 5 +++--
 linux-user/xtensa/syscall_nr.h     | 6 +++---
 linux-user/xtensa/target_structs.h | 4 ++--
 linux-user/xtensa/termbits.h       | 6 +++---
 qga/vss-win32/vss-handles.h        | 4 ++--
 target/i386/hax-i386.h             | 4 ++--
 target/i386/hax-interface.h        | 4 ++--
 target/i386/hvf/hvf-i386.h         | 4 ++--
 target/i386/hvf/vmcs.h             | 4 ++--
 target/i386/hvf/x86_emu.h          | 5 +++--
 target/i386/hvf/x86_flags.h        | 7 ++++---
 target/i386/hvf/x86_mmu.h          | 7 ++++---
 target/riscv/pmp.h                 | 4 ++--
 target/sparc/asi.h                 | 6 +++---
 tests/libqos/e1000e.h              | 4 ++--
 tests/libqos/sdhci.h               | 4 ++--
 38 files changed, 109 insertions(+), 100 deletions(-)

diff --git a/block/crypto.h b/block/crypto.h
index dd7d47903c..b935695e79 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -18,8 +18,8 @@
  *
  */
=20
-#ifndef BLOCK_CRYPTO_H__
-#define BLOCK_CRYPTO_H__
+#ifndef BLOCK_CRYPTO_H
+#define BLOCK_CRYPTO_H
=20
 #define BLOCK_CRYPTO_OPT_DEF_KEY_SECRET(prefix, helpstr)                =
\
     {                                                                   =
\
@@ -94,4 +94,4 @@ block_crypto_create_opts_init(QDict *opts, Error **errp=
);
 QCryptoBlockOpenOptions *
 block_crypto_open_opts_init(QDict *opts, Error **errp);
=20
-#endif /* BLOCK_CRYPTO_H__ */
+#endif /* BLOCK_CRYPTO_H */
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 0ff9095f32..3a694b186b 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -18,8 +18,8 @@
  * with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
-#ifndef AMD_IOMMU_H_
-#define AMD_IOMMU_H_
+#ifndef AMD_IOMMU_H
+#define AMD_IOMMU_H
=20
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
diff --git a/hw/tpm/tpm_ioctl.h b/hw/tpm/tpm_ioctl.h
index 59a0b0595d..f5f5c553a9 100644
--- a/hw/tpm/tpm_ioctl.h
+++ b/hw/tpm/tpm_ioctl.h
@@ -5,8 +5,9 @@
  *
  * This file is licensed under the terms of the 3-clause BSD license
  */
-#ifndef _TPM_IOCTL_H_
-#define _TPM_IOCTL_H_
+
+#ifndef TPM_IOCTL_H
+#define TPM_IOCTL_H
=20
 #include <sys/uio.h>
 #include <sys/ioctl.h>
@@ -267,4 +268,4 @@ enum {
     CMD_SET_BUFFERSIZE,
 };
=20
-#endif /* _TPM_IOCTL_H */
+#endif /* TPM_IOCTL_H */
diff --git a/hw/xtensa/xtensa_memory.h b/hw/xtensa/xtensa_memory.h
index e9aa08749d..89125c4a0d 100644
--- a/hw/xtensa/xtensa_memory.h
+++ b/hw/xtensa/xtensa_memory.h
@@ -25,8 +25,8 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
=20
-#ifndef _XTENSA_MEMORY_H
-#define _XTENSA_MEMORY_H
+#ifndef XTENSA_MEMORY_H
+#define XTENSA_MEMORY_H
=20
 #include "qemu-common.h"
 #include "cpu.h"
diff --git a/include/authz/base.h b/include/authz/base.h
index 55ac9581ad..14a59a0425 100644
--- a/include/authz/base.h
+++ b/include/authz/base.h
@@ -18,8 +18,8 @@
  *
  */
=20
-#ifndef QAUTHZ_BASE_H__
-#define QAUTHZ_BASE_H__
+#ifndef QAUTHZ_BASE_H
+#define QAUTHZ_BASE_H
=20
 #include "qemu-common.h"
 #include "qapi/error.h"
@@ -108,5 +108,4 @@ bool qauthz_is_allowed_by_id(const char *authzid,
                              const char *identity,
                              Error **errp);
=20
-#endif /* QAUTHZ_BASE_H__ */
-
+#endif /* QAUTHZ_BASE_H */
diff --git a/include/authz/list.h b/include/authz/list.h
index 138ae7047c..a88cdbbcf8 100644
--- a/include/authz/list.h
+++ b/include/authz/list.h
@@ -18,8 +18,8 @@
  *
  */
=20
-#ifndef QAUTHZ_LIST_H__
-#define QAUTHZ_LIST_H__
+#ifndef QAUTHZ_LIST_H
+#define QAUTHZ_LIST_H
=20
 #include "authz/base.h"
 #include "qapi/qapi-types-authz.h"
@@ -102,5 +102,4 @@ ssize_t qauthz_list_delete_rule(QAuthZList *auth,
                                 const char *match);
=20
=20
-#endif /* QAUTHZ_LIST_H__ */
-
+#endif /* QAUTHZ_LIST_H */
diff --git a/include/authz/simple.h b/include/authz/simple.h
index 30b932dfeb..2b7ab0cdd9 100644
--- a/include/authz/simple.h
+++ b/include/authz/simple.h
@@ -18,8 +18,8 @@
  *
  */
=20
-#ifndef QAUTHZ_SIMPLE_H__
-#define QAUTHZ_SIMPLE_H__
+#ifndef QAUTHZ_SIMPLE_H
+#define QAUTHZ_SIMPLE_H
=20
 #include "authz/base.h"
=20
@@ -80,5 +80,4 @@ QAuthZSimple *qauthz_simple_new(const char *id,
                                 Error **errp);
=20
=20
-#endif /* QAUTHZ_SIMPLE_H__ */
-
+#endif /* QAUTHZ_SIMPLE_H */
diff --git a/include/chardev/spice.h b/include/chardev/spice.h
index 6431da3205..1f7339b649 100644
--- a/include/chardev/spice.h
+++ b/include/chardev/spice.h
@@ -1,5 +1,5 @@
-#ifndef CHARDEV_SPICE_H_
-#define CHARDEV_SPICE_H_
+#ifndef CHARDEV_SPICE_H
+#define CHARDEV_SPICE_H
=20
 #include <spice.h>
 #include "chardev/char-fe.h"
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index e5b00d373e..fc4678f757 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -16,8 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef _PPC_PNV_H
-#define _PPC_PNV_H
+
+#ifndef PPC_PNV_H
+#define PPC_PNV_H
=20
 #include "hw/boards.h"
 #include "hw/sysbus.h"
@@ -255,4 +256,4 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV9_PSIHB_ESB_SIZE          0x0000000000010000ull
 #define PNV9_PSIHB_ESB_BASE(chip)    PNV9_CHIP_BASE(chip, 0x00060302031c=
0000ull)
=20
-#endif /* _PPC_PNV_H */
+#endif /* PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 50cdb2b358..d0926454a9 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -16,8 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef _PPC_PNV_CORE_H
-#define _PPC_PNV_CORE_H
+
+#ifndef PPC_PNV_CORE_H
+#define PPC_PNV_CORE_H
=20
 #include "hw/cpu/core.h"
=20
@@ -68,4 +69,4 @@ typedef struct PnvQuad {
     uint32_t id;
     MemoryRegion xscom_regs;
 } PnvQuad;
-#endif /* _PPC_PNV_CORE_H */
+#endif /* PPC_PNV_CORE_H */
diff --git a/include/hw/ppc/pnv_lpc.h b/include/hw/ppc/pnv_lpc.h
index 413579792e..f659410716 100644
--- a/include/hw/ppc/pnv_lpc.h
+++ b/include/hw/ppc/pnv_lpc.h
@@ -16,8 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef _PPC_PNV_LPC_H
-#define _PPC_PNV_LPC_H
+
+#ifndef PPC_PNV_LPC_H
+#define PPC_PNV_LPC_H
=20
 #include "hw/ppc/pnv_psi.h"
=20
@@ -98,4 +99,4 @@ struct PnvChip;
 ISABus *pnv_lpc_isa_create(PnvLpcController *lpc, bool use_cpld, Error *=
*errp);
 int pnv_dt_lpc(struct PnvChip *chip, void *fdt, int root_offset);
=20
-#endif /* _PPC_PNV_LPC_H */
+#endif /* PPC_PNV_LPC_H */
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index d22b65a71a..ed0709bfc0 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -16,8 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef _PPC_PNV_OCC_H
-#define _PPC_PNV_OCC_H
+
+#ifndef PPC_PNV_OCC_H
+#define PPC_PNV_OCC_H
=20
 #include "hw/ppc/pnv_psi.h"
=20
@@ -52,4 +53,4 @@ typedef struct PnvOCCClass {
     int psi_irq;
 } PnvOCCClass;
=20
-#endif /* _PPC_PNV_OCC_H */
+#endif /* PPC_PNV_OCC_H */
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 2c1b27e865..e82df9709f 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -16,8 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef _PPC_PNV_PSI_H
-#define _PPC_PNV_PSI_H
+
+#ifndef PPC_PNV_PSI_H
+#define PPC_PNV_PSI_H
=20
 #include "hw/sysbus.h"
 #include "hw/ppc/xics.h"
@@ -118,4 +119,4 @@ void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state=
);
=20
 void pnv_psi_pic_print_info(Pnv9Psi *psi, Monitor *mon);
=20
-#endif /* _PPC_PNV_PSI_H */
+#endif /* PPC_PNV_PSI_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 68dfae0dfe..c842d950d2 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -16,8 +16,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef _PPC_PNV_XSCOM_H
-#define _PPC_PNV_XSCOM_H
+
+#ifndef PPC_PNV_XSCOM_H
+#define PPC_PNV_XSCOM_H
=20
 #include "qom/object.h"
=20
@@ -98,4 +99,4 @@ extern void pnv_xscom_region_init(MemoryRegion *mr,
                                   const char *name,
                                   uint64_t size);
=20
-#endif /* _PPC_PNV_XSCOM_H */
+#endif /* PPC_PNV_XSCOM_H */
diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index 188a9367e2..5de5ecf5de 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -33,8 +33,9 @@
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
  * See the COPYING file in the top-level directory.
  */
-#ifndef _SPAPR_OVEC_H
-#define _SPAPR_OVEC_H
+
+#ifndef SPAPR_OVEC_H
+#define SPAPR_OVEC_H
=20
 #include "cpu.h"
 #include "migration/vmstate.h"
@@ -80,4 +81,4 @@ int spapr_ovec_populate_dt(void *fdt, int fdt_offset,
 /* migration */
 extern const VMStateDescription vmstate_spapr_ovec;
=20
-#endif /* !defined (_SPAPR_OVEC_H) */
+#endif /* SPAPR_OVEC_H */
diff --git a/include/hw/timer/pl031.h b/include/hw/timer/pl031.h
index 99416d8ba5..8857c24ca5 100644
--- a/include/hw/timer/pl031.h
+++ b/include/hw/timer/pl031.h
@@ -11,8 +11,8 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
=20
-#ifndef HW_TIMER_PL031
-#define HW_TIMER_PL031
+#ifndef HW_TIMER_PL031_H
+#define HW_TIMER_PL031_H
=20
 #include "hw/sysbus.h"
=20
diff --git a/include/hw/virtio/vhost-vsock.h b/include/hw/virtio/vhost-vs=
ock.h
index 7b9205fe3f..d509d67c4a 100644
--- a/include/hw/virtio/vhost-vsock.h
+++ b/include/hw/virtio/vhost-vsock.h
@@ -11,8 +11,8 @@
  * top-level directory.
  */
=20
-#ifndef _QEMU_VHOST_VSOCK_H
-#define _QEMU_VHOST_VSOCK_H
+#ifndef QEMU_VHOST_VSOCK_H
+#define QEMU_VHOST_VSOCK_H
=20
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
@@ -38,4 +38,4 @@ typedef struct {
     /*< public >*/
 } VHostVSock;
=20
-#endif /* _QEMU_VHOST_VSOCK_H */
+#endif /* QEMU_VHOST_VSOCK_H */
diff --git a/include/hw/virtio/virtio-crypto.h b/include/hw/virtio/virtio=
-crypto.h
index ca3a04938e..ffe2391ece 100644
--- a/include/hw/virtio/virtio-crypto.h
+++ b/include/hw/virtio/virtio-crypto.h
@@ -11,8 +11,8 @@
  * top-level directory.
  */
=20
-#ifndef _QEMU_VIRTIO_CRYPTO_H
-#define _QEMU_VIRTIO_CRYPTO_H
+#ifndef QEMU_VIRTIO_CRYPTO_H
+#define QEMU_VIRTIO_CRYPTO_H
=20
 #include "standard-headers/linux/virtio_crypto.h"
 #include "hw/virtio/virtio.h"
@@ -99,4 +99,4 @@ typedef struct VirtIOCrypto {
     uint8_t vhost_started;
 } VirtIOCrypto;
=20
-#endif /* _QEMU_VIRTIO_CRYPTO_H */
+#endif /* QEMU_VIRTIO_CRYPTO_H */
diff --git a/include/hw/xen/start_info.h b/include/hw/xen/start_info.h
index 348779eb10..6ed4877794 100644
--- a/include/hw/xen/start_info.h
+++ b/include/hw/xen/start_info.h
@@ -20,8 +20,8 @@
  * Copyright (c) 2016, Citrix Systems, Inc.
  */
=20
-#ifndef __XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H__
-#define __XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H__
+#ifndef XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H
+#define XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H
=20
 /*
  * Start of day structure passed to PVH guests and to HVM guests in %ebx=
.
@@ -143,4 +143,4 @@ struct hvm_memmap_table_entry {
     uint32_t reserved;
 };
=20
-#endif /* __XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H__ */
+#endif /* XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H */
diff --git a/include/hw/xtensa/mx_pic.h b/include/hw/xtensa/mx_pic.h
index e6cd8cf016..c9ea9e737c 100644
--- a/include/hw/xtensa/mx_pic.h
+++ b/include/hw/xtensa/mx_pic.h
@@ -25,8 +25,8 @@
  * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
=20
-#ifndef _XTENSA_MX_PIC_H
-#define _XTENSA_MX_PIC_H
+#ifndef XTENSA_MX_PIC_H
+#define XTENSA_MX_PIC_H
=20
 #include "exec/memory.h"
 #include "hw/irq.h"
diff --git a/include/qemu/drm.h b/include/qemu/drm.h
index 4c3e622f5c..fab74d4be9 100644
--- a/include/qemu/drm.h
+++ b/include/qemu/drm.h
@@ -1,5 +1,5 @@
-#ifndef QEMU_DRM_H_
-#define QEMU_DRM_H_
+#ifndef QEMU_DRM_H
+#define QEMU_DRM_H
=20
 int qemu_drm_rendernode_open(const char *rendernode);
=20
diff --git a/include/qemu/jhash.h b/include/qemu/jhash.h
index 7222242615..84d14dc7f7 100644
--- a/include/qemu/jhash.h
+++ b/include/qemu/jhash.h
@@ -21,8 +21,8 @@
   * Jozsef
   */
=20
-#ifndef QEMU_JHASH_H__
-#define QEMU_JHASH_H__
+#ifndef QEMU_JHASH_H
+#define QEMU_JHASH_H
=20
 #include "qemu/bitops.h"
=20
@@ -56,4 +56,4 @@
 /* An arbitrary initial parameter */
 #define JHASH_INITVAL           0xdeadbeef
=20
-#endif /* QEMU_JHASH_H__ */
+#endif /* QEMU_JHASH_H */
diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
index aaa51d2c51..300bf3e9a8 100644
--- a/include/sysemu/hvf.h
+++ b/include/sysemu/hvf.h
@@ -9,8 +9,9 @@
  */
=20
 /* header to be included in non-HVF-specific code */
-#ifndef _HVF_H
-#define _HVF_H
+
+#ifndef HVF_H
+#define HVF_H
=20
 #include "qemu-common.h"
 #include "qemu/bitops.h"
diff --git a/linux-user/xtensa/syscall_nr.h b/linux-user/xtensa/syscall_n=
r.h
index cd5ef45f84..27645bea47 100644
--- a/linux-user/xtensa/syscall_nr.h
+++ b/linux-user/xtensa/syscall_nr.h
@@ -8,8 +8,8 @@
  * Copyright (C) 2001 - 2009 Tensilica Inc.
  */
=20
-#ifndef _XTENSA_UNISTD_H
-#define _XTENSA_UNISTD_H
+#ifndef XTENSA_SYSCALL_NR_H
+#define XTENSA_SYSCALL_NR_H
=20
 #define TARGET_NR_spill                                0
 #define TARGET_NR_xtensa                               1
@@ -434,4 +434,4 @@
=20
 #define TARGET_NR_syscall_count                      352
=20
-#endif  /* _XTENSA_UNISTD_H */
+#endif /* XTENSA_SYSCALL_NR_H */
diff --git a/linux-user/xtensa/target_structs.h b/linux-user/xtensa/targe=
t_structs.h
index 1b3d9ca314..9cde6844b8 100644
--- a/linux-user/xtensa/target_structs.h
+++ b/linux-user/xtensa/target_structs.h
@@ -1,5 +1,5 @@
-#ifndef XTENSA_TARGET_STRUCTS_T
-#define XTENSA_TARGET_STRUCTS_T
+#ifndef XTENSA_TARGET_STRUCTS_H
+#define XTENSA_TARGET_STRUCTS_H
=20
 struct target_ipc_perm {
     abi_int __key;                      /* Key.  */
diff --git a/linux-user/xtensa/termbits.h b/linux-user/xtensa/termbits.h
index eed8286de7..d1e09e61a6 100644
--- a/linux-user/xtensa/termbits.h
+++ b/linux-user/xtensa/termbits.h
@@ -10,8 +10,8 @@
  * Copyright (C) 2001 - 2005 Tensilica Inc.
  */
=20
-#ifndef _XTENSA_TERMBITS_H
-#define _XTENSA_TERMBITS_H
+#ifndef XTENSA_TERMBITS_H
+#define XTENSA_TERMBITS_H
=20
 #include <linux/posix_types.h>
=20
@@ -325,4 +325,4 @@ struct target_ktermios {
=20
 #define TARGET_TIOCMIWAIT  _IO('T', 92) /* wait for a change on serial i=
nput line(s) */
 #define TARGET_TIOCGICOUNT 0x545D  /* read serial port inline interrupt =
counts */
-#endif  /* _XTENSA_TERMBITS_H */
+#endif /* XTENSA_TERMBITS_H */
diff --git a/qga/vss-win32/vss-handles.h b/qga/vss-win32/vss-handles.h
index ff399dd73a..0f8a741ad2 100644
--- a/qga/vss-win32/vss-handles.h
+++ b/qga/vss-win32/vss-handles.h
@@ -1,5 +1,5 @@
-#ifndef VSS_HANDLES
-#define VSS_HANDLES
+#ifndef VSS_HANDLES_H
+#define VSS_HANDLES_H
=20
 /* Constants for QGA VSS Provider */
=20
diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
index f13fa4638f..54e9d8b057 100644
--- a/target/i386/hax-i386.h
+++ b/target/i386/hax-i386.h
@@ -10,8 +10,8 @@
  *
  */
=20
-#ifndef _HAX_I386_H
-#define _HAX_I386_H
+#ifndef HAX_I386_H
+#define HAX_I386_H
=20
 #include "cpu.h"
 #include "sysemu/hax.h"
diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
index 93d5fcb1dc..537ae084e9 100644
--- a/target/i386/hax-interface.h
+++ b/target/i386/hax-interface.h
@@ -14,8 +14,8 @@
=20
 /* Interface with HAX kernel module */
=20
-#ifndef _HAX_INTERFACE_H
-#define _HAX_INTERFACE_H
+#ifndef HAX_INTERFACE_H
+#define HAX_INTERFACE_H
=20
 /* fx_layout has 3 formats table 3-56, 512bytes */
 struct fx_layout {
diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 2232501552..15ee4835cf 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -13,8 +13,8 @@
  *
  */
=20
-#ifndef _HVF_I386_H
-#define _HVF_I386_H
+#ifndef HVF_I386_H
+#define HVF_I386_H
=20
 #include "sysemu/hvf.h"
 #include "cpu.h"
diff --git a/target/i386/hvf/vmcs.h b/target/i386/hvf/vmcs.h
index 2a8c0424a5..42de7ebc3a 100644
--- a/target/i386/hvf/vmcs.h
+++ b/target/i386/hvf/vmcs.h
@@ -26,8 +26,8 @@
  * $FreeBSD$
  */
=20
-#ifndef _VMCS_H_
-#define _VMCS_H_
+#ifndef VMCS_H
+#define VMCS_H
=20
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index fbb4832576..f92a9c54b5 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -15,8 +15,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this program; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef __X86_EMU_H__
-#define __X86_EMU_H__
+
+#ifndef X86_EMU_H
+#define X86_EMU_H
=20
 #include "x86.h"
 #include "x86_decode.h"
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/hvf/x86_flags.h
index 8942745988..785e80cfca 100644
--- a/target/i386/hvf/x86_flags.h
+++ b/target/i386/hvf/x86_flags.h
@@ -20,8 +20,9 @@
 /*
  * x86 eflags functions
  */
-#ifndef __X86_FLAGS_H__
-#define __X86_FLAGS_H__
+
+#ifndef X86_FLAGS_H
+#define X86_FLAGS_H
=20
 #include "cpu.h"
 void lflags_to_rflags(CPUX86State *env);
@@ -77,4 +78,4 @@ void SET_FLAGS_OSZAPC_LOGIC16(CPUX86State *env, uint16_=
t v1, uint16_t v2,
 void SET_FLAGS_OSZAPC_LOGIC8(CPUX86State *env, uint8_t v1, uint8_t v2,
                              uint8_t diff);
=20
-#endif /* __X86_FLAGS_H__ */
+#endif /* X86_FLAGS_H */
diff --git a/target/i386/hvf/x86_mmu.h b/target/i386/hvf/x86_mmu.h
index 0bd1acc94f..cd6e137e79 100644
--- a/target/i386/hvf/x86_mmu.h
+++ b/target/i386/hvf/x86_mmu.h
@@ -15,8 +15,9 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this program; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef __X86_MMU_H__
-#define __X86_MMU_H__
+
+#ifndef X86_MMU_H
+#define X86_MMU_H
=20
 #define PT_PRESENT      (1 << 0)
 #define PT_WRITE        (1 << 1)
@@ -40,4 +41,4 @@ bool mmu_gva_to_gpa(struct CPUState *cpu, target_ulong =
gva, uint64_t *gpa);
 void vmx_write_mem(struct CPUState *cpu, target_ulong gva, void *data, i=
nt bytes);
 void vmx_read_mem(struct CPUState *cpu, void *data, target_ulong gva, in=
t bytes);
=20
-#endif /* __X86_MMU_H__ */
+#endif /* X86_MMU_H */
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index e3953c885f..66790950eb 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -19,8 +19,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
=20
-#ifndef _RISCV_PMP_H_
-#define _RISCV_PMP_H_
+#ifndef RISCV_PMP_H
+#define RISCV_PMP_H
=20
 typedef enum {
     PMP_READ  =3D 1 << 0,
diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index d8d6284125..bb58735ddb 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -1,5 +1,5 @@
-#ifndef _SPARC_ASI_H
-#define _SPARC_ASI_H
+#ifndef SPARC_ASI_H
+#define SPARC_ASI_H
=20
 /* asi.h:  Address Space Identifier values for the sparc.
  *
@@ -309,4 +309,4 @@
 				      * implicit, little-endian
 				      */
=20
-#endif /* _SPARC_ASI_H */
+#endif /* SPARC_ASI_H */
diff --git a/tests/libqos/e1000e.h b/tests/libqos/e1000e.h
index 9d37094f43..dc4ab10f58 100644
--- a/tests/libqos/e1000e.h
+++ b/tests/libqos/e1000e.h
@@ -16,8 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
-#ifndef QGRAPH_E1000E
-#define QGRAPH_E1000E
+#ifndef QGRAPH_E1000E_H
+#define QGRAPH_E1000E_H
=20
 #include "libqos/qgraph.h"
 #include "pci.h"
diff --git a/tests/libqos/sdhci.h b/tests/libqos/sdhci.h
index 032d815c38..a88b45ae9d 100644
--- a/tests/libqos/sdhci.h
+++ b/tests/libqos/sdhci.h
@@ -16,8 +16,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>
  */
=20
-#ifndef QGRAPH_QSDHCI
-#define QGRAPH_QSDHCI
+#ifndef QGRAPH_QSDHCI_H
+#define QGRAPH_QSDHCI_H
=20
 #include "libqos/qgraph.h"
 #include "pci.h"
--=20
2.17.2


