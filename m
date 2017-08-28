Received: from eggs.gnu.org ([2001:4830:134:3::10]:42584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dmJG6-0005Yr-FF
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dmJG0-0007ck-RK
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:35:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dmJG0-0007at-Kv
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 08:35:08 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 28 Aug 2017 14:35:01 +0200
Message-Id: <20170828123501.22317-4-kraxel@redhat.com>
In-Reply-To: <20170828123501.22317-1-kraxel@redhat.com>
References: <20170828123501.22317-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qxl_unpack_chunks: codestyle fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.com>, Gerd Hoffmann <kraxel@redhat.com>

---
 hw/display/qxl-render.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index b2c98f90c0..90e0865618 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -215,14 +215,17 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
         bytes = MIN(size - offset, chunk->data_size);
         memcpy(dest + offset, chunk->data, bytes);
         offset += bytes;
-        if (offset == size)
+        if (offset == size) {
             return;
+        }
         chunk = qxl_phys2virt(qxl, chunk->next_chunk, group_id);
-        if (!chunk)
+        if (!chunk) {
             return;
+        }
         max_chunks--;
-        if (max_chunks == 0)
+        if (max_chunks == 0) {
             return;
+        }
     }
 }
 
-- 
2.9.3
