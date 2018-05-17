Received: from eggs.gnu.org ([2001:4830:134:3::10]:55298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJNFx-0003bx-Nv
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:04:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJNFx-00051r-0A
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:04:01 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:40114)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJNFw-00051H-RF
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:04:00 -0400
Received: by mail-wm0-x22e.google.com with SMTP id j5-v6so10658223wme.5
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 11:04:00 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 May 2018 18:46:54 +0100
Message-Id: <20180517174718.10107-26-alex.bennee@linaro.org>
In-Reply-To: <20180517174718.10107-1-alex.bennee@linaro.org>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 25/49] tests/tcg/i386/test-i386: fix printf
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/tcg/i386/test-i386.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index caef4da176..a29b41e764 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -2258,7 +2258,7 @@ SSE_OP(a ## sd);
         "pop %0\n"\
         : "=rm" (eflags)\
         : "x" (a.dq), "x" (b.dq));\
-    printf("%-9s: a=%f b=%f cc=%04x\n",\
+    printf("%-9s: a=%f b=%f cc=%04lx\n",\
            #op, a1, b1,\
            eflags & (CC_C | CC_P | CC_Z | CC_S | CC_O | CC_A));\
 }
-- 
2.17.0
