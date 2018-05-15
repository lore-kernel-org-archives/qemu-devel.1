Received: from eggs.gnu.org ([2001:4830:134:3::10]:56877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIcmO-0002bS-BQ
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fIcmN-0005IB-JA
	for qemu-devel@nongnu.org; Tue, 15 May 2018 12:26:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 15 May 2018 18:26:20 +0200
Message-Id: <1526401580-20535-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] qapi/net.json: Fix the version number of the
 "vlan" removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org

"vlan" will be dropped in 2.13, not in 2.12. And while we're at it,
use the better wording "dropped in" instead of "removed with" (also
for the "dump" removal).

Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Reported-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/net.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index b4fe4b6..b8adf1f 100644
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
1.8.3.1
