Received: from eggs.gnu.org ([2001:4830:134:3::10]:47608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJgKo-0001XN-VL
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJgKo-0003Wk-0i
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:26:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 16:26:05 +0200
Message-Id: <20180518142605.19846-4-kwolf@redhat.com>
In-Reply-To: <20180518142605.19846-1-kwolf@redhat.com>
References: <20180518142605.19846-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qemu-iotests: 086 doesn't work with NFS
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

The reference output file only works for file. 'qemu-img convert -p'
makes a lot more progress updates for NFS than for file, so disable the
test for NFS.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/086 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/086 b/tests/qemu-iotests/086
index cd4494a660..84e3835071 100755
--- a/tests/qemu-iotests/086
+++ b/tests/qemu-iotests/086
@@ -38,7 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 
 _supported_fmt qcow2 raw
-_supported_proto file nfs
+_supported_proto file
 _supported_os Linux
 
 function run_qemu_img()
-- 
2.13.6
