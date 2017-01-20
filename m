Received: from eggs.gnu.org ([2001:4830:134:3::10]:43397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTYJ-0006FN-7f
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cUTYI-0000Dm-DZ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 02:24:03 -0500
From: Fam Zheng <famz@redhat.com>
Date: Fri, 20 Jan 2017 15:23:02 +0800
Message-Id: <20170120072310.8009-9-famz@redhat.com>
In-Reply-To: <20170120072310.8009-1-famz@redhat.com>
References: <20170120072310.8009-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 08/16] iotests: 087: Don't attach test
 image twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, eblake@redhat.com

The test scenario doesn't require the same image, instead it focuses on
the duplicated node-name, so use null-co to avoid locking conflict.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/qemu-iotests/087 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 9de57dd..6d52f7d 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -82,8 +82,7 @@ run_qemu -drive driver=$IMGFMT,id=disk,node-name=test-node,file="$TEST_IMG" <<EO
       "driver": "$IMGFMT",
       "node-name": "disk",
       "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
+          "driver": "null-co"
       }
     }
   }
@@ -92,8 +91,7 @@ run_qemu -drive driver=$IMGFMT,id=disk,node-name=test-node,file="$TEST_IMG" <<EO
       "driver": "$IMGFMT",
       "node-name": "test-node",
       "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
+          "driver": "null-co"
       }
     }
   }
-- 
2.9.3
