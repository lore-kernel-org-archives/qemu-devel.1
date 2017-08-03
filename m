Received: from eggs.gnu.org ([2001:4830:134:3::10]:47547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddJ4Y-0005hK-40
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:34:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddJ4X-00047E-5g
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:34:06 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 11:33:52 -0500
Message-Id: <20170803163353.19558-4-eblake@redhat.com>
In-Reply-To: <20170803163353.19558-1-eblake@redhat.com>
References: <20170803163353.19558-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 3/4] qga: Give more --version information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, berrange@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Include the package version information (useful for detecting
builds from git or downstream backports), and the copyright notice.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
---
 qga/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 1b381d0bf3..b64c7ac2a2 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -29,6 +29,7 @@
 #include "qemu/help_option.h"
 #include "qemu/sockets.h"
 #include "qemu/systemd.h"
+#include "qemu-version.h"
 #ifdef _WIN32
 #include "qga/service-win32.h"
 #include "qga/vss-win32.h"
@@ -213,7 +214,8 @@ static void usage(const char *cmd)
 {
     printf(
 "Usage: %s [-m <method> -p <path>] [<options>]\n"
-"QEMU Guest Agent %s\n"
+"QEMU Guest Agent " QEMU_VERSION QEMU_PKGVERSION "\n"
+QEMU_COPYRIGHT "\n"
 "\n"
 "  -m, --method      transport method: one of unix-listen, virtio-serial,\n"
 "                    isa-serial, or vsock-listen (virtio-serial is the default)\n"
@@ -248,7 +250,7 @@ static void usage(const char *cmd)
 "  -h, --help        display this help and exit\n"
 "\n"
 "Report bugs to <mdroth@linux.vnet.ibm.com>\n"
-    , cmd, QEMU_VERSION, QGA_VIRTIO_PATH_DEFAULT, QGA_SERIAL_PATH_DEFAULT,
+    , cmd, QGA_VIRTIO_PATH_DEFAULT, QGA_SERIAL_PATH_DEFAULT,
     dfl_pathnames.pidfile,
 #ifdef CONFIG_FSFREEZE
     QGA_FSFREEZE_HOOK_DEFAULT,
-- 
2.13.3
