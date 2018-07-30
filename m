Received: from eggs.gnu.org ([2001:4830:134:3::10]:47515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fjyDq-0004Id-Vj
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:47:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuchenlin@synology.com>) id 1fjyDq-0001eg-58
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 22:47:47 -0400
From: yuchenlin@synology.com
Date: Mon, 30 Jul 2018 10:47:00 +0800
Message-Id: <20180730024701.7613-2-yuchenlin@synology.com>
In-Reply-To: <20180730024701.7613-1-yuchenlin@synology.com>
References: <20180730024701.7613-1-yuchenlin@synology.com>
Subject: [Qemu-devel] [PATCH 1/2] vdi: remove CONFIG_VDI_WRITE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, qemu-block@nongnu.org, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

The CONFIG_VDI_WRITE is here when the first time vdi is added.
But there is no reason to leave an always on and cannot configure option
in the code-side.

Signed-off-by: yuchenlin <yuchenlin@synology.com>
---
 block/vdi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 6555cffb88..12f92e7891 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -70,9 +70,6 @@
 /* Enable debug messages. */
 //~ #define CONFIG_VDI_DEBUG
 
-/* Support write operations on VDI images. */
-#define CONFIG_VDI_WRITE
-
 /* Support non-standard block (cluster) size. This is untested.
  * Maybe it will be needed for very large images.
  */
@@ -1016,9 +1013,7 @@ static BlockDriver bdrv_vdi = {
     .bdrv_make_empty = vdi_make_empty,
 
     .bdrv_co_preadv     = vdi_co_preadv,
-#if defined(CONFIG_VDI_WRITE)
     .bdrv_co_pwritev    = vdi_co_pwritev,
-#endif
 
     .bdrv_get_info = vdi_get_info,
 
-- 
2.17.0
