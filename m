Received: from eggs.gnu.org ([2001:4830:134:3::10]:50972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN06-0006Kh-VT
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJN06-0003aW-3a
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:39 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:37340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJN05-0003a6-Ss
	for qemu-devel@nongnu.org; Thu, 17 May 2018 13:47:38 -0400
Received: by mail-wr0-x233.google.com with SMTP id h5-v6so6549595wrm.4
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 10:47:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:47:00 +0100
Message-Id: <20180517174718.10107-32-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 31/49] tests/tcg/aarch64: add Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

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
