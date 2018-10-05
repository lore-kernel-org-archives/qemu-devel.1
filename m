Received: from eggs.gnu.org ([2001:4830:134:3::10]:38595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g8RFA-0005hW-Px
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g8RF7-00053c-N2
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:38:16 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  5 Oct 2018 15:38:02 +0100
Message-Id: <20181005143802.18412-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

The test-bdrv-drain test fails at least 50% of the time
on my OS build system. Disable the test until we can figure
out what's going on, as this makes pull request processing
very difficult.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 175d013f4af..4aae761e769 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -91,7 +91,7 @@ gcov-files-test-thread-pool-y = thread-pool.c
 gcov-files-test-hbitmap-y = util/hbitmap.c
 check-unit-y += tests/test-hbitmap$(EXESUF)
 gcov-files-test-hbitmap-y = blockjob.c
-check-unit-y += tests/test-bdrv-drain$(EXESUF)
+#check-unit-y += tests/test-bdrv-drain$(EXESUF)
 check-unit-y += tests/test-blockjob$(EXESUF)
 check-unit-y += tests/test-blockjob-txn$(EXESUF)
 check-unit-y += tests/test-block-backend$(EXESUF)
-- 
2.19.0
