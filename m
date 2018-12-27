Received: from eggs.gnu.org ([208.118.235.92]:47868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZx-0001kw-Dp
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gcWZt-0002SL-KS
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:05 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:51262 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gcWZt-000217-7k
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 09:24:01 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 27 Dec 2018 15:23:00 +0100
Message-Id: <1545920586-17815-21-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545920586-17815-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 20/26] disas: nanoMIPS: Comment the decoder
 of 'gpr2.reg1' gpr encoding type
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

Comment the decoder of 'gpr2.reg1' gpr encoding type in nanoMIPS
disassembler.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 80f50fc..7a22ffe 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -467,6 +467,28 @@ uint64 NMD::decode_gpr_gpr4(uint64 d)
 }
=20
=20
+/*
+ * NMD::decode_gpr_gpr2_reg1() - decoder for 'gpr2.reg1' gpr encoding ty=
pe
+ *
+ *   Map a 2-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                                3 2 1 0
+ *                                | | | |
+ *                                | | | |
+ *                                | | | =E2=94=94-------------------=E2=94=
=90
+ *                                | | =E2=94=94-------------------=E2=94=
=90 |
+ *                                | =E2=94=94-------------------=E2=94=90=
 | |
+ *                                =E2=94=94-------------------=E2=94=90 =
| | |
+ *                                                    | | | |
+ *                                                    | | | |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   Used in handling following instructions:
+ *
+ *     - MOVEP
+ *     - MOVEP[REV]
+ */
 uint64 NMD::decode_gpr_gpr2_reg1(uint64 d)
 {
     static uint64 register_list[] =3D {  4,  5,  6,  7 };
--=20
2.7.4
