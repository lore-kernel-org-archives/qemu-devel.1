Received: from eggs.gnu.org ([2001:4830:134:3::10]:51850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLX-0002Xk-Ef
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5vLR-0006G5-Ik
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 11:38:11 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Apr 2018 17:37:46 +0200
Message-Id: <20180410153748.22505-6-kwolf@redhat.com>
In-Reply-To: <20180410153748.22505-1-kwolf@redhat.com>
References: <20180410153748.22505-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] qemu-iotests: Remove _supported_fmt dmg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

qemu-iotests doesn't support dmg, and the dmg block driver doesn't
support image creation. Two test cases declare dmg as supported, but
that's obviously wrong for both reasons. Remove the declaration.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/183 | 2 +-
 tests/qemu-iotests/194 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index 20268ff7a1..c49e1ad6ef 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -43,7 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.filter
 . ./common.qemu
 
-_supported_fmt qcow2 raw qed dmg quorum
+_supported_fmt qcow2 raw qed quorum
 _supported_proto file
 _supported_os Linux
 
diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 1d4214aca3..d746ab1e21 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -21,7 +21,7 @@
 
 import iotests
 
-iotests.verify_image_format(supported_fmts=['qcow2', 'qed', 'raw', 'dmg'])
+iotests.verify_image_format(supported_fmts=['qcow2', 'qed', 'raw'])
 iotests.verify_platform(['linux'])
 
 with iotests.FilePath('source.img') as source_img_path, \
-- 
2.13.6
