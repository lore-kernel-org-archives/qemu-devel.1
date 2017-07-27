Received: from eggs.gnu.org ([2001:4830:134:3::10]:33492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVg-0004q3-BX
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1dahVb-0001nR-0K
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 08:03:15 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2017 08:02:09 -0400
Message-Id: <20170727120210.6943-5-crosa@redhat.com>
In-Reply-To: <20170727120210.6943-1-crosa@redhat.com>
References: <20170727120210.6943-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] qemu-iotests: remove comment about root
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
Cc: qemu-trivial@nongnu.org, Cleber Rosa <crosa@redhat.com>

The check script contains a commented out root user requirement,
probably because of its xfstests heritage.  This requirement doesn't
apply to qemu-iotests, so it better be gone.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/check | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 437ef65..d504b6e 100755
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
2.9.4
