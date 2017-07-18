Received: from eggs.gnu.org ([2001:4830:134:3::10]:48731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7M-0005MJ-M8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7J-0006Sj-S8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:40 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ7J-0006SL-Kx
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:37 -0400
Received: by mail-wr0-x234.google.com with SMTP id 12so23477342wrb.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:52:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:45:06 +0100
Message-Id: <20170718104513.23947-26-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 25/32] shippable: use debian/mips[eb] targets
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

previous commit change image mips little -> big endian

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index fa54df6cff..f2a904014a 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -16,8 +16,8 @@ env:
     - IMAGE=debian-s390x-cross
       TARGET_LIST=s390x-softmmu,s390x-linux-user
     # mips64el-softmmu disabled due to libfdt problem
-    - IMAGE=debian-mipsel-cross
-      TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
+    - IMAGE=debian-mips-cross
+      TARGET_LIST=mips-softmmu,mipsel-linux-user
     - IMAGE=debian-powerpc-cross
       TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
     - IMAGE=debian-ppc64el-cross
-- 
2.13.0
