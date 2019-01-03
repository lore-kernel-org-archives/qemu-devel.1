Received: from eggs.gnu.org ([208.118.235.92]:38524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UL-0004mz-8D
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UJ-0007zx-Cj
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46255 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6UI-0007ef-W9
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:55 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:08:03 +0100
Message-Id: <1546535297-11040-31-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 30/44] disas: nanoMIPS: Comment the decoder
 of 'gpr4' gpr encoding type
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

Comment the decoder of 'gpr4' gpr encoding type in nanoMIPS
disassembler.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 5f6c93c..a086f65 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -406,6 +406,32 @@ uint64 NMD::encode_gpr4_zero(uint64 d)
 }
=20
=20
+/*
+ * NMD::decode_gpr_gpr4() - decoder for 'gpr4' gpr encoding type
+ *
+ *   Map a 4-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                              1                   0
+ *                    5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *                    | | | | | | | | | | | | | | | |
+ *                    | | | | | | | | | | | | | | | |
+ *                    | | | | | | | | | | | =E2=94=94---------------=E2=94=
=90
+ *                    | | | | | | | | | | =E2=94=94---------------=E2=94=
=90 |
+ *                    | | | | | | | | | =E2=94=94---------------=E2=94=90=
 | |
+ *                    | | | | | | | | =E2=94=94---------------=E2=94=90 =
| | |
+ *                    | | | | | | | |         | | | | | | | |
+ *                    | | | | | | | |         | | | | | | | |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   Used in handling following instructions:
+ *
+ *     - ADDU[4X4]
+ *     - LW[4X4]
+ *     - MOVEP[REV]
+ *     - MUL[4X4]
+ *     - SW[4X4]
+ */
 uint64 NMD::decode_gpr_gpr4(uint64 d)
 {
     static uint64 register_list[] =3D {  8,  9, 10, 11,  4,  5,  6,  7,
--=20
2.7.4
