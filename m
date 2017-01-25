Received: from eggs.gnu.org ([2001:4830:134:3::10]:44712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRaO-0004VY-8S
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRaN-0005iL-H3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:42:20 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 25 Jan 2017 12:42:08 -0500
Message-Id: <56f34791aae2b2b5dff23ea927dfa42b54d452c6.1485365834.git.jcody@redhat.com>
In-Reply-To: <cover.1485365834.git.jcody@redhat.com>
References: <cover.1485365834.git.jcody@redhat.com>
In-Reply-To: <cover.1485365834.git.jcody@redhat.com>
References: <cover.1485365834.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 7/7] QAPI: Fix blockdev-add example
 documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, berrange@redhat.com, pbonzini@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 qapi/block-core.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4ebb8d8..adc089f 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2909,21 +2909,24 @@
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
 #            "driver": "qcow2",
 #            "node-name": "node0",
 #            "discard": "unmap",
 #            "cache": {
-#                "direct": true,
-#                "writeback": true
+#                "direct": true
 #            },
 #            "file": {
 #                "driver": "file",
@@ -2936,7 +2939,6 @@
 #                    "filename": "/dev/fdset/4"
 #                }
 #            }
-#          }
 #        }
 #      }
 #
@@ -2964,14 +2966,12 @@
 #
 # -> { "execute": "blockdev-add",
 #      "arguments": {
-#          "options": {
 #              "driver": "qcow2",
 #              "node-name": "node0",
 #              "file": {
 #                  "driver": "file",
 #                  "filename": "test.qcow2"
 #              }
-#          }
 #      }
 #    }
 # <- { "return": {} }
-- 
2.9.3
