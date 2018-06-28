Received: from eggs.gnu.org ([2001:4830:134:3::10]:52592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa54-0007Wi-5K
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa53-0004yz-Ar
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:38 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:40143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYa53-0004yV-6Y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:47:37 -0400
Received: by mail-qt0-x231.google.com with SMTP id s47-v6so5316589qth.7
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:47:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 13:46:43 -0300
Message-Id: <20180628164643.9668-9-f4bug@amsat.org>
In-Reply-To: <20180628164643.9668-1-f4bug@amsat.org>
References: <20180628164643.9668-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 8/8] .shippable.yml: Restore the powerpc-cross
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Thomas Huth <huth@tuxfamily.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This reverts commit b2dba411cf5afc6771e0dd9900fa2b5031a686ac.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index f74a3de3ff..e907a4addd 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -23,6 +23,8 @@ env:
       TARGET_LIST=mips-softmmu,mipsel-linux-user
     - IMAGE=debian-mips64el-cross
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
+    - IMAGE=debian-powerpc-cross
+      TARGET_LIST=ppc-softmmu,ppcemb-softmmu,ppc-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
 build:
-- 
2.18.0
