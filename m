Received: from eggs.gnu.org ([2001:4830:134:3::10]:41325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkw-0004hx-E9
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWkv-0007ek-JF
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:26 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:23 +0200
Message-Id: <1499447335-6125-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 008/100] vvfat: rename useless enumeration values
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

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

MODE_FAKED and MODE_RENAMED are not and were never used.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vvfat.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 07a111f..18d9559 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -286,8 +286,7 @@ typedef struct mapping_t {
     union {
         /* offset is
          * - the offset in the file (in clusters) for a file, or
-         * - the next cluster of the directory for a directory, and
-         * - the address of the buffer for a faked entry
+         * - the next cluster of the directory for a directory
          */
         struct {
             uint32_t offset;
@@ -300,9 +299,13 @@ typedef struct mapping_t {
     /* path contains the full path, i.e. it always starts with s->path *=
/
     char* path;
=20
-    enum { MODE_UNDEFINED =3D 0, MODE_NORMAL =3D 1, MODE_MODIFIED =3D 2,
-        MODE_DIRECTORY =3D 4, MODE_FAKED =3D 8,
-        MODE_DELETED =3D 16, MODE_RENAMED =3D 32 } mode;
+    enum {
+        MODE_UNDEFINED =3D 0,
+        MODE_NORMAL =3D 1,
+        MODE_MODIFIED =3D 2,
+        MODE_DIRECTORY =3D 4,
+        MODE_DELETED =3D 8,
+    } mode;
     int read_only;
 } mapping_t;
=20
--=20
1.8.3.1
