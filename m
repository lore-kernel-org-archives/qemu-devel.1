Received: from eggs.gnu.org ([2001:4830:134:3::10]:58303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKUR-0005AD-IE
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKUQ-00058R-OZ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:08:47 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:43 +0200
Message-Id: <20180628000745.4477-30-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 29/31] block/null: Generate filename even
 with latency-ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

While we cannot represent the latency-ns option in a filename, it is not
a strong option so not being able to should not stop us from generating
a filename nonetheless.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/null.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/null.c b/block/null.c
index c681e7e20b..24c52a15de 100644
--- a/block/null.c
+++ b/block/null.c
@@ -252,7 +252,8 @@ static void null_refresh_filename(BlockDriverState *bs)
     {
         /* These options can be ignored */
         if (strcmp(qdict_entry_key(e), "filename") &&
-            strcmp(qdict_entry_key(e), "driver"))
+            strcmp(qdict_entry_key(e), "driver") &&
+            strcmp(qdict_entry_key(e), NULL_OPT_LATENCY))
         {
             return;
         }
-- 
2.17.1
