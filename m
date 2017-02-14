Received: from eggs.gnu.org ([2001:4830:134:3::10]:41967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdfr3-00016j-4D
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cdfr1-0004Kt-Uz
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 11:21:25 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 14 Feb 2017 11:21:16 -0500
Message-Id: <381b8a0035e1fe2d1c70ff878a89888443fc62a9.1487088544.git.jcody@redhat.com>
In-Reply-To: <cover.1487088544.git.jcody@redhat.com>
References: <cover.1487088544.git.jcody@redhat.com>
In-Reply-To: <cover.1487088544.git.jcody@redhat.com>
References: <cover.1487088544.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-iotests: Test 137 only supports
 'file' protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Since test 137 make uses of qcow2.py, only local files are supported.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/137 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/137 b/tests/qemu-iotests/137
index e5e30de..eb91e51 100755
--- a/tests/qemu-iotests/137
+++ b/tests/qemu-iotests/137
@@ -39,7 +39,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.qemu
 
 _supported_fmt qcow2
-_supported_proto generic
+_supported_proto file
 _supported_os Linux
 
 
-- 
2.9.3
