Received: from eggs.gnu.org ([2001:4830:134:3::10]:49974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZty2-0000HS-00
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZtxy-0008VU-KQ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:46:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZtxy-0008Ug-CR
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 03:46:02 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 20 Dec 2018 09:45:59 +0100
Message-Id: <20181220084559.13880-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2] ui/cocoa: Include less of the generated
 modular QAPI headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, r.bolshakov@yadro.com

Avoids pointless recompilation.  Missed in commit 112ed241f5d.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/cocoa.m | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/cocoa.m b/ui/cocoa.m
index ecf12bfc2e..ddc058e76e 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -32,7 +32,8 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands.h"
+#include "qapi/qapi-commands-block.h"
+#include "qapi/qapi-commands-misc.h"
 #include "sysemu/blockdev.h"
 #include "qemu-version.h"
 #include <Carbon/Carbon.h>
-- 
2.17.2
