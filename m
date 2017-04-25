Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d32Yr-00082L-4L
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d32Yq-00082g-DS
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:39:29 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 25 Apr 2017 16:38:46 +0100
Message-Id: <20170425153858.25660-7-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-1-berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 06/18] iotests: skip 048 with qcow which
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "Daniel P. Berrange" <berrange@redhat.com>

Test 048 is designed to verify data preservation during an
image resize. The qcow (v1) format impl has never supported
resize so always fails.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
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
