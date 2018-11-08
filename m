Received: from eggs.gnu.org ([2001:4830:134:3::10]:57964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gKlV4-0001Ng-PE
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gKlN9-0001ba-EE
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:33:32 -0500
Received: from m12-17.163.com ([220.181.12.17]:38423)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gKlN5-0001Vc-Q6
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:33:25 -0500
From: Li Qiang <liq3ea@163.com>
Date: Thu,  8 Nov 2018 06:33:06 -0800
Message-Id: <20181108143306.20187-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: set_netdev: make peers an empty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, marcandre.lureau@redhat.com, lvivier@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@163.com>

Though there is no inconsistency between 'queues'
and 'peers[i]' currently, this makes the 'peers[i] == NULL'
meaningful.

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/core/qdev-properties-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 8b22fb51c9..74004a2f33 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -257,7 +257,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     NICPeers *peers_ptr = qdev_get_prop_ptr(dev, prop);
     NetClientState **ncs = peers_ptr->ncs;
-    NetClientState *peers[MAX_QUEUE_NUM];
+    NetClientState *peers[MAX_QUEUE_NUM] = {NULL};
     Error *local_err = NULL;
     int queues, err = 0, i = 0;
     char *str;
-- 
2.17.1
