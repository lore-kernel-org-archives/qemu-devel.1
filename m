Received: from eggs.gnu.org ([2001:4830:134:3::10]:51931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRV-00046M-4i
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drmRP-0001vH-Mv
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:45:37 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 12 Sep 2017 16:44:57 +0200
Message-Id: <20170912144459.11359-9-pbonzini@redhat.com>
In-Reply-To: <20170912144459.11359-1-pbonzini@redhat.com>
References: <20170912144459.11359-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/10] qemu-iotests: fix uninitialized variable
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

The variable is used in "common" but defined only after the file
is sourced.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check  | 2 --
 tests/qemu-iotests/common | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 4cb5b05908..7aec176ac4 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -77,8 +77,6 @@ fi
 
 TIMESTAMP_FILE=check.time-$IMGPROTO-$IMGFMT
 
-tmp="${TEST_DIR}"/$$
-
 _wallclock()
 {
     date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index ee313af92f..365d3c4349 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -67,6 +67,8 @@ sortme=false
 expunge=true
 have_test_arg=false
 cachemode=false
+
+tmp="${TEST_DIR}"/$$
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
 export IMGFMT=raw
-- 
2.13.5
