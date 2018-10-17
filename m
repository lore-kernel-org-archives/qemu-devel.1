Received: from eggs.gnu.org ([2001:4830:134:3::10]:35789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gClxZ-0003m2-ER
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:34:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gClxY-0001W0-O2
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 09:34:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 17 Oct 2018 15:33:50 +0200
Message-Id: <20181017133350.14351-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vpc: Don't leak opts in vpc_open()
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/vpc.c b/block/vpc.c
index bf294abfa7..eace2ba484 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -454,10 +454,12 @@ static int vpc_open(BlockDriverState *bs, QDict *op=
tions, int flags,
     }
=20
     qemu_co_mutex_init(&s->lock);
+    qemu_opts_del(opts);
=20
     return 0;
=20
 fail:
+    qemu_opts_del(opts);
     qemu_vfree(s->pagetable);
 #ifdef CACHE
     g_free(s->pageentry_u8);
--=20
2.19.1
