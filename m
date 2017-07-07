Received: from eggs.gnu.org ([2001:4830:134:3::10]:43674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmh-0006py-MR
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWmg-0001G2-Ra
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:11:15 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:48 +0200
Message-Id: <1499447335-6125-94-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 093/100] iotests: skip 159 & 170 with luks format
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

While the qemu-img dd command does accept --image-opts
this is not sufficient to make it work with the LUKS
image yet. This is because bdrv_create() still always
requires the non-image-opts syntax.

Thus we must skip 159/170 with luks for now

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170626123510.20134-2-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
1.8.3.1
