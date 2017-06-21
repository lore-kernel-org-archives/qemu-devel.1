Received: from eggs.gnu.org ([2001:4830:134:3::10]:41123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNfQY-0002Bf-Vx
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNfQU-00074Z-Uk
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 09:12:10 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 21 Jun 2017 15:11:57 +0200
Message-Id: <20170621131157.16584-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: 181 does not work for all formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Test 181 only works for formats which support live migration (naturally,
as it is a live migration test). Disable it for all formats which do
not.

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
2.9.4
