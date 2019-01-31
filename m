Received: from eggs.gnu.org ([209.51.188.92]:44309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gpDo2-0004hP-Kt
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gpDo1-0008IJ-MC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:59:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gpDo0-0008HY-EG
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 09:59:04 -0500
Received: by mail-wm1-x343.google.com with SMTP id r24so2326666wmh.0
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 06:59:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 31 Jan 2019 15:59:00 +0100
Message-Id: <1548946740-28714-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: PCI proxy devices should depend on
 CONFIG_VIRTIO_PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com

... otherwise, they break the build in the rare case where
CONFIG_VIRTIO_PCI is disabled (which will not be so rare
once kconfig goes in).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index ea7913d..d335dd0 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -11,7 +11,7 @@ obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-p
 
 obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
-ifeq ($(CONFIG_PCI),y)
+ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
-- 
1.8.3.1
