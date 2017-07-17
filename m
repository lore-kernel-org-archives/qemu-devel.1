Received: from eggs.gnu.org ([2001:4830:134:3::10]:33206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX34z-0001qA-Cf
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX34u-0001MO-BV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:16:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX34u-0001Lw-4k
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:16:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2AEF1356D2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:16:35 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 12:16:32 +0200
Message-Id: <20170717101632.23247-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] add scripts/git.orderfile
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

Based on a old patch by Laszlo.
Time to get this in ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 scripts/git.orderfile | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 scripts/git.orderfile

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
new file mode 100644
index 0000000000..ac699700b1
--- /dev/null
+++ b/scripts/git.orderfile
@@ -0,0 +1,29 @@
+#
+# order file for git, to produce patches which are easier to review
+# by diffing the important stuff like interface changes first.
+#
+# one-off usage:
+#   git diff -O scripts/git.orderfile ...
+#
+# add to git config:
+#   git config diff.orderFile scripts/git.orderfile
+#
+
+# Documentation
+docs/*
+*.texi
+
+# build system
+configure
+Makefile*
+*.mak
+
+# qapi schema
+*.json
+
+# headers
+*.h
+
+# code
+*.c
+
-- 
2.9.3
