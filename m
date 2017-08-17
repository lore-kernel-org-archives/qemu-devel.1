Received: from eggs.gnu.org ([2001:4830:134:3::10]:39908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1diKOw-0006Qh-Ds
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:59:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1diKOv-0000Ui-Qx
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:59:54 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Date: Thu, 17 Aug 2017 15:59:04 +0300
Message-Id: <20170817125904.7421-1-pbutsykin@virtuozzo.com>
In-Reply-To: <8b89c494-29d8-515f-ac06-69c70c9f34f5@redhat.com>
References: <8b89c494-29d8-515f-ac06-69c70c9f34f5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] follow-up path - " qcow2: add shrink image
 support"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org, pbutsykin@virtuozzo.com

Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
---
 qapi/block-core.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index d6172bfe15..c55cd0c8db 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2479,6 +2479,11 @@
 #
 # Trigger events supported by blkdebug.
 #
+# @l1_shrink_write_table:      write zeros to the l1 table to shrink image.
+#                              (since 2.11)
+#
+# @l1_shrink_free_l2_clusters: discard the l2 tables. (since 2.11)
+#
 # Since: 2.9
 ##
 { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
-- 
2.14.1
