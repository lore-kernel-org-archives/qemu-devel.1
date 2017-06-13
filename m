Received: from eggs.gnu.org ([2001:4830:134:3::10]:59869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQZ-0001np-2F
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dKmQS-0005LE-89
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:26504 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dKmQR-0005Hu-UD
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:04:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 13 Jun 2017 17:03:37 +0300
Message-Id: <20170613140358.81651-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170613140358.81651-1-vsementsov@virtuozzo.com>
References: <20170613140358.81651-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v21 09/30] block/dirty-bitmap: fix comment for
 BlockDirtyBitmap.disabled field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/dirty-bitmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 90af37287f..573510229a 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -42,7 +42,8 @@ struct BdrvDirtyBitmap {
     BdrvDirtyBitmap *successor; /* Anonymous child; implies frozen status */
     char *name;                 /* Optional non-empty unique ID */
     int64_t size;               /* Size of the bitmap (Number of sectors) */
-    bool disabled;              /* Bitmap is read-only */
+    bool disabled;              /* Bitmap is disabled. It ignores all writes to
+                                   the device */
     int active_iterators;       /* How many iterators are active */
     QLIST_ENTRY(BdrvDirtyBitmap) list;
 };
-- 
2.11.1
