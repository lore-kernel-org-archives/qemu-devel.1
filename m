Received: from eggs.gnu.org ([2001:4830:134:3::10]:37963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYahd-00053Z-Ha
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYaha-0001TY-SC
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYaha-0001Sm-LO
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:50:38 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 16:50:21 +0100
Message-Id: <1485877831-28786-2-git-send-email-kraxel@redhat.com>
In-Reply-To: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
References: <1485877831-28786-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 01/11] qapi: add support for mice with
 extra/side buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fabian Lesniak <fabian@lesniak-it.de>, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Fabian Lesniak <fabian@lesniak-it.de>

Adds "side" and "extra" values to enum InputButton. The naming was borrowed
from evdev since it is more descriptive than "button4" and "button5".

Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
Message-id: 20161206190007.7539-2-fabian@lesniak-it.de
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 qapi-schema.json | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 82fabc6..cbdffdd 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5390,10 +5390,15 @@
 #
 # Button of a pointer input device (mouse, tablet).
 #
+# @side: front side button of a 5-button mouse (since 2.9)
+#
+# @extra: rear side button of a 5-button mouse (since 2.9)
+#
 # Since: 2.0
 ##
 { 'enum'  : 'InputButton',
-  'data'  : [ 'left', 'middle', 'right', 'wheel-up', 'wheel-down' ] }
+  'data'  : [ 'left', 'middle', 'right', 'wheel-up', 'wheel-down', 'side',
+  'extra' ] }
 
 ##
 # @InputAxis:
-- 
1.8.3.1
