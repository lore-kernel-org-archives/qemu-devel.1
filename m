Received: from eggs.gnu.org ([2001:4830:134:3::10]:38257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBh-0003cw-Qe
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pBh-0000QJ-2R
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:35:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:33:01 +0200
Message-Id: <1494513181-7900-59-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 58/58] MAINTAINERS: Add qemu-progress to the
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

util/qemu-progress.c is currently unmaintained. The only user of its
functionality is qemu-img, so it effectively is part of the block layer.

Suggested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170428165517.30341-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8224be0..145be0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1170,6 +1170,7 @@ F: include/block/
 F: qemu-img*
 F: qemu-io*
 F: tests/qemu-iotests/
+F: util/qemu-progress.c
 T: git git://repo.or.cz/qemu/kevin.git block
 
 Block I/O path
-- 
1.8.3.1
