Received: from eggs.gnu.org ([2001:4830:134:3::10]:52601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPt-0006BA-1X
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFPn-0000e9-3J
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFPm-0000dL-TZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:17:31 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:16:57 +0800
Message-Id: <20170908091700.14867-5-famz@redhat.com>
In-Reply-To: <20170908091700.14867-1-famz@redhat.com>
References: <20170908091700.14867-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 4/7] tests: Build fix for hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, programmingkidx@gmail.com, crosa@redhat.com, pbonzini@redhat.com, rth@twiddle.net

We have -Werror=missing-prototype, add a dummy prototype to avoid that
warning.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/tcg/hello-i386.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/hello-i386.c b/tests/tcg/hello-i386.c
index fa00380de2..cfeb24b2f5 100644
--- a/tests/tcg/hello-i386.c
+++ b/tests/tcg/hello-i386.c
@@ -20,6 +20,7 @@ static inline int write(int fd, const char * buf, int len)
   return status;
 }
 
+void _start(void);
 void _start(void)
 {
     write(1, "Hello World\n", 12);
-- 
2.13.5
