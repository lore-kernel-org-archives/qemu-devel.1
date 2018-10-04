Received: from eggs.gnu.org ([2001:4830:134:3::10]:53942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g84G7-0004eX-Md
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:05:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g84G6-0003v4-Oq
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:05:43 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  4 Oct 2018 09:05:22 -0500
Message-Id: <20181004140522.945682-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] edid: Ignore built binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, qemu-trivial@nongnu.org

Added in commit 72d277a7.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 5668d027824..64efdfd9292 100644
--- a/.gitignore
+++ b/.gitignore
@@ -107,6 +107,7 @@
 /qemu-doc.html
 /qemu-doc.info
 /qemu-doc.txt
+/qemu-edid
 /qemu-img
 /qemu-nbd
 /qemu-options.def
-- 
2.17.1
