Received: from eggs.gnu.org ([2001:4830:134:3::10]:48569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ7A-00055C-Da
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dXQ79-0006Mg-K5
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:28 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dXQ79-0006ML-DI
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:52:27 -0400
Received: by mail-wr0-x235.google.com with SMTP id w4so23077057wrb.2
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:52:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 18 Jul 2017 11:44:59 +0100
Message-Id: <20170718104513.23947-19-alex.bennee@linaro.org>
In-Reply-To: <20170718104513.23947-1-alex.bennee@linaro.org>
References: <20170718104513.23947-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/32] shippable: add ppc64el targets
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
index abcaf6f4d4..189d193da5 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -16,6 +16,8 @@ env:
     # mips64el-softmmu disabled due to libfdt problem
     - IMAGE=debian-mipsel-cross
       TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
+    - IMAGE=debian-ppc64el-cross
+      TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
-- 
2.13.0
