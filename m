Received: from eggs.gnu.org ([2001:4830:134:3::10]:37929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cg92h-00058W-2d
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cg92g-00058j-AX
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:55:39 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 21 Feb 2017 11:54:59 +0000
Message-Id: <20170221115512.21918-6-berrange@redhat.com>
In-Reply-To: <20170221115512.21918-1-berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/18] iotests: skip 042 with qcow which
 dosn't support zero sized images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Test 042 is designed to verify operation with zero sized images.
Such images are not supported with qcow (v1), so this test has
always failed.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
2.9.3
