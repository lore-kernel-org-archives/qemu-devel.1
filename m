Received: from eggs.gnu.org ([2001:4830:134:3::10]:48379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGfo-0005pc-Pu
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fRGfn-0000zH-VK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:20 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fRGfn-0000yz-OG
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 08:39:19 -0400
Received: by mail-wm0-x232.google.com with SMTP id 69-v6so3452457wmf.3
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 05:39:19 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  8 Jun 2018 13:32:33 +0100
Message-Id: <20180608123307.24773-16-alex.bennee@linaro.org>
In-Reply-To: <20180608123307.24773-1-alex.bennee@linaro.org>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
Subject: [Qemu-devel] [PATCH v6 15/49] tests/tcg/i386: Build fix for
 hello-i386
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Fam Zheng <famz@redhat.com>

We have -Werror=missing-prototype, add a dummy prototype to avoid that
warning.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.17.1
