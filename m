Received: from eggs.gnu.org ([2001:4830:134:3::10]:39203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNh00-0003ta-KG
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNgzz-0007oq-Ma
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:52 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNgzz-0007oZ-Fn
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 10:52:51 -0400
Received: by mail-wr0-x233.google.com with SMTP id 77so138341782wrb.1
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 07:52:51 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 15:48:12 +0100
Message-Id: <20170621144814.15324-20-alex.bennee@linaro.org>
In-Reply-To: <20170621144814.15324-1-alex.bennee@linaro.org>
References: <20170621144814.15324-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/21] shippable: add mipsel target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
[AJB: fixups after dropping powerpc]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/.shippable.yml b/.shippable.yml
index 2070c4d827..5e0caa65c5 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -11,6 +11,9 @@ env:
       TARGET_LIST=aarch64-softmmu,aarch64-linux-user
     - IMAGE=debian-s390x-cross
       TARGET_LIST=s390x-softmmu,s390x-linux-user
+    # mips64el-softmmu disabled due to libfdt problem
+    - IMAGE=debian-mipsel-cross
+      TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
-- 
2.13.0
