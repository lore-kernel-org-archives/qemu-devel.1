Received: from eggs.gnu.org ([208.118.235.92]:47870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZx-0001l1-Du
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZt-0002S4-Hu
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51246 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcWZt-00020l-5x
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 27 Dec 2018 15:22:58 +0100
Message-Id: <1545920586-17815-19-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 18/26] disas: nanoMIPS: Comment the decoder
 of 'gpr4.zero' gpr encoding type
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

Comment the decoder of 'gpr4.zero' gpr encoding type in nanoMIPS
disassembler.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index f4acba8..6578aa3 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -396,6 +396,33 @@ uint64 NMD::encode_rd1_from_rd(uint64 d)
 }
=20
=20
+/*
+ * NMD::decode_gpr_gpr4_zero() - decoder for 'gpr4.zero' gpr encoding ty=
pe
+ *
+ *   Map a 4-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                              1                   0
+ *                    5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *                    | | | | | | | | | | | | | | | |
+ *                    | | | | | | | | | | | | =E2=94=94-----------------=
----=E2=94=90
+ *                    | | | | | | | | | | | =E2=94=94---------------=E2=94=
=90       |
+ *                    | | | | | | | | | | =E2=94=94---------------=E2=94=
=90 |       |
+ *                    | | | | | | | | | =E2=94=94---------------=E2=94=90=
 | |       |
+ *                    | | | | | | | | =E2=94=94---------------=E2=94=90 =
| | |       |
+ *                    | | | | | | | |           | | | | | | |       |
+ *                    | | | | | | | |           | | | | | | |       |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   This pattern is the same one used for 'gpr4' gpr encoding type, exc=
ept for
+ * the input value 3, that is mapped to the output value 0 instead of 11=
.
+ *
+ *   Used in handling following instructions:
+ *
+ *     - MOVE.BALC
+ *     - MOVEP
+ *     - SW[4X4]
+ */
 uint64 NMD::decode_gpr_gpr4_zero(uint64 d)
 {
     static uint64 register_list[] =3D {  8,  9, 10,  0,  4,  5,  6,  7,
--=20
2.7.4
