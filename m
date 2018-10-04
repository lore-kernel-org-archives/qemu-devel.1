Received: from eggs.gnu.org ([2001:4830:134:3::10]:46304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LK-0005d1-VM
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LH-0002Xr-LS
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:13 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:46 -0400
Message-Id: <20181004161852.11673-5-crosa@redhat.com>
In-Reply-To: <20181004161852.11673-1-crosa@redhat.com>
References: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 04/10] qemu-iotests: fix filename containing
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

Commit cce293a2945 moved some functions from common.config to
common.rc, but the error messages still reference the old file
location.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/qemu-iotests/common.rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 44bee16a5e..70ca65b49b 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -170,7 +170,7 @@ if [ ! -e "$TEST_DIR" ]; then
 fi
 
 if [ ! -d "$TEST_DIR" ]; then
-    echo "common.config: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
+    echo "common.rc: Error: \$TEST_DIR ($TEST_DIR) is not a directory"
     exit 1
 fi
 
@@ -179,7 +179,7 @@ if [ -z "$REMOTE_TEST_DIR" ]; then
 fi
 
 if [ ! -d "$SAMPLE_IMG_DIR" ]; then
-    echo "common.config: Error: \$SAMPLE_IMG_DIR ($SAMPLE_IMG_DIR) is not a directory"
+    echo "common.rc: Error: \$SAMPLE_IMG_DIR ($SAMPLE_IMG_DIR) is not a directory"
     exit 1
 fi
 
-- 
2.17.1
