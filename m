Received: from eggs.gnu.org ([2001:4830:134:3::10]:60972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S8-0001B7-SM
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1df6S7-0006i6-SR
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1df6S7-0006hV-Lz
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:29:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94E867C82F
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 15:29:50 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  8 Aug 2017 17:29:39 +0200
Message-Id: <20170808152941.11247-8-pbonzini@redhat.com>
In-Reply-To: <20170808152941.11247-1-pbonzini@redhat.com>
References: <20170808152941.11247-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] qemu-io: Give more --version information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

Include the package version information (useful for detecting
builds from git or downstream backports), and the copyright notice.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20170803163353.19558-3-eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
