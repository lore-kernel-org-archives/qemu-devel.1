Received: from eggs.gnu.org ([2001:4830:134:3::10]:59330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDp-0006I9-F7
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAzDo-0004Q8-HX
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dAzDo-0004Q4-BK
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:42:36 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 17 May 2017 10:40:02 -0300
Message-Id: <20170517134003.17110-22-ehabkost@redhat.com>
In-Reply-To: <20170517134003.17110-1-ehabkost@redhat.com>
References: <20170517134003.17110-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 21/22] s390-pcibus: No need to set
 user_creatable=false explicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

TYPE_S390_PCI_HOST_BRIDGE is a subclass of TYPE_PCI_HOST_BRIDGE,
which is a subclass of TYPE_SYS_BUS_DEVICE. TYPE_SYS_BUS_DEVICE
already sets user_creatable=false, so we don't require an
explicit user_creatable=false assignment in
s390_pcihost_class_init().

Cc: Alexander Graf <agraf@suse.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Frank Blaschka <frank.blaschka@de.ibm.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20170503203604.31462-22-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index b60a8f22b0..66a6fbeb8c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -872,7 +872,6 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    dc->user_creatable = false;
     dc->reset = s390_pcihost_reset;
     k->init = s390_pcihost_init;
     hc->plug = s390_pcihost_hot_plug;
-- 
2.11.0.259.g40922b1
