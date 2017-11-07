Received: from eggs.gnu.org ([2001:4830:134:3::10]:54069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtfz-00014f-SW
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eBtfz-00087i-5s
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 21:31:43 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  6 Nov 2017 21:31:22 -0500
Message-Id: <ba11b692f7e46cd4f1a581288e145686e2e35362.1510021573.git.jcody@redhat.com>
In-Reply-To: <cover.1510021573.git.jcody@redhat.com>
References: <cover.1510021573.git.jcody@redhat.com>
In-Reply-To: <cover.1510021573.git.jcody@redhat.com>
References: <cover.1510021573.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/4] qemu-iotests: update unsupported image
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

Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 tests/qemu-iotests/194 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 8d973b4..1d4214a 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -21,7 +21,7 @@
 
 import iotests
 
-iotests.verify_image_format(unsupported_fmts=['luks'])
+iotests.verify_image_format(supported_fmts=['qcow2', 'qed', 'raw', 'dmg'])
 iotests.verify_platform(['linux'])
 
 with iotests.FilePath('source.img') as source_img_path, \
-- 
2.9.5
