Received: from eggs.gnu.org ([2001:4830:134:3::10]:56870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmF4-0006wJ-EG
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmF3-0000g2-EK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmF3-0000et-2o
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:01 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:33 +0800
Message-Id: <20180815031248.14908-3-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/17] tests/vm: Add flex and bison to the vm
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Similar to 79f24568e5e70, this fixes the following warnings:

           CHK version_gen.h
           LEX convert-dtsv0-lexer.lex.c
  make[1]: flex: Command not found
           BISON dtc-parser.tab.c
  make[1]: bison: Command not found
           LEX dtc-lexer.lex.c
  make[1]: flex: Command not found

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180628153535.1411-5-f4bug@amsat.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/ubuntu.i386 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index fc319e0e6e..fc27b6935e 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -77,7 +77,7 @@ class UbuntuX86VM(basevm.BaseVM):
         # The previous update sometimes doesn't survive a reboot, so do =
it again
         self.ssh_root_check("apt-get update")
         self.ssh_root_check("apt-get build-dep -y qemu")
-        self.ssh_root_check("apt-get install -y libfdt-dev")
+        self.ssh_root_check("apt-get install -y libfdt-dev flex bison")
         self.ssh_root("poweroff")
         self.wait()
         if os.path.exists(img):
--=20
2.17.1
