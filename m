Received: from eggs.gnu.org ([2001:4830:134:3::10]:44919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d13GY-0005Lt-Kz
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d13GY-0008EX-1a
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:00:22 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 20 Apr 2017 12:00:03 +0800
Message-Id: <20170420040003.31074-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] sheepdog: Set error when connection fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sheepdog@lists.wpkg.org, qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, Liu Yuan <namei.unix@gmail.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/sheepdog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index fb9203e..7e889ee 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -608,6 +608,7 @@ static int connect_to_sdog(BDRVSheepdogState *s, Error **errp)
         qemu_set_nonblock(fd);
     } else {
         fd = -EIO;
+        error_setg(errp, "Failed to connect to sheepdog server");
     }
 
     return fd;
-- 
2.9.3
