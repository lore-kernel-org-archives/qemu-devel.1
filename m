Received: from eggs.gnu.org ([2001:4830:134:3::10]:45919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvD-00060B-9d
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1fKHvA-0002tV-3W
	for qemu-devel@nongnu.org; Sun, 20 May 2018 02:34:23 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun, 20 May 2018 09:15:07 +0300
Message-Id: <4088b5536436090207dcf6d15e47908f74b2d8f2.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
References: <cover.1526796813.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 21/22] qapi/net.json: Fix the version number of
 the "vlan" removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Thomas Huth <thuth@redhat.com>

"vlan" will be dropped in 2.13, not in 2.12. And while we're at it,
use the better wording "dropped in" instead of "removed with" (also
for the "dump" removal).

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 qapi/net.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index b4fe4b660b..b8adf1f03f 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -450,7 +450,7 @@
 #
 # Since: 2.7
 #
-# 'dump' - removed with 2.12
+# 'dump': dropped in 2.12
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde',
@@ -498,7 +498,7 @@
 #
 # Since: 1.2
 #
-# 'vlan' - removed with 2.12
+# 'vlan': dropped in 2.13
 ##
 { 'struct': 'NetLegacy',
   'data': {
-- 
2.11.0
