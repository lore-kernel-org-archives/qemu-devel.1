Received: from eggs.gnu.org ([2001:4830:134:3::10]:42298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlf-0005ZR-1o
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWld-0008Sf-V1
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:00 +0200
Message-Id: <1499447335-6125-46-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 045/100] iotests: skip 042 with qcow which
 dosn't support zero sized images
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

Test 042 is designed to verify operation with zero sized images.
Such images are not supported with qcow (v1), so this test has
always failed.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-6-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/042 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/042 b/tests/qemu-iotests/042
index 351b283..a53e7cb 100755
--- a/tests/qemu-iotests/042
+++ b/tests/qemu-iotests/042
@@ -37,7 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.rc
 . ./common.filter
 
-_supported_fmt qcow2 qcow qed
+_supported_fmt qcow2 qed
 _supported_proto file
 _supported_os Linux
 
-- 
1.8.3.1
