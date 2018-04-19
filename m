Received: from eggs.gnu.org ([2001:4830:134:3::10]:47383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADw-0004bU-Bk
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9ADv-0005Pq-EU
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:44 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9ADv-0005PP-82
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 10:07:43 -0400
Received: by mail-wr0-x244.google.com with SMTP id w3-v6so14436652wrg.2
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 07:07:43 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 19 Apr 2018 14:58:41 +0100
Message-Id: <20180419135901.30035-24-alex.bennee@linaro.org>
In-Reply-To: <20180419135901.30035-1-alex.bennee@linaro.org>
References: <20180419135901.30035-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 23/43] tests/tcg/i386/test-i386: use modern
 vector_size attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The compiler complains about the old __mode__ style attributes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.17.0
