Received: from eggs.gnu.org ([2001:4830:134:3::10]:56952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFe-0004pA-8A
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFd-00044b-EG
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:10 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHvFd-00044C-A5
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:53:09 -0400
Received: by mail-qt0-x243.google.com with SMTP id x58so9855011qtc.2
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 09:53:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  5 Jun 2017 09:52:31 -0700
Message-Id: <20170605165233.4135-25-rth@twiddle.net>
In-Reply-To: <20170605165233.4135-1-rth@twiddle.net>
References: <20170605165233.4135-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 24/26] target/mips: optimize indirect branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

From: Aurelien Jarno <aurelien@aurel32.net>

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
Message-Id: <20170430145254.25616-4-aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/mips/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1a7ac07..559f8fe 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -10725,7 +10725,7 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
                 save_cpu_state(ctx, 0);
                 gen_helper_raise_exception_debug(cpu_env);
             }
-            tcg_gen_exit_tb(0);
+            tcg_gen_lookup_and_goto_ptr(cpu_PC);
             break;
         default:
             fprintf(stderr, "unknown branch 0x%x\n", proc_hflags);
-- 
2.9.4
