Received: from eggs.gnu.org ([2001:4830:134:3::10]:46924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6H-00051c-Nf
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ccj6G-00075P-ML
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 20:37:13 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sun, 12 Feb 2017 02:36:46 +0100
Message-Id: <20170212013704.6378-1-mreitz@redhat.com>
In-Reply-To: <20170212013440.5919-1-mreitz@redhat.com>
References: <20170212013440.5919-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 03/21] qapi: Tweak error message of
 bdrv_query_image_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Fam Zheng <famz@redhat.com>

@bs doesn't always have a device name, such as when it comes from
"qemu-img info". Report file name instead.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20170119130759.28319-2-famz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index a62e862f3c..63297353f7 100644
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
2.11.0
