Received: from eggs.gnu.org ([2001:4830:134:3::10]:42302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTsvC-0005Sa-Cj
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTsvB-0005yB-LO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:17:14 -0500
From: Eric Blake <eblake@redhat.com>
Date: Wed, 18 Jan 2017 10:16:51 -0600
Message-Id: <20170118161653.19296-5-eblake@redhat.com>
In-Reply-To: <20170118161653.19296-1-eblake@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] fdc-test: Avoid deprecated 'change'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, John Snow <jsnow@redhat.com>, "open list:Floppy" <qemu-block@nongnu.org>

Use the preferred blockdev-change-medium command instead.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/fdc-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/fdc-test.c b/tests/fdc-test.c
index 738c6b4..f5ff68d 100644
--- a/tests/fdc-test.c
+++ b/tests/fdc-test.c
@@ -298,8 +298,9 @@ static void test_media_insert(void)

     /* Insert media in drive. DSKCHK should not be reset until a step pulse
      * is sent. */
-    qmp_discard_response("{'execute':'change', 'arguments':{"
-                         " 'device':'floppy0', 'target': %s, 'arg': 'raw' }}",
+    qmp_discard_response("{'execute':'blockdev-change-medium', 'arguments':{"
+                         " 'device':'floppy0', 'filename': %s, "
+                         "'format': 'raw' }}",
                          test_image);

     dir = inb(FLOPPY_BASE + reg_dir);
-- 
2.9.3
