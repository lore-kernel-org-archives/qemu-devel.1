Received: from eggs.gnu.org ([2001:4830:134:3::10]:45224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5a8m-0003cD-6q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5a8l-0002bJ-DR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:55:04 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  2 May 2017 16:54:48 +0100
Message-Id: <20170502155452.7033-2-berrange@redhat.com>
In-Reply-To: <20170502155452.7033-1-berrange@redhat.com>
References: <20170502155452.7033-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/5] iotests: skip 159 & 170 with luks format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

While the qemu-img dd command does accept --image-opts
this is not sufficient to make it work with the LUKS
image yet. This is because bdrv_create() still always
requires the non-image-opts syntax.

Thus we must skip 159/170 with luks for now

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/qemu-iotests/159 | 1 +
 tests/qemu-iotests/170 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/159 b/tests/qemu-iotests/159
index 825f05f..9b0e1ec 100755
--- a/tests/qemu-iotests/159
+++ b/tests/qemu-iotests/159
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
+_unsupported_fmt luks
 
 TEST_SIZES="5 512 1024 1999 1K 64K 1M"
 
diff --git a/tests/qemu-iotests/170 b/tests/qemu-iotests/170
index 5b335db..b79359f 100755
--- a/tests/qemu-iotests/170
+++ b/tests/qemu-iotests/170
@@ -40,6 +40,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt generic
 _supported_proto file
 _supported_os Linux
+_unsupported_fmt luks
 
 echo
 echo "== Creating image =="
-- 
2.9.3
