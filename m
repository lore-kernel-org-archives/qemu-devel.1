Received: from eggs.gnu.org ([2001:4830:134:3::10]:54334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexf-0006uk-AR
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEexe-0004o2-BK
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 12:25:23 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 14 Nov 2017 18:24:17 +0100
Message-Id: <20171114172417.7654-21-mreitz@redhat.com>
In-Reply-To: <20171114172417.7654-1-mreitz@redhat.com>
References: <20171114172417.7654-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 20/20] qemu-iotests: update unsupported image
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Jeff Cody <jcody@redhat.com>

Test 194 checks for 'luks' to exclude as an unsupported format,
However, most formats are unsupported, due to migration blockers.

Rather than specifying a blacklist of unsupported formats, whitelist
supported formats (specifically, qcow2, qed, raw, dmg).

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Jeff Cody <jcody@redhat.com>
Message-id: 23ca18c7f843c86a28b1529ca9ac6db4b35ca0e4.1510059970.git.jcody@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
