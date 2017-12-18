Received: from eggs.gnu.org ([2001:4830:134:3::10]:44323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFK-0002dI-WB
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eQzFJ-0004hZ-OO
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:34 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Dec 2017 18:30:17 +0100
Message-Id: <20171218173023.21417-5-armbru@redhat.com>
In-Reply-To: <20171218173023.21417-1-armbru@redhat.com>
References: <20171218173023.21417-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/10] qemu-options: Move -iscsi under "Block
 device options"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

-iscsi ended up under the "Device URL Syntax" heading by a sequence of
errors, as explained in the previous commit.  Move it under the "Block
device options" heading.  Nothing left under "Device URL Syntax";
drop the heading.

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
---
 qemu-options.hx | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 18b8211a21..3d05bcf557 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1182,6 +1182,13 @@ STEXI
 Create synthetic file system image
 ETEXI
=20
+DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
+    "-iscsi [user=3Duser][,password=3Dpassword]\n"
+    "       [,header-digest=3DCRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
+    "       [,initiator-name=3Dinitiator-iqn][,id=3Dtarget-iqn]\n"
+    "       [,timeout=3Dtimeout]\n"
+    "                iSCSI session parameters\n", QEMU_ARCH_ALL)
+
 STEXI
 @end table
 ETEXI
@@ -2821,14 +2828,6 @@ STEXI
 ETEXI
 DEFHEADING()
=20
-DEFHEADING(Device URL Syntax:)
-DEF("iscsi", HAS_ARG, QEMU_OPTION_iscsi,
-    "-iscsi [user=3Duser][,password=3Dpassword]\n"
-    "       [,header-digest=3DCRC32C|CR32C-NONE|NONE-CRC32C|NONE\n"
-    "       [,initiator-name=3Dinitiator-iqn][,id=3Dtarget-iqn]\n"
-    "       [,timeout=3Dtimeout]\n"
-    "                iSCSI session parameters\n", QEMU_ARCH_ALL)
-
 DEFHEADING(Bluetooth(R) options:)
 STEXI
 @table @option
--=20
2.13.6
