Received: from eggs.gnu.org ([2001:4830:134:3::10]:56329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drETV-00036T-Hx
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 22:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drETR-0002rG-4P
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 22:29:25 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drETQ-0002qt-VQ
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 22:29:21 -0400
Received: by mail-qk0-x243.google.com with SMTP id i14so4712285qke.3
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 19:29:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Sep 2017 23:28:39 -0300
Message-Id: <20170911022839.23231-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

changed in 659ef5cbb893, this fixes building with --enable-tcg-interpreter:

/home/travis/build/qemu/qemu/tcg/tcg.c:116:14: error: ‘tcg_out_ldst_finalize’ used but never defined [-Werror]
 static bool tcg_out_ldst_finalize(TCGContext *s);
              ^

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
see https://travis-ci.org/qemu/qemu/jobs/273351287

 tcg/tci/tcg-target.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 5d692e1f4b..26140d78cb 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -206,8 +206,4 @@ static inline void tb_target_set_jmp_target(uintptr_t tc_ptr,
     /* no need to flush icache explicitly */
 }
 
-#ifdef CONFIG_SOFTMMU
-#define TCG_TARGET_NEED_LDST_LABELS
-#endif
-
 #endif /* TCG_TARGET_H */
-- 
2.14.1
