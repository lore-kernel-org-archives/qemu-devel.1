Received: from eggs.gnu.org ([2001:4830:134:3::10]:57574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLQXc-0005iG-Vo
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLQXc-0004df-DW
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:58:45 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 11:58:30 +0200
Message-Id: <20180523095830.24362-3-kwolf@redhat.com>
In-Reply-To: <20180523095830.24362-1-kwolf@redhat.com>
References: <20180523095830.24362-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-iotests: Remove MIG_SOCKET from
 non-migration tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org

185 and 191 define a MIG_SOCKET even though they don't do anything with
migration. Remove the useless variable.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/185 | 2 --
 tests/qemu-iotests/191 | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tests/qemu-iotests/185 b/tests/qemu-iotests/185
index 9a2d317414..deb42cc886 100755
--- a/tests/qemu-iotests/185
+++ b/tests/qemu-iotests/185
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1 # failure is the default!
 
-MIG_SOCKET="${TEST_DIR}/migrate"
-
 _cleanup()
 {
     rm -f "${TEST_IMG}.mid"
diff --git a/tests/qemu-iotests/191 b/tests/qemu-iotests/191
index dfad6555e4..77224eb151 100755
--- a/tests/qemu-iotests/191
+++ b/tests/qemu-iotests/191
@@ -27,8 +27,6 @@ echo "QA output created by $seq"
 here=`pwd`
 status=1 # failure is the default!
 
-MIG_SOCKET="${TEST_DIR}/migrate"
-
 _cleanup()
 {
     rm -f "${TEST_IMG}.mid"
-- 
2.13.6
