Received: from eggs.gnu.org ([2001:4830:134:3::10]:32975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX34G-0001NF-TB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX34C-0000s1-8a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:15:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX34C-0000pI-25
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:15:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8F4980460
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 10:15:50 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 12:15:47 +0200
Message-Id: <20170717101547.22295-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] add editorconfig
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

Add a .editorconfig file for qemu.  Specifies the indent and tab style
for various files (C code and Makefiles for starters).  Most popular
editors support this either natively or via plugin.

Check http://editorconfig.org/ for details.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 .editorconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 0000000000..b2022e391a
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,15 @@
+# http://editorconfig.org
+root = true
+
+[*]
+end_of_line = lf
+insert_final_newline = true
+charset = utf-8
+
+[Makefile*]
+indent_style = tab
+indent_size = 8
+
+[*.{c,h}]
+indent_style = space
+indent_size = 4
-- 
2.9.3
