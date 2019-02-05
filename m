Received: from eggs.gnu.org ([209.51.188.92]:36507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Gf-0002ed-HK
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gr5Ge-0004Ao-5J
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gr5Gd-00049d-Sn
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:16:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id z15so2673702wrn.1
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 10:16:19 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id p5sm8931665wmh.16.2019.02.05.10.16.17
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 10:16:17 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  5 Feb 2019 19:14:57 +0100
Message-Id: <1549390526-24246-48-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
References: <1549390526-24246-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 47/76] vfio: move conditional up to
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

Instead of wrapping the entire Makefile.objs with an ifeq/endif, just
include the directory only for Linux.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-4-yang.zhong@intel.com>
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
