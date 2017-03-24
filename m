Received: from eggs.gnu.org ([2001:4830:134:3::10]:34998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1crZSk-0000IQ-63
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 20:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1crZSh-0002WG-0w
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 20:21:46 -0400
Received: from mail-dm3nam03on0132.outbound.protection.outlook.com
	([104.47.41.132]:39936
	helo=NAM03-DM3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Andrew.Baumann@microsoft.com>)
	id 1crZSg-0002Vw-F9
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 20:21:42 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Fri, 24 Mar 2017 16:46:46 -0700
Message-ID: <20170324234646.15264-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] tap-win32: don't abort in tap_enable();
 enables -netdev tap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>, Andrew
	Baumann <Andrew.Baumann@microsoft.com>

The docs generally steer users away from using the legacy -net
parameter, however on win32 attempting to enable a tap device using
-netdev tap fails at an abort() in tap_enable(). Removing the abort()s
seems to be enough to get everything working, so do that.

Signed-off-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
---
 net/tap-win32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index 662f9b6..3620843 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -811,10 +811,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
 
 int tap_enable(NetClientState *nc)
 {
-    abort();
+    return 0;
 }
 
 int tap_disable(NetClientState *nc)
 {
-    abort();
+    return 0;
 }
-- 
2.8.3
