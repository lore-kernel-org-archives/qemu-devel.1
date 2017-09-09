Received: from eggs.gnu.org ([2001:4830:134:3::10]:33846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbZ-0006GL-Pl
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqYbY-0006Yq-LA
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqYbY-0006YW-FF
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 01:46:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Sat,  9 Sep 2017 13:45:57 +0800
Message-Id: <20170909054613.19148-22-famz@redhat.com>
In-Reply-To: <20170909054613.19148-1-famz@redhat.com>
References: <20170909054613.19148-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL v2 21/37] docker: Add test_fail and prep_fail
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

They both print a message and exit, but with different status code so
distinguish real test errors from env preparation failures.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170905025614.579-3-famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Based-on: 20170905021201.25684-1-famz@redhat.com
---
 tests/docker/common.rc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 3b45eb91c6..87f5263757 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -32,3 +32,15 @@ build_qemu()
     echo $config_opts
     $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
 }
+
+test_fail()
+{
+    echo "$@"
+    exit 1
+}
+
+prep_fail()
+{
+    echo "$@"
+    exit 2
+}
-- 
2.13.5
