Received: from eggs.gnu.org ([2001:4830:134:3::10]:42811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5p-00068u-1J
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9A5o-0002bE-6l
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:21 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:46504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9A5o-0002YO-0y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 09:59:20 -0400
Received: by mail-wr0-x244.google.com with SMTP id d1-v6so14338106wrj.13
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:59:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:36 +0100
Message-Id: <20180419135901.30035-19-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [PATCH v2 18/43] tests/tcg/i386: Build fix for
 hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

We have -Werror=missing-prototype, add a dummy prototype to avoid that
warning.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
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
2.17.0
