Received: from eggs.gnu.org ([2001:4830:134:3::10]:48996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwrZJ-0005ua-QJ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:14:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwrZD-0005q6-Nl
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:14:41 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 26 Sep 2017 10:14:21 -0500
Message-Id: <20170926151421.14557-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] scsi: Ignore executable for in-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-trivial@nongnu.org

The new qemu-pr-helper (commit b855f8d17) should not be checked in,
even when doing in-tree builds.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 40acfcb9e2..3a7e01dc6a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,7 @@
 /qemu-version.h
 /qemu-version.h.tmp
 /module_block.h
+/scsi/qemu-pr-helper
 /vscclient
 /vhost-user-scsi
 /fsdev/virtfs-proxy-helper
-- 
2.13.5
