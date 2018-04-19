Received: from eggs.gnu.org ([2001:4830:134:3::10]:47107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADm-0004NM-0O
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADk-0004rB-T4
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:33 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ADk-0004nC-If
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:32 -0400
Received: by mail-wr0-x242.google.com with SMTP id s18-v6so14410189wrg.9
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:07:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:45 +0100
Message-Id: <20180419135901.30035-28-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 27/43] tests/tcg/aarch64: add Makefile.target
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

Nothing much here yet.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/Makefile.target | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 tests/tcg/aarch64/Makefile.target

diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
new file mode 100644
index 0000000000..4ac8fbe73f
--- /dev/null
+++ b/tests/tcg/aarch64/Makefile.target
@@ -0,0 +1,5 @@
+# -*- Mode: makefile -*-
+#
+# AArch64 specific tweaks
+
+fcvt: LDFLAGS+=-lm
-- 
2.17.0
