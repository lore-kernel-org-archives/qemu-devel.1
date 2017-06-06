Received: from eggs.gnu.org ([2001:4830:134:3::10]:36207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dI8Zs-00049A-Hv
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dI8Zr-0007sz-Mr
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:06:56 -0400
From: "sochin.jiang" <sochin.jiang@huawei.com>
Date: Tue, 6 Jun 2017 15:03:19 +0800
Message-ID: <1496732599-7977-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qemu-img: supplement the omitted 'disk size'
 bytes info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

From: "sochin.jiang" <sochin.jiang@huawei.com>

 Supplement the omitted 'disk size' bytes information when using

 'qemu-img info',it is useful in some occasion. Anyhow, it looks

 strange that 'virtual size' has bytes while actual 'disk size'

 does not.

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
---
 block/qapi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index a40922e..9bb5956 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -703,10 +703,11 @@ void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
                  "image: %s\n"
                  "file format: %s\n"
                  "virtual size: %s (%" PRId64 " bytes)\n"
-                 "disk size: %s\n",
+                 "disk size: %s (%" PRId64 " bytes)\n",
                  info->filename, info->format, size_buf,
                  info->virtual_size,
-                 dsize_buf);
+                 dsize_buf,
+                 info->actual_size);
 
     if (info->has_encrypted && info->encrypted) {
         func_fprintf(f, "encrypted: yes\n");
-- 
1.8.3.1
