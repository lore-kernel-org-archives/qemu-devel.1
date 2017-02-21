Received: from eggs.gnu.org ([2001:4830:134:3::10]:55297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYx-0005x6-Il
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYw-0004Od-QM
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:11 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Feb 2017 10:40:57 -0500
Message-Id: <20170221154057.20313-10-jcody@redhat.com>
In-Reply-To: <20170221154057.20313-1-jcody@redhat.com>
References: <20170221154057.20313-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] qemu-options: Fix broken sheepdog URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

From: Thomas Huth <thuth@redhat.com>

The sheepdog URL is broken twice: First it uses a duplicated
http:// prefix, second the website seems to have moved to
https://sheepdog.github.io/sheepdog/ instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 1e815ef..9936cf3 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2586,7 +2586,7 @@ Example
 qemu-system-i386 --drive file=sheepdog://192.0.2.1:30000/MyVirtualMachine
 @end example
 
-See also @url{http://http://www.osrg.net/sheepdog/}.
+See also @url{https://sheepdog.github.io/sheepdog/}.
 
 @item GlusterFS
 GlusterFS is a user space distributed file system.
-- 
2.9.3
