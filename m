Received: from eggs.gnu.org ([2001:4830:134:3::10]:47289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6XhH-00076p-Ri
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e6XhH-0006Wb-2F
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11751)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e6XhG-0006W5-S7
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 04:02:54 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Oct 2017 10:02:43 +0200
Message-Id: <20171023080245.31300-2-kraxel@redhat.com>
In-Reply-To: <20171023080245.31300-1-kraxel@redhat.com>
References: <20171023080245.31300-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] configure: disable qemu-keymap for
 linux-user qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>

From: Laurent Vivier <laurent@vivier.eu>

We don't need qemu-keymap when we build only linux-user qemu.

When we compile in static mode, the libxkbcommon is detected
by configure if the shared one is available, but cannot
be linked if the static version is not available.

As we don't need it for qemu-linux-user, and we generally need
a static link to use it in a chroot, disable qemu-keymap in
this case.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-id: 20171019191606.14129-1-laurent@vivier.eu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 6f21aaf989..03547cea6a 100755
--- a/configure
+++ b/configure
@@ -5136,9 +5136,9 @@ if test "$softmmu" = yes ; then
     fi
     mpath=no
   fi
-fi
-if test "$xkbcommon" = "yes"; then
-  tools="qemu-keymap\$(EXESUF) $tools"
+  if test "$xkbcommon" = "yes"; then
+    tools="qemu-keymap\$(EXESUF) $tools"
+  fi
 fi
 
 # Probe for guest agent support/options
-- 
2.9.3
