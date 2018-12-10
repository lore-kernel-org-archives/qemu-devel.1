Received: from eggs.gnu.org ([2001:4830:134:3::10]:43241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU3-000859-QB
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWNU0-0000TR-H0
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:35 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWNU0-0000Sj-AK
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:28:32 -0500
Received: by mail-wr1-x442.google.com with SMTP id t27so10896021wra.6
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:28:32 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Dec 2018 15:28:18 +0000
Message-Id: <20181210152829.29271-3-alex.bennee@linaro.org>
In-Reply-To: <20181210152829.29271-1-alex.bennee@linaro.org>
References: <20181210152829.29271-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 02/13] tests: enable tcg tests for softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile.target        | 2 --
 tests/Makefile.include | 7 +++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 4d56298bbf..a0fe085bae 100644
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
index fb0b449c02..7dd9ecc2be 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -837,10 +837,9 @@ check-report.html: check-report.xml
 
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
2.17.1
