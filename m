Received: from eggs.gnu.org ([2001:4830:134:3::10]:52275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQGp-00066e-Lp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQGn-0003BY-Ln
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:27 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:35404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQGn-0003Az-Ec
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:02:25 -0400
Received: by mail-lf0-x234.google.com with SMTP id w198so10483319lff.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 04:02:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:08 +0100
Message-Id: <20170718104513.23947-28-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/32] shippable: add mips64el targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, "open list:-----------------..." <qemu-devel@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index f2a904014a..53b43b349f 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -15,9 +15,10 @@ env:
       TARGET_LIST=aarch64-softmmu,aarch64-linux-user
     - IMAGE=debian-s390x-cross
       TARGET_LIST=s390x-softmmu,s390x-linux-user
-    # mips64el-softmmu disabled due to libfdt problem
     - IMAGE=debian-mips-cross
       TARGET_LIST=mips-softmmu,mipsel-linux-user
+    - IMAGE=debian-mips64el-cross
+      TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-powerpc-cross
       TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
     - IMAGE=debian-ppc64el-cross
-- 
2.13.0
