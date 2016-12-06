Received: from eggs.gnu.org ([2001:4830:134:3::10]:60733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cEKyU-0005ob-Jl
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fabian@lesniak-it.de>) id 1cEKyP-0007l0-W2
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:22 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:49766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fabian@lesniak-it.de>)
	id 1cEKyP-0007k6-L1
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 14:00:17 -0500
From: Fabian Lesniak <fabian@lesniak-it.de>
Date: Tue,  6 Dec 2016 20:00:05 +0100
Message-Id: <20161206190007.7539-2-fabian@lesniak-it.de>
In-Reply-To: <20161206190007.7539-1-fabian@lesniak-it.de>
References: <20161206190007.7539-1-fabian@lesniak-it.de>
Subject: [Qemu-devel] [PATCH v3 1/3] qapi: add support for mice with
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
Cc: Fabian Lesniak <fabian@lesniak-it.de>

Adds "side" and "extra" values to enum InputButton. The naming was borrowed
from evdev since it is more descriptive than "button4" and "button5".

Signed-off-by: Fabian Lesniak <fabian@lesniak-it.de>
---
 qapi-schema.json | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index f3e9bfc..7f3272f 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -4277,10 +4277,15 @@
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
 # @InputAxis
-- 
2.10.2
