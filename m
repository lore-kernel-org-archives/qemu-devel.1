Received: from eggs.gnu.org ([2001:4830:134:3::10]:48431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxQ-0000g3-SG
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fnMxN-0008HZ-Av
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fnMxN-0008GV-60
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 07:48:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A70727A7E7
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 11:48:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  8 Aug 2018 13:48:17 +0200
Message-Id: <20180808114830.7169-10-quintela@redhat.com>
In-Reply-To: <20180808114830.7169-1-quintela@redhat.com>
References: <20180808114830.7169-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2 09/22] virtio: Remove unneeded includes
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

They are all already included in virtio_pci.h.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/virtio/virtio-pci.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..cb2ddd3f41 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -18,24 +18,11 @@
 #include "qemu/osdep.h"
 
 #include "standard-headers/linux/virtio_pci.h"
-#include "hw/virtio/virtio.h"
-#include "hw/virtio/virtio-blk.h"
-#include "hw/virtio/virtio-net.h"
-#include "hw/virtio/virtio-serial.h"
-#include "hw/virtio/virtio-scsi.h"
-#include "hw/virtio/virtio-balloon.h"
-#include "hw/virtio/virtio-input.h"
-#include "hw/pci/pci.h"
+#include "virtio-pci.h"
 #include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/loader.h"
 #include "sysemu/kvm.h"
-#include "virtio-pci.h"
 #include "qemu/range.h"
-#include "hw/virtio/virtio-bus.h"
-#include "qapi/visitor.h"
 
 #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
 
-- 
2.17.1
