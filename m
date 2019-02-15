Received: from eggs.gnu.org ([209.51.188.92]:54406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugJO-0001Pz-15
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:26:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=9420f6528=Paul.Durrant@citrix.com>)
	id 1gugJN-0007BM-33
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:26:01 -0500
From: Paul Durrant <paul.durrant@citrix.com>
Date: Fri, 15 Feb 2019 16:25:32 +0000
Message-ID: <20190215162533.19475-3-paul.durrant@citrix.com>
In-Reply-To: <20190215162533.19475-1-paul.durrant@citrix.com>
References: <20190215162533.19475-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/3] xen-block: remove redundant assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, xen-devel@lists.xenproject.org
Cc: Paul Durrant <paul.durrant@citrix.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The assignment to 'p' is unnecessary as the code will either goto 'invalid'
or p will get overwritten.

Spotted by Coverity: CID 1398638

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
---
 hw/block/xen-block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 5012af9cb6..29afe2703a 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -413,8 +413,7 @@ static void xen_block_set_vdev(Object *obj, Visitor *v, const char *name,
         }
 
         if (*end == 'p') {
-            p = (char *) ++end;
-            if (*end == '\0') {
+            if (*(++end) == '\0') {
                 goto invalid;
             }
         }
-- 
2.20.1.2.gb21ebb6
