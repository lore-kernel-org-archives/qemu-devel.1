Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g6y89-0001As-Pk
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g6y84-0004OC-19
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:20:57 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  1 Oct 2018 14:20:36 +0100
Message-Id: <20181001132036.7919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tests: Disable test-bdrv-drain and
 test-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

The test-bdrv-drain and test-replication tests have
intermittent errors which make my build testing process
fail way too often. Disable them both for the moment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm having trouble making forward progress with applying
merges because of these flaky tests :-(

 tests/Makefile.include | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index d0c0a92e67d..1cb1e1a1da7 100644
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
@@ -167,7 +167,7 @@ check-unit-y += tests/test-crypto-xts$(EXESUF)
 check-unit-y += tests/test-crypto-block$(EXESUF)
 check-unit-y += tests/test-logging$(EXESUF)
 gcov-files-test-logging-y = util/log.c
-check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
+#check-unit-$(CONFIG_REPLICATION) += tests/test-replication$(EXESUF)
 check-unit-y += tests/test-bufferiszero$(EXESUF)
 gcov-files-check-bufferiszero-y = util/bufferiszero.c
 check-unit-y += tests/test-uuid$(EXESUF)
-- 
2.19.0
