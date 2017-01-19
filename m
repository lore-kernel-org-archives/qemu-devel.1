Received: from eggs.gnu.org ([2001:4830:134:3::10]:53623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDrS-00089u-7o
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUDrO-00039w-Jx
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:38:46 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 22:38:02 +0800
Message-Id: <20170119143816.21972-3-famz@redhat.com>
In-Reply-To: <20170119143816.21972-1-famz@redhat.com>
References: <20170119143816.21972-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v10 02/16] block: Define BDRV_O_SHARE_RW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, rjones@redhat.com

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/block/block.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 8b0dcda..243839d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -97,6 +97,8 @@ typedef struct HDGeometry {
                                       select an appropriate protocol driver,
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
+#define BDRV_O_SHARE_RW    0x20000 /* accept shared read-write from other users
+                                      of the image */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
-- 
2.9.3
