Received: from eggs.gnu.org ([2001:4830:134:3::10]:55042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOic-0005rX-2b
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ffOib-0007av-2K
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ffOia-0007aY-Tw
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 08:04:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 826A27D84D
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:04:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 17 Jul 2018 14:04:13 +0200
Message-Id: <20180717120414.5852-14-quintela@redhat.com>
In-Reply-To: <20180717120414.5852-1-quintela@redhat.com>
References: <20180717120414.5852-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 13/14] check: Only test virtio-input when it is
 compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

The full of it.  Introspection is able to search for drivers that you
aren't there, so just disable it.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/virtio-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 75c96990c0..987d7c0a5a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2524,6 +2524,7 @@ static const TypeInfo virtio_rng_pci_info = {
 #endif
 /* virtio-input-pci */
 
+#ifdef CONFIG_VIRTIO_INPUT
 static Property virtio_input_pci_properties[] = {
     DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors, 2),
     DEFINE_PROP_END_OF_LIST(),
@@ -2645,6 +2646,7 @@ static const TypeInfo virtio_host_pci_info = {
     .instance_init = virtio_host_initfn,
 };
 #endif
+#endif
 
 /* virtio-pci-bus */
 
@@ -2696,6 +2698,7 @@ static void virtio_pci_register_types(void)
 #ifdef CONFIG_VIRTIO_RNG
     type_register_static(&virtio_rng_pci_info);
 #endif
+#ifdef CONFIG_VIRTIO_INPUT
     type_register_static(&virtio_input_pci_info);
     type_register_static(&virtio_input_hid_pci_info);
     type_register_static(&virtio_keyboard_pci_info);
@@ -2703,6 +2706,7 @@ static void virtio_pci_register_types(void)
     type_register_static(&virtio_tablet_pci_info);
 #ifdef CONFIG_LINUX
     type_register_static(&virtio_host_pci_info);
+#endif
 #endif
     type_register_static(&virtio_pci_bus_info);
     type_register_static(&virtio_pci_info);
-- 
2.17.1
