Received: from eggs.gnu.org ([209.51.188.92]:42566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFU-0000Ql-9a
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFT-0007DE-EJ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41553)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFT-00079o-5v
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id n2so23420507wrw.8
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:43 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:25 +0000
Message-Id: <20190228202537.4638-5-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v2 04/16] tests/tcg: add gdb runner variant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

With this you can launch a test in gdb with:

  cd $(BUILD)/tests
  make -f $(SRC)/tests/tcg/Makefile gdb-$(TEST_NAME)

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/tcg/Makefile b/tests/tcg/Makefile
index 097e6374ea..47f4298e68 100644
--- a/tests/tcg/Makefile
+++ b/tests/tcg/Makefile
@@ -113,6 +113,9 @@ RUN_TESTS+=$(EXTRA_RUNS)
 run-%: %
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS) $<, "$< on $(TARGET_NAME)")
 
+gdb-%: %
+	gdb --args $(QEMU) $(QEMU_OPTS) $<
+
 .PHONY: run
 run: $(RUN_TESTS)
 
-- 
2.20.1
