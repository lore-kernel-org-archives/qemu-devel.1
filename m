Received: from eggs.gnu.org ([2001:4830:134:3::10]:56655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fe20Z-0000cW-0E
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fe20Y-000241-6J
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:37:31 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 13 Jul 2018 13:37:21 -0400
Message-Id: <20180713173721.14915-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2] iotests: remove LUKS support from test 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This test doesn't actually care about the format anyway, it just
supports "all formats" as a convenience. LUKS however does not use a
simple image filename which confuses this iotest.

We can simply skip the test for formats that use IMGOPTSSYNTAX for
their filenames without missing much coverage.

Signed-off-by: John Snow <jsnow@redhat.com>
---
V2: Test against IMGOPTSSYNTAX instead of 'luks' directly (Kevin)

 tests/qemu-iotests/226 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 460aea2fc9..34987d43f9 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -41,6 +41,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # Generic format, but tests file-protocol specific error handling
 _supported_fmt generic
+if [ "$IMGOPTSSYNTAX" = "true" ]; then
+    _unsupported_fmt $IMGFMT
+fi
 _supported_proto file
 _supported_os Linux
 
-- 
2.14.4
