Received: from eggs.gnu.org ([2001:4830:134:3::10]:51770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRI-0003v2-MI
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRH-0001rZ-Q2
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:24 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:55 +0200
Message-Id: <20170912144459.11359-7-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 06/10] qemu-iotests: do not include common.rc
 in "check"
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

It only provides functions used by the test programs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check     |  6 ------
 tests/qemu-iotests/common.rc | 13 +++++--------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index b7c54390d3..4cb5b05908 100755
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
2.13.5
