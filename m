Received: from eggs.gnu.org ([2001:4830:134:3::10]:53974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoZ-0000Yv-7G
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTuoY-0006b4-4j
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:19 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTuoX-0006ZC-VW
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:55:18 -0400
Received: by mail-wm0-x231.google.com with SMTP id v131-v6so5761222wma.1
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:55:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 20:46:31 +0100
Message-Id: <20180615194705.28019-21-alex.bennee@linaro.org>
In-Reply-To: <20180615194705.28019-1-alex.bennee@linaro.org>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 20/54] tests/tcg/i386/test-i386: use modern
 vector_size attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The compiler complains about the old __mode__ style attributes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/tcg/i386/test-i386.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
