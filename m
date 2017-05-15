Received: from eggs.gnu.org ([2001:4830:134:3::10]:47881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAGLz-0005Ad-H6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAGLu-0004CJ-Iv
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35446)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dAGLu-0004A6-Cs
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:47:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A3CAFC0467C0
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 13:47:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 15 May 2017 14:47:53 +0100
Message-Id: <20170515134753.28412-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] .gdbinit: load QEMU sub-commands when gdb
 starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbinit
file so GDB either loads qemu-gdb.py automatically or prints a message
informing the user how to enable them (some systems disable ./.gdbinit
loading for security reasons).

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 .gdbinit | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 .gdbinit

diff --git a/.gdbinit b/.gdbinit
new file mode 100644
index 0000000..9d322fc
--- /dev/null
+++ b/.gdbinit
@@ -0,0 +1,8 @@
+# GDB may have ./.gdbinit loading disabled by default.  In that case you can
+# follow the instructions it prints.  They boil down to adding the following to
+# your home directory's ~/.gdbinit file:
+#
+#   add-auto-load-safe-path /path/to/qemu/.gdbinit
+
+# Load QEMU-specific sub-commands and settings
+source scripts/qemu-gdb.py
-- 
2.9.3
