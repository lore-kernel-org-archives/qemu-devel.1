Received: from eggs.gnu.org ([2001:4830:134:3::10]:34448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSN-0001fa-3P
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSM-0005XW-D1
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:43 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:34121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSM-0005Wv-8H
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:42 -0400
Received: by mail-qt0-x241.google.com with SMTP id 19so732980qty.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:33:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:56 -0300
Message-Id: <20170718003159.10200-29-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 28/31] shippable: add mips64el targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
2.13.2
