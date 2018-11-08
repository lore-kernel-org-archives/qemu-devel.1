Received: from eggs.gnu.org ([2001:4830:134:3::10]:40747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKnFf-00083H-ER
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gKnFd-0004ts-Kx
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:51 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gKnFd-0004eO-CC
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:33:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id i17-v6so21941824wre.7
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 08:33:34 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  8 Nov 2018 16:33:27 +0000
Message-Id: <20181108163329.19940-5-alex.bennee@linaro.org>
In-Reply-To: <20181108163329.19940-1-alex.bennee@linaro.org>
References: <20181108163329.19940-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 4/6] tests/guest-debug: fix scoping of
 failcount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

You should declare you are using a global version of a variable before
you attempt to modify it in a function.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/guest-debug/test-gdbstub.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-gdbstub.py
index 0e4ac01426..c7e3986a24 100644
--- a/tests/guest-debug/test-gdbstub.py
+++ b/tests/guest-debug/test-gdbstub.py
@@ -16,6 +16,7 @@ def report(cond, msg):
         print ("PASS: %s" % (msg))
     else:
         print ("FAIL: %s" % (msg))
+        global failcount
         failcount += 1
 
 
-- 
2.17.1
