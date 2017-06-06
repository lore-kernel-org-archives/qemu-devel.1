Received: from eggs.gnu.org ([2001:4830:134:3::10]:35153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIC7S-000867-CH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dIC7P-0006LT-Vo
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dIC7P-0006KV-Pt
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 06:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAA2237E67
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 10:53:46 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue,  6 Jun 2017 12:53:36 +0200
Message-Id: <20170606105339.3613-2-kraxel@redhat.com>
In-Reply-To: <20170606105339.3613-1-kraxel@redhat.com>
References: <20170606105339.3613-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] gtk: prefer gtk3 over gtk2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

In case the configure script finds both gtk2 and gtk3 installed it
still prefers gtk2 over gtk3.  Prefer gtk3 instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/configure b/configure
index 13e040d28c..b75b9c57c0 100755
--- a/configure
+++ b/configure
@@ -2325,14 +2325,14 @@ fi
 # GTK probe
 
 if test "$gtkabi" = ""; then
-    # The GTK ABI was not specified explicitly, so try whether 2.0 is available.
-    # Use 3.0 as a fallback if that is available.
-    if $pkg_config --exists "gtk+-2.0 >= 2.18.0"; then
-        gtkabi=2.0
-    elif $pkg_config --exists "gtk+-3.0 >= 3.0.0"; then
+    # The GTK ABI was not specified explicitly, so try whether 3.0 is available.
+    # Use 2.0 as a fallback if that is available.
+    if $pkg_config --exists "gtk+-3.0 >= 3.0.0"; then
         gtkabi=3.0
+    elif $pkg_config --exists "gtk+-2.0 >= 2.18.0"; then
+        gtkabi=2.0
     else
-        gtkabi=2.0
+        gtkabi=3.0
     fi
 fi
 
@@ -2355,7 +2355,7 @@ if test "$gtk" != "no"; then
         libs_softmmu="$gtk_libs $libs_softmmu"
         gtk="yes"
     elif test "$gtk" = "yes"; then
-        feature_not_found "gtk" "Install gtk2 or gtk3 devel"
+        feature_not_found "gtk" "Install gtk3-devel"
     else
         gtk="no"
     fi
-- 
2.9.3
