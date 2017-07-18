Received: from eggs.gnu.org ([2001:4830:134:3::10]:34417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSK-0001cz-7q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSG-0005UK-61
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:40 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXGSG-0005UC-1u
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:33:36 -0400
Received: by mail-qt0-x242.google.com with SMTP id 19so732780qty.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 17:33:35 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 21:31:54 -0300
Message-Id: <20170718003159.10200-27-f4bug@amsat.org>
In-Reply-To: <20170718003159.10200-1-f4bug@amsat.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
	<20170718003159.10200-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 26/31] shippable: use debian/mips[eb] targets
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

previous commit change image mips little -> big endian

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
2.13.2
