Received: from eggs.gnu.org ([209.51.188.92]:54154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXL-000236-GX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gmGXJ-0007cx-Q2
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:39 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:53554 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gmGXI-0006wq-Qu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 06:17:37 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 23 Jan 2019 12:15:53 +0100
Message-Id: <1548242160-16039-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1548242160-16039-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/9] target/mips: nanoMIPS: Remove an unused
 macro
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

Remove a macro that is never used.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6002d1c..06e7bc6 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -18462,7 +18462,6 @@ enum {
=20
 #define NANOMIPS_EXTRACT_RD(op) ((op >> 7) & 0x7)
 #define NANOMIPS_EXTRACT_RS(op) ((op >> 4) & 0x7)
-#define NANOMIPS_EXTRACT_RS2(op) uMIPS_RS(op)
 #define NANOMIPS_EXTRACT_RS1(op) ((op >> 1) & 0x7)
 #define NANOMIPS_EXTRACT_RD5(op) ((op >> 5) & 0x1f)
 #define NANOMIPS_EXTRACT_RS5(op) (op & 0x1f)
--=20
2.7.4
