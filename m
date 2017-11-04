Received: from eggs.gnu.org ([2001:4830:134:3::10]:44914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPY-00069g-AV
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eApPX-0000tX-JP
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:20 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:48294)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eApPX-0000s2-DB
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 23:46:19 -0400
Received: by mail-lf0-x241.google.com with SMTP id r135so5171454lfe.5
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 20:46:19 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri,  3 Nov 2017 20:45:15 -0700
Message-Id: <1509767121-26925-11-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
References: <1509767121-26925-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 10/16] target/xtensa: tests: fix memctl SR test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Max Filippov <jcmvbkbc@gmail.com>

memctl SR is not available on dc232b, as it was introduced in more
recent hardware release. Now that this information is available through
the libisa the test fails. Fix the test.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_sr.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/xtensa/test_sr.S b/tests/tcg/xtensa/test_sr.S
index 42e3e5e386d4..052f1e04a72c 100644
--- a/tests/tcg/xtensa/test_sr.S
+++ b/tests/tcg/xtensa/test_sr.S
@@ -44,7 +44,6 @@ test_end
 
 test_sr acchi, 1
 test_sr acclo, 1
-test_sr /*memctl*/97, 0
 test_sr_mask /*atomctl*/99, 0, 0
 test_sr_mask /*br*/4, 0, 0
 test_sr_mask /*cacheattr*/98, 0, 0
@@ -76,6 +75,7 @@ test_sr lcount, 1
 test_sr lend, 1
 test_sr litbase, 1
 test_sr m0, 1
+test_sr_mask /*memctl*/97, 0, 0
 test_sr misc0, 1
 test_sr_mask /*prefctl*/40, 0, 0
 test_sr_mask /*prid*/235, 0, 1
-- 
2.1.4
