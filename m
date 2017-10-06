Received: from eggs.gnu.org ([2001:4830:134:3::10]:56147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uy7-0000rk-Vf
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uy7-0003Zz-4n
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:53:58 +0200
Message-Id: <20171006155422.10135-31-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 30/54] qemu-iotests: fix uninitialized variable
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

The variable is used in "common" but defined only after the file
is sourced.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/check  | 2 --
 tests/qemu-iotests/common | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index e39680ade2..2d2ef687ad 100755
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
2.13.6
