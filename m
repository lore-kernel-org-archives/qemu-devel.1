Received: from eggs.gnu.org ([2001:4830:134:3::10]:45621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daMta-00046a-A1
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daMtU-0003s8-QR
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:38 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 26 Jul 2017 09:02:16 -0500
Message-Id: <20170726140218.15904-2-eblake@redhat.com>
In-Reply-To: <20170726140218.15904-1-eblake@redhat.com>
References: <20170726140218.15904-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] qemu-io: Give more --version information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Include the package version information (useful for detecting
builds from git or downstream backports), and the copyright notice.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/qemu-io.c b/qemu-io.c
index 4cfa41c8f9..ec175630a6 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -26,6 +26,7 @@
 #include "block/block_int.h"
 #include "trace/control.h"
 #include "crypto/init.h"
+#include "qemu-version.h"

 #define CMD_NOFILE_OK   0x01

@@ -522,7 +523,8 @@ int main(int argc, char **argv)
             trace_file = trace_opt_parse(optarg);
             break;
         case 'V':
-            printf("%s version %s\n", progname, QEMU_VERSION);
+            printf("%s version " QEMU_VERSION QEMU_PKGVERSION "\n"
+                   QEMU_COPYRIGHT "\n", progname);
             exit(0);
         case 'h':
             usage(progname);
-- 
2.13.3
