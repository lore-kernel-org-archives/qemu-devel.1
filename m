Received: from eggs.gnu.org ([2001:4830:134:3::10]:56700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFt-0002XU-2i
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fEKFo-0002Sg-3Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35290 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fEKFn-0002SH-VZ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 15:51:00 -0400
Date: Thu, 3 May 2018 22:50:58 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1525376963-79623-21-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525376963-79623-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PATCH 20/67] tests: relative include for child
 directory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

When pulling in headers that are in the child directory of the C file
(as opposed to one in include/), we should use its relative path, with
name of the child directory. Full path including the current directory
works more or less by accident.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/migration-test.c | 2 +-
 tests/pkix_asn1_tab.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index 422bf1a..be8d564 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -80,7 +80,7 @@ static const char *tmpfs;
 /* A simple PC boot sector that modifies memory (1-100MB) quickly
  * outputting a 'B' every so often if it's still running.
  */
-#include "tests/migration/x86-a-b-bootblock.h"
+#include "migration/x86-a-b-bootblock.h"
 
 static void init_bootfile_x86(const char *bootpath)
 {
diff --git a/tests/pkix_asn1_tab.c b/tests/pkix_asn1_tab.c
index f15fc51..f3bb2c7 100644
--- a/tests/pkix_asn1_tab.c
+++ b/tests/pkix_asn1_tab.c
@@ -4,7 +4,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "tests/crypto-tls-x509-helpers.h"
+#include "crypto-tls-x509-helpers.h"
 
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
-- 
MST
