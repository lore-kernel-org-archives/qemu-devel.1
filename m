Received: from eggs.gnu.org ([2001:4830:134:3::10]:56686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtI3-0004qy-0u
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVtI2-0003I2-9A
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:41:55 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVtI2-0003HA-2j
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:41:54 -0400
Received: by mail-wr0-x229.google.com with SMTP id l8-v6so1871693wrr.2
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:41:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:30 +0100
Message-Id: <20180621062605.941-23-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 22/57] tests/tcg/i386/test-i386: fix printf
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
2.17.1
