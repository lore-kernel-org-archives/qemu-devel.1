Received: from eggs.gnu.org ([2001:4830:134:3::10]:60492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5anM-0003rB-DS
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5anL-0000Eh-Ia
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:00 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:46 +0800
Message-Id: <20170502163558.7611-12-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 11/23] iotests: 087: Don't attach test
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

The test scenario doesn't require the same image, instead it focuses on
the duplicated node-name, so use null-co to avoid locking conflict.

Reviewed-by: Max Reitz <mreitz@redhat.com>
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
