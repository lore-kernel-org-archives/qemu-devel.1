Received: from eggs.gnu.org ([2001:4830:134:3::10]:45593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daMtU-00041d-VV
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daMtT-0003rb-TK
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daMtT-0003rO-Nd
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Jul 2017 09:02:17 -0500
Message-Id: <20170726140218.15904-3-eblake@redhat.com>
In-Reply-To: <20170726140218.15904-1-eblake@redhat.com>
References: <20170726140218.15904-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qga: Give more --version information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Include the package version information (useful for detecting
builds from git or downstream backports), and the copyright notice.

Signed-off-by: Eric Blake <eblake@redhat.com>
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
