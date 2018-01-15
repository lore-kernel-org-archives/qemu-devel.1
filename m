Received: from eggs.gnu.org ([2001:4830:134:3::10]:40688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb5ho-0005vC-Sf
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eb5hn-00054c-U0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:25:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eb5hn-00054B-OV
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:25:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBE8113AA3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 14:25:42 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 15 Jan 2018 14:25:33 +0000
Message-Id: <20180115142533.24585-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] ui: deprecate use of SDL 1.2 in favour of 2.0
 series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The SDL 2.0 release was made in Aug, 2013:

  https://www.libsdl.org/release/

That will soon be 4 + 1/2 years ago, which is enough time to consider
the 2.0 series widely supported.

Thus we deprecate the SDL 1.2 support, which will allow us to delete it
in the last release of 2018. By this time, SDL 2.0 will be more than 5
years old.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 configure     | 6 ++++++
 qemu-doc.texi | 7 +++++++
 ui/sdl.c      | 3 +++
 3 files changed, 16 insertions(+)

diff --git a/configure b/configure
index b272a0336b..dc2615a0cb 100755
--- a/configure
+++ b/configure
@@ -5635,6 +5635,12 @@ if test "$gtkabi" = "2.0"; then
     echo "WARNING: future releases. Please switch to using GTK 3.0"
 fi
 
+if test "$sdlabi" = "1.2"; then
+    echo
+    echo "WARNING: Use of SDL 1.2 is deprecated and will be removed in"
+    echo "WARNING: future releases. Please switch to using SDL 2.0"
+fi
+
 if test "$supported_cpu" = "no"; then
     echo
     echo "WARNING: SUPPORT FOR THIS HOST CPU WILL GO AWAY IN FUTURE RELEASES!"
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3e9eb819a6..3d2b3ff1ea 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2596,6 +2596,13 @@ and 3.x series APIs. Support for the GTK 2.x builds will be
 discontinued, so maintainers should switch to using GTK 3.x,
 which is the default.
 
+@subsection SDL 1.2
+
+Previously QEMU has supported building against both SDL 1.2
+and 2.0 series APIs. Support for the SDL 1.2 builds will be
+discontinued, so maintainers should switch to using SDL 2.0,
+which is the default.
+
 @section System emulator command line arguments
 
 @subsection -tdf (since 1.3.0)
diff --git a/ui/sdl.c b/ui/sdl.c
index 7b71a9ac58..8a93054fd4 100644
--- a/ui/sdl.c
+++ b/ui/sdl.c
@@ -963,6 +963,9 @@ void sdl_display_init(DisplayState *ds, int full_screen, int no_frame)
             exit(1);
     }
 
+    g_printerr("Running QEMU with SDL 1.2 is deprecated, and will be removed\n"
+               "in a future release. Please switch to SDL 2.0 instead\n");
+
     if (no_frame)
         gui_noframe = 1;
 
-- 
2.14.3
