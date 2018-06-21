Received: from eggs.gnu.org ([2001:4830:134:3::10]:54334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8P-0005ed-0K
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVt8L-0003hd-TN
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:57 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:39332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVt8L-0003hG-Ml
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 02:31:53 -0400
Received: by mail-wm0-x230.google.com with SMTP id p11-v6so3609203wmc.4
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 23:31:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Jun 2018 07:25:29 +0100
Message-Id: <20180621062605.941-22-alex.bennee@linaro.org>
In-Reply-To: <20180621062605.941-1-alex.bennee@linaro.org>
References: <20180621062605.941-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 21/57] tests/tcg/i386/test-i386: use modern
 vector_size attributes
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

The compiler complains about the old __mode__ style attributes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index cae6a7773a..caef4da176 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -2106,8 +2106,8 @@ static void test_enter(void)
 
 #ifdef TEST_SSE
 
-typedef int __m64 __attribute__ ((__mode__ (__V2SI__)));
-typedef float __m128 __attribute__ ((__mode__(__V4SF__)));
+typedef int __m64 __attribute__ ((vector_size(8)));
+typedef float __m128 __attribute__ ((vector_size(16)));
 
 typedef union {
     double d[2];
-- 
2.17.1
