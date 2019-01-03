Received: from eggs.gnu.org ([208.118.235.92]:38526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UL-0004n2-8b
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UI-0007yt-Sp
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46252 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6UI-0007eI-K7
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:54 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:08:01 +0100
Message-Id: <1546535297-11040-29-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 28/44] disas: nanoMIPS: Comment the decoder
 of 'gpr3.src.store' gpr encoding type
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

Comment the decoder of 'gpr3.src.store' gpr encoding type in nanoMIPS
disassembler.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 7c56162..1c313f3 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -349,6 +349,38 @@ uint64 NMD::decode_gpr_gpr3(uint64 d)
 }
=20
=20
+/*
+ * NMD::decode_gpr_gpr3_src_store() - decoder for 'gpr3.src.store' gpr e=
ncoding
+ *     type
+ *
+ *   Map a 3-bit code to the 5-bit register space according to this patt=
ern:
+ *
+ *                            7 6 5 4 3 2 1 0
+ *                            | | | | | | | |
+ *                            | | | | | | | =E2=94=94-------------------=
----=E2=94=90
+ *                            | | | =E2=94=94-----------------------=E2=94=
=90       |
+ *                            | | =E2=94=94-----------------------=E2=94=
=90 |       |
+ *                            | =E2=94=94-----------------------=E2=94=90=
 | |       |
+ *                            =E2=94=94-----------------------=E2=94=90 =
| | |       |
+ *                                    | | |           | | | |       |
+ *                            =E2=94=8C-------=E2=94=98 | |           | =
| | |       |
+ *                            | =E2=94=8C-------=E2=94=98 |           | =
| | |       |
+ *                            | | =E2=94=8C-------=E2=94=98           | =
| | |       |
+ *                            | | |                   | | | |       |
+ *                            | | |                   | | | |       |
+ *    1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+ *      3                   2                   1                   0
+ *
+ *   This pattern is the same one used for 'gpr3' gpr encoding type, exc=
ept for
+ * the input value 0, that is mapped to the output value 0 instead of 16=
.
+ *
+ *   Used in handling following instructions:
+ *
+ *     - SB[16]
+ *     - SH[16]
+ *     - SW[16]
+ *     - SW[GP16]
+ */
 uint64 NMD::decode_gpr_gpr3_src_store(uint64 d)
 {
     static uint64 register_list[] =3D {  0, 17, 18, 19,  4,  5,  6,  7 }=
;
--=20
2.7.4
