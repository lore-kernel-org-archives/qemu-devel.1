Received: from eggs.gnu.org ([209.51.188.92]:54139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXK-00022h-Vw
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXJ-0007co-KX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:38 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53535 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gmGXI-0006wl-Qt
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:36 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 23 Jan 2019 12:15:52 +0100
Message-Id: <1548242160-16039-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/9] target/mips: nanoMIPS: Remove duplicate
 macro definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Several macros were defined twice, with identical values, so
remove duplicates.

Previously added in 80845edf37b.

This reverts commit 6bfa9f4c9cf24d6cfaaa227722e9cdcca1ad6fe9.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ab307c4..6002d1c 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18502,16 +18502,6 @@ static inline int decode_gpr_gpr4_zero(int r)
 }
=20
=20
-/* extraction utilities */
-
-#define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
-#define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
-#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
-#define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
-#define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
-#define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
-
-
 static void gen_adjust_sp(DisasContext *ctx, int u)
 {
     gen_op_addr_addi(ctx, cpu_gpr[29], cpu_gpr[29], u);
--=20
2.7.4
