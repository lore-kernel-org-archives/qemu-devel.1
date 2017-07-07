Received: from eggs.gnu.org ([2001:4830:134:3::10]:42611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWly-0005xP-7G
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlt-0000A7-Q4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:30 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:10 +0200
Message-Id: <1499447335-6125-56-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 055/100] iotests: enable tests 134 and 158 to
 work with qcow (v1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The 138 and 158 iotests exercise the legacy qcow2 aes encryption
code path and they work fine with qcow v1 too.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-16-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/134 | 2 +-
 tests/qemu-iotests/158 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index f851d92..9914415 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-_supported_fmt qcow2
+_supported_fmt qcow qcow2
 _supported_proto generic
 _unsupported_proto vxhs
 _supported_os Linux
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index e280b79..823c120 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-_supported_fmt qcow2
+_supported_fmt qcow qcow2
 _supported_proto generic
 _unsupported_proto vxhs
 _supported_os Linux
-- 
1.8.3.1
