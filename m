Received: from eggs.gnu.org ([2001:4830:134:3::10]:46722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z79-0000Hh-4P
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f5z77-0006OB-CB
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:35 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:56051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f5z77-0006NN-2X
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 15:39:33 -0400
Received: by mail-wm0-x242.google.com with SMTP id b127so28589796wmf.5
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 12:39:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 10 Apr 2018 20:39:08 +0100
Message-Id: <20180410193919.28026-14-alex.bennee@linaro.org>
In-Reply-To: <20180410193919.28026-1-alex.bennee@linaro.org>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 13/24] tests/tcg/i386: move test-i386-sse.c
 to tests/tcg/x86_64/test-sse.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, famz@redhat.com, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The test mixes up 32bit and 64 bit code. It should probably be split
into two distinct test cases. However for now just move it out of the
way of the i386 build.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/{i386/test-i386-ssse3.c => x86_64/test-sse.c} | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)
 rename tests/tcg/{i386/test-i386-ssse3.c => x86_64/test-sse.c} (93%)

diff --git a/tests/tcg/i386/test-i386-ssse3.c b/tests/tcg/x86_64/test-sse.c
similarity index 93%
rename from tests/tcg/i386/test-i386-ssse3.c
rename to tests/tcg/x86_64/test-sse.c
index 0a42bd03e2..196ec7f32f 100644
--- a/tests/tcg/i386/test-i386-ssse3.c
+++ b/tests/tcg/x86_64/test-sse.c
@@ -1,4 +1,4 @@
-/* See if various MMX/SSE SSSE3 instructions give expected results */
+/* See if various MMX/SSE SSSE3/4 instructions give expected results */
 #include <stdio.h>
 #include <string.h>
 #include <stdint.h>
@@ -41,8 +41,7 @@ int main(int argc, char *argv[]) {
 	asm volatile ("movdqa  %%xmm0, (%0)" : : "r" (hello));
 	printf("%5.5s\n", hello);
 
-#if 1 /* SSE4 */
-	/* popcnt r64, r/m64 */
+	/* SSE4 popcnt r64, r/m64 */
 	asm volatile ("movq    $0x8421000010009c63, %%rax" : : : "rax");
 	asm volatile ("popcnt  %%ax, %%dx" : : : "dx");
 	asm volatile ("popcnt  %%eax, %%ecx" : : : "ecx");
@@ -51,7 +50,6 @@ int main(int argc, char *argv[]) {
 	asm volatile ("movl    %%ecx, %0" : "=m" (c));
 	asm volatile ("movw    %%dx, %0" : "=m" (d));
 	printf("%i = %i\n%i = %i = %i\n", 13, (int) a, 9, c, d + 1);
-#endif
 
 	return 0;
 }
-- 
2.16.2
