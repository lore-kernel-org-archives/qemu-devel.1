Received: from eggs.gnu.org ([2001:4830:134:3::10]:60605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhs-00043J-1m
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhr-0000fu-AM
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:59 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gMFhr-0008MG-2O
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:08:59 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gMFhN-0005sf-9Y
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 17:08:29 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 17:08:09 +0000
Message-Id: <20181112170816.500-10-peter.maydell@linaro.org>
In-Reply-To: <20181112170816.500-1-peter.maydell@linaro.org>
References: <20181112170816.500-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/16] tests/guest-debug: fix scoping of
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

From: Alex Bennée <alex.bennee@linaro.org>

You should declare you are using a global version of a variable before
you attempt to modify it in a function.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20181109152119.9242-5-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/guest-debug/test-gdbstub.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-gdbstub.py
index 0e4ac014260..c7e3986a249 100644
--- a/tests/guest-debug/test-gdbstub.py
+++ b/tests/guest-debug/test-gdbstub.py
@@ -16,6 +16,7 @@ def report(cond, msg):
         print ("PASS: %s" % (msg))
     else:
         print ("FAIL: %s" % (msg))
+        global failcount
         failcount += 1
 
 
-- 
2.19.1
