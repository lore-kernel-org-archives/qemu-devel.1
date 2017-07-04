Received: from eggs.gnu.org ([2001:4830:134:3::10]:48987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxJ-0000Jt-RK
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxI-0000oT-VA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:01 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:31 +0200
Message-Id: <20170704220346.29244-21-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/35] quorum: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Quorum" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/quorum.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index 55ba916655..b086d70daa 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -264,7 +264,8 @@ static void quorum_report_bad_versions(BDRVQuorumStat=
e *s,
     }
 }
=20
-static void quorum_rewrite_entry(void *opaque)
+static void coroutine_fn
+quorum_rewrite_entry(void *opaque)
 {
     QuorumCo *co =3D opaque;
     QuorumAIOCB *acb =3D co->acb;
@@ -282,7 +283,8 @@ static void quorum_rewrite_entry(void *opaque)
     }
 }
=20
-static bool quorum_rewrite_bad_versions(QuorumAIOCB *acb,
+static bool coroutine_fn
+quorum_rewrite_bad_versions(QuorumAIOCB *acb,
                                         QuorumVoteValue *value)
 {
     QuorumVoteVersion *version;
@@ -497,7 +499,8 @@ static int quorum_vote_error(QuorumAIOCB *acb)
     return ret;
 }
=20
-static void quorum_vote(QuorumAIOCB *acb)
+static void coroutine_fn
+quorum_vote(QuorumAIOCB *acb)
 {
     bool quorum =3D true;
     int i, j, ret;
@@ -577,7 +580,8 @@ free_exit:
     quorum_free_vote_list(&acb->votes);
 }
=20
-static void read_quorum_children_entry(void *opaque)
+static void coroutine_fn
+read_quorum_children_entry(void *opaque)
 {
     QuorumCo *co =3D opaque;
     QuorumAIOCB *acb =3D co->acb;
@@ -605,7 +609,7 @@ static void read_quorum_children_entry(void *opaque)
     }
 }
=20
-static int read_quorum_children(QuorumAIOCB *acb)
+static int coroutine_fn read_quorum_children(QuorumAIOCB *acb)
 {
     BDRVQuorumState *s =3D acb->bs->opaque;
     int i, ret;
@@ -648,7 +652,8 @@ static int read_quorum_children(QuorumAIOCB *acb)
     return ret;
 }
=20
-static int read_fifo_child(QuorumAIOCB *acb)
+static int coroutine_fn
+read_fifo_child(QuorumAIOCB *acb)
 {
     BDRVQuorumState *s =3D acb->bs->opaque;
     int n, ret;
@@ -669,7 +674,8 @@ static int read_fifo_child(QuorumAIOCB *acb)
     return ret;
 }
=20
-static int quorum_co_preadv(BlockDriverState *bs, uint64_t offset,
+static int coroutine_fn
+quorum_co_preadv(BlockDriverState *bs, uint64_t offset,
                             uint64_t bytes, QEMUIOVector *qiov, int flag=
s)
 {
     BDRVQuorumState *s =3D bs->opaque;
@@ -689,7 +695,7 @@ static int quorum_co_preadv(BlockDriverState *bs, uin=
t64_t offset,
     return ret;
 }
=20
-static void write_quorum_entry(void *opaque)
+static void coroutine_fn write_quorum_entry(void *opaque)
 {
     QuorumCo *co =3D opaque;
     QuorumAIOCB *acb =3D co->acb;
@@ -715,7 +721,8 @@ static void write_quorum_entry(void *opaque)
     }
 }
=20
-static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
+static int coroutine_fn
+quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
                              uint64_t bytes, QEMUIOVector *qiov, int fla=
gs)
 {
     BDRVQuorumState *s =3D bs->opaque;
--=20
2.13.1.395.gf7b71de06
