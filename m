Received: from eggs.gnu.org ([2001:4830:134:3::10]:44537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxj3-000729-HC
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxj2-0005YN-OR
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:25 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:04 +0200
Message-Id: <20170711160814.20941-16-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 15/85] iotests: enable tests 134 and 158 to work
 with qcow (v1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

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
2.9.4
