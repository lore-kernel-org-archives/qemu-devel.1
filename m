Received: from eggs.gnu.org ([2001:4830:134:3::10]:42330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlg-0005cD-Qu
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWlf-0008U7-H3
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:01 +0200
Message-Id: <1499447335-6125-47-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 046/100] iotests: skip 048 with qcow which
 doesn't support resize
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

Test 048 is designed to verify data preservation during an
image resize. The qcow (v1) format impl has never supported
resize so always fails.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-7-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/048 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/048 b/tests/qemu-iotests/048
index 203c04f..9ed04a0 100755
--- a/tests/qemu-iotests/048
+++ b/tests/qemu-iotests/048
@@ -46,7 +46,7 @@ _compare()
 . ./common.filter
 . ./common.pattern
 
-_supported_fmt raw qcow qcow2 qed luks
+_supported_fmt raw qcow2 qed luks
 _supported_proto file
 _supported_os Linux
 
-- 
1.8.3.1
