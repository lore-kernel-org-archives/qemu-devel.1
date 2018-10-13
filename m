Received: from eggs.gnu.org ([2001:4830:134:3::10]:54031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe1-0006Rr-BU
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLdz-0004Nw-IT
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:57 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLdz-0004ND-B1
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:55 -0400
Received: by mail-wm1-x342.google.com with SMTP id 206-v6so14887082wmb.5
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 08:15:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 17:15:40 +0200
Message-Id: <20181013151545.3731-2-f4bug@amsat.org>
In-Reply-To: <20181013151545.3731-1-f4bug@amsat.org>
References: <20181013151545.3731-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 1/6] tests/acceptance: Rename the generic
 BootLinuxConsole test as test_x86_64_pc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index ba3ac036da..3aa4dbe5f9 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -15,7 +15,7 @@ from avocado_qemu import Test
 
 class BootLinuxConsole(Test):
     """
-    Boots a x86_64 Linux kernel and checks that the console is operational
+    Boots a Linux kernel and checks that the console is operational
     and the kernel command line is properly passed from QEMU to the kernel
 
     :avocado: enable
@@ -23,7 +23,7 @@ class BootLinuxConsole(Test):
 
     timeout = 60
 
-    def test(self):
+    def test_x86_64_pc(self):
         if self.arch != 'x86_64':
             self.cancel('Currently specific to the x86_64 target arch')
         kernel_url = ('https://mirrors.kernel.org/fedora/releases/28/'
-- 
2.19.1
