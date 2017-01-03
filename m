Received: from eggs.gnu.org ([2001:4830:134:3::10]:56614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOSWM-0006PU-Df
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOSWL-0001tj-Jf
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:05:10 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  3 Jan 2017 17:04:55 +0000
Message-Id: <20170103170459.27662-2-berrange@redhat.com>
In-Reply-To: <20170103170459.27662-1-berrange@redhat.com>
References: <20170103170459.27662-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] iotests: skip 159 & 170 with luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

While the qemu-img dd command does accept --image-opts
this is not sufficient to make it work with the LUKS
image yet. This is because bdrv_create() still always
requires the non-image-opts syntax.

Thus we must skip 159/170 with luks for now

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/159 | 2 +-
 tests/qemu-iotests/170 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 825f05f..7636865 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.pattern
 
-_supported_fmt generic
+_supported_fmt raw qcow qcow2 qed
 _supported_proto file
 _supported_os Linux
 
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 5b335db..6bd1c37 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.pattern
 
-_supported_fmt generic
+_supported_fmt raw qcow qcow2 qed
 _supported_proto file
 _supported_os Linux
 
-- 
2.9.3
