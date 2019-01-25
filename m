Received: from eggs.gnu.org ([209.51.188.92]:57805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOT-0007L0-6O
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyOQ-0001YU-Rq
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:24 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:40453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyOP-0001TM-14
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:07:21 -0500
Received: by mail-wr1-x433.google.com with SMTP id p4so9622539wrt.7
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:07:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:06:22 +0100
Message-Id: <1548410831-19553-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 03/52] vfio: move conditional up to
 hw/Makefile.objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

Instead of wrapping the entire Makefile.objs with an ifeq/endif, just
include the directory only for Linux.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs      | 2 +-
 hw/vfio/Makefile.objs | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 39d882a..22dd211 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -30,7 +30,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += ssi/
 devices-dirs-$(CONFIG_SOFTMMU) += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-$(CONFIG_SOFTMMU) += usb/
-devices-dirs-$(CONFIG_SOFTMMU) += vfio/
+devices-dirs-$(CONFIG_LINUX) += vfio/
 devices-dirs-$(CONFIG_SOFTMMU) += virtio/
 devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index 8b3f664..9180589 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,4 +1,3 @@
-ifeq ($(CONFIG_LINUX), y)
 obj-$(CONFIG_SOFTMMU) += common.o
 obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
 obj-$(CONFIG_VFIO_CCW) += ccw.o
@@ -7,4 +6,3 @@ obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
 obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
 obj-$(CONFIG_SOFTMMU) += spapr.o
 obj-$(CONFIG_VFIO_AP) += ap.o
-endif
-- 
1.8.3.1
