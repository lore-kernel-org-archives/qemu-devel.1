Received: from eggs.gnu.org ([2001:4830:134:3::10]:47251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADs-0004Ve-BF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADq-0005Ch-Qn
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:40 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ADq-00057T-GV
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:38 -0400
Received: by mail-wr0-x243.google.com with SMTP id u11-v6so14407848wri.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:07:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:39 +0100
Message-Id: <20180419135901.30035-22-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 21/43] tests/tcg/i386: disable i386 version
 of test-i386-ssse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

It doesn't build for i386 easily and we probably need a better more
methodical test for SSE et all in QEMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.target | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 2f27b65e2d..a6cc76664c 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -9,7 +9,7 @@ I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
 I386_TESTS=$(I386_SRCS:.c=)
 
 # Update TESTS
-TESTS+=$(I386_TESTS)
+TESTS+=$(I386_ONLY_TESTS)
 
 ifneq ($(TARGET_NAME),x86_64)
 CFLAGS+=-m32
-- 
2.17.0
