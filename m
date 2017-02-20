Received: from eggs.gnu.org ([2001:4830:134:3::10]:35107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1cfr8s-0001Ay-7g
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:48:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <v.maffione@gmail.com>) id 1cfr8n-0001aR-9b
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 11:48:50 -0500
From: Vincenzo Maffione <v.maffione@gmail.com>
Date: Mon, 20 Feb 2017 17:45:09 +0100
Message-Id: <20170220164509.27868-1-v.maffione@gmail.com>
Subject: [Qemu-devel] [PATCH] qemu-options.hx: add missing id=chr0 chardev
 argument in vhost-user example
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, Vincenzo Maffione <v.maffione@gmail.com>

In the vhost-user example, a chardev with id chr0 is referenced by the
vhost-user net backend, but the id is not specified in the chardev option.

Signed-off-by: Vincenzo Maffione <v.maffione@gmail.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 5633d3914f..ed22fc479a 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2127,7 +2127,7 @@ Example:
 @example
 qemu -m 512 -object memory-backend-file,id=mem,size=512M,mem-path=/hugetlbfs,share=on \
      -numa node,memdev=mem \
-     -chardev socket,path=/path/to/socket \
+     -chardev socket,id=chr0,path=/path/to/socket \
      -netdev type=vhost-user,id=net0,chardev=chr0 \
      -device virtio-net-pci,netdev=net0
 @end example
-- 
2.11.1
