Received: from eggs.gnu.org ([209.51.188.92]:45857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaX-00066m-Do
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTY-0005fe-N1
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:57 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:37771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTY-0005fI-FD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:56 -0500
Received: by mail-qt1-f176.google.com with SMTP id t33so105079qtt.4
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:56 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-19-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 18/25] hw/virtio: Use CONFIG_VIRTIO_PCI switch
 instead of CONFIG_PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Thomas Huth <thuth@redhat.com>

For downstream s390x builds, we'd like to be able to build QEMU with
CONFIG_VIRTIO_PCI disabled (since virtio-ccw is used here instead),
but still with CONFIG_PCI enabled. This currently fails since the
virtio-*-pci.o files are still included in the build, but virtio-pci.o
is missing. Use the right config switch CONFIG_VIRTIO_PCI to exclude
the virtio-*-pci.o files from the build.

Reported-by: Miroslav Rezanina <mrezanin@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/Makefile.objs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 16f8e1c154..757a45743e 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -13,7 +13,7 @@ obj-$(CONFIG_VHOST_USER) += vhost-user.o
 obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) += vhost.o vhost-backend.o
 common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL))) += vhost-stub.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
-ifeq ($(CONFIG_PCI),y)
+ifeq ($(CONFIG_VIRTIO_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-user-scsi-pci.o
-- 
MST
