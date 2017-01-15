Received: from eggs.gnu.org ([2001:4830:134:3::10]:35938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs8d-0001mi-L4
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs8c-0003pa-BW
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:55 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:35676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs8c-0003pS-6Q
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:14:54 -0500
Received: by mail-pf0-x244.google.com with SMTP id f144so12782062pfa.2
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:14:54 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:14:38 -0800
Message-Id: <1484514878-11828-3-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514878-11828-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514878-11828-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] target/xtensa: tests: add memctl test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_sr.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/xtensa/test_sr.S b/tests/tcg/xtensa/test_sr.S
index 4fac46e..42e3e5e 100644
--- a/tests/tcg/xtensa/test_sr.S
+++ b/tests/tcg/xtensa/test_sr.S
@@ -44,6 +44,7 @@ test_end
 
 test_sr acchi, 1
 test_sr acclo, 1
+test_sr /*memctl*/97, 0
 test_sr_mask /*atomctl*/99, 0, 0
 test_sr_mask /*br*/4, 0, 0
 test_sr_mask /*cacheattr*/98, 0, 0
-- 
2.1.4
