Received: from eggs.gnu.org ([2001:4830:134:3::10]:57153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUCRp-0007fm-2M
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUCRo-0006JJ-9d
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:08:13 -0500
From: Fam Zheng <famz@redhat.com>
Date: Thu, 19 Jan 2017 21:07:58 +0800
Message-Id: <20170119130759.28319-2-famz@redhat.com>
In-Reply-To: <20170119130759.28319-1-famz@redhat.com>
References: <20170119130759.28319-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qapi: Tweak error message of
 bdrv_query_image_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

@bs doesn't always have a device name, such as when it comes from
"qemu-img info". Report file name instead.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/qapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index a62e862..6329735 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -237,8 +237,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
 
     size = bdrv_getlength(bs);
     if (size < 0) {
-        error_setg_errno(errp, -size, "Can't get size of device '%s'",
-                         bdrv_get_device_name(bs));
+        error_setg_errno(errp, -size, "Can't get image size '%s'",
+                         bs->exact_filename);
         goto out;
     }
 
-- 
2.9.3
