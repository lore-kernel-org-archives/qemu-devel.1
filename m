Received: from eggs.gnu.org ([2001:4830:134:3::10]:60920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXpW-0006qf-8C
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dHXpS-0004z3-BB
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 11:52:38 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  4 Jun 2017 18:45:21 +0300
Message-Id: <7064024dee8eb8af89fe6f0d93983b7de2c72ecc.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
References: <cover.1496591095.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/22] qemu-ga: remove useless allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

There is no need to duplicate a fixed string.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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
2.11.0
