Received: from eggs.gnu.org ([209.51.188.92]:42506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFS-0000QK-O5
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzSFR-00078v-Tr
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:42 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzSFR-00077j-Nm
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 15:25:41 -0500
Received: by mail-wr1-x441.google.com with SMTP id o17so23460336wrw.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 12:25:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 28 Feb 2019 20:25:23 +0000
Message-Id: <20190228202537.4638-3-alex.bennee@linaro.org>
In-Reply-To: <20190228202537.4638-1-alex.bennee@linaro.org>
References: <20190228202537.4638-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/16] tests/tcg: enable tcg tests for
 softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 Makefile.target        | 2 --
 tests/Makefile.include | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 3b79e7074c..61b8be31a2 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -37,9 +37,7 @@ PROGS=$(QEMU_PROG) $(QEMU_PROGW)
 STPFILES=
 
 # Makefile Tests
-ifdef CONFIG_USER_ONLY
 include $(SRC_PATH)/tests/tcg/Makefile.include
-endif
 
 config-target.h: config-target.h-timestamp
 config-target.h-timestamp: config-target.mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 2187b0c5aa..f39b96e250 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -1030,10 +1030,9 @@ endif
 
 # Per guest TCG tests
 
-LINUX_USER_TARGETS=$(filter %-linux-user,$(TARGET_DIRS))
-BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(LINUX_USER_TARGETS))
-CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(LINUX_USER_TARGETS))
-RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(LINUX_USER_TARGETS))
+BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TARGET_DIRS))
+CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TARGET_DIRS))
+RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TARGET_DIRS))
 
 ifeq ($(HAVE_USER_DOCKER),y)
 # Probe for the Docker Builds needed for each build
-- 
2.20.1
