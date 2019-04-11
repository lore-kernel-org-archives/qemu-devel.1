Received: from eggs.gnu.org ([209.51.188.92]:58689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEaca-0004cg-Ly
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEacZ-00011s-SI
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:24:08 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 11 Apr 2019 17:23:46 +0300
Message-Id: <e68bde5c675a67b336ad567ec35a138271cf0c87.1554992449.git.berto@igalia.com>
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
References: <cover.1554992449.git.berto@igalia.com>
In-Reply-To: <cover.1554992449.git.berto@igalia.com>
References: <cover.1554992449.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-4.1 2/2] block: Clear the backing_file
 fields on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block.c b/block.c
index e496999e2f..e9c0c9e2ad 100644
--- a/block.c
+++ b/block.c
@@ -1085,6 +1085,9 @@ static void bdrv_backing_detach(BdrvChild *c)
     error_free(parent->backing_blocker);
     parent->backing_blocker = NULL;
 
+    parent->backing_file[0] = '\0';
+    parent->backing_format[0] = '\0';
+
     bdrv_child_cb_detach(c);
 }
 
-- 
2.11.0
