Received: from eggs.gnu.org ([2001:4830:134:3::10]:51509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Be-0004QQ-62
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7Bd-0005nR-8b
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cu7Bd-0005mr-21
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:46:37 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:07 -0300
Message-Id: <20170401004624.30886-3-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 02/19] s390: Add FIXME for unexplained
 user_creatable=false line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

TYPE_S390_PCI_HOST_BRIDGE has user_creatable=false but has
no comment explaining why. Add a FIXME to document that.

Cc: Frank Blaschka <frank.blaschka@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Richard Henderson <rth@twiddle.net>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 1ec30c45ce..2c3b960bdf 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -867,7 +867,7 @@ static void s390_pcihost_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    dc->user_creatable = false;
+    dc->user_creatable = false; /*FIXME: explain why */
     dc->reset = s390_pcihost_reset;
     k->init = s390_pcihost_init;
     hc->plug = s390_pcihost_hot_plug;
-- 
2.11.0.259.g40922b1
