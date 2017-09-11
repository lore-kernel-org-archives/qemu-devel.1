Received: from eggs.gnu.org ([2001:4830:134:3::10]:34294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVpx-0003HL-Tf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:01:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVpt-0002Fw-2O
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:01:45 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drVps-0002Fl-V4
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:01:41 -0400
Received: by mail-qk0-x243.google.com with SMTP id d70so6137871qkc.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:01:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 11 Sep 2017 18:01:29 -0300
Message-Id: <20170911210129.5874-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] test-qga: add missing qemu-ga tool dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

this fixes running 'make check-unit' without running 'make all' beforehand:

$ make check-unit
  ...
  GTESTER tests/test-qga
**
ERROR:tests/test-qga.c:73:fixture_setup: assertion failed (error == NULL): Failed to execute child process "/build/qemu/qemu-ga" (No such file or directory) (g-exec-error-quark, 8)
make: *** [check-tests/test-qga] Error 1

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
occured trying to split Travis jobs to run more/faster

 tests/Makefile.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715e9c..59e027f6ea 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -832,7 +832,8 @@ endif
 qtest-obj-y = tests/libqtest.o $(test-util-obj-y)
 $(check-qtest-y): $(qtest-obj-y)
 
-tests/test-qga: tests/test-qga.o $(qtest-obj-y)
+tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
+tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
 
 SPEED = quick
 GTESTER_OPTIONS = -k $(if $(V),--verbose,-q)
-- 
2.14.1
