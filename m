Received: from eggs.gnu.org ([2001:4830:134:3::10]:47382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNFe-0006tO-Gv
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:23:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNFb-0000Vg-7W
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:23:18 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emNFb-0000VW-3R
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 12:23:15 -0500
Received: by mail-qt0-x244.google.com with SMTP id d26so545598qtj.4
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 09:23:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 15 Feb 2018 14:23:06 -0300
Message-Id: <20180215172306.10389-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: dump 'config.log' if ./configure fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/common.rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/docker/common.rc b/tests/docker/common.rc
index 7951555e3f..dd011cdf1e 100755
--- a/tests/docker/common.rc
+++ b/tests/docker/common.rc
@@ -30,7 +30,9 @@ build_qemu()
                  $@"
     echo "Configure options:"
     echo $config_opts
-    $QEMU_SRC/configure $config_opts && make $MAKEFLAGS
+    $QEMU_SRC/configure $config_opts || \
+        (cat config.log && prep_fail "Failed to run 'configure'")
+    make $MAKEFLAGS
 }
 
 test_fail()
-- 
2.16.1
