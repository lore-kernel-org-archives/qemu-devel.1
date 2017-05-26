Received: from eggs.gnu.org ([2001:4830:134:3::10]:56940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dECG1-0006dj-Mm
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dECFw-0005vB-7S
	for qemu-devel@nongnu.org; Fri, 26 May 2017 06:14:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 May 2017 14:13:37 +0400
Message-Id: <20170526101337.4096-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu-ga: remove useless allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

There is no need to duplicate a fixed string.

CC: qemu-trivial@nongnu.org
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/commands-posix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 284ecc6d7e..d8e412275e 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2197,12 +2197,10 @@ static void transfer_memory_block(GuestMemoryBloc=
k *mem_blk, bool sys2memblk,
         }
     } else {
         if (mem_blk->online !=3D (strncmp(status, "online", 6) =3D=3D 0)=
) {
-            char *new_state =3D mem_blk->online ? g_strdup("online") :
-                                                g_strdup("offline");
+            const char *new_state =3D mem_blk->online ? "online" : "offl=
ine";
=20
             ga_write_sysfs_file(dirfd, "state", new_state, strlen(new_st=
ate),
                                 &local_err);
-            g_free(new_state);
             if (local_err) {
                 error_free(local_err);
                 result->response =3D
--=20
2.13.0.rc1.16.gd80b50c3f
