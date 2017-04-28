Received: from eggs.gnu.org ([2001:4830:134:3::10]:35526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3vZL-0001pv-0W
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 22:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3vZG-0008PE-3a
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 22:23:39 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 27 Apr 2017 21:23:29 -0500
Message-Id: <20170428022329.30726-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: Ignore another built executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, thuth@redhat.com, dgilbert@redhat.com

Commit 78f86a2b7 added a new test, but forgot to exclude the built
binary from version control.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/.gitignore b/tests/.gitignore
index 5ab00a9..40c2e3e 100644
--- a/tests/.gitignore
+++ b/tests/.gitignore
@@ -40,6 +40,7 @@ test-crypto-tlssession-server/
 test-crypto-xts
 test-cutils
 test-hbitmap
+test-hmp
 test-int128
 test-iov
 test-io-channel-buffer
-- 
2.9.3
