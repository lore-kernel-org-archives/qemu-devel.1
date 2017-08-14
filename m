Received: from eggs.gnu.org ([2001:4830:134:3::10]:52235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDDx-0003g0-Al
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dhDDu-0004jn-4m
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 07:07:57 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 14 Aug 2017 14:07:43 +0300
Message-Id: <a3e08c2dbd7db9b86e174f5e50c6aa7a59a2b21d.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
In-Reply-To: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
References: <cover.1502708830.git.mjt@msgid.tls.msk.ru>
Subject: [Qemu-devel] [PULL 6/7] qemu-iotests: remove comment about root
 privileges requirement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>

From: Cleber Rosa <crosa@redhat.com>

The check script contains a commented out root user requirement,
probably because of its xfstests heritage.  This requirement doesn't
apply to qemu-iotests, so it better be gone.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 tests/qemu-iotests/check | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 437ef65320..d504b6e455 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -123,12 +123,6 @@ fi
 # we need common
 . "$source_iotests/common"
 
-#if [ `id -u` -ne 0 ]
-#then
-#    echo "check: QA must be run as root"
-#    exit 1
-#fi
-
 TIMESTAMP_FILE=check.time-$IMGPROTO-$IMGFMT
 
 tmp="${TEST_DIR}"/$$
-- 
2.11.0
