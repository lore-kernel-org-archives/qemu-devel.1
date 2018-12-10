Received: from eggs.gnu.org ([2001:4830:134:3::10]:43246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU3-00085B-Rw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU1-0000U1-G3
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:35 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU1-0000TX-8D
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:33 -0500
Received: by mail-wm1-x344.google.com with SMTP id s14so11410689wmh.1
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:33 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:19 +0000
Message-Id: <20181210152829.29271-4-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 03/13] tests/tcg: add QEMU_OPT option for
 test runner
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This will allow tests to modify the QEMU invocation with for example
different -cpu stazas without having to define a whole new set of
runner types.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index d6a7fee2e7..e7215e8455 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -58,6 +58,8 @@ else
 QEMU=../qemu-system-$(TARGET_NAME)
 endif
 
+QEMU_OPTS=
+
 # If TCG debugging is enabled things are a lot slower
 ifeq ($(CONFIG_DEBUG_TCG),y)
 TIMEOUT=45
@@ -108,7 +110,7 @@ RUN_TESTS=$(patsubst %,run-%, $(TESTS))
 RUN_TESTS+=$(EXTRA_RUNS)
 
 run-%: %
-	$(call run-test, $<, $(QEMU) $<, "$< on $(TARGET_NAME)")
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on $(TARGET_NAME) $(QEMU_OPTS)")
 
 .PHONY: run
 run: $(RUN_TESTS)
-- 
2.17.1
