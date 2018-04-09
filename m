Received: from eggs.gnu.org ([2001:4830:134:3::10]:55000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5j-0007g6-8q
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f5R5g-0002bD-3n
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35046 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f5R5f-0002b2-V4
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 03:19:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon,  9 Apr 2018 15:19:31 +0800
Message-Id: <20180409071934.20845-2-famz@redhat.com>
In-Reply-To: <20180409071934.20845-1-famz@redhat.com>
References: <20180409071934.20845-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] docker: dump 'config.log' if ./configure
 fails
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

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-Id: <20180315142713.30960-1-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/docker/common.rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 7951555e3f..046f8a5921 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -30,7 +30,9 @@ build_qemu()
                  $@"
     echo "Configure options:"
     echo $config_opts
-    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
+    $QEMU_SRC/configure $config_opts || \
+        { cat config.log && test_fail "Failed to run 'configure'"; }
+    make $MAKEFLAGS
 }
=20
 test_fail()
--=20
2.14.3
