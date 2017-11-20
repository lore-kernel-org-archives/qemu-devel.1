Received: from eggs.gnu.org ([2001:4830:134:3::10]:35746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsQH-0001Gv-Hy
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsQG-0007tW-NJ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:12:05 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:10:04 +0100
Message-Id: <20171120201004.14999-26-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 25/25] block/null: Generate
 filename even with latency-ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

While we cannot represent the latency-ns option in a filename, it is not
a significant option so not being able to should not stop us from
generating a filename nonetheless.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/null.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/null.c b/block/null.c
index 65f5d681c0..ca0aa3d528 100644
--- a/block/null.c
+++ b/block/null.c
@@ -250,7 +250,8 @@ static void null_refresh_filename(BlockDriverState *bs)
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
2.13.6
