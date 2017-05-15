Received: from eggs.gnu.org ([2001:4830:134:3::10]:34971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeN-0001NP-AR
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dAMeM-0003Wm-99
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:31:27 -0400
From: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Date: Mon, 15 May 2017 22:31:04 +0200
Message-Id: <20170515203114.9477-5-hpoussin@reactos.org>
In-Reply-To: <20170515203114.9477-1-hpoussin@reactos.org>
References: <20170515203114.9477-1-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 04/13] vvfat: rename useless enumeration values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>

MODE_FAKED and MODE_RENAMED are not and were never used.

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
---
 block/vvfat.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/block/vvfat.c b/block/vvfat.c
index 57f2489689..4f4a63c03f 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -287,8 +287,7 @@ typedef struct mapping_t {
     union {
         /* offset is
          * - the offset in the file (in clusters) for a file, or
-         * - the next cluster of the directory for a directory, and
-         * - the address of the buffer for a faked entry
+         * - the next cluster of the directory for a directory
          */
         struct {
             uint32_t offset;
@@ -301,9 +300,13 @@ typedef struct mapping_t {
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
2.11.0
