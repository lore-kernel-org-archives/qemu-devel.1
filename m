Received: from eggs.gnu.org ([2001:4830:134:3::10]:39012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldIN-0002Iq-Ir
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eldIM-0006G1-NV
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:19:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eldIM-00067h-Ij
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:19:02 -0500
Date: Tue, 13 Feb 2018 18:18:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518538727-952-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] qom: print out type name on lookup failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

this makes debugging a bit easier.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qom/object.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/qom/object.c b/qom/object.c
index c58c52d..a1e5f99 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -499,6 +499,10 @@ Object *object_new(const char *typename)
 {
     TypeImpl *ti = type_get_by_name(typename);
 
+    if (!ti) {
+        g_error("Object type not found: %s\n", typename);
+    }
+
     return object_new_with_type(ti);
 }
 
-- 
MST
