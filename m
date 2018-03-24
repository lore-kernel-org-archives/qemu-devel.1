Received: from eggs.gnu.org ([2001:4830:134:3::10]:45198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ezbVJ-00051o-JG
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 01:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1ezbVG-0005UG-Ac
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 01:14:09 -0400
From: Michal Privoznik <mprivozn@redhat.com>
Date: Sat, 24 Mar 2018 06:13:41 +0100
Message-Id: <4e8dcc24123a09587ecc427f2e80727ba41a7866.1521868380.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kraxel@redhat.com

When trying to build with latest libcacard-2.5.1, I hit the
following error:

In file included from hw/usb/ccid-card-passthru.c:12:0:
/usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libcacard.h> can be included directly" [-Werror=cpp]
 #warning "Only <libcacard.h> can be included directly"

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 hw/usb/ccid-card-emulated.c | 5 +----
 hw/usb/ccid-card-passthru.c | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index ea42e4681d..7b538ae6da 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -27,10 +27,7 @@
  */
 
 #include "qemu/osdep.h"
-#include <eventt.h>
-#include <vevent.h>
-#include <vreader.h>
-#include <vcard_emul.h>
+#include <cacard/libcacard.h>
 
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
diff --git a/hw/usb/ccid-card-passthru.c b/hw/usb/ccid-card-passthru.c
index b7dd3602dc..982d575edd 100644
--- a/hw/usb/ccid-card-passthru.c
+++ b/hw/usb/ccid-card-passthru.c
@@ -9,7 +9,7 @@
  */
 
 #include "qemu/osdep.h"
-#include <cacard/vscard_common.h>
+#include <cacard/libcacard.h>
 #include "chardev/char-fe.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
-- 
2.16.1
