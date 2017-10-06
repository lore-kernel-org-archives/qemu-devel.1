Received: from eggs.gnu.org ([2001:4830:134:3::10]:56241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyC-0000xq-Vf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uy7-0003Zs-4l
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:25 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:56 +0200
Message-Id: <20171006155422.10135-29-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/54] qemu-iotests: do not include common.rc in
 "check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

It only provides functions used by the test programs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/check     |  6 ------
 tests/qemu-iotests/common.rc | 13 +++++--------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 03871d0681..e39680ade2 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -72,12 +72,6 @@ then
     _init_error "failed to source common.config"
 fi
 
-# we need common.rc
-if ! . "$source_iotests/common.rc"
-then
-    _init_error "failed to source common.rc"
-fi
-
 # we need common
 . "$source_iotests/common"
 
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index e7f74b4dbd..20f6821a69 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -40,14 +40,11 @@ poke_file()
     printf "$3" | dd "of=$1" bs=1 "seek=$2" conv=notrunc &>/dev/null
 }
 
-# we need common.config
-if [ "$iam" != "check" ]
-then
-    if ! . ./common.config
-        then
-        echo "$iam: failed to source common.config"
-        exit 1
-    fi
+
+if ! . ./common.config
+    then
+    echo "$iam: failed to source common.config"
+    exit 1
 fi
 
 _qemu_wrapper()
-- 
2.13.6
