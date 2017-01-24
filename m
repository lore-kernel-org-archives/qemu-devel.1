Received: from eggs.gnu.org ([2001:4830:134:3::10]:42934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW2Se-0003TP-TO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW2Se-0002OD-9p
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:40 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 14:51:50 +0000
Message-Id: <20170124145152.22980-16-berrange@redhat.com>
In-Reply-To: <20170124145152.22980-1-berrange@redhat.com>
References: <20170124145152.22980-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/17] iotests: enable tests 134 and 158 to
 work with qcow (v1)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The 138 and 158 iotests exercise the legacy qcow2 aes encryption
code path and they work fine with qcow v1 too.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/134 | 10 +++++-----
 tests/qemu-iotests/158 |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index dd080a2..23b7834 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-_supported_fmt qcow2
+_supported_fmt qcow qcow2
 _supported_proto generic
 _supported_os Linux
 
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 7a1eb5c..2b53d9f 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-_supported_fmt qcow2
+_supported_fmt qcow qcow2
 _supported_proto generic
 _supported_os Linux
 
-- 
2.9.3
