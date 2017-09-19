Received: from eggs.gnu.org ([2001:4830:134:3::10]:60044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfR-0004EF-2x
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHfQ-0005Z8-9e
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:21 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:48171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHfQ-0005XL-23
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:30:20 -0400
Received: by mail-wr0-x22f.google.com with SMTP id 108so2947027wra.5
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:30:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:29:21 +0200
Message-Id: <1505824179-21541-33-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 32/50] test-qga: add missing qemu-ga tool
 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

this fixes running 'make check-unit' without running 'make all' beforehand:

$ make check-unit
  ...
  GTESTER tests/test-qga
**
ERROR:tests/test-qga.c:73:fixture_setup: assertion failed (error == NULL): Failed to execute child process "/build/qemu/qemu-ga" (No such file or directory) (g-exec-error-quark, 8)
make: *** [check-tests/test-qga] Error 1

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170911210129.5874-1-f4bug@amsat.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index fae5715..59e027f 100644
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
1.8.3.1
