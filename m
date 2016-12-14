Received: from eggs.gnu.org ([2001:4830:134:3::10]:35166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7w-0006BW-Il
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cHD7q-0001z7-Nd
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:14:00 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cHD7q-0001yy-Hg
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:13:54 -0500
Received: by mail-wm0-f50.google.com with SMTP id a197so123132919wmd.0
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 09:13:54 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Dec 2016 17:12:43 +0000
Message-Id: <20161214171244.26813-4-alex.bennee@linaro.org>
In-Reply-To: <20161214171244.26813-1-alex.bennee@linaro.org>
References: <20161214171244.26813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC/POC PATCH 3/4] tests/tcg: don't run tests by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com, marcandre.lureau@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

If we are going to be doing the build in a different place we might
not have binfmt setup and certainly won't have a qemu built.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/arm/Makefile  | 2 +-
 tests/tcg/misc/Makefile | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/arm/Makefile b/tests/tcg/arm/Makefile
index a7c8953bf4..c374f719c8 100644
--- a/tests/tcg/arm/Makefile
+++ b/tests/tcg/arm/Makefile
@@ -24,7 +24,7 @@ LDFLAGS=-nostdlib
 
 TESTS=hello-arm arm-iwmmxt
 
-all: $(patsubst %,run-%,$(TESTS))
+all: $(TESTS)
 test: all
 
 # rules to run tests
diff --git a/tests/tcg/misc/Makefile b/tests/tcg/misc/Makefile
index 0aa6f2ea21..6070107898 100644
--- a/tests/tcg/misc/Makefile
+++ b/tests/tcg/misc/Makefile
@@ -29,7 +29,7 @@ TESTS=linux-test \
       sha1 \
       test-mmap
 
-all: $(patsubst %,run-%,$(TESTS))
+all: $(TESTS)
 test: all
 
 # rules to run tests
@@ -64,7 +64,7 @@ testthread: testthread.c
 
 # generic Linux and CPU test
 linux-test: linux-test.c
-	$(CROSS_CC) $(CFLAGS) $(LDFLAGS) -o $@ $< -lm
+	$(CROSS_CC) ${QEMU_INCLUDES} $(CFLAGS) $(LDFLAGS) -o $@ $< -lm
 
 test-mmap: test-mmap.c
 	$(CROSS_CC) $(CFLAGS) -Wall -O2 $(LDFLAGS) -o $@ $< -static
-- 
2.11.0
