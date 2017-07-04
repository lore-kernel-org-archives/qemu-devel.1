Received: from eggs.gnu.org ([2001:4830:134:3::10]:49457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyN-0001II-Lh
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVyM-0001Xq-Fv
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:07:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:43 +0200
Message-Id: <20170704220346.29244-33-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 32/35] qed: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:qed" <qemu-block@nongnu.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/qed.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/qed.c b/block/qed.c
index 385381a78a..dd2859a1c9 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -622,7 +622,8 @@ out:
     return ret;
 }
=20
-static int bdrv_qed_create(const char *filename, QemuOpts *opts, Error *=
*errp)
+static int coroutine_fn
+bdrv_qed_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     uint64_t image_size =3D 0;
     uint32_t cluster_size =3D QED_DEFAULT_CLUSTER_SIZE;
--=20
2.13.1.395.gf7b71de06
