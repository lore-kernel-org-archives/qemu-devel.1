Received: from eggs.gnu.org ([2001:4830:134:3::10]:42733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWm3-00062D-0q
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWm1-0000Hk-FY
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:10:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:08:16 +0200
Message-Id: <1499447335-6125-62-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 061/100] iotests: 181 does not work for all
 formats
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

From: Max Reitz <mreitz@redhat.com>

Test 181 only works for formats which support live migration (naturally,
as it is a live migration test). Disable it for all formats which do
not.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170621131157.16584-1-mreitz@redhat.com
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/181 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index e969a2a..f73ad5a 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -43,6 +43,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt generic
+# Formats that do not support live migration
+_unsupported_fmt qcow vdi vhdx vmdk vpc vvfat
 _supported_proto generic
 _supported_os Linux
 
-- 
1.8.3.1
