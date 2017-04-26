Received: from eggs.gnu.org ([2001:4830:134:3::10]:43135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Dik-0002GJ-NR
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Dik-0001YJ-0J
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:34:26 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 26 Apr 2017 11:33:54 +0800
Message-Id: <20170426033413.17192-3-famz@redhat.com>
In-Reply-To: <20170426033413.17192-1-famz@redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v15 02/21] block: Define BLK_PERM_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

This is the order of the largest possible permission.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 include/block/block.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index eb0565d..a798f10 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -224,6 +224,8 @@ enum {
     BLK_PERM_ALL                = 0x1f,
 };
 
+#define BLK_PERM_MAX (64 - clz64((uint64_t)BLK_PERM_ALL))
+
 char *bdrv_perm_names(uint64_t perm);
 
 /* disk I/O throttling */
-- 
2.9.3
