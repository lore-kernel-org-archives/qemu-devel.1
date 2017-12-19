Received: from eggs.gnu.org ([2001:4830:134:3::10]:49544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdB-00012T-KD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1eRAdA-0001yo-Nb
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:57 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1eRAdA-0001yK-H6
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 00:39:56 -0500
Received: by mail-wr0-x244.google.com with SMTP id v21so6296647wrc.0
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 21:39:56 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 18 Dec 2017 21:38:46 -0800
Message-Id: <1513661932-6849-11-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
References: <1513661932-6849-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH v2 10/16] target/xtensa: tests: fix memctl SR
 test
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
