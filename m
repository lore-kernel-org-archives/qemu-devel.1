Received: from eggs.gnu.org ([2001:4830:134:3::10]:45432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8n-0001QZ-6w
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8m-00060d-Dg
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:18:53 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:15 +0000
Message-Id: <20170126101827.22378-7-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 06/18] iotests: skip 048 with qcow which
 doesn't support resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Test 048 is designed to verify data preservation during an
image resize. The qcow (v1) format impl has never supported
resize so always fails.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
2.9.3
