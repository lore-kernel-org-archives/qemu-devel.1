Received: from eggs.gnu.org ([2001:4830:134:3::10]:48916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNJOf-0003uc-Hh
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eskultet@redhat.com>) id 1gNJOc-0003Gk-Mt
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eskultet@redhat.com>) id 1gNJOa-0003Dp-OX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 10:17:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3B95300295C
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 15:17:24 +0000 (UTC)
From: Erik Skultety <eskultet@redhat.com>
Date: Thu, 15 Nov 2018 16:15:54 +0100
Message-Id: <85078eacaa4ba2c83f0ff25387a664dcccb65308.1542294676.git.eskultet@redhat.com>
In-Reply-To: <cover.1542294676.git.eskultet@redhat.com>
References: <cover.1542294676.git.eskultet@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] qapi: Add "rendernode" display option for
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
Cc: Erik Skultety <eskultet@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Unlike SPICE, egl-headless doesn't offer a way of specifying the DRM
node used for OpenGL, hence QEMU always selecting the first one that is
available. Thus, add rendernode option to QAPI.

Signed-off-by: Erik Skultety <eskultet@redhat.com>
---
 qapi/ui.json | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index bf9e157d5a..7ecc6eb67e 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1037,6 +1037,19 @@
   'data'    : { '*grab-on-hover' : 'bool',
                 '*zoom-to-fit'   : 'bool'  } }
=20
+##
+# @DisplayEGLHeadless:
+#
+# EGL headless display options.
+#
+# @rendernode: Which DRM render node should be used.
+#
+# Since: 3.2
+#
+##
+{ 'struct'  : 'DisplayEGLHeadless',
+  'data'    : { '*rendernode' : 'str' } }
+
  ##
  # @DisplayGLMode:
  #
@@ -1086,4 +1099,5 @@
                 '*window-close'  : 'bool',
                 '*gl'            : 'DisplayGLMode' },
   'discriminator' : 'type',
-  'data'    : { 'gtk'            : 'DisplayGTK' } }
+  'data'    : { 'gtk'            : 'DisplayGTK',
+                'egl-headless'   : 'DisplayEGLHeadless'} }
--=20
2.19.1
