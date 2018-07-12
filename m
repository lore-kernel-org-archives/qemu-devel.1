Received: from eggs.gnu.org ([2001:4830:134:3::10]:53595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fdjow-0005ZQ-MS
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 18:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fdjov-000463-Sw
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 18:12:18 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 12 Jul 2018 18:12:08 -0400
Message-Id: <20180712221208.3732-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: remove LUKS support from test 226
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

This test doesn't actually care about the format anyway, it just
supports "all formats" as a convenience. LUKS however does not use a
simple image filename which confuses this iotest.

We can simply remove the LUKS "support" and be happier for it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/226 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qemu-iotests/226 b/tests/qemu-iotests/226
index 460aea2fc9..ebfaf62e53 100755
--- a/tests/qemu-iotests/226
+++ b/tests/qemu-iotests/226
@@ -40,7 +40,9 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common.pattern
 
 # Generic format, but tests file-protocol specific error handling
+# LUKS does not use a simple filename; this test doesn't use the format anyway.
 _supported_fmt generic
+_unsupported_fmt luks
 _supported_proto file
 _supported_os Linux
 
-- 
2.14.4
