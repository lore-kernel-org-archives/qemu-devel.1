Received: from eggs.gnu.org ([2001:4830:134:3::10]:56493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dddZp-000446-8e
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddaoG-0004Ie-TQ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:31:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddaoG-0004H0-L0
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:30:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 Aug 2017 13:29:46 +0200
Message-Id: <20170804112946.5247-10-cohuck@redhat.com>
In-Reply-To: <20170804112946.5247-1-cohuck@redhat.com>
References: <20170804112946.5247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 9/9] s390x: refine pci dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

VIRTIO_PCI should properly depend on CONFIG_PCI.
With this change, we can switch off pci for s390x by removing
'CONFIG_PCI=y' from the default config.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 default-configs/s390x-softmmu.mak | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.13.3
