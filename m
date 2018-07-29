Received: from eggs.gnu.org ([2001:4830:134:3::10]:33885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtF2-00020U-8E
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fjtEz-0000Wd-29
	for qemu-devel@nongnu.org; Sun, 29 Jul 2018 17:28:40 -0400
From: Leonid Bloch <lbloch@janustech.com>
Date: Mon, 30 Jul 2018 00:27:39 +0300
Message-Id: <20180729212744.23709-2-lbloch@janustech.com>
In-Reply-To: <20180729212744.23709-1-lbloch@janustech.com>
References: <20180729212744.23709-1-lbloch@janustech.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/6 for-3.0] Update .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Leonid Bloch <lbloch@janustech.com>

Adds /roms/vgabios to .gitignore - this directory appears after the
build, and was not ignored by Git so far.

Signed-off-by: Leonid Bloch <lbloch@janustech.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 5668d02782..2b3b30ae9f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -212,3 +212,4 @@ trace-dtrace-root.dtrace
 trace-ust-all.h
 trace-ust-all.c
 /target/arm/decode-sve.inc.c
+/roms/vgabios
-- 
2.17.1
