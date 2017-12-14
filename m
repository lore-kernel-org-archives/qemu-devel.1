Received: from eggs.gnu.org ([2001:4830:134:3::10]:55973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3f-00016i-FY
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePX3b-00080w-EA
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:12:31 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 14 Dec 2017 18:09:49 +0100
Message-Id: <20171214171004.25058-32-cohuck@redhat.com>
In-Reply-To: <20171214171004.25058-1-cohuck@redhat.com>
References: <20171214171004.25058-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 31/46] s390x/css: attach css bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Logically, the css bridge should be attached to the machine.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: Bjoern Walk <bwalk@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css-bridge.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index a91a237f37..a02d708239 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -99,6 +99,8 @@ VirtualCssBus *virtual_css_bus_init(void)
 
     /* Create bridge device */
     dev = qdev_create(NULL, TYPE_VIRTUAL_CSS_BRIDGE);
+    object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
+                              OBJECT(dev), NULL);
     qdev_init_nofail(dev);
 
     /* Create bus on bridge device */
-- 
2.13.6
