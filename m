Received: from eggs.gnu.org ([209.51.188.92]:38474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5m-0001HK-Qy
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI5m-0001oR-4k
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:22:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:37 +0100
Message-Id: <20190225152053.15976-56-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 55/71] block/null: Generate filename even with
 latency-ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

While we cannot represent the latency-ns option in a filename, it is not
a strong option so not being able to should not stop us from generating
a filename nonetheless.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20190201192935.18394-30-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
