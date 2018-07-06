Received: from eggs.gnu.org ([2001:4830:134:3::10]:36805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fbPjr-000445-4G
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:21:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fbPjo-0000Oo-0f
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:21:27 -0400
Received: from mx2.mpynet.fi ([82.197.21.85]:39104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ari@tuxera.com>) id 1fbPjn-0000OV-Q0
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:21:23 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 6 Jul 2018 15:21:18 +0300
Message-ID: <1530879678-20487-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] qapi/block-core.json: Add missing
 documentation for blklogwrites log-append option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

This was accidentally omitted. Thanks to Eric Blake for spotting this.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 qapi/block-core.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 38b3125..62a92fa 100644
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
2.7.4
