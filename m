Received: from eggs.gnu.org ([2001:4830:134:3::10]:55063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5m-0007iy-Cu
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5l-0002hB-Ij
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f5R5l-0002gk-EE
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:53 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  9 Apr 2018 15:19:33 +0800
Message-Id: <20180409071934.20845-4-famz@redhat.com>
In-Reply-To: <20180409071934.20845-1-famz@redhat.com>
References: <20180409071934.20845-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] docker: Inline "prep_fail" in run script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>

We don't source common.rc where prep_fail is defined, so spell out the
commands and do what was intended.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20180326090350.30014-1-famz@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/run | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/run b/tests/docker/run
index 9dd362bb98..7aebf4b569 100755
--- a/tests/docker/run
+++ b/tests/docker/run
@@ -29,7 +29,7 @@ export TEST_DIR=/tmp/qemu-test
 mkdir -p $TEST_DIR/{src,build,install}
 
 # Extract the source tarballs
-tar -C $TEST_DIR/src -xf $BASE/qemu.tar || prep_fail "Failed to untar source"
+tar -C $TEST_DIR/src -xf $BASE/qemu.tar || { echo "Failed to untar source"; exit 2; }
 if test -f $TEST_DIR/src/Makefile; then
     export FEATURES="$FEATURES dtc"
 fi
-- 
2.14.3
