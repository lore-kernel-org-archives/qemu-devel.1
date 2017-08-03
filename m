Received: from eggs.gnu.org ([2001:4830:134:3::10]:47482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddJ4V-0005dl-Vt
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddJ4V-00044k-8C
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 12:34:04 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu,  3 Aug 2017 11:33:51 -0500
Message-Id: <20170803163353.19558-3-eblake@redhat.com>
In-Reply-To: <20170803163353.19558-1-eblake@redhat.com>
References: <20170803163353.19558-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v3 2/4] qemu-io: Give more --version information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, berrange@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, peter.maydell@linaro.org

Include the package version information (useful for detecting
builds from git or downstream backports), and the copyright notice.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>
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
