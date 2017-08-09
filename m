Received: from eggs.gnu.org ([2001:4830:134:3::10]:51487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwj-0002Pw-SF
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwi-0006Tv-Dc
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:21 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 Aug 2017 23:55:03 +0200
Message-Id: <20170809215510.22802-6-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-1-pbonzini@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 05/12] qemu-iotests: do not include common.rc
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
Cc: qemu-block@nongnu.org, kwolf@redhat.com

It only provides functions used by the test programs.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check     |  6 ------
 tests/qemu-iotests/common.rc | 13 +++++--------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 5075029e89..1ef6d0ac3a 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -113,12 +113,6 @@ then
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
index ef5cdb3385..390aa81224 100644
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
 
 _fatal()
-- 
2.13.3
