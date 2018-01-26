Received: from eggs.gnu.org ([2001:4830:134:3::10]:57275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ef0e7-0006zk-8k
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ef0e2-0001fJ-VM
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:50:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ef0e2-0001ep-OQ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 04:50:02 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5ADB6C03ABC6
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 09:13:46 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 26 Jan 2018 10:13:37 +0100
Message-Id: <20180126091338.13708-7-kraxel@redhat.com>
In-Reply-To: <20180126091338.13708-1-kraxel@redhat.com>
References: <20180126091338.13708-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/7] ui: fix alphabetical ordering of keymaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The qcode-to-linux keymaps was accidentally added in the wrong place
by

  commit de80d78594b4c3767a12d8d42debcf12cbf85a5b
  Author: Owen Smith <owen.smith@citrix.com>
  Date:   Fri Nov 3 11:56:28 2017 +0000

    ui: generate qcode to linux mappings

breaking the alphabetical ordering of keymaps

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-id: 20180117164118.8510-4-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 Makefile           | 2 +-
 include/ui/input.h | 6 +++---
 ui/input-keymap.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index b4811750b1..d55b711e0e 100644
--- a/Makefile
+++ b/Makefile
@@ -236,10 +236,10 @@ KEYCODEMAP_FILES =3D \
 		 ui/input-keymap-qcode-to-atset1.c \
 		 ui/input-keymap-qcode-to-atset2.c \
 		 ui/input-keymap-qcode-to-atset3.c \
+		 ui/input-keymap-qcode-to-linux.c \
 		 ui/input-keymap-qcode-to-qnum.c \
 		 ui/input-keymap-qcode-to-sun.c \
 		 ui/input-keymap-qnum-to-qcode.c \
-		 ui/input-keymap-qcode-to-linux.c \
 		 $(NULL)
=20
 GENERATED_FILES +=3D $(KEYCODEMAP_FILES)
diff --git a/include/ui/input.h b/include/ui/input.h
index e6c9b483b0..bf3d0d1060 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -80,6 +80,9 @@ extern const guint16 qemu_input_map_qcode_to_atset2[];
 extern const guint qemu_input_map_qcode_to_atset3_len;
 extern const guint16 qemu_input_map_qcode_to_atset3[];
=20
+extern const guint qemu_input_map_qcode_to_linux_len;
+extern const guint16 qemu_input_map_qcode_to_linux[];
+
 extern const guint qemu_input_map_qcode_to_qnum_len;
 extern const guint16 qemu_input_map_qcode_to_qnum[];
=20
@@ -89,7 +92,4 @@ extern const guint16 qemu_input_map_qcode_to_sun[];
 extern const guint qemu_input_map_qnum_to_qcode_len;
 extern const guint16 qemu_input_map_qnum_to_qcode[];
=20
-extern const guint qemu_input_map_qcode_to_linux_len;
-extern const guint16 qemu_input_map_qcode_to_linux[];
-
 #endif /* INPUT_H */
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 32cc224e39..1f60caf314 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -9,10 +9,10 @@
 #include "ui/input-keymap-qcode-to-atset1.c"
 #include "ui/input-keymap-qcode-to-atset2.c"
 #include "ui/input-keymap-qcode-to-atset3.c"
+#include "ui/input-keymap-qcode-to-linux.c"
 #include "ui/input-keymap-qcode-to-qnum.c"
 #include "ui/input-keymap-qcode-to-sun.c"
 #include "ui/input-keymap-qnum-to-qcode.c"
-#include "ui/input-keymap-qcode-to-linux.c"
=20
 int qemu_input_linux_to_qcode(unsigned int lnx)
 {
--=20
2.9.3
