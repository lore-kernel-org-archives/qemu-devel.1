Received: from eggs.gnu.org ([2001:4830:134:3::10]:59395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e80TC-00044h-RB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:58:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1e80TC-0001oO-7E
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 04:58:26 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Fri, 27 Oct 2017 04:57:56 -0400
Message-Id: <d2e970e5721be56e078338925db8838cae8afa33.1509094209.git.jcody@redhat.com>
In-Reply-To: <cover.1509094209.git.jcody@redhat.com>
References: <cover.1509094209.git.jcody@redhat.com>
In-Reply-To: <cover.1509094209.git.jcody@redhat.com>
References: <cover.1509094209.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 4/4] qemu-iotests: update unsupported image
 formats in 194
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, mreitz@redhat.com, den@openvz.org, stefanha@redhat.com

Test 194 checks for 'luks' to exclude as an unsupported format,
However, most formats are unsupported, due to migration blockers.

Rather than specifying a blacklist of unsupported formats, whitelist
supported formats (specifically, qcow2, qed, raw, dmg).

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/194 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 8d973b440f..1d4214aca3 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -21,7 +21,7 @@
 
 import iotests
 
-iotests.verify_image_format(unsupported_fmts=['luks'])
+iotests.verify_image_format(supported_fmts=['qcow2', 'qed', 'raw', 'dmg'])
 iotests.verify_platform(['linux'])
 
 with iotests.FilePath('source.img') as source_img_path, \
-- 
2.13.6
