Received: from eggs.gnu.org ([2001:4830:134:3::10]:44348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunc-00059r-H4
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunb-0001fX-L7
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:49 +0200
Message-Id: <20180710154304.18304-10-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 09/24] qapi/block-core.json: Add missing
 documentation for blklogwrites log-append option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Ari Sundholm <ari@tuxera.com>

This was accidentally omitted. Thanks to Eric Blake for spotting this.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 38b31250f9..62a92fa4f4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3057,6 +3057,8 @@
 # @log-sector-size: sector size used in logging writes to @file, determines
 #                   granularity of offsets and sizes of writes (default: 512)
 #
+# @log-append:      append to an existing log (default: false)
+#
 # @log-super-update-interval: interval of write requests after which the log
 #                             super block is updated to disk (default: 4096)
 #
-- 
2.13.6
