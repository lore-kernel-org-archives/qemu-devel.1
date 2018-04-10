Received: from eggs.gnu.org ([2001:4830:134:3::10]:49770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5zC6-0004xD-Tw
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5zC6-0001FR-03
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:42 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5zC5-0001EC-P1
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:44:41 -0400
Received: by mail-wm0-x243.google.com with SMTP id x4so25414130wmh.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:44:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:07 +0100
Message-Id: <20180410193919.28026-13-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [PATCH v1 12/24] tests/tcg/i386: Build fix for
 hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org

From: Fam Zheng <famz@redhat.com>

We have -Werror=missing-prototype, add a dummy prototype to avoid that
warning.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/tcg/i386/hello-i386.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/i386/hello-i386.c b/tests/tcg/i386/hello-i386.c
index fa00380de2..cfeb24b2f5 100644
--- a/tests/tcg/i386/hello-i386.c
+++ b/tests/tcg/i386/hello-i386.c
@@ -20,6 +20,7 @@ static inline int write(int fd, const char * buf, int len)
   return status;
 }
 
+void _start(void);
 void _start(void)
 {
     write(1, "Hello World\n", 12);
-- 
2.16.2
