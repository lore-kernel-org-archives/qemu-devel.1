Received: from eggs.gnu.org ([2001:4830:134:3::10]:46748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z79-0000Ia-Ul
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z79-0006Pf-3w
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:35 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z78-0006Oz-TL
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id b21so644465wme.4
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:34 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:10 +0100
Message-Id: <20180410193919.28026-16-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 15/24] tests/tcg/i368: fix hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a direct syscall test so needs additional CFLAGS and LDFLAGS.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/Makefile.target | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 1df69e0dab..44803c0382 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -9,6 +9,12 @@ CFLAGS+=$(CROSS_CC_GUEST_CFLAGS)
 endif
 endif
 
+#
+# hello-i386 is a barebones app
+#
+hello-i386: CFLAGS+=-ffreestanding
+hello-i386: LDFLAGS+=-nostdlib
+
 #
 # test-386 includes a couple of additional objects that need to be linked together
 #
-- 
2.16.2
