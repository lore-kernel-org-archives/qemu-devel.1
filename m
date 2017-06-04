Received: from eggs.gnu.org ([2001:4830:134:3::10]:50494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRh-0007r3-OB
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHZRg-0003cN-Rc
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:09 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHZRg-0003bV-Le
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 13:36:08 -0400
Received: by mail-pg0-x242.google.com with SMTP id v18so3986587pgb.3
	for <qemu-devel@nongnu.org>; Sun, 04 Jun 2017 10:36:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun,  4 Jun 2017 10:34:40 -0700
Message-Id: <20170604173509.29684-41-rth@twiddle.net>
In-Reply-To: <20170604173509.29684-1-rth@twiddle.net>
References: <20170604173509.29684-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/69] target/s390x: remove dead code in
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, aurelien@aurel32.net

From: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170531220129.27724-2-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/translate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 97ca639..f759818 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5467,10 +5467,7 @@ void gen_intermediate_code(CPUS390XState *env, struct TranslationBlock *tb)
             gen_io_start();
         }
 
-        status = NO_EXIT;
-        if (status == NO_EXIT) {
-            status = translate_one(env, &dc);
-        }
+        status = translate_one(env, &dc);
 
         /* If we reach a page boundary, are single stepping,
            or exhaust instruction count, stop generation.  */
-- 
2.9.4
