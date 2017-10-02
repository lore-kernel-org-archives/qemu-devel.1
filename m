Received: from eggs.gnu.org ([2001:4830:134:3::10]:40486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Jh-0005p2-Bv
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz1Jd-0004qV-Hj
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:03:29 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 16:03:03 +0200
Message-Id: <20171002140307.5292-5-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-1-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 4/8] qemu-options: Move -iscsi under "Block
 device options"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>

-iscsi ended up under the "Device URL Syntax" heading by a sequence of
errors, as explained in the previous commit.  Move it under the "Block
device options" heading.  Nothing left under "Device URL Syntax";
drop the heading.

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-options.hx | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index f112281d37..c647fdde62 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1172,6 +1172,13 @@ STEXI
 Create synthetic file system image
 ETEXI
 
+DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
+    "-iscsi [user=user][,password=password]\n"
+    "       [,header-digest=CRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
+    "       [,initiator-name=initiator-iqn][,id=target-iqn]\n"
+    "       [,timeout=timeout]\n"
+    "                iSCSI session parameters\n", QEMU_ARCH_ALL)
+
 STEXI
 @end table
 ETEXI
@@ -2811,14 +2818,6 @@ STEXI
 ETEXI
 DEFHEADING()
 
-DEFHEADING(Device URL Syntax:)
-DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
-    "-iscsi [user=user][,password=password]\n"
-    "       [,header-digest=CRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
-    "       [,initiator-name=initiator-iqn][,id=target-iqn]\n"
-    "       [,timeout=timeout]\n"
-    "                iSCSI session parameters\n", QEMU_ARCH_ALL)
-
 DEFHEADING(Bluetooth(R) options:)
 STEXI
 @table @option
-- 
2.13.6
