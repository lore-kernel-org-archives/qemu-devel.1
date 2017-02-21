Received: from eggs.gnu.org ([2001:4830:134:3::10]:55268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYw-0005vf-9V
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYv-0004Nr-Gj
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:10 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Feb 2017 10:40:55 -0500
Message-Id: <20170221154057.20313-8-jcody@redhat.com>
In-Reply-To: <20170221154057.20313-1-jcody@redhat.com>
References: <20170221154057.20313-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 7/9] QAPI: Fix blockdev-add example documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qapi/block-core.json | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ea9b04a..5f82d35 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2910,34 +2910,36 @@
 # 1.
 # -> { "execute": "blockdev-add",
 #      "arguments": {
-#          "options" : { "driver": "qcow2",
-#                        "file": { "driver": "file",
-#                                  "filename": "test.qcow2" } } } }
+#           "driver": "qcow2",
+#           "node-name": "test1",
+#           "file": {
+#               "driver": "file",
+#               "filename": "test.qcow2"
+#            }
+#       }
+#     }
 # <- { "return": {} }
 #
 # 2.
 # -> { "execute": "blockdev-add",
 #      "arguments": {
-#          "options": {
-#            "driver": "qcow2",
-#            "node-name": "node0",
-#            "discard": "unmap",
-#            "cache": {
-#                "direct": true,
-#                "writeback": true
+#           "driver": "qcow2",
+#           "node-name": "node0",
+#           "discard": "unmap",
+#           "cache": {
+#              "direct": true
 #            },
 #            "file": {
-#                "driver": "file",
-#                "filename": "/tmp/test.qcow2"
+#              "driver": "file",
+#              "filename": "/tmp/test.qcow2"
 #            },
 #            "backing": {
-#                "driver": "raw",
-#                "file": {
-#                    "driver": "file",
-#                    "filename": "/dev/fdset/4"
+#               "driver": "raw",
+#               "file": {
+#                  "driver": "file",
+#                  "filename": "/dev/fdset/4"
 #                }
 #            }
-#          }
 #        }
 #      }
 #
@@ -2965,14 +2967,12 @@
 #
 # -> { "execute": "blockdev-add",
 #      "arguments": {
-#          "options": {
-#              "driver": "qcow2",
-#              "node-name": "node0",
-#              "file": {
-#                  "driver": "file",
-#                  "filename": "test.qcow2"
-#              }
-#          }
+#           "driver": "qcow2",
+#           "node-name": "node0",
+#           "file": {
+#               "driver": "file",
+#               "filename": "test.qcow2"
+#           }
 #      }
 #    }
 # <- { "return": {} }
-- 
2.9.3
