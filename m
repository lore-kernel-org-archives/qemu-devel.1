Received: from eggs.gnu.org ([2001:4830:134:3::10]:48276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbnYR-00006y-J4
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cbnYQ-0002lY-PA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:10:27 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  9 Feb 2017 13:10:18 +0100
Message-Id: <1486642218-18520-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-options: Fix broken sheepdog URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, Hitoshi Mitake <mitake.hitoshi@lab.ntt.co.jp>, Liu Yuan <namei.unix@gmail.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

The sheepdog URL is broken twice: First it uses a duplicated
http:// prefix, second the website seems to have moved to
https://sheepdog.github.io/sheepdog/ instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ad2f8fc..38113b9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2583,7 +2583,7 @@ Example
 qemu-system-i386 --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
 @end example
 
-See also @url{http://http://www.osrg.net/sheepdog/}.
+See also @url{https://sheepdog.github.io/sheepdog/}.
 
 @item GlusterFS
 GlusterFS is a user space distributed file system.
-- 
1.8.3.1
