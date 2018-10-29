Received: from eggs.gnu.org ([2001:4830:134:3::10]:34202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LR-0008JG-IW
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9LJ-0003GG-Bd
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:43 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:38693 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9LJ-0003Cv-0Y
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:19:52 +0100
Message-Id: <1540826418-5501-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 01/27] target/mips: Add two missing breaks for
 NM_LLWPE and NM_SCWPE decoder cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Coverity found two fallthroughs that miss break statement. Fix them.

Revieved-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 51a5488..3bdefc0 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -21321,6 +21321,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         check_eva(ctx);
                         check_cp0_enabled(ctx);
                         gen_llwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
+                        break;
                     default:
                         generate_exception_end(ctx, EXCP_RI);
                         break;
@@ -21339,6 +21340,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                         check_eva(ctx);
                         check_cp0_enabled(ctx);
                         gen_scwp(ctx, rs, 0, rt, extract32(ctx->opcode, 3, 5));
+                        break;
                     default:
                         generate_exception_end(ctx, EXCP_RI);
                         break;
-- 
2.7.4
