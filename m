Received: from eggs.gnu.org ([2001:4830:134:3::10]:42317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEX-0001yx-Ef
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEW-0002Tt-5L
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:25 +0100
Message-Id: <1488901251-16214-2-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/27] commit: Fix error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Apparently some kind of mismerge happened in commit 8dfba279, which
broke the error handling without any real reason by removing the
assignment of the return value to ret in a blk_insert_bs() call.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 block/commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/commit.c b/block/commit.c
index 22a0a4d..e57c1cf 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -364,7 +364,7 @@ void commit_start(const char *job_id, BlockDriverStat=
e *bs,
=20
     /* Required permissions are already taken with block_job_add_bdrv() =
*/
     s->top =3D blk_new(0, BLK_PERM_ALL);
-    blk_insert_bs(s->top, top, errp);
+    ret =3D blk_insert_bs(s->top, top, errp);
     if (ret < 0) {
         goto fail;
     }
--=20
1.8.3.1
