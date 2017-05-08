Received: from eggs.gnu.org ([2001:4830:134:3::10]:37795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7apD-00081n-GC
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7apC-0000NV-NU
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:03:11 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7apC-0000NR-JT
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:03:10 -0400
Received: by mail-qt0-x243.google.com with SMTP id r58so8248580qtb.2
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 22:03:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 02:02:30 -0300
Message-Id: <20170508050230.22039-1-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 18/23] shippable: temporary disable
 mips64el-softmmu build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.shippable.yml b/.shippable.yml
index 6601243060..7e714991f9 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -15,8 +15,9 @@ env:
       TARGET_LIST=aarch64-softmmu,aarch64-linux-user
     - IMAGE=debian-s390x-cross
       TARGET_LIST=s390x-softmmu,s390x-linux-user
+    # mips64el-softmmu disabled due to libfdt problem
     - IMAGE=debian-mipsel-cross
-      TARGET_LIST=mipsel-softmmu,mips64el-softmmu,mipsel-linux-user,mips64el-linux-user
+      TARGET_LIST=mipsel-softmmu,mipsel-linux-user,mips64el-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE}
-- 
2.11.0
