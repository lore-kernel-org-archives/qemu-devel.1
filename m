Received: from eggs.gnu.org ([2001:4830:134:3::10]:33784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC2-0003nq-Cl
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC1-0000EO-HV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:50 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:41233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC1-0000Dv-Cq
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:49 -0400
Received: by mail-qk0-x22a.google.com with SMTP id w23-v6so2847391qkb.8
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:44:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 21:44:31 -0300
Message-Id: <20180622004435.10291-3-f4bug@amsat.org>
In-Reply-To: <20180622004435.10291-1-f4bug@amsat.org>
References: <20180622004435.10291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/6] tests/acceptance: Rename the x86-64
 specific BootLinuxConsole test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 98324f7591..f6a34d75a5 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -13,7 +13,7 @@ import logging
 from avocado_qemu import Test
 
 
-class BootLinuxConsole(Test):
+class BootLinuxConsoleX86_64(Test):
     """
     Boots a x86_64 Linux kernel and checks that the console is operational
     and the kernel command line is properly passed from QEMU to the kernel
-- 
2.18.0.rc2
