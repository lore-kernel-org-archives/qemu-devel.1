Received: from eggs.gnu.org ([2001:4830:134:3::10]:48561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnobf-0005hG-O7
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnobf-0004tR-2P
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:43:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 23:43:15 +0800
Message-Id: <20170314154315.17869-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] file-posix: Don't leak fd in
 hdev_get_max_segments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index c4c0663..e6170f4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -703,6 +703,7 @@ static int hdev_get_max_segments(const struct stat *st)
     }
 
 out:
+    close(fd);
     g_free(sysfspath);
     return ret;
 #else
-- 
2.9.3
