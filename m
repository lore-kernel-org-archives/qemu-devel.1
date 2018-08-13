Received: from eggs.gnu.org ([2001:4830:134:3::10]:38012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpBO5-0004tc-PG
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fpBO1-00068t-Tc
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 07:51:53 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 13 Aug 2018 13:51:44 +0200
Message-Id: <1534161104-8253-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-options: Fix bad "macaddr" property in
 the documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Harald Hoyer <harald@redhat.com>, qemu-trivial@nongnu.org

When using the "-device" option, the property is called "mac".
"macaddr" is only used for the legacy "-net nic" option.

Reported-by: Harald Hoyer <harald@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index b1bf0f4..3495531 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2345,7 +2345,7 @@ qemu-system-i386 linux.img \
                  -netdev socket,id=n2,mcast=230.0.0.1:1234
 # launch yet another QEMU instance on same "bus"
 qemu-system-i386 linux.img \
-                 -device e1000,netdev=n3,macaddr=52:54:00:12:34:58 \
+                 -device e1000,netdev=n3,mac=52:54:00:12:34:58 \
                  -netdev socket,id=n3,mcast=230.0.0.1:1234
 @end example
 
-- 
1.8.3.1
