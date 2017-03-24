Received: from eggs.gnu.org ([2001:4830:134:3::10]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@centos7-2.localdomain>) id 1crQlZ-0005O7-T4
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <root@centos7-2.localdomain>) id 1crQlW-0006pp-Pk
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:04:37 -0400
Received: from [39.183.12.116] (port=36763 helo=centos7-2.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@centos7-2.localdomain>) id 1crQlW-0006pS-9P
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 11:04:34 -0400
From: "sochin.jiang" <sochin@aliyun.com>
Date: Fri, 24 Mar 2017 22:28:25 +0800
Message-Id: <1490365705-2912-1-git-send-email-sochin@aliyun.com>
Subject: [Qemu-devel] [PATCH] channel-file: fix wrong parameter comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: berrange@redhat.com
Cc: sochin@aliyun.com, sochin.jiang@huawei.com, qemu-devel@nongnu.org

From: "sochin.jiang" <sochin@aliyun.com>

    fix wrong parameter comments in channel-file.h.

Signed-off-by: sochin.jiang <sochin@aliyun.com>
---
 include/io/channel-file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/io/channel-file.h b/include/io/channel-file.h
index d2462c2..79245f1 100644
--- a/include/io/channel-file.h
+++ b/include/io/channel-file.h
@@ -71,7 +71,7 @@ qio_channel_file_new_fd(int fd);
 
 /**
  * qio_channel_file_new_path:
- * @fd: the file descriptor
+ * @path: the file path
  * @flags: the open flags (O_RDONLY|O_WRONLY|O_RDWR, etc)
  * @mode: the file creation mode if O_WRONLY is set in @flags
  * @errp: pointer to initialized error object
-- 
1.8.3.1
