Received: from eggs.gnu.org ([2001:4830:134:3::10]:46607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Sbn-0002Ro-0M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6Sbj-0004JB-1Z
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:38 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  5 May 2017 10:04:30 +0800
Message-Id: <20170505020430.2305-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] tests: Remove redundant assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/postcopy-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index de35a18..e86f876 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -41,7 +41,7 @@ static bool ufd_version_check(void)
     struct uffdio_api api_struct;
     uint64_t ioctl_mask;
 
-    int ufd = ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
+    int ufd = syscall(__NR_userfaultfd, O_CLOEXEC);
 
     if (ufd == -1) {
         g_test_message("Skipping test: userfaultfd not available");
-- 
2.9.3
