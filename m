Received: from eggs.gnu.org ([2001:4830:134:3::10]:51703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYws-0002YK-2r
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwp-0006at-8w
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:30 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 Aug 2017 23:55:09 +0200
Message-Id: <20170809215510.22802-12-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-1-pbonzini@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/12] qemu-iotests: include common.env and
 common.config early
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

They are now very small and they do not have external dependencies.  We
can source them as soon as we have their path.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index dc60e17e6a..28b3444963 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -55,6 +55,18 @@ else
     build_iotests=$PWD
 fi
 
+# we need common.env
+if ! . "$build_iotests/common.env"
+then
+    _init_error "failed to source common.env (make sure the qemu-iotests are run from tests/qemu-iotests in the build tree)"
+fi
+
+# we need common.config
+if ! . "$source_iotests/common.config"
+then
+    _init_error "failed to source common.config"
+fi
+
 build_root="$build_iotests/../.."
 
 if [ -x "$build_iotests/socket_scm_helper" ]
@@ -98,18 +110,6 @@ then
     export QEMU_NBD_PROG="$build_root/qemu-nbd"
 fi
 
-# we need common.env
-if ! . "$build_iotests/common.env"
-then
-    _init_error "failed to source common.env (make sure the qemu-iotests are run from tests/qemu-iotests in the build tree)"
-fi
-
-# we need common.config
-if ! . "$source_iotests/common.config"
-then
-    _init_error "failed to source common.config"
-fi
-
 # we need common
 . "$source_iotests/common"
 
-- 
2.13.3
