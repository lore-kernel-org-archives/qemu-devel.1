Received: from eggs.gnu.org ([2001:4830:134:3::10]:44349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etx4y-0001mY-V8
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:03:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1etx4v-00086c-49
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:03:36 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1etx4u-00085r-Uq
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:03:33 -0500
Received: by mail-wr0-x243.google.com with SMTP id p104so5972446wrc.12
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 07:03:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Mar 2018 15:03:29 +0000
Message-Id: <20180308150329.27238-2-alex.bennee@linaro.org>
In-Reply-To: <20180308150329.27238-1-alex.bennee@linaro.org>
References: <20180308150329.27238-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/1] .shippable.yml: disable powerpc-cross image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Something has happened to the old emdebian setup which means it no
longer builds. Let's disable the shippable builds which are always
failing.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/.shippable.yml b/.shippable.yml
index dd4bbc84b1..60f2ce9218 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -23,8 +23,6 @@ env:
       TARGET_LIST=mips-softmmu,mipsel-linux-user
     - IMAGE=debian-mips64el-cross
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
-    - IMAGE=debian-powerpc-cross
-      TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
-- 
2.15.1
