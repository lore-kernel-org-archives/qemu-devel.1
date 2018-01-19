Received: from eggs.gnu.org ([2001:4830:134:3::10]:57879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecW7o-0006lV-3L
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1ecW7l-00036a-BQ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 07:50:28 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 19 Jan 2018 15:50:00 +0300
Message-Id: <1516366207-109842-2-git-send-email-anton.nefedov@virtuozzo.com>
In-Reply-To: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 1/8] qapi: group BlockDeviceStats fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@virtuozzo.com, Anton Nefedov <anton.nefedov@virtuozzo.com>

Make the stat fields definition slightly more readable.
Cosmetic change only.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qapi/block-core.json | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index e94a688..2e0665e 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -733,14 +733,26 @@
 # Since: 0.14.0
 ##
 { 'struct': 'BlockDeviceStats',
-  'data': {'rd_bytes': 'int', 'wr_bytes': 'int', 'rd_operations': 'int',
-           'wr_operations': 'int', 'flush_operations': 'int',
+  'data': {'rd_bytes': 'int', 'wr_bytes': 'int',
+
+           'rd_operations': 'int', 'wr_operations': 'int',
+           'flush_operations': 'int',
+
            'flush_total_time_ns': 'int', 'wr_total_time_ns': 'int',
-           'rd_total_time_ns': 'int', 'wr_highest_offset': 'int',
-           'rd_merged': 'int', 'wr_merged': 'int', '*idle_time_ns': 'int',
+           'rd_total_time_ns': 'int',
+
+           'wr_highest_offset': 'int',
+
+           'rd_merged': 'int', 'wr_merged': 'int',
+
+           '*idle_time_ns': 'int',
+
            'failed_rd_operations': 'int', 'failed_wr_operations': 'int',
-           'failed_flush_operations': 'int', 'invalid_rd_operations': 'int',
-           'invalid_wr_operations': 'int', 'invalid_flush_operations': 'int',
+           'failed_flush_operations': 'int',
+
+           'invalid_rd_operations': 'int', 'invalid_wr_operations': 'int',
+           'invalid_flush_operations': 'int',
+
            'account_invalid': 'bool', 'account_failed': 'bool',
            'timed_stats': ['BlockDeviceTimedStats'] } }
 
-- 
2.7.4
