Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRZ-00049x-1W
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRU-0001xq-Bu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:41 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:58 +0200
Message-Id: <20170912144459.11359-10-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/10] qemu-iotests: get rid of $iam
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

The variable is almost unused, and one of the two uses is actually
uninitialized.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check     | 5 +----
 tests/qemu-iotests/common.rc | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 7aec176ac4..5dfd4bd51d 100755
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
2.13.5
