Received: from eggs.gnu.org ([208.118.235.92]:47876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZx-0001l5-Ej
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZt-0002Ru-Gk
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51211 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcWZt-0001xA-6L
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 27 Dec 2018 15:22:52 +0100
Message-Id: <1545920586-17815-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 12/26] disas: nanoMIPS: Comment the decoder
 of 'gpr3' gpr encoding type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, arikalo@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Comment the decoder of 'gpr3' gpr encoding type in nanoMIPS
disassembler.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 51 ++++++++++++++++++++++++++++++++++++++++++++++++=
---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index bfa8c1a..8f354b2 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -291,9 +291,54 @@ uint64 NMD::renumber_registers(uint64 index, uint64 =
*register_list,
=20
=20
 /*
- * these functions should be decode functions but the json does not have
- * decode sections so they are based on the encode, the equivalent decod=
e
- * functions need writing eventually.
+ * NMD::decode_gpr_gpr3() - decoder for 'gpr3' gpr encoding type
+ *
+ *   Map a 3-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                            7 6 5 4 3 2 1 0
+ *                            | | | | | | | |
+ *                            | | | | | | | |
+ *                            | | | =E2=94=94-----------------------=E2=94=
=90
+ *                            | | =E2=94=94-----------------------=E2=94=
=90 |
+ *                            | =E2=94=94-----------------------=E2=94=90=
 | |
+ *                            =E2=94=94-----------------------=E2=94=90 =
| | |
+ *                                    | | | |         | | | |
+ *                            =E2=94=8C-------=E2=94=98 | | |         | =
| | |
+ *                            | =E2=94=8C-------=E2=94=98 | |         | =
| | |
+ *                            | | =E2=94=8C-------=E2=94=98 |         | =
| | |
+ *                            | | | =E2=94=8C-------=E2=94=98         | =
| | |
+ *                            | | | |                 | | | |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   Used in handling following instructions:
+ *
+ *     - ADDIU[R1.SP]
+ *     - ADDIU[R2]
+ *     - ADDU[16]
+ *     - AND[16]
+ *     - ANDI[16]
+ *     - BEQC[16]
+ *     - BEQZC[16]
+ *     - BNEC[16]
+ *     - BNEZC[16]
+ *     - LB[16]
+ *     - LBU[16]
+ *     - LH[16]
+ *     - LHU[16]
+ *     - LI[16]
+ *     - LW[16]
+ *     - LW[GP16]
+ *     - LWXS[16]
+ *     - NOT[16]
+ *     - OR[16]
+ *     - SB[16]
+ *     - SH[16]
+ *     - SLL[16]
+ *     - SRL[16]
+ *     - SUBU[16]
+ *     - SW[16]
+ *     - XOR[16]
  */
 uint64 NMD::decode_gpr_gpr3(uint64 d)
 {
--=20
2.7.4
