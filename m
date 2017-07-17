Received: from eggs.gnu.org ([2001:4830:134:3::10]:39401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Sk-0005fR-LZ
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dX7Sj-0005x2-8X
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:30 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dX7Sj-0005wZ-1G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:57:29 -0400
Received: by mail-wr0-x236.google.com with SMTP id y43so2322260wrd.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 07:57:28 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Jul 2017 15:48:42 +0100
Message-Id: <20170717144848.11793-18-alex.bennee@linaro.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 17/23] shippable: add ppc64el targets
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
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

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
