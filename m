Received: from eggs.gnu.org ([2001:4830:134:3::10]:48371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1Hz-0006Ur-MC
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1Hx-00035F-Fl
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:11 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dR1Hx-00034w-Al
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:09 -0400
Received: by mail-qk0-x241.google.com with SMTP id v143so3780372qkb.3
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:09:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 30 Jun 2017 12:09:01 -0700
Message-Id: <20170630190903.9886-2-rth@twiddle.net>
In-Reply-To: <20170630190903.9886-1-rth@twiddle.net>
References: <20170630190903.9886-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 1/3] gen-icount: add missing inline to gen_tb_end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1497639397-19453-2-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/gen-icount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 62d462e..547c979 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -44,7 +44,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_temp_free_i32(count);
 }
 
-static void gen_tb_end(TranslationBlock *tb, int num_insns)
+static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 {
     if (tb->cflags & CF_USE_ICOUNT) {
         /* Update the num_insn immediate parameter now that we know
-- 
2.9.4
