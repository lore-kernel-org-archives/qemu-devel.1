Received: from eggs.gnu.org ([209.51.188.92]:36183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaV-000683-IH
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaU-0003dt-RX
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:15 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:52020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=955018df6=anthony.perard@citrix.com>)
	id 1gzPaU-0003KN-I6
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 12:35:14 -0500
From: Anthony PERARD <anthony.perard@citrix.com>
Date: Thu, 28 Feb 2019 17:34:37 +0000
Message-ID: <20190228173439.8013-3-anthony.perard@citrix.com>
In-Reply-To: <20190228173439.8013-1-anthony.perard@citrix.com>
References: <20190228173439.8013-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 2/4] xen-block: remove redundant assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Peter Maydell <peter.maydell@linaro.org>

From: Paul Durrant <paul.durrant@citrix.com>

The assignment to 'p' is unnecessary as the code will either goto 'invalid'
or p will get overwritten.

Spotted by Coverity: CID 1398638

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Message-Id: <20190215162533.19475-3-paul.durrant@citrix.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
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
Anthony PERARD
