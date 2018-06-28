Received: from eggs.gnu.org ([2001:4830:134:3::10]:60588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxz-0002Os-Pu
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxy-0001cf-RC
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:15 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:41317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxy-0001bq-MS
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:14 -0400
Received: by mail-qt0-x22b.google.com with SMTP id y20-v6so5087029qto.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:36:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 12:35:35 -0300
Message-Id: <20180628153535.1411-5-f4bug@amsat.org>
In-Reply-To: <20180628153535.1411-1-f4bug@amsat.org>
References: <20180628153535.1411-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/4] tests/vm: Add flex and bison to the vm
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Similar to 79f24568e5e70, this fixes the following warnings:

           CHK version_gen.h
           LEX convert-dtsv0-lexer.lex.c
  make[1]: flex: Command not found
           BISON dtc-parser.tab.c
  make[1]: bison: Command not found
           LEX dtc-lexer.lex.c
  make[1]: flex: Command not found

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/ubuntu.i386 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index be16ceed50..88b661b6d8 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -81,7 +81,7 @@ class UbuntuX86VM(basevm.BaseVM):
         # The previous update sometimes doesn't survive a reboot, so do it again
         self.ssh_root_check("apt-get update")
         self.ssh_root_check("apt-get build-dep -y qemu")
-        self.ssh_root_check("apt-get install -y libfdt-dev")
+        self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
         self.ssh_root("poweroff")
         self.wait()
         if os.path.exists(img):
-- 
2.18.0
