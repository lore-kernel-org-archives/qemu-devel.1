Received: from eggs.gnu.org ([2001:4830:134:3::10]:36827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSH4-0008Pl-VE
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSH2-0005uh-PD
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSH2-0005uD-Iv
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:16 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  7 Jul 2017 14:21:59 +0200
Message-Id: <20170707122159.24714-8-cohuck@redhat.com>
In-Reply-To: <20170707122159.24714-1-cohuck@redhat.com>
References: <20170707122159.24714-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 7/7] s390x: refine pci dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

We have some code that should properly depend on CONFIG_PCI.
With this change, we can switch off pci for s390x by removing
'CONFIG_PCI=y' from the default config.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 default-configs/s390x-softmmu.mak | 2 +-
 hw/s390x/Makefile.objs            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index b227a36179..7adaa4a4fe 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,5 +1,5 @@
 CONFIG_PCI=y
-CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_PCI=$(CONFIG_PCI)
 CONFIG_VHOST_USER_SCSI=$(CONFIG_LINUX)
 CONFIG_VIRTIO=y
 CONFIG_SCLPCONSOLE=y
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index a8e5575a8a..7040a2c7f2 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -11,7 +11,7 @@ obj-y += 3270-ccw.o
 obj-y += virtio-ccw.o
 obj-y += css-bridge.o
 obj-y += ccw-device.o
-obj-y += s390-pci-bus.o s390-pci-inst.o
+obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
 obj-y += s390-skeys.o
 obj-$(CONFIG_KVM) += s390-skeys-kvm.o
 obj-y += s390-ccw.o
-- 
2.13.0
