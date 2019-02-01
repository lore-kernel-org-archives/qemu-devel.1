Received: from eggs.gnu.org ([209.51.188.92]:47386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXK-00077f-UY
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXJ-0003B8-Sb
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:31:38 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:33 +0100
Message-Id: <20190201192935.18394-30-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 29/31] block/null: Generate filename even
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
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/null.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/null.c b/block/null.c
index 1c56a0ef01..a322929478 100644
--- a/block/null.c
+++ b/block/null.c
@@ -248,7 +248,8 @@ static void null_refresh_filename(BlockDriverState *b=
s)
     {
         /* These options can be ignored */
         if (strcmp(qdict_entry_key(e), "filename") &&
-            strcmp(qdict_entry_key(e), "driver"))
+            strcmp(qdict_entry_key(e), "driver") &&
+            strcmp(qdict_entry_key(e), NULL_OPT_LATENCY))
         {
             return;
         }
--=20
2.20.1
