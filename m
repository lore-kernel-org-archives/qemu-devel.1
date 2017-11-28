Received: from eggs.gnu.org ([2001:4830:134:3::10]:58825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eJYof-0002Kv-Dt
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 00:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eJYoa-00031O-F9
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 00:52:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ybettan@redhat.com>) id 1eJYoa-00030J-9Q
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 00:52:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5AFDB5F7AC
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 05:52:15 +0000 (UTC)
From: Yoni Bettan <ybettan@redhat.com>
Date: Tue, 28 Nov 2017 07:51:11 +0200
Message-Id: <20171128055111.10101-2-ybettan@redhat.com>
In-Reply-To: <20171128055111.10101-1-ybettan@redhat.com>
References: <20171128055111.10101-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/pci/pci.c : changed the access to
 ObjectClass to use OBJECT_CLASS macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoni Bettan <ybettan@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 02f6f2f37a..d2bf749251 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2014,7 +2014,7 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
 {
     PCIDevice *pci_dev = (PCIDevice *)qdev;
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
-    ObjectClass *klass = &(pc->parent_class.parent_class);
+    ObjectClass *klass = OBJECT_CLASS(pc);
     Error *local_err = NULL;
     PCIBus *bus;
     bool is_default_rom;
-- 
2.13.6
