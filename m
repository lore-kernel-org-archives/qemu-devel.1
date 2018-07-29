Received: from eggs.gnu.org ([2001:4830:134:3::10]:33886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF2-00020W-8I
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF0-0000X4-3e
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:40 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 30 Jul 2018 00:27:42 +0300
Message-Id: <20180729212744.23709-5-lbloch@janustech.com>
In-Reply-To: <20180729212744.23709-1-lbloch@janustech.com>
References: <20180729212744.23709-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/6] qcow2: Update total_sectors when resizing
 the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 block/qcow2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..223d351e40 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3646,6 +3646,8 @@ static int coroutine_fn qcow2_co_truncate(BlockDriverState *bs, int64_t offset,
         }
     }
 
+    bs->total_sectors = offset / 512;
+
     /* write updated header.size */
     offset = cpu_to_be64(offset);
     ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, size),
-- 
2.17.1
