Received: from eggs.gnu.org ([2001:4830:134:3::10]:40324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cuyhJ-0005YL-LI
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cuyhF-0006DB-Lr
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cuyhF-0006Cz-H0
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:54:49 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  3 Apr 2017 11:54:38 +0200
Message-Id: <20170403095438.15423-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qga: improve fsfreeze documentations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Some users find the fsfreeze behaviour confusing. Add some notes about
invalid mount points and Windows usage.

Related to:
https://bugzilla.redhat.com/show_bug.cgi?id=3D1436976

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qga/qapi-schema.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2d18..8d901f556a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -426,7 +426,13 @@
 ##
 # @guest-fsfreeze-freeze:
 #
-# Sync and freeze all freezable, local guest filesystems
+# Sync and freeze all freezable, local guest filesystems. If this
+# command succeeded, you may call @guest-fsfreeze-thaw later to
+# unfreeze.
+#
+# Note: On Windows, the command is implemented with the help of a
+# Volume Shadow-copy Service DLL helper. The frozen state is limited
+# for up to 10 seconds by VSS.
 #
 # Returns: Number of file systems currently frozen. On error, all filesy=
stems
 # will be thawed.
@@ -439,10 +445,12 @@
 ##
 # @guest-fsfreeze-freeze-list:
 #
-# Sync and freeze specified guest filesystems
+# Sync and freeze specified guest filesystems.
+# See also @guest-fsfreeze-freeze.
 #
 # @mountpoints: an array of mountpoints of filesystems to be frozen.
 #               If omitted, every mounted filesystem is frozen.
+#               Invalid mount points are ignored.
 #
 # Returns: Number of file systems currently frozen. On error, all filesy=
stems
 # will be thawed.
--=20
2.12.0.191.gc5d8de91d
