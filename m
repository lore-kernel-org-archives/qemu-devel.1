Received: from eggs.gnu.org ([2001:4830:134:3::10]:33802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC4-0003ob-WE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC3-0000F2-UN
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:53 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:42661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAC3-0000Ey-PR
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 20:44:51 -0400
Received: by mail-qk0-x243.google.com with SMTP id u62-v6so313423qkf.9
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 17:44:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 21 Jun 2018 21:44:32 -0300
Message-Id: <20180622004435.10291-4-f4bug@amsat.org>
In-Reply-To: <20180622004435.10291-1-f4bug@amsat.org>
References: <20180622004435.10291-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/6] tests/acceptance: Improve the Avocado
 tags
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

Introduce 'arch' and 'endian' namespaces.

For example, all little-endian tests can be run using:

    $ avocado run -t endian:little tests/acceptance

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f6a34d75a5..17dc8d58c1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -19,7 +19,8 @@ class BootLinuxConsoleX86_64(Test):
     and the kernel command line is properly passed from QEMU to the kernel
 
     :avocado: enable
-    :avocado: tags=x86_64
+    :avocado: tags=endian:little
+    :avocado: tags=arch:x86_64
     """
 
     timeout = 60
-- 
2.18.0.rc2
