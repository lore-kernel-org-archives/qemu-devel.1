Received: from eggs.gnu.org ([2001:4830:134:3::10]:50132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42U-0004t1-DO
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dp42Q-0003NW-17
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dp42P-0003Mg-RL
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 22:56:29 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue,  5 Sep 2017 10:56:10 +0800
Message-Id: <20170905025614.579-3-famz@redhat.com>
In-Reply-To: <20170905025614.579-1-famz@redhat.com>
References: <20170905025614.579-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/6] docker: Add test_fail and prep_fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, kchamart@redhat.com, eblake@redhat.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

They both print a message and exit, but with different status code so
distinguish real test errors from env preparation failures.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/common.rc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index c22d825b16..63ce9a7af5 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -35,3 +35,15 @@ build_qemu()
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
