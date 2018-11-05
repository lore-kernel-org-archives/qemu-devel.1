Received: from eggs.gnu.org ([2001:4830:134:3::10]:51638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhwK-00029Q-4y
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhw7-00038q-4e
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:41:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:19 +0100
Message-Id: <20181105163744.25139-12-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/36] vpc: Don't leak opts in vpc_open()
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/vpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/vpc.c b/block/vpc.c
index 984187cadd..80c5b2b197 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -456,10 +456,12 @@ static int vpc_open(BlockDriverState *bs, QDict *op=
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
