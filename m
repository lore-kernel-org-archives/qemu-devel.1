Received: from eggs.gnu.org ([2001:4830:134:3::10]:35422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIxS-00041L-OD
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTIxR-0001Yy-SL
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:26 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTIxR-0001Yk-Om
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:25:25 -0400
Received: by mail-qk0-x244.google.com with SMTP id v143so2749478qkb.3
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:25:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:21:08 -1000
Message-Id: <20170707022111.21836-25-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 24/27] target/sh4: Implement fpchg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index d164e62..35a5c91 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -492,6 +492,11 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_SZ);
 	ctx->bstate = BS_STOP;
 	return;
+    case 0xf7fd:                /* fpchg */
+        CHECK_SH4A
+        tcg_gen_xori_i32(cpu_fpscr, cpu_fpscr, FPSCR_PR);
+        ctx->bstate = BS_STOP;
+        return;
     case 0x0009:		/* nop */
 	return;
     case 0x001b:		/* sleep */
-- 
2.9.4
