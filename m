Received: from eggs.gnu.org ([2001:4830:134:3::10]:54393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GKy-0006eu-QT
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GKv-0000iD-S9
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:10:36 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:26 +0300
Message-Id: <311875781e549af91a3216d34c6ef40420bab435.1494140528.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
References: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 23/23] tests: Remove redundant assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/postcopy-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index de35a18903..e86f87656a 100644
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
2.11.0
