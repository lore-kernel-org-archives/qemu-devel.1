Received: from eggs.gnu.org ([2001:4830:134:3::10]:56143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uy7-0000rh-Sy
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uy7-0003a4-53
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:59 +0200
Message-Id: <20171006155422.10135-32-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 31/54] qemu-iotests: get rid of $iam
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

The variable is almost unused, and one of the two uses is actually
uninitialized.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/check     | 5 +----
 tests/qemu-iotests/common.rc | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 2d2ef687ad..010bf48e92 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -30,12 +30,9 @@ interrupt=true
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
 
-# generic initialization
-iam=check
-
 _init_error()
 {
-    echo "$iam: $1" >&2
+    echo "check: $1" >&2
     exit 1
 }
 
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index f4dc0104e6..0e8a33c696 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -43,7 +43,7 @@ poke_file()
 
 if ! . ./common.config
     then
-    echo "$iam: failed to source common.config"
+    echo "$0: failed to source common.config"
     exit 1
 fi
 
-- 
2.13.6
