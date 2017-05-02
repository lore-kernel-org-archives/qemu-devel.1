Received: from eggs.gnu.org ([2001:4830:134:3::10]:59663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOf-0002Aj-1q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOe-0001v7-60
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:41 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33036)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOe-0001uq-10
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:40 -0400
Received: by mail-qk0-x242.google.com with SMTP id o85so22942139qkh.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:23:00 -0700
Message-Id: <20170502192300.2124-26-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v6 25/25] target/mips: optimize indirect
 branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

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
2.9.3
