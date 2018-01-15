Received: from eggs.gnu.org ([2001:4830:134:3::10]:40497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eazNc-0005nD-Iz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eazNV-0004Kh-R5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:40:25 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 15 Jan 2018 08:40:17 +0100
Message-Id: <1516002017-4981-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-doc: Get rid of "vlan=X" example in the
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: qemu-trivial@nongnu.org

The vlan concept is marked as deprecated, so we should not use
this for examples in the documentation anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 130016c..d0c8b06 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2257,8 +2257,8 @@ qemu-system-i386 linux.img -net nic -net tap
 #launch a QEMU instance with two NICs, each one connected
 #to a TAP device
 qemu-system-i386 linux.img \
-                 -net nic,vlan=0 -net tap,vlan=0,ifname=tap0 \
-                 -net nic,vlan=1 -net tap,vlan=1,ifname=tap1
+        -netdev tap,id=nd0,ifname=tap0 -device e1000,netdev=nd0 \
+        -netdev tap,id=nd1,ifname=tap1 -device rtl8139,netdev=nd1
 @end example
 
 @example
-- 
1.8.3.1
