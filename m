Received: from eggs.gnu.org ([2001:4830:134:3::10]:48776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eg4d2-0002iE-JX
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eg4d1-0003lC-Oy
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eg4d1-0003jn-IA
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:17:23 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2018 16:17:04 +0800
Message-Id: <1517213825-24085-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1517213825-24085-1-git-send-email-jasowang@redhat.com>
References: <1517213825-24085-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] qemu-doc: Get rid of "vlan=X" example in
 the documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The vlan concept is marked as deprecated, so we should not use
this for examples in the documentation anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 qemu-options.hx | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 56b9a86..8ce427d 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2242,8 +2242,8 @@ qemu-system-i386 linux.img -net nic -net tap
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
2.7.4
