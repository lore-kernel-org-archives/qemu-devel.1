Received: from eggs.gnu.org ([2001:4830:134:3::10]:51018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxt-0002DK-88
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fhdxs-0005Ai-Hs
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:45:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 23 Jul 2018 18:45:27 +0200
Message-Id: <20180723164530.26599-5-kwolf@redhat.com>
In-Reply-To: <20180723164530.26599-1-kwolf@redhat.com>
References: <20180723164530.26599-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] iotests: remove LUKS support from test 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org

From: John Snow <jsnow@redhat.com>

This test doesn't actually care about the format anyway, it just
supports "all formats" as a convenience. LUKS however does not use a
simple image filename which confuses this iotest.

We can simply skip the test for formats that use IMGOPTSSYNTAX for
their filenames without missing much coverage.

Signed-off-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
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
2.13.6
