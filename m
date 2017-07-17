Received: from eggs.gnu.org ([2001:4830:134:3::10]:33396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX35S-0002Aw-H2
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX35N-0001cE-GN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:17:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX35N-0001bj-9w
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:17:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CC4461B8D
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:17:04 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 12:17:00 +0200
Message-Id: <20170717101700.23552-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] add scripts/indent.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Script to reformat sources in qemu style.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 scripts/indent.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100755 scripts/indent.sh

diff --git a/scripts/indent.sh b/scripts/indent.sh
new file mode 100755
index 0000000000..8f045ecb1d
--- /dev/null
+++ b/scripts/indent.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+#
+# indent wrapper script, with args to format
+# source code according to qemu coding style.
+#
+indent	--ignore-profile	\
+	--k-and-r-style		\
+	--line-length 80	\
+	--indent-level 4	\
+	--no-tabs		\
+	"$@"
-- 
2.9.3
