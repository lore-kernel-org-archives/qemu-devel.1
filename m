Received: from eggs.gnu.org ([2001:4830:134:3::10]:53830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyIPw-0002To-V8
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyIPt-0005Ak-Lm
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:39:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43860 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyIPt-0005Ac-HG
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 10:39:09 -0400
Date: Tue, 20 Mar 2018 16:39:08 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521556695-35907-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] postcopy-ram: add a stub for
 postcopy_request_shared_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This fixes the build on systems without userfaultfd.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 migration/postcopy-ram.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 146bc09..bf78d5c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -928,6 +928,13 @@ int postcopy_ram_prepare_discard(MigrationIncomingState *mis)
     return -1;
 }
 
+int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
+                                 uint64_t client_addr, uint64_t rb_offset)
+{
+    assert(0);
+    return -1;
+}
+
 int postcopy_ram_enable_notify(MigrationIncomingState *mis)
 {
     assert(0);
-- 
MST
