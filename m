Received: from eggs.gnu.org ([2001:4830:134:3::10]:50368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzwT-0005xR-Gs
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fAzwS-0001Tf-BD
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:17 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fAzwS-0001RL-2m
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 11:33:16 -0400
Received: by mail-wr0-x241.google.com with SMTP id c14-v6so10281993wrd.4
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 08:33:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Apr 2018 16:23:47 +0100
Message-Id: <20180424152405.10304-29-alex.bennee@linaro.org>
In-Reply-To: <20180424152405.10304-1-alex.bennee@linaro.org>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 28/46] tests/tcg/aarch64: add Makefile.target
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
