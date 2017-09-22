Received: from eggs.gnu.org ([2001:4830:134:3::10]:38236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIh5-0000JK-Sa
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIh2-0001GZ-Ql
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIh2-0001GG-Kr
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:12 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:59 +0800
Message-Id: <20170922074659.30097-37-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 36/36] docker: Drop 'set -e' from run script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/run | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tests/docker/run b/tests/docker/run
index 52b76e443d..c8f940de15 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -1,4 +1,4 @@
-#!/bin/bash -e
+#!/bin/bash
 #
 # Docker test runner
 #
@@ -11,8 +11,6 @@
 # or (at your option) any later version. See the COPYING file in
 # the top-level directory.
 
-set -e
-
 if test -n "$V"; then
     set -x
 fi
@@ -20,7 +18,7 @@ fi
 BASE="$(dirname $(readlink -e $0))"
 
 # Prepare the environment
-. /etc/profile || true
+. /etc/profile
 export PATH=/usr/lib/ccache:$PATH
 
 if test -n "$J"; then
@@ -32,7 +30,7 @@ export TEST_DIR=/tmp/qemu-test
 mkdir -p $TEST_DIR/{src,build,install}
 
 # Extract the source tarballs
-tar -C $TEST_DIR/src -xf $BASE/qemu.tar
+tar -C $TEST_DIR/src -xf $BASE/qemu.tar || prep_fail "Failed to untar source"
 
 if test -n "$SHOW_ENV"; then
     if test -f /packages.txt; then
-- 
2.13.5
