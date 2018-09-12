Received: from eggs.gnu.org ([2001:4830:134:3::10]:60579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aR-00071e-Q6
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aP-0003cD-9u
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:51 -0400
Received: from m12-15.163.com ([220.181.12.15]:51797)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1g07aO-0003bd-K8
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 12:01:49 -0400
From: Li Qiang <liq3ea@163.com>
Date: Wed, 12 Sep 2018 09:01:12 -0700
Message-Id: <20180912160118.21158-3-liq3ea@163.com>
In-Reply-To: <20180912160118.21158-1-liq3ea@163.com>
References: <20180912160118.21158-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH 2/8] hw: debugexit: add read callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/misc/debugexit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index 84fa1a5b9d..bed293247e 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -23,6 +23,11 @@ typedef struct ISADebugExitState {
     MemoryRegion io;
 } ISADebugExitState;
 
+static uint64_t debug_exit_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
 static void debug_exit_write(void *opaque, hwaddr addr, uint64_t val,
                              unsigned width)
 {
@@ -30,6 +35,7 @@ static void debug_exit_write(void *opaque, hwaddr addr, uint64_t val,
 }
 
 static const MemoryRegionOps debug_exit_ops = {
+    .read = debug_exit_read,
     .write = debug_exit_write,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-- 
2.17.1
