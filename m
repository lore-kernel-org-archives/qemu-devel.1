Received: from eggs.gnu.org ([2001:4830:134:3::10]:49244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxt-0000pz-LF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dSVxs-0001Dp-NZ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dSVxs-0001Ch-HR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 18:06:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed,  5 Jul 2017 00:03:39 +0200
Message-Id: <20170704220346.29244-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170704220346.29244-1-marcandre.lureau@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 28/35] 9p: mark coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/9pfs/9p.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index d1cfeaf10e..935a6c9a3c 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -312,21 +312,24 @@ typedef struct V9fsGetlock
 extern int open_fd_hw;
 extern int total_open_fd;
=20
-static inline void v9fs_path_write_lock(V9fsState *s)
+static inline void coroutine_fn
+v9fs_path_write_lock(V9fsState *s)
 {
     if (s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT) {
         qemu_co_rwlock_wrlock(&s->rename_lock);
     }
 }
=20
-static inline void v9fs_path_read_lock(V9fsState *s)
+static inline void coroutine_fn
+v9fs_path_read_lock(V9fsState *s)
 {
     if (s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT) {
         qemu_co_rwlock_rdlock(&s->rename_lock);
     }
 }
=20
-static inline void v9fs_path_unlock(V9fsState *s)
+static inline void coroutine_fn
+v9fs_path_unlock(V9fsState *s)
 {
     if (s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT) {
         qemu_co_rwlock_unlock(&s->rename_lock);
--=20
2.13.1.395.gf7b71de06
