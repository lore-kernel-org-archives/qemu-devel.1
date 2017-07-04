Received: from eggs.gnu.org ([2001:4830:134:3::10]:48920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVx8-00007o-Ci
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVx7-0000hF-JV
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:05:50 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:29 +0200
Message-Id: <20170704220346.29244-19-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 18/35] gluster: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:GLUSTER" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/gluster.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/gluster.c b/block/gluster.c
index addceed6eb..dea8ab43a5 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -965,7 +965,8 @@ static coroutine_fn int qemu_gluster_co_pwrite_zeroes=
(BlockDriverState *bs,
 }
 #endif
=20
-static int qemu_gluster_create(const char *filename,
+static int coroutine_fn
+qemu_gluster_create(const char *filename,
                                QemuOpts *opts, Error **errp)
 {
     BlockdevOptionsGluster *gconf;
--=20
2.13.1.395.gf7b71de06
