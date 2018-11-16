Received: from eggs.gnu.org ([2001:4830:134:3::10]:43899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNeBo-0001eM-QE
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNeBn-0002gS-26
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNeBm-0002fa-TE
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 08:29:39 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41CAC308AA13
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 13:29:38 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 16 Nov 2018 14:29:29 +0100
Message-Id: <20181116132931.8737-2-kraxel@redhat.com>
In-Reply-To: <20181116132931.8737-1-kraxel@redhat.com>
References: <20181116132931.8737-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] qapi: Add "rendernode" display option for
 egl-headless
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Erik Skultety <eskultet@redhat.com>

From: Erik Skultety <eskultet@redhat.com>

Unlike SPICE, egl-headless doesn't offer a way of specifying the DRM
node used for OpenGL, hence QEMU always selecting the first one that is
available. Thus, add the 'rendernode' option for egl-headless to QAPI.

Signed-off-by: Erik Skultety <eskultet@redhat.com>
Message-id: 7658e15eca72d520e7a5fb1c2e724702d83d4f7f.1542362949.git.eskultet@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qapi/ui.json | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index bf9e157d5a..e0000248d3 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1037,6 +1037,20 @@
   'data'    : { '*grab-on-hover' : 'bool',
                 '*zoom-to-fit'   : 'bool'  } }
 
+##
+# @DisplayEGLHeadless:
+#
+# EGL headless display options.
+#
+# @rendernode: Which DRM render node should be used. Default is the first
+#              available node on the host.
+#
+# Since: 3.1
+#
+##
+{ 'struct'  : 'DisplayEGLHeadless',
+  'data'    : { '*rendernode' : 'str' } }
+
  ##
  # @DisplayGLMode:
  #
@@ -1086,4 +1100,5 @@
                 '*window-close'  : 'bool',
                 '*gl'            : 'DisplayGLMode' },
   'discriminator' : 'type',
-  'data'    : { 'gtk'            : 'DisplayGTK' } }
+  'data'    : { 'gtk'            : 'DisplayGTK',
+                'egl-headless'   : 'DisplayEGLHeadless'} }
-- 
2.9.3
