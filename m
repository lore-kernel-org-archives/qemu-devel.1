Received: from eggs.gnu.org ([2001:4830:134:3::10]:46733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfO-0002Lk-A9
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gRZfL-00041L-6L
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39941)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gRZfL-000417-1H
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:28:23 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 13:27:35 +0400
Message-Id: <20181127092801.21777-3-marcandre.lureau@redhat.com>
In-Reply-To: <20181127092801.21777-1-marcandre.lureau@redhat.com>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-3.2 v4 02/28] target/xtensa: drop
 num_[core_]regs from dc232b/dc233c configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, Max Filippov <jcmvbkbc@gmail.com>

From: Max Filippov <jcmvbkbc@gmail.com>

Now that xtensa_count_regs does the right thing, remove manual
initialization of these fields from the affected configurations and let
xtensa_finalize_config initialize them. Add XTREG_END to terminate
register lists.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/core-dc232b.c                | 2 --
 target/xtensa/core-dc232b/gdb-config.inc.c | 1 +
 target/xtensa/core-dc233c.c                | 2 --
 target/xtensa/core-dc233c/gdb-config.inc.c | 1 +
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/xtensa/core-dc232b.c b/target/xtensa/core-dc232b.c
index 7131337840..7851bcb636 100644
--- a/target/xtensa/core-dc232b.c
+++ b/target/xtensa/core-dc232b.c
@@ -40,8 +40,6 @@
 static XtensaConfig dc232b __attribute__((unused)) =3D {
     .name =3D "dc232b",
     .gdb_regmap =3D {
-        .num_regs =3D 120,
-        .num_core_regs =3D 52,
         .reg =3D {
 #include "core-dc232b/gdb-config.inc.c"
         }
diff --git a/target/xtensa/core-dc232b/gdb-config.inc.c b/target/xtensa/c=
ore-dc232b/gdb-config.inc.c
index 13aba5edec..d87168628b 100644
--- a/target/xtensa/core-dc232b/gdb-config.inc.c
+++ b/target/xtensa/core-dc232b/gdb-config.inc.c
@@ -259,3 +259,4 @@
           0, 0, 0, 0, 0, 0)
   XTREG(119, 476, 32, 4, 4, 0x000f, 0x0006, -2, 8, 0x0100, a15,
           0, 0, 0, 0, 0, 0)
+  XTREG_END
diff --git a/target/xtensa/core-dc233c.c b/target/xtensa/core-dc233c.c
index d701e3f5de..8853bfd4d0 100644
--- a/target/xtensa/core-dc233c.c
+++ b/target/xtensa/core-dc233c.c
@@ -40,8 +40,6 @@
 static XtensaConfig dc233c __attribute__((unused)) =3D {
     .name =3D "dc233c",
     .gdb_regmap =3D {
-        .num_regs =3D 121,
-        .num_core_regs =3D 52,
         .reg =3D {
 #include "core-dc233c/gdb-config.inc.c"
         }
diff --git a/target/xtensa/core-dc233c/gdb-config.inc.c b/target/xtensa/c=
ore-dc233c/gdb-config.inc.c
index b632341b28..7e8963227f 100644
--- a/target/xtensa/core-dc233c/gdb-config.inc.c
+++ b/target/xtensa/core-dc233c/gdb-config.inc.c
@@ -143,3 +143,4 @@ XTREG(117, 468, 32, 4, 4, 0x000c, 0x0006, -2, 8, 0x01=
00, a12,         0, 0, 0, 0
 XTREG(118, 472, 32, 4, 4, 0x000d, 0x0006, -2, 8, 0x0100, a13,         0,=
 0, 0, 0, 0, 0)
 XTREG(119, 476, 32, 4, 4, 0x000e, 0x0006, -2, 8, 0x0100, a14,         0,=
 0, 0, 0, 0, 0)
 XTREG(120, 480, 32, 4, 4, 0x000f, 0x0006, -2, 8, 0x0100, a15,         0,=
 0, 0, 0, 0, 0)
+XTREG_END
--=20
2.20.0.rc1
