Received: from eggs.gnu.org ([2001:4830:134:3::10]:34185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d49B2-00063l-Dv
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d49B1-0007aM-Gg
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:55:28 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 28 Apr 2017 18:55:17 +0200
Message-Id: <20170428165517.30341-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add qemu-progress to the block
 layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

util/qemu-progress.c is currently unmaintained. The only user of its
functionality is qemu-img, so it effectively is part of the block layer.

Suggested-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1d2b3a4d3..768b4d94ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1168,6 +1168,7 @@ F: include/block/
 F: qemu-img*
 F: qemu-io*
 F: tests/qemu-iotests/
+F: util/qemu-progress.c
 T: git git://repo.or.cz/qemu/kevin.git block
 
 Block I/O path
-- 
2.12.2
