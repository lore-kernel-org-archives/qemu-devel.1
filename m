Received: from eggs.gnu.org ([2001:4830:134:3::10]:45319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eg6b3-0006Nn-G8
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eg6az-0001Tm-5E
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eg6ay-0001Sp-Tz
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 05:23:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FE9113AA2
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 10:23:24 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Jan 2018 11:23:19 +0100
Message-Id: <20180129102320.21534-7-kraxel@redhat.com>
In-Reply-To: <20180129102320.21534-1-kraxel@redhat.com>
References: <20180129102320.21534-1-kraxel@redhat.com>
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
index f9278f14c9..7073b3d842 100644
--- a/Makefile
+++ b/Makefile
@@ -237,10 +237,10 @@ KEYCODEMAP_FILES =3D \
 		 ui/input-keymap-qcode-to-atset1.c \
 		 ui/input-keymap-qcode-to-atset2.c \
 		 ui/input-keymap-qcode-to-atset3.c \
+		 ui/input-keymap-qcode-to-linux.c \
 		 ui/input-keymap-qcode-to-qnum.c \
 		 ui/input-keymap-qcode-to-sun.c \
 		 ui/input-keymap-qnum-to-qcode.c \
-		 ui/input-keymap-qcode-to-linux.c \
 		 ui/input-keymap-usb-to-qcode.c \
 		 ui/input-keymap-win32-to-qcode.c \
 		 ui/input-keymap-x11-to-qcode.c \
diff --git a/include/ui/input.h b/include/ui/input.h
index 7d6c92224e..ceb22b8eef 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -83,6 +83,9 @@ extern const guint16 qemu_input_map_qcode_to_atset2[];
 extern const guint qemu_input_map_qcode_to_atset3_len;
 extern const guint16 qemu_input_map_qcode_to_atset3[];
=20
+extern const guint qemu_input_map_qcode_to_linux_len;
+extern const guint16 qemu_input_map_qcode_to_linux[];
+
 extern const guint qemu_input_map_qcode_to_qnum_len;
 extern const guint16 qemu_input_map_qcode_to_qnum[];
=20
@@ -92,9 +95,6 @@ extern const guint16 qemu_input_map_qcode_to_sun[];
 extern const guint qemu_input_map_qnum_to_qcode_len;
 extern const guint16 qemu_input_map_qnum_to_qcode[];
=20
-extern const guint qemu_input_map_qcode_to_linux_len;
-extern const guint16 qemu_input_map_qcode_to_linux[];
-
 extern const guint qemu_input_map_usb_to_qcode_len;
 extern const guint16 qemu_input_map_usb_to_qcode[];
=20
diff --git a/ui/input-keymap.c b/ui/input-keymap.c
index 7a9475abd9..3d4e66bab5 100644
--- a/ui/input-keymap.c
+++ b/ui/input-keymap.c
@@ -10,10 +10,10 @@
 #include "ui/input-keymap-qcode-to-atset1.c"
 #include "ui/input-keymap-qcode-to-atset2.c"
 #include "ui/input-keymap-qcode-to-atset3.c"
+#include "ui/input-keymap-qcode-to-linux.c"
 #include "ui/input-keymap-qcode-to-qnum.c"
 #include "ui/input-keymap-qcode-to-sun.c"
 #include "ui/input-keymap-qnum-to-qcode.c"
-#include "ui/input-keymap-qcode-to-linux.c"
 #include "ui/input-keymap-usb-to-qcode.c"
 #include "ui/input-keymap-win32-to-qcode.c"
 #include "ui/input-keymap-x11-to-qcode.c"
--=20
2.9.3
