Received: from eggs.gnu.org ([2001:4830:134:3::10]:51593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwn-0002SX-4G
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dfYwl-0006XD-Qb
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 17:55:25 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 Aug 2017 23:55:06 +0200
Message-Id: <20170809215510.22802-9-pbonzini@redhat.com>
In-Reply-To: <20170809215510.22802-1-pbonzini@redhat.com>
References: <20170809215510.22802-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/12] qemu-iotests: fix uninitialized variable
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

The function is used in "common" but defined only after the file
is sourced.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qemu-iotests/check  | 2 --
 tests/qemu-iotests/common | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 1ef6d0ac3a..5b9c0c8ade 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -118,8 +118,6 @@ fi
 
 TIMESTAMP_FILE=check.time-$IMGPROTO-$IMGFMT
 
-tmp="${TEST_DIR}"/$$
-
 _wallclock()
 {
     date "+%H %M %S" | awk '{ print $1*3600 + $2*60 + $3 }'
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index adf427501e..35e4d0f87b 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -80,6 +80,8 @@ sortme=false
 expunge=true
 have_test_arg=false
 cachemode=false
+
+tmp="${TEST_DIR}"/$$
 rm -f $tmp.list $tmp.tmp $tmp.sed
 
 export IMGFMT=raw
-- 
2.13.3
