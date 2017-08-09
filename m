Received: from eggs.gnu.org ([2001:4830:134:3::10]:51660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwo-0002Ul-St
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwn-0006ZO-Tz
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:26 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 Aug 2017 23:55:08 +0200
Message-Id: <20170809215510.22802-11-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-1-pbonzini@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 10/12] qemu-iotests: get rid of $iam
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

The variable is almost unused, and one of the two uses is actually
uninitialized.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check     | 5 +----
 tests/qemu-iotests/common.rc | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e5d1ae3d92..dc60e17e6a 100755
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
index 7046a83974..d0aa22543e 100644
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
2.13.3
